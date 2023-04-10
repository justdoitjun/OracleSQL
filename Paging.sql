-- MySQl 페이징
UPDATE tb_board SET writer= 'test' WHERE 1=1;
ALTER TABLE tb_board ADD FOREIGN KEY(writer) REFERENCES tb_member(userid);

SELECT A.id, A.title, A.writer, A.num, A.username
     ,date_format(A.wdate, '%Y-%m-%d') wdate
from
(
select A.id, A.title, A.writer, A.wdate , C.username, @rownum:=@rownum +1 num
from tb_board A
LEFT OUTER JOIN (SELECT @rownum:=0) B ON 1=1
LEFT OUTER JOIN tb_member C ON A.writer=C.userid
order by A.id
) A
limit 0, 10;


-- 
