package com.jiudian.p2p.front.servlets.setmap;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Timer;
import java.util.TimerTask;

public class DailyBatchJob implements AutoCloseable {

	protected Timer timer;

	// 定时任务的执行周期，即每隔EXECUTE_PERIOD毫秒会执行一次
	private long EXECUTE_PERIOD = 12 * 3600 * 1000L;
	//private long EXECUTE_PERIOD = 30 * 1000L;
	// 任务启动时间
	private String EXECUTE_TIME = "00:01:00";

	public DailyBatchJob() {
		long millis = System.currentTimeMillis();
		/**
		 * 当服务器启动时，判断当前时间是否小于EXECUTE_TIME，如果是，
		 * 就在今天的EXECUTE_TIME开始执行BatchJob，否则，将从明天的
		 * EXECUTE_TIME开始执行BatchJob，这样无论任何时候重启动服务 器，BatchJob一天只会执行一次。
		 */
		String now = new Time(millis).toString();
		String tomorrow = new Date(millis + 24 * 3600 * 1000L).toString();
		String today = new Date(millis).toString();
		Timestamp start_time;
		if (Time.valueOf(now).getTime() < Time.valueOf(EXECUTE_TIME).getTime()) {
			start_time = Timestamp.valueOf(today + " " + EXECUTE_TIME);
		} else {
			start_time = Timestamp.valueOf(tomorrow + " " + EXECUTE_TIME);
		}
		timer = new Timer();
		timer.scheduleAtFixedRate(new TimerTask() {
			protected Runnable[] tasks = new Runnable[] { new GenSitemapJob() };

			public void run() {
				try {
					System.out.println("Starting run batch job >>>>>>>>>>>>>>");
					long begin = System.currentTimeMillis();
					for (Runnable task : tasks) {
						task.run();
					}
					long end = System.currentTimeMillis();
					System.out.println("Batch job run completed, it's total took " + ((end - begin) / 1000.0)
							+ " seconds.");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}, start_time, EXECUTE_PERIOD);
		System.out.println(start_time + " 开始启动 DialyBatchJob");
	}

	@Override
	public void close() {
		timer.cancel();
		timer.purge();
	}
}

