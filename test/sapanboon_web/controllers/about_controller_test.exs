defmodule SapanboonWeb.AboutControllerTest do
  use SapanboonWeb.ConnCase

  describe "index" do
    test "Check wording 'เกี่ยวกับเรา' on about pages.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "เกี่ยวกับเรา"
    end

    test "Check wording preface on about pages.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "มูลนิธิสะพานบุญจัดตั้งขึ้นจากกัลยาณมิตรหลายท่าน ที่ต้องการสร้างทานบารมีร่วมกันช่วยทำนุบำรุงพระพุทธศาสนา โดยมีวัตถุประสงค์หลักเพื่อให้ประชาชน บุคคลทั่วไป สามารถร่วมกันบริจาคทานซึ่งเป็นหนึ่งในบุญกิริยาวัตถุ 10 ได้โดยง่าย สะดวก รวดเร็ว โปร่งใส ตรวจสอบได้ โดยสร้าง Crowdfunding Platform และนำเทคโนโลยีสมัยใหม่เข้ามาช่วย โดยเว็บ Sapanboon.org นี้ จะเป็นเหมือนสะพาน หรือตัวกลางที่เชื่อมโยง ระหว่างผู้ที่ต้องการบริจาคสร้างทานบารมีและผู้รับ ซึ่งเป็นโครงการสาธารณกุศลต่าง ๆ เพื่อระดมทุนสำหรับใช้เป็นสาธารณกุศลตามวัตถุประสงค์ของแต่ละโครงการ ซึ่งในแต่ละโครงการที่เข้าร่วมเป็นสะพานบุญจะผ่านกระบวนการคัดเลือกเพื่อให้แน่ใจว่า"
    end

    test "Check wording '1. โครงการที่ทำจริง' on about pages.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "1. โครงการที่ทำจริง"
    end

    test "Check wording clause 1 detail.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "เป็นโครงการที่ทำจริง มีผู้รับผิดชอบ มีเจ้าของโครงการจริง"
    end

    test "Check wording '2. มีความโปร่งใส' on about pages.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "2. มีความโปร่งใส"
    end

    test "Check wording clause 2 detail.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "มีความโปร่งใสในการจัดการทุนบริจาค"
    end

    test "Check wording '3. ตรวจสอบได้' on about pages.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "3. ตรวจสอบได้"
    end

    test "Check wording clause 3 detail.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "สามารถตรวจสอบโครงการ และ มีหลักฐานในการรับปัจจัยต่าง ๆ ได้"
    end

    test "Check wording '4. จัดโอนส่งโดยตรงให้กับเจ้าของโครงการ' on about pages.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "4. จัดโอนส่งโดยตรงให้กับเจ้าของโครงการ"
    end

    test "Check wording clause 4 detail.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "ปัจจัยที่ได้จากการบริจาคในโครงการทั้งหมด จะจัดโอนส่งโดยตรงให้กับเจ้าของโครงการ โดยมีหลักฐานในการโอนและมีผู้รับที่ชัดเจน ตรวจสอบได้ และไม่มีการหักค่าใช้จ่ายในค่าดำเนินการจาก Sapanboon.org"
    end

    test "Check wording '5. สามารถร่วมสนับสนุนสะพานบุญ' on about pages.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "5. สามารถร่วมสนับสนุนสะพานบุญ"
    end

    test "Check wording clause 5 detail.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "สำหรับผู้ที่ต้องการสนับสนุนค่าใช้จ่ายค่าดำเนินการของมูลนิธิสะพานบุญ อาทิ ค่า Host ค่าพัฒนาระบบ ค่าเจ้าหน้าที่ และอื่น ๆ ท่านสามารถร่วมสนับสนุนสะพานบุญได้ในชื่อโครงการ “SPB999 สนับสนุนมูลนิธิสะพานบุญ” โดยจะเริ่มเปิดรับบริจาคในปีหน้า"
    end

    test "Check wording conclude.", %{conn: conn} do
      conn = get(conn, Routes.about_path(conn, :index))
      assert html_response(conn, 200) =~ "ประชาชน บุคคลทั่วไปสามารถร่วมบริจาคผ่านเว็บไซต์ของสะพานบุญ โดยทุนบริจาคที่ได้จะถูกนำไปใช้เพื่อเป็นสาธารณกุศลตามวัตถุประสงค์ของแต่ละโครงการทั้งหมด ในโอกาสนี้คณะผู้จัดทำเว็บสะพานบุญ ขออนุโมทนาบุญกับผู้มีจิตอันเป็นกุศลทุกท่าน ทั้งผู้ร่วมก่อตั้ง ผู้ร่วมพัฒนา ผู้เรียบเรียงเนื้อหา ตลอดจนผู้ทำโครงการ และผู้ร่วมบริจาคทุกท่าน ที่ได้ร่วมกันบริจาคเพื่อสร้างทานบารมีในโครงการ จงเป็นพลวัตรปัจจัย เป็นผลบุญอุทิศให้แก่สิ่งศักดิ์สิทธิ์ทั้งหลายที่คุ้มครอง บิดา มารดา ผู้มีพระคุณ ตลอดจนเจ้ากรรมนายเวรของทุกท่าน ขอให้ทุกท่านจงพบแต่ความสุข ความเจริญยิ่งๆ ขึ้นไป ทั้งทางโลก ทางธรรม กระทำสิ่งใดที่ไม่ผิดทำนอง คลองธรรม ก็ขอให้สำเร็จ สมหวังในสิ่งที่ปรารถนาทุกประการเทอญ"
    end
  end

end
