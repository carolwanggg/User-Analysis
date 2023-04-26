create temporary table sessions_w_repeats_for_time_diff
select new_sessions.user_id,
       new_sessions.website_session_id as new_session_id,
       new_sessions.created_at as new_session_created_at,
       website_sessions.website_session_id as repeat_session_id,
        website_sessions.created_at as repeat_session_created_at
from( select user_id, website_session_id,created_at
      from website_sessions
      where created_at < '2014-11-03' 
             and created_at >='2014-01-01' 
             and is_repeat_session=0 )      as new_sessions
left join website_sessions
on website_sessions.user_id=new_sessions.user_id
   and website_sessions.is_repeat_session=1;
   and website_sessions.website_session_id > new_sessions.website_session_id
   and website_sessions.created_at<'2014-11-03' 
   and website_sessions.created_at>='2014-01-01';
   
   
select  user_id,new_session_id,new_session_created_at,
        min(repeat_session_id) as second_session_id,
	    min(repeat_session_created_at) as second_session_created_at
from sessions_w_repeats_for_time_diff
where repeat_session_id is not null
group by 1,2,3;
