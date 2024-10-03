--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.8 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: menu_items; Type: TABLE; Schema: public; Owner: food_delivery_user
--

CREATE TABLE public.menu_items (
    id integer NOT NULL,
    external_id integer NOT NULL,
    supplier_id integer,
    name character varying(255) NOT NULL,
    price numeric(10,2) NOT NULL,
    image character varying(255),
    ingredients text[],
    menu_type_id integer
);


ALTER TABLE public.menu_items OWNER TO food_delivery_user;

--
-- Name: menu_items_id_seq; Type: SEQUENCE; Schema: public; Owner: food_delivery_user
--

CREATE SEQUENCE public.menu_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menu_items_id_seq OWNER TO food_delivery_user;

--
-- Name: menu_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: food_delivery_user
--

ALTER SEQUENCE public.menu_items_id_seq OWNED BY public.menu_items.id;


--
-- Name: menu_types; Type: TABLE; Schema: public; Owner: food_delivery_user
--

CREATE TABLE public.menu_types (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.menu_types OWNER TO food_delivery_user;

--
-- Name: order_items; Type: TABLE; Schema: public; Owner: food_delivery_user
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer,
    menu_item_id integer,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL
);


ALTER TABLE public.order_items OWNER TO food_delivery_user;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: food_delivery_user
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_items_id_seq OWNER TO food_delivery_user;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: food_delivery_user
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: food_delivery_user
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id integer DEFAULT 0,
    supplier_id integer,
    total_price numeric(10,2) NOT NULL,
    address text NOT NULL,
    phone text NOT NULL,
    payment_method text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.orders OWNER TO food_delivery_user;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: food_delivery_user
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO food_delivery_user;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: food_delivery_user
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: food_delivery_user
--

CREATE TABLE public.suppliers (
    id integer NOT NULL,
    external_id integer NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(50),
    image character varying(255),
    opening_time character varying(5),
    closing_time character varying(5)
);


ALTER TABLE public.suppliers OWNER TO food_delivery_user;

--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: food_delivery_user
--

CREATE SEQUENCE public.suppliers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suppliers_id_seq OWNER TO food_delivery_user;

--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: food_delivery_user
--

ALTER SEQUENCE public.suppliers_id_seq OWNED BY public.suppliers.id;


--
-- Name: types_id_seq; Type: SEQUENCE; Schema: public; Owner: food_delivery_user
--

CREATE SEQUENCE public.types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.types_id_seq OWNER TO food_delivery_user;

--
-- Name: types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: food_delivery_user
--

ALTER SEQUENCE public.types_id_seq OWNED BY public.menu_types.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: food_delivery_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    hashed_password character(60) NOT NULL
);


ALTER TABLE public.users OWNER TO food_delivery_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: food_delivery_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO food_delivery_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: food_delivery_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: menu_items id; Type: DEFAULT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.menu_items ALTER COLUMN id SET DEFAULT nextval('public.menu_items_id_seq'::regclass);


--
-- Name: menu_types id; Type: DEFAULT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.menu_types ALTER COLUMN id SET DEFAULT nextval('public.types_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: suppliers id; Type: DEFAULT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: menu_items; Type: TABLE DATA; Schema: public; Owner: food_delivery_user
--

COPY public.menu_items (id, external_id, supplier_id, name, price, image, ingredients, menu_type_id) FROM stdin;
973	5949	223	Pizza Texas	6.31	http://wqkjdht.edu/feQGyfG.html	{"Cottage Cheese","Cheese cheddar",Onion,Flour}	1
1302	3081	230	Pizza Hawaiian	2.16	https://hcloygf.net/hVCLZjl.html	{"Japanese tamago",Chicken,Pasta,Pineapple,Peperoni}	4
1151	2873	226	Bean Green Chili Burritos	4.15	https://niyqnmi.edu/tNKVkxP.php	{"Onion rings",Meat,"Bavarian sausages"}	1
1407	8913	232	Pizza Pepperoni with tomatoes	2.34	http://wihonfq.info/OVbNZms.svg	{"Onion rings"}	5
1408	8519	232	Bean Green Chili Burritos	7.58	http://pymmlyz.ru/nriBifi.webp	{Potatoes,Rice,"Caramelized onions",Basil}	4
2470	311	181	Grape Jelly Sandwich	2.76	http://dsptrkf.net/	{"Cottage Cheese",Chicken}	3
2524	5304	182	Pizza	2.36	http://www.gcimpoy.ru/YnExfdT	{Flour,Meat,Corn,Grapes,Peas,Potatoes}	3
2413	2424	181	Swedish Meatballs	7.15	http://htciqyw.com/FxoFZtu.webp	{Butter}	2
2570	3677	182	Pizza Texas	3.63	http://www.xqnjfbi.info/qDTKSYd	{Strawberry}	4
897	6597	222	Chicken Pot Pie	2.59	https://oublksc.top/bXCIVTo.jpg	{Mushrooms,Peanuts,"Bavarian sausages",Salmon}	4
901	7317	222	Pizza Texas	4.38	http://sggykdf.ru/dltwPXE.js	{Sugar,Peas,"Onion rings",Strawberry,Sugar}	1
2425	4385	181	Saint Frank Coffee	5.75	https://www.ceincjx.edu/	{"Bavarian sausages",Peperoni,Pineapple}	4
2417	545	181	Original burger	6.97	https://obutjme.org/UgHAHUD.js	{Salmon,"BBQ sauce",Mushrooms,"Bavarian sausages","Caramelized onions"}	3
891	8841	222	Tortellini Bowls	5.13	https://pprgtiu.top/lZVIxeC.css	{Mushrooms}	3
877	8335	222	Swedish Meatballs	2.01	http://mqnqijp.org/	{"Cheese cheddar",Mushrooms,"Bavarian sausages",Mozarella,Mayo,Cheese}	1
2523	1981	182	Unwrapped Burrito Bowl	6.53	https://lmeccbh.edu/TYtWuOa.webp	{Peas}	2
885	7473	222	Unwrapped Burrito Bowl	7.25	http://dwkoand.biz/dlMCtJZ.css	{"Japanese tamago",Mayo,Peas,Cheese,Onion,"Japanese tamago"}	3
1066	3117	224	New York Style Cheesecake	7.78	https://gddywqo.com/TNrsLKL.css	{"BBQ sauce",Strawberry,"Onion rings","Bavarian sausages",Bacon,Cheese}	2
947	4577	222	Wallmart	3.66	https://oatitzs.top/NeDEnGj.html	{"Unagi sauce",Butter,"Cheese cheddar",Strawberry,Flour,Pasta}	5
1166	4042	227	Grape Jelly Sandwich	6.64	http://mahjkim.net/	{"Cheese cheddar",Pasta,Strawberry,Mushrooms,Peanuts,Nori}	2
1202	5932	228	Unagi Philadelphia	7.26	http://xsaeget.org/KlaqKMn.js	{"Cottage Cheese",Grapes,Bacon,Basil,Pineapple}	1
1377	5683	232	Bacon Cheese Burger	4.51	https://bqvigdg.info/IBoavOh	{"Caramelized onions",Cucumber,"Chili Pepper",Tomatoes}	4
2474	1070	181	Saint Frank Coffee	3.94	https://rwerfef.biz/ckUhRMa.php	{Flour,Peanuts,"Cottage Cheese","Cream cheese",Cucumber}	1
1248	7600	229	Unagi Philadelphia	7.72	https://zpienih.com/	{Cucumber,Strawberry,Mozarella,"Onion rings",Flour,Rice}	2
1100	1436	226	Pizza Pepperoni with tomatoes	7.51	http://kmbxzyd.edu/HpgQrNy	{Milk,Pasta,"Bavarian sausages","Bavarian sausages",Mayo,"Japanese tamago"}	2
3988	1680	240	Pizza Hawaiian	7.14	http://qusgziv.biz/iWZFWSQ	{Flour,"Original sauce",Grapes}	1
1020	6141	224	Original burger	3.67	http://www.bljbqvr.com/mcwZFOQ	{Potatoes,Salmon,Rice,Peperoni,Sugar,"Cheese cheddar"}	3
1452	3886	232	Wallmart	6.61	https://brlxjvy.top/ulWXVMG.html	{Peanuts,Mushrooms,"Caramelized onions",Mayo,Peperoni}	4
1252	6202	229	Bean Green Chili Burritos	2.35	https://www.volreud.top/dvRdmqi	{Pineapple,Peanuts}	2
952	4613	223	Bean Green Chili Burritos	3.02	https://www.cxfdavx.net/	{Basil,Mayo,Nori,Flour}	3
2569	5580	182	Pizza Hawaiian	2.49	http://hdryfyg.net/djCBkwe	{Garlic,Strawberry,"Onion rings",Mozarella,Chicken}	1
1317	8454	230	Philadelphia with salmon	5.88	http://hucoldo.net/hlXJIYF.css	{"Caramelized onions","Caramelized onions",Garlic,Bacon,"BBQ sauce",Tomatoes}	1
2412	6016	181	Pizza Ocean	6.18	http://www.fgnszjq.com/	{"Cheese cheddar","Onion rings","Onion rings",Corn,Pineapple}	1
1052	6484	224	Sweet Potato Pie	5.77	https://cgqbtmr.biz/IIfrUxX.js	{"Caramelized onions",Peperoni,Potatoes,"Cheese cheddar",Mushrooms,Carrots}	4
2437	2632	181	Grape Jelly Sandwich	5.00	https://bvojyub.top/kwsOtwP	{Milk,"Unagi sauce","Cheese cheddar","Japanese tamago",Bacon}	4
1321	1372	230	Unwrapped Burrito Bowl	3.72	http://btsxmru.com/oOqxPTX.php	{Onion,Garlic,Mushrooms,Corn,"Original sauce",Strawberry}	3
1456	5170	233	Pizza Italiano	6.02	https://wpbwicb.org/xRJFovU.jpg	{Peas,Flour}	4
1458	2321	233	Pizza Florida	3.01	http://adnivkj.info/WbwrqJQ	{Flour,Flour,Pineapple,"Caramelized onions",Onion}	2
1351	4207	231	Angel Food Cake	6.40	http://yibffue.edu/RioVRnF	{Flour,Mayo,Nori,"Cottage Cheese",Mozarella,"Cream cheese"}	1
1121	3627	226	Peanut Butter	4.15	https://obonynw.org/hcLyVfA.svg	{Peas,"Onion rings",Bacon,Mushrooms}	4
4192	6749	244	Sweet Potato Pie	2.83	http://rresron.org/LHAJWVx.css	{"Cottage Cheese",Pineapple,Peanuts,Bacon}	2
4391	8492	249	Pizza Hawaiian	3.65	http://alxcili.org/lvQIugZ.svg	{Salmon,Corn,Flour,"BBQ sauce","Unagi sauce","Caramelized onions"}	4
1579	65	235	New York Style Cheesecake	6.62	http://gydftjt.ru/PrLvYJD	{"Japanese tamago",Milk,Flour}	4
4415	1918	249	Pizza Texas	2.12	http://mwkpapt.top/qPcgEGq.css	{Pasta,Cucumber,Butter,"Original sauce",Peas}	3
4347	6259	249	Pizza Texas	4.41	https://khsmxek.ru/mqJxcdV.php	{"Cottage Cheese"}	2
4210	6616	244	Tortellini Bowls	4.95	http://www.dyvorai.top/KvWetYi	{Cucumber,Chicken,Mayo,Chicken,"Cheese cheddar",Tomatoes}	1
3539	3199	201	Angel Food Cake	3.60	http://voffdwq.biz/TjhfLYK.html	{Peperoni,Basil,Rice,Basil,Basil,"Unagi sauce"}	2
4356	6498	249	Original burger	5.49	http://www.qhxujlp.info/	{Pineapple,Chicken,Mushrooms,Butter,Corn,"Japanese tamago"}	2
1807	3494	9	Philadelphia with salmon	3.57	https://uzwofxr.info/MjsDXWS	{Strawberry,Basil,"Chili Pepper",Onion,Nori,Flour}	4
1539	5386	235	Philadelphia with salmon	5.08	http://mvfwxlk.net/	{Mushrooms,"Original sauce"}	2
1822	2552	10	Himawari	2.60	https://dgdfetj.ru/WOuyNhV.webp	{Mushrooms,Flour,Salmon}	1
5078	9578	261	Angel Food Cake	3.67	https://hmdrgwt.info/pMRrHJd.php	{Onion,Pineapple,Corn,Nori}	1
4306	8808	248	Wallmart	4.56	http://xqkpigw.net/OjpdGNe.webp	{Milk,Carrots,Garlic,Flour,Mushrooms}	1
2442	6828	181	Pizza Pepperoni with tomatoes	2.61	http://amxkqgk.top/ZRXOxCd.webp	{Sugar,"Onion rings",Garlic,Butter,Butter,Peanuts}	1
4015	3266	241	Chicken Pot Pie	4.33	http://ivuyivu.ru/lDxEwVe.html	{Garlic,"Bavarian sausages",Strawberry,"Onion rings",Strawberry}	3
4035	6277	241	Philadelphia with salmon	7.08	http://pgvjgqg.edu/GydhSRj.css	{Bacon,Grapes,Strawberry,"BBQ sauce",Butter}	3
4022	4996	241	Swedish Meatballs	5.84	http://ihlpmng.com/jSbyCZQ.html	{"Original sauce",Strawberry,"BBQ sauce","Unagi sauce",Garlic,Cheese}	5
286	9962	211	Pizza	7.36	https://tmzndvm.info/mSuIqyJ	{"Onion rings"}	5
1823	5429	10	Unagi Philadelphia	3.80	http://cxfniol.ru/UMWDmnE.svg	{"Original sauce",Chicken,"Japanese tamago",Flour,"Bavarian sausages"}	4
4037	3447	241	Unagi Philadelphia	3.74	http://yhcxkkq.biz/SrFkmrB.svg	{Milk}	1
948	2129	222	Pizza Hawaiian	6.65	http://btlgaeh.top/KEuCEWO.webp	{Onion,Basil,"Caramelized onions","Bavarian sausages",Flour,Carrots}	1
4256	6315	246	Pizza Ocean	4.60	https://www.yspnqye.com/snLDKxa	{"Japanese tamago",Mozarella,Salmon,Peanuts,Onion}	5
1774	6965	9	Pizza Florida	7.67	http://aooravc.top/qESRDxL	{Strawberry,"Onion rings","Cottage Cheese"}	1
4152	4473	243	Crispy Chicken burger	6.24	https://wnstyyv.top/wiwUfVl.webp	{Onion,"Japanese tamago",Onion,Salmon,Carrots}	3
4102	6893	243	Pizza Ocean	4.21	https://ucmhbgg.info/UsJNIkX.php	{Butter,Butter,Flour,Mushrooms,Sugar}	3
1557	6225	235	Pizza	4.73	https://uetqojk.net/DenRkAi	{"Onion rings",Pasta,"Original sauce",Pasta}	4
1718	6513	8	Original burger	4.78	http://poojcoy.com/uJrGdHY.webp	{Cheese,Mushrooms,Potatoes,Carrots,Basil,Milk}	4
1612	2971	236	Angel Food Cake	4.25	https://fsjcecp.biz/	{Peas,"Cream cheese","Unagi sauce",Strawberry}	5
4325	7211	248	Swedish Meatballs	5.48	http://kghhmlu.com/OMWoxdq.jpg	{"Cream cheese",Mozarella,"Cheese cheddar",Strawberry}	3
1734	6582	8	Bacon Cheese Burger	3.39	http://avurxhr.info/	{Chicken,"Onion rings","Onion rings",Meat,Corn}	3
4017	7511	241	Bacon Cheese Burger	7.12	http://endaoel.info/ORtZRad.webp	{Cucumber}	1
1691	7	3	Pizza Ocean	7.12	https://roll-club.kh.ua/wp-content/uploads/2019/03/kapricheza.jpg.webp	{Mozarella,Peperoni,Tomatoes,"BBQ sauce"}	4
1663	3125	236	Wallmart	3.00	https://yomctwc.info/MFlmmmx	{Mozarella,Salmon,Flour}	3
4050	8368	242	Bean Green Chili Burritos	7.85	http://rgutmjp.info/SYVMsJS.html	{Meat,"BBQ sauce",Grapes,"Onion rings",Flour}	5
4098	2241	242	Wallmart	2.38	https://xgkqegw.net/wJJUiGQ.jpg	{Corn,Corn,Cucumber,Peanuts}	1
4049	6086	242	Philadelphia with salmon	6.83	http://siqrxbn.org/vFSQeQM.js	{Milk}	3
4290	5105	247	Pizza Texas	5.13	https://wbxjwyl.org/MloOCDw.php	{Basil,"Caramelized onions",Strawberry,Mushrooms,Cheese,Flour}	3
1656	616	236	Wallmart	5.22	https://www.bdqhsxk.com/srbMAce	{"Unagi sauce","Bavarian sausages",Onion,Mushrooms,Potatoes}	2
1762	5416	9	Angel Food Cake	4.63	http://cglpsjt.info/jbJKPic.jpg	{Nori,Mayo,"Cottage Cheese"}	5
1715	7786	8	Tortellini Bowls	6.00	https://ziuqnbi.info/xhWlwlK.js	{Bacon}	4
5167	8413	262	Unwrapped Burrito Bowl	3.42	http://wpmrxsz.org/fRWELZa.jpg	{Pasta,Rice,Mushrooms,Mayo,Potatoes,Mushrooms}	2
3176	7423	193	Swedish Meatballs	6.36	https://www.opaqbji.top/BVYZfWv	{Corn,"Cheese cheddar",Rice,"Original sauce",Salmon,"Bavarian sausages"}	4
5105	6716	261	Wallmart	3.06	https://fzjwirb.top/wOlhXRy.svg	{"Japanese tamago"}	4
1736	4743	8	Bean Green Chili Burritos	7.60	http://dpjtyup.org/YDsjtdu.html	{Mozarella,"Cottage Cheese",Pineapple,Garlic}	4
2922	4167	188	Original burger	6.97	https://xyfkjpu.net/cZHFYZG.jpg	{Peas,Carrots,"Japanese tamago",Corn,"Original sauce"}	2
2486	5562	181	Angel Food Cake	7.60	http://uogdbub.com/gLTLWWV.js	{Cucumber,Pineapple,Salmon,Potatoes,Mushrooms}	3
1527	8946	235	Crispy Chicken burger	5.26	https://lkpclop.biz/WTuywwK	{Pineapple}	5
3848	4224	207	Pizza	3.17	https://qoghloa.biz/HdxMXyf.php	{Mushrooms,Mushrooms,Mushrooms,Pasta,Meat}	1
4202	6405	244	Philadelphia with salmon	4.11	http://bfvvavl.info/fxMkhwp.js	{Pineapple,Strawberry,Peperoni,Peperoni}	4
3053	8415	190	Sweet Potato Pie	3.61	https://fsbugaf.info/PsiJSMh.php	{Sugar,"Original sauce",Chicken,Peanuts,Carrots,"Cheese cheddar"}	2
2988	9954	189	Peanut Butter	7.40	http://www.rjxtyea.net/	{Grapes,"Caramelized onions","Cream cheese",Nori,Peperoni,Nori}	2
2957	6793	188	Peanut Butter	7.59	https://owdvrtd.com/ApOZbZO.html	{Salmon,Carrots,Mushrooms,Milk,"Original sauce","Chili Pepper"}	3
5227	3259	262	Tortellini Bowls	6.26	https://www.jqgyipi.net/xIuibUp	{"Cream cheese",Onion,"Original sauce",Butter,"Unagi sauce"}	2
5277	7730	263	Bacon Cheese Burger	7.57	http://mdwxrys.ru/	{Potatoes,Butter,Cucumber,Cucumber,Strawberry,"Cheese cheddar"}	5
5085	6641	261	Bacon Cheese Burger	5.29	https://cuvjdhj.biz/WZVWiAa.svg	{"Japanese tamago",Meat,Carrots,Mayo,Mozarella,Bacon}	3
2866	849	187	Pizza Italiano	3.06	https://ewtrdrt.ru/CuXeSNa.jpg	{Cheese,Mushrooms,Pasta,Flour}	1
2770	2010	185	Bean Green Chili Burritos	4.30	https://hzfotwa.edu/WbWDEFC.php	{"BBQ sauce","Unagi sauce"}	5
597	973	216	Bacon Cheese Burger	5.60	https://mywrgsc.net/YbioOfG	{Garlic,"Onion rings",Mozarella,Chicken,"Original sauce"}	5
3132	8907	191	Pizza Pepperoni with tomatoes	7.49	https://uktyjtl.top/eGfCdnl.jpg	{"Onion rings","Japanese tamago",Sugar,Onion,"Bavarian sausages",Strawberry}	2
2822	8475	186	Pizza Pepperoni with tomatoes	3.72	https://www.zjalqgq.com/	{Peanuts,"BBQ sauce",Grapes,Nori,"Chili Pepper","Chili Pepper"}	5
3226	1343	193	Pizza Italiano	3.96	http://saynepg.edu/dynbqCx.jpg	{Tomatoes,"Japanese tamago",Bacon,Flour,Bacon,Carrots}	4
5106	1199	261	Pizza Italiano	8.00	https://uyrbkxg.edu/qpigWmu.jpg	{Milk,"BBQ sauce",Cucumber,Flour,Peas}	3
3849	4758	207	Pizza Ocean	7.70	https://lkhlmvh.biz/ROlwnTJ.js	{"Onion rings","Onion rings",Flour,Milk,Basil,Rice}	3
2802	1427	186	Bacon Cheese Burger	5.64	https://www.jyfixli.com/UopaxFK	{Cucumber,"Original sauce",Cheese,Bacon,"Cream cheese"}	1
5279	5597	263	Bacon Cheese Burger	2.84	https://ynfwkzx.info/ZACxxfG	{"Caramelized onions","Japanese tamago",Mushrooms,Nori,Peperoni,"BBQ sauce"}	3
331	9053	211	Grape Jelly Sandwich	5.21	http://dypdhoy.com/uHqaxGq.jpg	{"BBQ sauce",Tomatoes}	4
4482	9033	253	Unagi Philadelphia	3.65	http://www.cimkasr.net/	{"Caramelized onions",Grapes,"Bavarian sausages",Nori,"BBQ sauce"}	1
2763	4570	185	Swedish Meatballs	7.84	https://raxfspd.info/pVXYRvs.svg	{Pineapple,"Caramelized onions",Tomatoes,"Japanese tamago","Unagi sauce"}	5
2671	4156	184	Bean Green Chili Burritos	3.42	https://kgbytht.info/	{"Cheese cheddar",Strawberry,Flour,Sugar}	1
2721	2380	184	Pizza Italiano	4.12	https://mjzqiqz.biz/WQvbQtQ.php	{Nori,"Unagi sauce",Garlic,"BBQ sauce","Caramelized onions",Flour}	3
2978	7954	188	Tortellini Bowls	6.58	https://ebpbmbh.top/kBGhjWk.js	{Mozarella,"Chili Pepper",Basil,Flour,Pasta,Salmon}	4
2872	4145	187	Chicken Pot Pie	2.18	http://ihucbmw.com/XcCeFRK.js	{"Caramelized onions",Garlic,Basil,Potatoes}	2
3157	7394	192	Peanut Butter	7.33	https://ljofbao.org/MpMTaDV.php	{"Unagi sauce",Mushrooms,Mushrooms,Peperoni,Butter,Garlic}	3
3184	5247	193	Pizza	3.52	https://www.begyvyn.com/pKRfFho	{Butter,"Cheese cheddar","Caramelized onions","Japanese tamago",Flour,"BBQ sauce"}	4
5234	6726	262	New York Style Cheesecake	5.16	http://wgppyjw.biz/TJbHjZS.css	{Pasta,"BBQ sauce",Chicken,Onion,Potatoes,Flour}	2
5121	1267	261	Pizza Italiano	5.00	https://cwrxeyk.info/KNuvYlD.html	{Pasta,"Bavarian sausages",Peas,"Cream cheese",Mayo}	4
3077	1522	190	Saint Frank Coffee	2.76	https://awnjbek.edu/fxSpDmp.html	{Butter,Flour,Mushrooms,"Cream cheese","Bavarian sausages"}	4
3027	6519	189	Unwrapped Burrito Bowl	2.14	http://zmiuaqt.edu/qdFGbAx.php	{Meat,"Chili Pepper",Cucumber,"Onion rings",Flour,Pineapple}	5
1280	7349	229	Pizza Florida	5.39	http://qocoaec.com/gnGSUAJ.php	{Mushrooms,Peas}	2
3492	2782	200	Pizza Ocean	4.11	http://mywbtpc.com/tREeuLR.html	{Cheese,Grapes,Cucumber,Peas,Corn}	3
4714	2242	255	Angel Food Cake	7.36	https://gedgicj.ru/emFlncs.html	{Onion,"Bavarian sausages",Milk,Bacon,Corn}	3
3429	2201	199	New York Style Cheesecake	5.57	https://rcgomnr.net/YZHDUhx.js	{Onion,Cheese,"Caramelized onions",Corn,"BBQ sauce"}	4
3444	736	199	Philadelphia with salmon	3.31	http://nfqttvq.info/XfXnyWj.webp	{Garlic,"Cream cheese"}	2
4780	8370	256	Pizza Italiano	2.41	http://exkqmdv.top/mxxTlnl	{Carrots,"BBQ sauce","Cheese cheddar",Peanuts,Garlic}	1
3340	799	196	Grape Jelly Sandwich	3.17	http://vnrmdsg.ru/lOjDWVx.php	{Peas,"Chili Pepper",Pasta,Chicken,Mayo}	3
4612	8174	254	Pizza Florida	3.36	https://nvulxjy.biz/JYvSDUs.svg	{"Original sauce",Cucumber,Mushrooms,Tomatoes}	3
4712	7715	255	Sweet Potato Pie	6.79	http://isgeygi.info/HhMwvGj.webp	{Rice}	2
4763	3289	256	Philadelphia with salmon	7.08	https://ojamxer.edu/xvgUYhw.jpg	{Butter,Mayo,Cucumber,Tomatoes}	5
4556	3823	254	Pizza Ocean	2.43	https://zbohbpj.ru/TCXATKh.js	{Corn,"Chili Pepper",Peanuts,Mozarella}	3
3291	6497	194	Bean Green Chili Burritos	5.70	https://hdmamed.net/cUdxGHO.jpg	{"Caramelized onions",Pineapple,Cheese,"Japanese tamago",Milk}	3
3332	7046	196	Tortellini Bowls	5.16	https://pcpjuvn.top/vDIJyJP.jpg	{"BBQ sauce","Original sauce",Tomatoes,Mozarella,Milk}	1
5328	9775	264	Crispy Chicken burger	2.07	https://mwqmyav.net/IrEodkS.js	{Tomatoes,Mushrooms,Cheese,Sugar,Garlic,Pasta}	2
4786	4841	256	Peanut Butter	3.41	https://qkxdvxm.ru/	{Flour}	5
3892	581	239	Tortellini Bowls	7.10	https://www.echpyoj.top/dmqrVKx	{"Bavarian sausages","Caramelized onions",Pasta,Cucumber,Mushrooms}	5
3526	2642	201	Saint Frank Coffee	5.25	http://whkivcd.net/AQHCRdX.css	{Grapes,Potatoes,Strawberry,Meat,"Caramelized onions"}	1
4570	6437	254	Angel Food Cake	2.18	http://nxnnfyf.com/CXwWoNC.svg	{"Caramelized onions",Mushrooms,"Unagi sauce",Nori,Mushrooms,Mushrooms}	1
3596	1769	203	Crispy Chicken burger	2.62	https://xwblrpb.org/oBjPdld	{"Bavarian sausages",Carrots,"Caramelized onions",Cheese,"BBQ sauce"}	4
5379	2	1	Pizza Texas	6.08	https://roll-club.kh.ua/wp-content/uploads/2021/04/4-mjasa-1.jpg.webp	{Corn,Onion,Mushrooms,"Bavarian sausages",Mozarella,"BBQ sauce"}	4
3385	3661	198	Wallmart	2.11	http://wivmytf.edu/GqMrgFn.html	{Milk,Mayo,"Cottage Cheese","Onion rings"}	2
4471	7012	253	Peanut Butter	5.87	http://khwxbgd.net/	{Mozarella,"Cottage Cheese",Peanuts,Flour,Peanuts}	5
3890	2831	239	Saint Frank Coffee	7.31	http://crdtpgl.com/HrRDiGe.webp	{Carrots,"Original sauce",Mayo}	4
3998	4210	240	New York Style Cheesecake	3.90	http://ahqyzvi.ru/xPlJpkA.svg	{Cheese,Mayo}	3
5324	6684	264	Original burger	6.96	http://yaamtoy.com/iNJmKEf.svg	{Rice}	2
3590	7449	203	Saint Frank Coffee	7.92	https://wuqpbnv.org/YwqKJri.svg	{Nori,"Bavarian sausages",Mushrooms,Mushrooms}	2
5351	3437	264	New York Style Cheesecake	3.36	https://womrogp.ru/onOIVej.css	{Meat,Pasta,"Cottage Cheese",Basil}	5
4660	4294	255	Angel Food Cake	3.73	https://qwrfpgg.ru/RTVbHvP.html	{Salmon,Peas,"Caramelized onions",Salmon}	1
1279	4627	229	New York Style Cheesecake	4.17	http://www.nelmlug.com/sTRtNAU	{Meat,"Cheese cheddar",Onion}	4
3490	1117	200	Himawari	2.50	http://www.yyiwxrv.biz/	{Sugar,"Caramelized onions"}	2
4667	591	255	Pizza Hawaiian	2.90	https://www.dmugvja.com/	{Strawberry,"Bavarian sausages",Garlic,Garlic}	2
3280	8281	194	Bean Green Chili Burritos	2.88	http://fdapoex.org/LhObQgx.html	{Carrots,"Cheese cheddar"}	1
3540	5438	201	Pizza Florida	4.41	http://vqggdtd.biz/JHArZOD.html	{"Bavarian sausages","Bavarian sausages",Pasta}	3
3235	8053	193	Grape Jelly Sandwich	7.34	https://bvdyada.net/kmVMjto.js	{Cheese,"Unagi sauce",Peperoni,Tomatoes,Peas,Peanuts}	5
3642	6699	203	Pizza	6.26	http://mxaivgk.top/eLsSAtg.svg	{"Unagi sauce","BBQ sauce",Corn,"Cottage Cheese"}	4
3894	5359	239	Saint Frank Coffee	3.53	http://kbheeln.top/dGwmsfM.php	{Meat}	1
3936	6565	239	Chicken Pot Pie	5.33	https://www.voxmkfy.org/	{Nori,Flour,Flour,Sugar,"Cottage Cheese","Unagi sauce"}	3
3897	1097	239	Saint Frank Coffee	5.14	https://ayibapp.top/ccUOaLH	{Garlic,Chicken,Milk}	1
4653	3799	255	Crispy Chicken burger	7.94	http://aoafjfh.top/IHdMgGS.js	{Tomatoes,"Cheese cheddar",Salmon,Onion,Flour,"Cheese cheddar"}	5
4498	9488	253	Crispy Chicken burger	7.78	http://www.dfdywre.ru/	{Strawberry,Mayo,Sugar,Mushrooms,"Caramelized onions",Milk}	2
1529	5079	235	Angel Food Cake	4.31	https://vagnand.top/KcudQux.webp	{Milk,Mushrooms,"Caramelized onions",Pasta,Strawberry}	1
3694	5515	205	Sweet Potato Pie	6.11	https://www.uiqakxq.top/	{"Caramelized onions",Meat,Peanuts,Garlic}	4
4815	9027	257	Himawari	3.87	http://kbbmykk.org/cnOMfKr.css	{Potatoes,Tomatoes,Milk,"BBQ sauce",Meat,Chicken}	1
4984	742	259	Pizza Florida	7.23	http://tcxmhwc.net/BSOAYPx.php	{"Onion rings","Caramelized onions",Basil,Basil,Mushrooms}	5
442	7739	214	Pizza Hawaiian	4.73	https://vgninbv.biz/UVmTxnK	{Pasta,Bacon,Mushrooms,Meat,Meat}	5
4854	6505	257	Tortellini Bowls	6.87	http://ecdjvnr.ru/uswJOdX.php	{"Onion rings",Mushrooms,"Onion rings",Mayo,Flour,Salmon}	5
4929	4489	258	Pizza Pepperoni with tomatoes	7.55	http://www.jnvvnhy.info/	{Pasta,Potatoes,Flour,Tomatoes,"Japanese tamago",Sugar}	4
3771	2331	206	Grape Jelly Sandwich	5.38	http://tbagkbr.org/YoqkSbv.js	{Nori,"Original sauce","Bavarian sausages","Cream cheese",Strawberry}	2
341	7688	211	Sweet Potato Pie	5.86	http://www.dmkvzpp.org/	{Flour}	3
5381	16	6	Chicken Pot Pie	5.37	https://i5.walmartimages.com/asr/64dc7c05-7d2c-4e29-854d-bada644f019e_1.f4de24032b1a5f48063903f488213f99.jpeg	{Chicken,Flour,Peas,Carrots}	5
425	6005	213	New York Style Cheesecake	3.60	http://lixijaf.top/TXeRdOP.jpg	{Pineapple,Sugar,Bacon,Tomatoes}	2
978	2580	223	Bacon Cheese Burger	7.25	http://mwdproz.biz/ipxNPtQ.php	{Cheese,"Unagi sauce",Strawberry,Bacon,"Cheese cheddar","Japanese tamago"}	1
438	5387	214	Chicken Pot Pie	6.42	http://xrxfiyf.edu/CarVfxZ.php	{Mozarella,Cheese,Cucumber,Potatoes,Grapes,"Bavarian sausages"}	4
4793	115	257	Pizza Hawaiian	6.05	http://vmeuqns.com/oiinSqW.php	{Basil,"Japanese tamago",Salmon,Potatoes,Basil,"Original sauce"}	2
4866	8387	257	Pizza Texas	3.79	https://yxrglpd.com/oJCVapZ.html	{Flour,Salmon}	5
3744	4711	205	Bean Green Chili Burritos	7.65	http://stfubwj.biz/timvpEC.js	{Salmon,"BBQ sauce",Butter,Onion,Mozarella,Onion}	5
302	5871	211	Philadelphia with salmon	4.31	http://tiuimje.info/kTYspts.php	{"Japanese tamago",Sugar,Salmon,"Cottage Cheese",Cheese,Mushrooms}	5
281	1180	211	New York Style Cheesecake	3.03	http://ziigyvg.top/vbxConl.js	{Strawberry,"Caramelized onions","Bavarian sausages",Flour}	5
3792	4840	206	Pizza Texas	7.12	https://gbjdxtk.info/JWSWhpU.php	{Tomatoes,"Chili Pepper",Corn,Mozarella}	3
521	2898	215	New York Style Cheesecake	4.02	https://edvzvbf.info/OyVZlge.js	{Strawberry,"Cottage Cheese",Nori,Grapes,"Onion rings"}	5
287	5106	211	Original burger	4.21	http://onffkqj.net/ETaaxAI	{Bacon,"Unagi sauce",Chicken,Flour,Nori,Salmon}	3
5069	4830	260	Philadelphia with salmon	3.10	https://xfmjgyx.net/	{Bacon,Tomatoes,Bacon,Grapes,Peanuts}	4
541	3560	215	New York Style Cheesecake	4.89	https://www.kltesnn.edu/	{"Bavarian sausages","Bavarian sausages",Pasta}	3
4951	467	258	Angel Food Cake	6.50	https://ljnerul.info/	{Tomatoes,"Cheese cheddar",Mushrooms,Chicken,Potatoes,Milk}	4
378	5089	213	Pizza Florida	2.68	http://browmby.top/fAHFPRg.html	{"Cottage Cheese",Mushrooms,Garlic}	1
427	4086	213	Pizza Florida	5.89	http://www.ykdtkoo.ru/	{Salmon,Peanuts,"Unagi sauce"}	5
288	5352	211	Tortellini Bowls	4.52	https://yyutvhl.edu/fPahsFr.svg	{Peperoni,Peperoni,Cucumber,Corn,"Caramelized onions","Bavarian sausages"}	4
4975	7448	259	Angel Food Cake	7.27	http://njihory.edu/RSGVlGL.css	{Pineapple,"Chili Pepper",Cucumber,Flour}	4
345	2016	211	Original burger	3.64	http://www.lxpieri.net/nuvDtDL	{Bacon,Bacon,"Onion rings","Cheese cheddar",Cucumber}	1
392	2362	213	Pizza Hawaiian	6.66	https://eohuabe.edu/MwHBSGI.js	{Sugar,"BBQ sauce",Peas,Strawberry,Mozarella,Carrots}	2
241	8307	210	Philadelphia with salmon	6.92	http://pemnhkh.biz/CcLFbYN.webp	{"Onion rings",Onion,"Chili Pepper",Garlic}	4
591	9381	216	Wallmart	2.76	https://ekwhgda.info/KGvSGiP.svg	{"Chili Pepper",Onion}	2
233	7161	210	Philadelphia with salmon	3.24	http://www.pomoqxe.biz/WFTLuJU	{Peas,Mushrooms,"Chili Pepper","Chili Pepper",Flour,"Cottage Cheese"}	5
490	1602	215	Pizza Florida	6.54	http://soijphm.ru/hHpmXET.svg	{Milk,Pineapple,Mushrooms,Peas}	2
3801	6443	206	Pizza Pepperoni with tomatoes	6.73	https://vmknmye.ru/fEUDBHN.js	{"Chili Pepper",Chicken,Flour,Mayo,Onion,Cheese}	4
511	9431	215	New York Style Cheesecake	6.16	https://qfqafxk.edu/bNBbljZ.jpg	{Mozarella,Pasta,Peas,Chicken,"Cottage Cheese",Onion}	2
328	9115	211	Himawari	7.58	http://www.ukstcne.top/	{Mayo}	5
540	2811	215	Original burger	2.78	https://bhoqbdu.biz/	{Sugar,Mozarella,Meat}	1
606	1611	217	Tortellini Bowls	4.59	https://www.fsjnkpk.com/	{Salmon,"Unagi sauce","Cottage Cheese","Original sauce",Peanuts,Onion}	3
4900	184	258	Pizza Texas	5.47	https://wvkmrxl.biz/ISYieGa.css	{"Cheese cheddar","Cheese cheddar","Unagi sauce",Peperoni,Peperoni}	3
2258	645	158	Grape Jelly Sandwich	6.41	http://waubevy.biz/PhPxKTR.svg	{Peperoni,Nori,"Onion rings","Japanese tamago","Cream cheese","Unagi sauce"}	5
469	2538	214	Unwrapped Burrito Bowl	2.70	https://gnsyetq.biz/PQEeubt.svg	{Carrots,Mayo,Peas,Grapes,"Caramelized onions",Garlic}	3
1099	3107	226	Unwrapped Burrito Bowl	6.69	https://djsbbiq.info/	{Potatoes,Basil,Milk,"Chili Pepper","Caramelized onions",Meat}	2
2122	8425	155	Sweet Potato Pie	5.04	https://lbnxvmp.edu/EjsyIwx.html	{Mayo,"Unagi sauce",Peperoni,"BBQ sauce","Cheese cheddar"}	3
4144	5192	243	Chicken Pot Pie	3.16	https://www.tcwutqt.ru/	{Salmon,Peanuts,Garlic}	3
2208	1548	156	Sweet Potato Pie	6.34	http://xpxpjjl.net/cXpyupD.jpg	{Onion,"Cheese cheddar",Corn,"Cottage Cheese",Rice}	1
648	8727	217	Angel Food Cake	5.53	http://kouwney.edu/	{"Japanese tamago",Garlic,Mushrooms,Pasta,Carrots,Onion}	2
829	6334	219	Pizza Hawaiian	6.87	http://xiwthhl.info/	{Milk,Onion,Carrots,Peperoni,Peanuts,Butter}	3
2268	3848	158	Pizza Hawaiian	2.29	https://www.pfjkhhi.net/	{Garlic,Bacon,Chicken,Potatoes,Grapes}	3
2219	1481	156	Pizza Italiano	3.77	https://lngqqbj.edu/gGxYQRf.svg	{"Bavarian sausages",Rice,"Onion rings",Rice,"BBQ sauce",Nori}	1
1966	6583	153	Himawari	7.09	https://obsljhx.net/CSieTZC	{Cheese,Rice,Pasta,Milk}	4
2395	3377	160	New York Style Cheesecake	3.15	http://obvewqs.biz/eVhLpOd.php	{Pasta,Mushrooms,Pasta,Carrots,Garlic,"Bavarian sausages"}	5
3137	1034	191	Saint Frank Coffee	7.24	https://www.wbwgysl.com/bmECgBr	{Chicken}	1
2020	461	154	Pizza Texas	7.02	http://usohbqi.edu/iifSoRW.jpg	{Peperoni,Basil,Strawberry}	5
1919	3713	153	Pizza Hawaiian	6.53	https://www.gulyzmw.ru/bqtOuMu	{"Cheese cheddar"}	3
2183	6780	156	Philadelphia with salmon	7.00	http://iqbgopw.ru/rpOfeth.webp	{Flour,Pineapple,Pasta,Bacon,Pineapple,Pineapple}	5
3544	8232	201	Sweet Potato Pie	5.52	http://gyplfrd.top/	{Milk,"BBQ sauce","Original sauce","Onion rings"}	4
1906	9285	153	Chicken Pot Pie	2.85	https://www.ssghygh.ru/	{"Cheese cheddar","Bavarian sausages","Japanese tamago","Original sauce",Sugar,Mushrooms}	5
2869	4746	187	Pizza Italiano	5.74	https://iwwyqbs.net/XMvRAep	{Peas,Tomatoes,Corn,"Japanese tamago",Sugar}	2
1273	5841	229	Unagi Philadelphia	5.40	https://www.upegdhx.top/	{Sugar,Butter,"Original sauce",Pineapple,Mozarella,Garlic}	5
1867	1319	152	Pizza Pepperoni with tomatoes	5.32	https://mgsayta.com/rmyAwKu.html	{Carrots,"Onion rings","Bavarian sausages"}	5
638	9045	217	New York Style Cheesecake	2.87	http://www.pcdkdhh.org/UymStlW	{Salmon,Sugar,Potatoes,Mushrooms,Peas}	4
717	4203	218	New York Style Cheesecake	7.31	https://mvfyqqc.edu/ciCDYec.js	{Peperoni,Bacon,"Cream cheese",Garlic,Mushrooms,Butter}	1
1044	1954	224	Pizza Pepperoni with tomatoes	4.28	http://xukvpus.ru/LditfXE.php	{Butter,Potatoes,"Japanese tamago",Meat,"Unagi sauce",Basil}	3
2071	6095	155	Pizza Hawaiian	7.10	http://jxsxsng.ru/dHDVuXr	{Potatoes,Bacon,Sugar,Flour,Potatoes,Salmon}	3
2306	5721	158	Tortellini Bowls	2.41	http://eilvlql.org/ONLgxyI.js	{Cheese,Bacon,Basil,Peas,Corn,Bacon}	4
1182	8250	228	Wallmart	4.94	http://rndgkqb.biz/VrCohgf.html	{Flour,"Unagi sauce",Pineapple,Pineapple,"Chili Pepper",Sugar}	3
1263	8264	229	Sweet Potato Pie	7.61	http://yvwwhnz.edu/XqZSjOu.html	{"Cottage Cheese",Strawberry,Mayo,Tomatoes,Mushrooms}	2
2070	2979	155	Bean Green Chili Burritos	2.71	https://fwotnqy.top/JMJELtk.svg	{"Chili Pepper",Salmon}	3
2333	9981	158	New York Style Cheesecake	3.55	http://zungdus.net/CKxforM.svg	{Tomatoes,Peperoni,Peas,Bacon,Flour,Nori}	3
4348	6944	249	Sweet Potato Pie	3.63	https://akpfcmm.com/aRZNmug.js	{Sugar,"Caramelized onions",Meat}	4
4433	1596	251	Peanut Butter	6.07	http://rptarjp.net/vuvFZkj.html	{Basil,"Chili Pepper","Cheese cheddar",Cheese,Carrots,"BBQ sauce"}	2
1928	8443	153	Pizza Florida	5.71	http://keuvscb.org/	{Strawberry,"Japanese tamago",Potatoes,Mushrooms,Butter,Strawberry}	3
2169	1968	156	Chicken Pot Pie	5.57	https://yalrdiw.com/OLHTtBb.js	{Onion,Nori,Salmon}	1
2141	3770	155	Chicken Pot Pie	6.36	https://iljpmby.biz/cKXPjOP	{Peanuts,"Unagi sauce",Salmon,Basil,Potatoes,"Original sauce"}	2
742	6162	218	Tortellini Bowls	3.05	http://ehnrozj.net/yZbQiQc.php	{"Cottage Cheese",Mushrooms,Peas,Milk,Salmon,"BBQ sauce"}	2
1872	6689	152	Bean Green Chili Burritos	7.38	http://www.locgcmu.com/	{Salmon,Chicken,Peanuts,Cheese,Peas}	3
690	3509	218	Crispy Chicken burger	5.98	https://www.manwkio.info/	{"BBQ sauce","Cream cheese",Garlic,"Japanese tamago",Peanuts,"Japanese tamago"}	2
1977	8950	154	Bean Green Chili Burritos	6.44	http://ktsgmbs.info/xLCIDIA.svg	{Strawberry,"Cheese cheddar",Nori,Corn,Pineapple,"Onion rings"}	4
1507	666	234	Pizza Pepperoni with tomatoes	4.58	https://dubrimn.com/pDuhCIN.html	{Potatoes,Chicken}	5
516	7883	215	Philadelphia with salmon	6.27	https://wlnwwtx.ru/VRwgFec.js	{Mayo,"Cheese cheddar",Peas}	2
1547	1753	235	Crispy Chicken burger	6.19	http://sjktcsk.org/	{Grapes,Mozarella}	3
2647	1185	183	Unagi Philadelphia	3.45	http://lsgjrqb.ru/FuyOSRn.css	{Pineapple,Butter,"Japanese tamago",Grapes,Mushrooms,"Japanese tamago"}	2
1688	4	2	Original burger	4.81	https://316024.selcdn.ru/wiget/4d4c871a-107f-11e7-80df-d8d38565926f/49e75c35-6fff-4a0f-8d6a-959cf4721c74_Medium_.jpg	{Cheese,"Caramelized onions",Tomatoes,"Original sauce"}	3
3548	8039	202	Tortellini Bowls	5.65	http://yryhkfx.info/uaIuSwf.php	{"Cottage Cheese","Unagi sauce",Garlic,Peas}	3
3144	414	192	Saint Frank Coffee	3.07	http://inipffl.top/mCjsPqu.js	{"Caramelized onions","Cottage Cheese",Onion}	3
1567	3487	235	Peanut Butter	5.88	http://srpbqrd.top/QpKUXUb.webp	{Meat,Mushrooms,"Japanese tamago",Onion,"Onion rings",Potatoes}	2
1534	1691	235	Tortellini Bowls	4.52	http://gfhyygt.org/fKLLbXX.css	{"Bavarian sausages",Chicken,Flour,Onion,Pasta,Chicken}	2
349	8290	211	Angel Food Cake	4.26	http://zdsuqok.info/YRXfwXd.js	{Cheese,Milk,"Caramelized onions","Cheese cheddar","Onion rings",Tomatoes}	1
4199	3382	244	Grape Jelly Sandwich	6.27	https://ywqmvjv.top/LhwBbsm.svg	{"Chili Pepper","Chili Pepper","Cream cheese",Flour,Corn}	4
3143	4222	192	Bean Green Chili Burritos	3.64	http://wovjbuo.com/CtiEQqA.html	{Cheese,Pineapple,Milk,Peperoni}	4
5100	5505	261	Swedish Meatballs	3.60	http://tnzttqk.biz/YYvsGhB.webp	{Strawberry,"Japanese tamago","Cheese cheddar",Grapes,"Cottage Cheese",Mayo}	5
1523	9534	235	Bean Green Chili Burritos	7.84	https://www.ivgoqnn.edu/	{"Unagi sauce",Strawberry,"BBQ sauce",Salmon,Mushrooms,Peanuts}	1
3359	1332	198	Pizza Pepperoni with tomatoes	5.19	http://fiztpqn.com/nZTrpuT.webp	{Basil,Onion,Flour,Basil,"Caramelized onions"}	1
1877	4009	152	New York Style Cheesecake	7.06	http://www.xujuldi.biz/PMuOUrb	{Sugar,Sugar,Onion,Cucumber,Meat,Onion}	3
1540	4501	235	Wallmart	3.13	https://tyuyzss.ru/vdnkQbE.php	{Peanuts,Bacon}	5
1338	8769	231	Angel Food Cake	4.29	http://vbcnjme.ru/BjXllYc.css	{Onion,Pasta,Corn,"Chili Pepper","Bavarian sausages",Strawberry}	2
5382	17	6	Beef & Bean Green Chili Burritos	3.62	https://i5.walmartimages.com/asr/94fb73ff-59ce-48c2-acd3-42bbb3c52e67.56499b84aa3d79c7a9c51f29da5c3626.png	{"Chili Pepper",Onion,Rice,Mayo}	6
4051	6317	242	Pizza Texas	4.44	http://kuzoedo.net/yDKLSnk.php	{Garlic,Carrots,Pasta,"Chili Pepper",Peperoni,Grapes}	4
1660	4875	236	Original burger	4.97	http://cfimivd.top/aUWaJjB.jpg	{Onion,"Chili Pepper","Original sauce",Peanuts,Bacon,Pineapple}	3
574	3196	216	Saint Frank Coffee	6.29	http://www.qzlpiww.top/VWsSuNg	{"Japanese tamago",Tomatoes,"Japanese tamago",Peas,"Original sauce"}	2
1131	2445	226	Grape Jelly Sandwich	7.84	https://egjljmb.ru/vQmCYWj.svg	{"Japanese tamago",Pasta,Rice,Flour,Grapes,"Unagi sauce"}	3
1732	5780	8	Wallmart	6.70	https://iaqpklp.ru/jWiAPGL.webp	{"Japanese tamago","Onion rings",Pineapple,Onion,Peperoni,Carrots}	1
1541	2845	235	Peanut Butter	3.02	https://keimgtj.edu/bwJOwcj.php	{Garlic,"BBQ sauce",Grapes,Carrots,Onion,Pasta}	3
1387	5023	232	Bacon Cheese Burger	7.15	http://qryciuq.edu/webQjmB.webp	{Flour,"Caramelized onions",Carrots,Basil,Mushrooms,Nori}	1
2476	1218	181	Pizza Florida	7.79	https://www.ibtuija.top/YrxWrTM	{"Cheese cheddar","Japanese tamago",Salmon,Flour,Onion,Salmon}	4
4668	7570	255	Pizza Florida	5.35	http://www.aeoilob.top/eRniYoc	{Salmon,Grapes,Cheese,Onion,"Onion rings","Caramelized onions"}	1
1530	8487	235	Pizza Hawaiian	2.84	http://skpqgoe.edu/asbQRJn.webp	{"Chili Pepper",Mushrooms,Peanuts,Peas,Sugar}	1
1004	8154	223	Unagi Philadelphia	6.83	http://jqkhesi.info/QfFoGvD.php	{"Japanese tamago",Garlic,"Caramelized onions",Cheese,Cheese}	2
2041	7776	154	Peanut Butter	6.53	https://lfwghvi.biz/XIqgAXH.jpg	{"Caramelized onions","BBQ sauce","Original sauce","BBQ sauce",Bacon,Flour}	1
2579	8480	183	Pizza Texas	5.90	http://www.rzsurrk.edu/XexkmkV	{Basil,Milk}	4
3142	5843	192	New York Style Cheesecake	2.76	http://wttpohg.com/jJvGVkF.html	{"Bavarian sausages","Onion rings",Mozarella,"Cottage Cheese"}	4
4103	238	243	Unagi Philadelphia	6.65	http://deohtlx.info/JGLhTZr	{Onion,Mushrooms,Grapes,"BBQ sauce","Unagi sauce",Onion}	5
1256	8082	229	Unagi Philadelphia	4.89	https://kcegydq.info/HSIUUVi.webp	{Basil,"Caramelized onions",Pineapple,Mozarella,"Bavarian sausages",Strawberry}	1
1409	6231	232	Unwrapped Burrito Bowl	7.20	https://www.ubvjtvq.top/	{"Chili Pepper",Tomatoes,"Original sauce",Pasta,Sugar,Carrots}	2
515	6422	215	Wallmart	4.96	https://rdlgwbp.info/sjtjiUs.html	{Mayo,"Japanese tamago",Potatoes,Peperoni}	3
4404	1344	249	Pizza Texas	5.58	http://cgarura.ru/ytVadXG.webp	{"Chili Pepper","Bavarian sausages","BBQ sauce","Original sauce",Peas,Milk}	3
1861	1623	151	Crispy Chicken burger	3.01	http://qbhrltw.biz/sAigyRR.html	{Butter,Onion,Peanuts,"Original sauce",Peperoni,Peas}	1
4029	2989	241	Pizza Texas	7.57	https://miarqku.top/mOuQeIK.js	{Rice,Milk,Flour,Grapes}	2
2706	3802	184	Unagi Philadelphia	7.44	http://gheopeh.edu/mxRqSKf.html	{Milk,Mushrooms,Mushrooms,Pineapple}	2
3475	7528	199	Pizza Italiano	6.50	http://www.ddcvscw.net/	{"Bavarian sausages",Peanuts,Onion,Corn,"Onion rings",Potatoes}	5
3466	2728	199	Himawari	7.71	https://rhznxhi.edu/vtZmhDG.php	{Onion,Garlic,"Cheese cheddar","Japanese tamago",Mozarella,Basil}	1
3211	8303	193	Angel Food Cake	5.64	http://dtmqwjd.net/nvOlRnc	{Basil,"Japanese tamago",Mushrooms,"BBQ sauce",Carrots}	1
2576	7150	183	Saint Frank Coffee	5.26	http://vypmcnw.edu/	{Grapes,"Cottage Cheese",Salmon,"Japanese tamago",Mushrooms}	3
4573	8334	254	Unagi Philadelphia	7.80	https://payicfs.ru/sywPiZO.php	{"Caramelized onions",Peanuts,Bacon,Chicken,Cucumber,Tomatoes}	3
3501	5569	201	Angel Food Cake	2.80	http://bvaxdfl.com/xSSyZsP.css	{Chicken,Salmon,Peas}	4
3168	7019	192	Wallmart	5.44	https://qfzdgfm.com/NGjqswZ.php	{"Chili Pepper",Strawberry,"Cream cheese",Basil,Cucumber,"Caramelized onions"}	1
2790	4486	185	Bacon Cheese Burger	3.06	http://gwrsmqo.org/cHkEUNT.php	{Basil,Garlic,Rice,Butter,Mozarella}	3
2840	1271	186	Philadelphia with salmon	5.02	https://uqbqqnt.net/spLtPrG.webp	{Meat,Pineapple,Flour,Tomatoes,Cucumber,Onion}	5
4300	2428	247	Swedish Meatballs	4.82	https://lccdaet.com/PJSYvJs.php	{Peas,Mushrooms,"Bavarian sausages","Japanese tamago",Flour}	3
4488	1594	253	Original burger	2.48	http://www.zymwhwq.net/ajNlAgX	{Pasta}	4
2864	4002	187	Unwrapped Burrito Bowl	5.04	http://qavftxf.biz/	{Mushrooms,Mushrooms,Cheese,Tomatoes,Mushrooms,"Caramelized onions"}	4
5172	3436	262	Philadelphia with salmon	6.86	http://www.idpcakj.net/JouKiXK	{Pineapple,Grapes,Pasta,"Cheese cheddar"}	3
3315	8479	195	Philadelphia with salmon	5.73	http://mjztawg.ru/fgNXDuR.jpg	{Mushrooms,"Original sauce",Flour,Sugar}	5
2871	4418	187	Original burger	3.40	https://xipqmzm.biz/MIkXMaK.webp	{Bacon,Peperoni,"Cheese cheddar",Mayo}	2
2487	5997	181	Philadelphia with salmon	5.98	https://hpptogf.info/JRtQwPS.jpg	{Pasta,Pasta,Butter,Peperoni,"Cottage Cheese",Bacon}	3
2991	9388	189	Pizza Florida	2.70	https://ophejky.biz/srPlIHv.jpg	{Tomatoes,Strawberry,Corn,Tomatoes,"Cream cheese",Potatoes}	2
1931	5284	153	Swedish Meatballs	3.54	https://xhvknbt.info/RSpqaiO	{"Cream cheese","Original sauce",Mayo,Mushrooms,"Onion rings",Peanuts}	1
5246	8198	262	Saint Frank Coffee	5.66	https://apqxyrt.top/BrQsaKP.css	{"Caramelized onions",Sugar,Butter,"BBQ sauce"}	4
561	1945	216	Chicken Pot Pie	3.94	https://sfwrsgo.net/kVRoNjQ.jpg	{Meat,Chicken}	4
4487	7626	253	Peanut Butter	6.56	http://www.tccziur.ru/	{Chicken,Peas,Garlic,"Bavarian sausages",Basil,Flour}	1
3503	9834	201	Swedish Meatballs	4.11	http://sesafjo.org/	{Mushrooms}	5
2859	1544	186	Grape Jelly Sandwich	6.26	http://www.gwanquh.ru/CAuRCSB	{"Bavarian sausages",Rice,Potatoes,Pineapple,"Japanese tamago",Peperoni}	4
2912	7259	187	Original burger	4.08	http://www.pgztaih.ru/ypfbKXf	{"Bavarian sausages",Flour,"Cottage Cheese","Cheese cheddar",Nori,Pasta}	3
3974	1419	239	Pizza Florida	6.41	http://fabwzuy.edu/TjidBUx.webp	{"Chili Pepper",Pineapple,Pineapple,"Chili Pepper",Onion,Cucumber}	5
2870	8944	187	Pizza Pepperoni with tomatoes	6.53	http://jclpoht.ru/MeIjlLB.php	{Rice,Onion}	4
4146	1067	243	Pizza Ocean	5.77	https://www.biviemo.ru/	{"Caramelized onions","Bavarian sausages",Salmon}	2
3903	1985	239	Bacon Cheese Burger	6.74	https://enhpeqw.biz/IYcyjMm.php	{"Caramelized onions",Garlic,Garlic,Flour,"Caramelized onions"}	2
3939	1908	239	Pizza Ocean	4.52	https://ryxlcsc.edu/	{Pasta,"Caramelized onions",Rice,Mushrooms,Pineapple,Garlic}	2
2968	7198	188	Pizza Florida	6.80	https://gyvcyqb.biz/OeAcnii.html	{Corn,Strawberry,"Japanese tamago",Sugar,Pineapple}	3
1993	6213	154	Pizza Pepperoni with tomatoes	2.94	https://tddmlnd.com/mfPSGLn.php	{Pasta,"Bavarian sausages",Pasta}	4
2580	4134	183	Grape Jelly Sandwich	5.02	http://frsmbkn.ru/GPcwjXc.php	{"Original sauce"}	5
2804	7964	186	Tortellini Bowls	2.90	https://qxlplmn.edu/eYHXqfR	{"Chili Pepper",Basil,Potatoes,Grapes,Butter,"Cream cheese"}	5
5304	3583	264	Peanut Butter	5.48	https://www.cskxuuu.top/aUopEDe	{Salmon,Peperoni,"Cottage Cheese","Bavarian sausages","Caramelized onions"}	4
4326	3887	248	Pizza Florida	2.90	http://vlwioqv.top/gowgKYZ.webp	{"Onion rings","Bavarian sausages","BBQ sauce",Garlic,Grapes}	5
3146	4457	192	Crispy Chicken burger	3.15	https://gutvuib.ru/PYQrCfD.js	{"Cheese cheddar",Tomatoes,Nori,"Caramelized onions","Unagi sauce",Tomatoes}	1
2265	2301	158	Peanut Butter	6.59	https://www.pphhojl.ru/	{"Cheese cheddar",Carrots,Butter,Strawberry,"BBQ sauce",Peperoni}	3
2337	1837	158	Saint Frank Coffee	6.28	http://ijngkqk.ru/HpLsyHw.js	{"Cheese cheddar",Pineapple,Potatoes,Rice,Potatoes,Peas}	4
3783	2575	206	Bean Green Chili Burritos	2.27	http://nwxhckw.top/eqCwZjl.svg	{Garlic,"Cottage Cheese",Sugar,Cucumber,Bacon,Bacon}	2
570	4269	216	Pizza Hawaiian	6.64	http://iyrlksw.top/ZRyyKiK	{Meat,Peperoni}	3
534	621	215	New York Style Cheesecake	2.49	https://odxlqdj.net/iVaFnxS	{"Onion rings","Original sauce","Cheese cheddar",Mayo,Peas,Strawberry}	5
3706	753	205	Bacon Cheese Burger	2.58	http://rgrhqfr.info/oZbxOgq.html	{Potatoes,"Cream cheese","Cream cheese","Unagi sauce",Basil}	3
3725	8778	205	Philadelphia with salmon	4.11	http://vwmqkow.biz/	{"Cottage Cheese",Flour,"Onion rings",Strawberry,"Caramelized onions","Unagi sauce"}	4
769	6423	219	Saint Frank Coffee	6.98	https://zyuhqox.biz/ZLvlLdj.css	{Meat,Basil,Peas,Pineapple,"Caramelized onions",Meat}	4
3638	6053	203	Bean Green Chili Burritos	6.08	http://blewpjg.top/hMOHSiM.html	{Cucumber,"Cream cheese","Japanese tamago","Cheese cheddar"}	5
3239	3995	193	Crispy Chicken burger	7.17	http://xmobdba.top/	{Pineapple,"Cheese cheddar","Cottage Cheese",Chicken,"Bavarian sausages","Cream cheese"}	2
4455	3230	252	Philadelphia with salmon	6.49	https://lctioce.biz/rIEbKNI.php	{Mushrooms,Butter,"Onion rings"}	3
4658	7220	255	Pizza Pepperoni with tomatoes	7.52	http://tnxwrly.org/NVJoQTH.jpg	{"Cheese cheddar","Original sauce",Basil,"Chili Pepper",Pineapple}	4
4038	6713	241	New York Style Cheesecake	6.52	https://cjdicmj.info/IrQnHid.css	{"Original sauce","Onion rings",Mushrooms,Rice,Cheese,"Cottage Cheese"}	3
4489	1135	253	Angel Food Cake	3.77	https://cpfhlvy.edu/YQQMJti.html	{Cheese,Peas,Nori,"BBQ sauce","Unagi sauce","Bavarian sausages"}	4
3145	529	192	Bean Green Chili Burritos	6.32	https://fhukktz.edu/LjRSIZL.jpg	{Peperoni,Salmon,Salmon,Strawberry,Strawberry,Mushrooms}	2
2209	6723	156	Pizza Italiano	3.73	https://mixfuuu.info/vwkIFjn.php	{Mushrooms,Mushrooms,Butter,Garlic,Sugar}	1
335	1278	211	Wallmart	7.16	http://www.rcnsyrg.ru/WSNmqjl	{Basil,Carrots,Pasta,Corn,Peperoni,"BBQ sauce"}	3
3827	9908	207	Philadelphia with salmon	2.16	http://qwhbgka.net/dkbcTJQ.webp	{"Original sauce",Butter,"Cheese cheddar",Salmon}	5
4802	8407	257	Bean Green Chili Burritos	4.88	https://orcywqu.ru/FtJmLqV.webp	{"Chili Pepper","Bavarian sausages",Tomatoes,Nori,Nori,Cheese}	4
4601	9086	254	Unagi Philadelphia	3.36	https://fbwpiei.ru/	{"Cottage Cheese",Butter,"Caramelized onions","Cream cheese","Cottage Cheese",Flour}	3
2308	5951	158	Bean Green Chili Burritos	3.78	https://piabmjm.net/Ihrewux.jpg	{Milk,"BBQ sauce",Strawberry,Sugar,Chicken}	4
4908	7727	258	Chicken Pot Pie	2.05	https://dobhbum.biz/PsrJikX.html	{Peperoni,Bacon,"Onion rings",Meat,Mushrooms}	3
4853	4432	257	Bacon Cheese Burger	5.61	http://hbggpcx.org/ejOZnQr.webp	{Peanuts,"Original sauce",Pasta,Potatoes,Sugar}	3
820	7380	219	Swedish Meatballs	6.11	http://ldchceb.com/qolnouV.html	{"BBQ sauce",Mozarella,Pasta,"Unagi sauce"}	1
665	8612	217	Bacon Cheese Burger	4.68	http://xqoeqxk.biz/wxQpObj.css	{Carrots,Strawberry,Butter,Corn}	5
703	2912	218	Unwrapped Burrito Bowl	4.22	http://arljnty.info/aewTGem.css	{Onion,Sugar,"Caramelized onions",Sugar,Garlic}	3
608	9976	217	Tortellini Bowls	7.74	https://vwfeiod.top/PIvSjlY	{Peanuts,"Cream cheese",Potatoes,Milk,"Japanese tamago"}	2
5054	1150	260	Unwrapped Burrito Bowl	3.48	https://meqkqeb.ru/mEqFcKq.webp	{Strawberry,"Original sauce",Peas}	2
4957	3688	259	Sweet Potato Pie	4.20	https://wlothvh.ru/xyXGejd.php	{"Cottage Cheese",Flour,Sugar,Corn,"Cheese cheddar"}	2
4147	4536	243	Pizza Florida	6.28	http://qmgaqya.top/gnKoril.svg	{Mozarella,Mayo,Nori,"BBQ sauce",Sugar}	5
733	165	218	Grape Jelly Sandwich	5.79	https://www.lixompl.biz/	{Pineapple,Flour,"BBQ sauce",Cheese,"Cottage Cheese","Onion rings"}	3
3535	9686	201	Crispy Chicken burger	6.05	http://geljeng.net/LoYgolg.js	{Milk,Bacon,Bacon,Chicken,Meat}	3
4993	4589	259	Pizza Pepperoni with tomatoes	2.69	http://sfbkwqy.info/jTcnOcl.css	{"Japanese tamago",Mushrooms,Nori,Corn,"BBQ sauce",Flour}	3
623	9883	217	Philadelphia with salmon	3.58	http://qxvbnny.net/WpfHBIy.jpg	{"Unagi sauce","Bavarian sausages","Caramelized onions",Pasta,Grapes}	4
858	3011	220	Pizza Hawaiian	5.23	https://zqscqvy.edu/LiqnOEn.php	{Mayo,"Unagi sauce",Grapes,Cucumber,Sugar}	1
4490	5016	253	Pizza Hawaiian	6.65	https://wejtbgl.org/nPYElNr.php	{Pasta,"Unagi sauce",Mushrooms,"Caramelized onions"}	4
543	6625	215	Grape Jelly Sandwich	5.02	http://fojfqfq.top/grvxqoh.svg	{Meat,Nori,"Japanese tamago",Rice,"Unagi sauce","Caramelized onions"}	3
4503	8140	253	Saint Frank Coffee	4.33	http://ilrcsgq.info/	{Flour,Salmon,Strawberry}	5
1180	3605	228	Unwrapped Burrito Bowl	5.50	https://kuhcgmf.info/PQPeOJd.css	{"Chili Pepper",Corn,"Japanese tamago","Bavarian sausages",Corn,"Unagi sauce"}	3
2585	4677	183	Pizza Florida	7.32	http://lpdjagl.edu/rYlfHkW.css	{Sugar,"Caramelized onions",Chicken,"Cottage Cheese",Flour}	5
4504	4736	253	Pizza Florida	7.36	https://qgecxgb.ru/VNMAxOH.php	{Onion,Sugar}	3
366	3326	212	Unwrapped Burrito Bowl	5.16	https://www.ahtqgao.biz/	{Peanuts,"Cream cheese",Milk}	3
2586	8483	183	Original burger	7.41	https://agrmtlf.info/RotumAf.js	{Pineapple}	5
2589	596	183	Pizza Florida	2.95	http://www.zaqfafu.top/	{Carrots,"BBQ sauce"}	1
2584	7818	183	Philadelphia with salmon	7.25	https://www.pqfbxmb.ru/	{Butter,Mushrooms,Peperoni,Pasta,Meat}	4
4497	7534	253	Grape Jelly Sandwich	6.31	http://www.hcblkmj.com/YrraVLS	{Milk,"Chili Pepper",Peperoni}	1
4494	7975	253	Pizza Italiano	6.74	http://pckyqhc.net/RZguHfw.html	{"Cream cheese"}	4
370	6073	212	Swedish Meatballs	4.67	https://mcjjtbc.edu/idCjwci.php	{"Caramelized onions",Corn,Mozarella}	4
2591	6007	183	Grape Jelly Sandwich	3.38	http://jjjfzge.com/NCngLOy.css	{Basil,Potatoes,Mushrooms,"Caramelized onions","Cream cheese"}	1
395	5161	213	Himawari	6.51	http://www.ieanxcy.biz/	{Rice,"Cheese cheddar","Cottage Cheese",Peanuts,Meat,"Caramelized onions"}	2
2581	8802	183	Unagi Philadelphia	2.76	https://www.ryahkqn.info/NBKWZYc	{"Cream cheese",Flour,Potatoes}	5
4496	9382	253	Bacon Cheese Burger	5.07	https://konmgzg.edu/nZgicbx.css	{Nori,Cucumber,"Cheese cheddar",Peperoni}	1
367	7216	212	Pizza	6.72	https://atneyug.edu/UTnuaPZ.css	{Mayo}	1
4495	8109	253	Bean Green Chili Burritos	6.10	http://tbyerkj.com/tXQVoQo.js	{Rice,Grapes,"Chili Pepper"}	5
4505	5734	253	Pizza Ocean	3.26	http://dqbhoyd.com/XbGZsYc.svg	{Peperoni,Peas,Onion,"BBQ sauce",Chicken}	2
2590	5117	183	Wallmart	3.94	http://dbrlggu.top/bPBVulA.php	{Garlic,Pineapple,"Onion rings",Mushrooms}	2
2588	264	183	Angel Food Cake	7.54	https://vxlzndi.com/OEqEcDp	{Strawberry}	3
2582	399	183	Angel Food Cake	6.45	http://tuofwle.top/dDctVxd.css	{Basil,Flour,Carrots,Corn}	3
2104	3643	155	Peanut Butter	7.96	https://nsdeays.com/WfmniML.jpg	{Meat,Mayo,"Caramelized onions","Onion rings","Bavarian sausages","Onion rings"}	5
653	181	217	Pizza Pepperoni with tomatoes	7.18	http://www.xjtlaeo.org/ILUqaqe	{Sugar,Meat,Peanuts,Milk}	2
369	3473	212	Pizza Florida	5.46	http://qkvwdnp.edu/fsadCGU.webp	{Rice,Cucumber,Mushrooms,Corn,Mozarella,Pineapple}	2
444	9128	214	Unagi Philadelphia	5.05	https://ocxxcaq.top/oclKPNp.html	{"Original sauce",Mayo,Grapes,Cheese,"Caramelized onions","Original sauce"}	1
2587	9826	183	Unwrapped Burrito Bowl	5.27	https://ktghiqa.ru/rICbvVh.php	{Mayo,"Chili Pepper",Basil,"Bavarian sausages",Mozarella,Mayo}	5
396	522	213	Bean Green Chili Burritos	7.60	http://tsuampe.biz/BhcLvlT.php	{"Cream cheese",Tomatoes,"Onion rings","Cheese cheddar"}	1
2592	9804	183	Wallmart	7.11	http://fbxwpnb.com/yNDZLOn.svg	{Butter,Flour,Milk,Carrots,Pineapple,Nori}	1
4491	32	253	Bean Green Chili Burritos	7.87	https://www.qvdmrsk.top/RvSqvDt	{Strawberry,Peanuts,Corn,Cucumber,"Chili Pepper","Cheese cheddar"}	3
2593	7482	183	Bacon Cheese Burger	4.72	http://www.puiwutb.top/lBnHWkD	{Onion,"Caramelized onions",Tomatoes,"Bavarian sausages"}	4
368	2402	212	Wallmart	4.88	http://nenymla.info/GVxBMBa	{Pasta,Nori,Rice,Mushrooms,Meat,Flour}	5
4493	1828	253	Pizza Hawaiian	7.22	https://vdllebk.info/xrOlkXb.html	{Peanuts,Peperoni,Salmon,"Bavarian sausages","BBQ sauce"}	4
4492	9983	253	Crispy Chicken burger	6.27	http://dnjwaye.biz/BGiDMqt.jpg	{Butter,Flour,Tomatoes,"Cheese cheddar"}	3
4716	1924	255	Pizza Italiano	2.91	http://dtlymrh.biz/iOPJekt.js	{Mushrooms,Flour,"Cheese cheddar",Mushrooms,Bacon,Pineapple}	2
3048	7812	190	Philadelphia with salmon	2.44	https://ltxitvc.info/Glrgknv	{Nori,Mushrooms,Pineapple,Butter,Pineapple,"Original sauce"}	2
3081	2602	190	Pizza Pepperoni with tomatoes	6.77	https://crqxuas.ru/eEcXWLu.php	{"Japanese tamago",Corn,Nori,Rice,Bacon,Potatoes}	4
3400	9261	199	New York Style Cheesecake	2.47	https://duqkvac.ru/ibcrBUe.webp	{Chicken,Peperoni,Mushrooms,Mushrooms,Basil}	3
2131	3145	155	Unwrapped Burrito Bowl	4.97	https://phabikz.biz/BcbtBkf.webp	{Tomatoes,Grapes,"Japanese tamago","Bavarian sausages","BBQ sauce"}	4
2632	3518	183	Sweet Potato Pie	5.19	https://vgyvyqg.ru/xJmAwmo.php	{Cheese,"Caramelized onions",Flour,Butter,Sugar,"Unagi sauce"}	3
2635	7825	183	Bean Green Chili Burritos	2.95	http://ximgtyp.top/MXlJaMK.css	{Chicken,Sugar,Salmon}	4
2627	1944	183	Pizza Texas	2.95	http://btdyufp.net/VfxLHSS	{"Original sauce",Flour,Strawberry,Peperoni,"Cottage Cheese",Potatoes}	1
2633	5859	183	Saint Frank Coffee	6.04	http://ytokdkx.com/ggBTyMg.js	{Flour,Mushrooms,"BBQ sauce",Mushrooms,Potatoes,Pineapple}	4
2629	1801	183	Saint Frank Coffee	6.33	http://prdiffe.ru/aNvULWx.php	{Potatoes,Sugar,"Onion rings",Carrots,Pasta}	4
701	8170	218	Unagi Philadelphia	4.16	http://www.saeuwqb.ru/AueFOTw	{Tomatoes,"Cottage Cheese",Bacon}	4
2636	3921	183	Crispy Chicken burger	5.47	http://eigmsoa.ru/vTgKjMD.webp	{"Bavarian sausages",Peanuts,"Cream cheese","BBQ sauce"}	2
2594	3809	183	Angel Food Cake	2.49	https://emyckqs.com/VCktREI.js	{Mushrooms}	2
2638	2451	183	Tortellini Bowls	6.98	https://juwrfru.com/uXekCdV	{Nori,Mayo,Onion,Salmon,Mozarella}	2
2596	6135	183	Sweet Potato Pie	5.12	https://pkoyaxe.biz/rERhiXb.jpg	{"Japanese tamago"}	5
2637	6671	183	Pizza Italiano	5.62	https://www.ybetdom.com/	{"Japanese tamago",Corn}	4
4506	8529	253	Pizza	5.51	http://adygvta.top/	{Sugar,"Unagi sauce",Potatoes,"BBQ sauce"}	1
2603	6695	183	New York Style Cheesecake	6.06	https://dniffct.net/NNtNJPL.html	{"Caramelized onions","Unagi sauce",Chicken,Sugar,"Chili Pepper"}	1
4507	7699	253	Unwrapped Burrito Bowl	3.25	http://fobwfap.info/	{Nori,"Japanese tamago",Bacon,Salmon,Meat,Mushrooms}	1
2597	2197	183	Unagi Philadelphia	4.72	http://hbyqfsi.top/GUDALyP.php	{"Unagi sauce",Sugar,"BBQ sauce",Flour}	3
2595	861	183	Grape Jelly Sandwich	7.18	http://www.ptololj.net/rbOIYui	{Sugar,Peanuts}	2
2605	8621	183	Pizza Ocean	7.58	https://www.qjhmxpv.biz/	{Flour,Corn,Tomatoes}	2
2602	3669	183	Philadelphia with salmon	3.50	http://bptldax.edu/KdXwPoU.js	{Flour}	3
2604	7945	183	New York Style Cheesecake	3.98	https://iwqoqcj.edu/uwHTMpB.jpg	{Strawberry,Mushrooms,Flour,"Unagi sauce"}	4
2607	1503	183	Unagi Philadelphia	2.14	http://tamunap.net/	{Milk,Onion,"Unagi sauce","Cottage Cheese",Potatoes}	4
2601	6144	183	Tortellini Bowls	7.63	https://hizoldh.edu/oqUPGDE.svg	{Pasta,Salmon,Rice,Onion,Potatoes,Flour}	4
2610	8937	183	Himawari	6.32	https://tglkhqs.ru/jBPvmoI	{Salmon,"Unagi sauce","Caramelized onions"}	3
2612	3462	183	Chicken Pot Pie	2.80	https://xmftwnp.org/imIlxWs.css	{"Caramelized onions",Flour,"Cream cheese",Pineapple,Corn,"Unagi sauce"}	2
2606	4422	183	Pizza	5.73	https://lekhhmf.top/UQXAopA.webp	{Pineapple}	4
2608	2520	183	Pizza Italiano	7.86	https://srjcjdq.ru/fTMLmie.html	{Pineapple}	5
2615	267	183	Original burger	5.60	https://mncawee.ru/LWGUVog	{Nori,Mushrooms,Strawberry}	2
2617	3633	183	Peanut Butter	2.74	https://ifsclft.ru/PEAIVVm.webp	{Tomatoes,Onion}	1
2611	466	183	Sweet Potato Pie	3.98	http://www.owqnbcp.top/MDdCSHP	{"Unagi sauce","Onion rings","Chili Pepper","Cottage Cheese"}	4
2614	8763	183	Bean Green Chili Burritos	7.88	https://lwhhrgv.net/KQGlqci.webp	{"Japanese tamago","Unagi sauce",Potatoes,Potatoes,Carrots,Cheese}	5
2619	2381	183	Bacon Cheese Burger	6.96	https://www.ofyrsen.ru/	{Corn,Corn,Corn,Bacon,"Caramelized onions"}	2
2623	9004	183	Himawari	3.76	http://oyyvhfh.org/NnRhEmx.html	{Mozarella,Sugar}	5
2618	5074	183	Swedish Meatballs	7.14	http://zcgmfsx.edu/	{"Chili Pepper",Nori,"Bavarian sausages",Salmon,Garlic}	5
2626	8257	183	Tortellini Bowls	6.17	http://www.jehkgek.info/yDXODTP	{"Original sauce",Nori,Chicken,Strawberry}	3
2613	4538	183	Pizza Florida	5.54	http://www.kqapugy.org/	{Cheese}	5
2624	8448	183	Grape Jelly Sandwich	3.07	https://www.jmxvdsx.com/YeQluHc	{"BBQ sauce","Cream cheese",Bacon,Rice}	3
2631	7949	183	Wallmart	5.95	https://jvyghxz.com/	{"Cheese cheddar"}	1
2628	8029	183	Pizza Italiano	6.52	http://ayzuumb.ru/KyhHBFY.html	{Mayo,Pineapple,Milk,Peperoni,Onion}	1
2625	6538	183	Wallmart	6.03	http://tesyvma.top/xbVmRAH.php	{Sugar,Flour}	5
2620	4988	183	Wallmart	6.24	https://lgkiduu.com/jKQxGAI.webp	{Milk,Peanuts,"Cheese cheddar",Rice,"Cottage Cheese","Onion rings"}	2
2630	8600	183	Swedish Meatballs	7.25	https://www.znpyyzk.top/	{Mushrooms,"Bavarian sausages",Cheese}	2
2634	4863	183	Saint Frank Coffee	7.63	http://www.sbmhdrr.top/aWrnLAc	{Onion}	1
2609	2923	183	Original burger	3.75	https://dgcdjso.biz/VdQIVUU.html	{Bacon}	5
2616	5551	183	Angel Food Cake	3.81	https://vhvnqre.biz/mcWVdes.jpg	{"Original sauce",Milk,Mozarella}	1
2646	5766	183	Saint Frank Coffee	4.31	https://www.oxxbggs.ru/jYhjjLP	{"Unagi sauce",Mozarella,Butter,Meat}	4
2664	825	184	Pizza	6.71	http://oitpnnn.info/uxYJTBe.jpg	{Strawberry,"Cheese cheddar",Basil,"Chili Pepper"}	5
2676	2911	184	Unwrapped Burrito Bowl	3.98	http://padaaka.top/JSvAJFD.svg	{Cheese,Pineapple}	2
2668	1699	184	Peanut Butter	7.97	http://bffdich.biz/eZViqON.svg	{Strawberry}	2
4511	6125	253	Sweet Potato Pie	3.16	http://tdnzktp.top/mabjYhI.svg	{Mayo,Pasta,"Unagi sauce","Onion rings",Peas,Pineapple}	5
2679	7782	184	Unwrapped Burrito Bowl	2.83	https://ndysdyh.org/XifeVfW.jpg	{"Chili Pepper",Corn,Butter,Strawberry}	2
2663	6967	184	Philadelphia with salmon	4.72	https://auibnzt.biz/SyaGRyZ.js	{Potatoes,"Unagi sauce",Rice}	3
2678	4410	184	Philadelphia with salmon	4.41	https://peayvlw.org/TQRqVxq.svg	{Peas,Potatoes,Onion,"Caramelized onions",Garlic,Peperoni}	1
2666	6116	184	Original burger	6.02	http://qisyhyp.com/PHlLpnc.php	{Bacon}	5
2674	4037	184	Unwrapped Burrito Bowl	2.98	https://dpuheam.info/EdKQTCf.js	{Pasta,Peas,Mayo,"Bavarian sausages",Butter,Cheese}	2
2639	4631	183	Peanut Butter	3.00	http://yfzjbrg.top/dCRQNdo.php	{"BBQ sauce","Unagi sauce",Peas,Sugar,Corn}	2
2675	9547	184	New York Style Cheesecake	7.09	http://ikdpqno.net/jDYSkfs.jpg	{"Unagi sauce","Original sauce"}	3
2651	7733	183	Angel Food Cake	6.57	https://dwkeuxm.edu/PgIrnLe	{Carrots,Pasta}	1
2649	4245	183	Pizza Pepperoni with tomatoes	5.05	http://ifaiwrc.org/ejrPoLp.jpg	{Mozarella,Bacon,Peas}	4
2642	2487	183	Pizza Italiano	6.34	http://rorsucc.top/JeyKkUk.css	{Garlic,"BBQ sauce"}	1
2645	6526	183	Unwrapped Burrito Bowl	3.56	http://pafvytw.org/yXuDBFR.svg	{"Bavarian sausages",Bacon,Nori,"BBQ sauce"}	5
2667	8164	184	Pizza Pepperoni with tomatoes	6.86	http://www.mzypxfo.edu/SmbxfFJ	{Garlic,Chicken,Bacon,Pasta}	2
4512	8087	253	Bean Green Chili Burritos	5.89	http://www.pehubtr.edu/AeDQYTq	{Chicken,Butter,"BBQ sauce",Mushrooms}	5
2665	7013	184	Unwrapped Burrito Bowl	2.22	http://bshlglv.edu/	{Salmon,"Bavarian sausages",Mushrooms}	2
2648	6328	183	Pizza Hawaiian	4.75	https://mzihepd.net/kaMqVjM.svg	{Flour,Pineapple,Mayo,"Unagi sauce","Original sauce",Chicken}	1
2643	4928	183	Pizza Texas	5.69	http://fqldfyt.net/ErLHYvq	{Meat}	4
4514	5662	253	Pizza Hawaiian	7.31	https://lkptneo.info/NmIVIEg	{Onion,Corn,"Chili Pepper",Mozarella,Sugar,Tomatoes}	4
2641	9670	183	Crispy Chicken burger	6.09	http://pooqgzb.top/bjmTqWK.js	{"Japanese tamago"}	1
748	7375	218	Pizza Hawaiian	5.71	http://ztcerbi.ru/MRiSekB.php	{Milk,Flour}	1
4508	4628	253	Tortellini Bowls	4.84	https://blhcfus.org/FkkNkUQ.html	{Milk,Milk,"Unagi sauce",Potatoes,Peas,Butter}	4
2654	1583	183	Wallmart	2.30	http://btelnwm.biz/ZWjnGgk.css	{Tomatoes}	3
2650	2908	183	New York Style Cheesecake	5.80	http://mbintoh.info/XoQvbRL.webp	{"BBQ sauce",Potatoes}	2
2660	1989	184	Sweet Potato Pie	4.98	https://xljmkui.edu/	{Sugar,Mushrooms,Onion,Peanuts,Chicken}	3
2659	7621	184	Crispy Chicken burger	5.29	https://www.kjabjno.top/POqRmLq	{"Original sauce","BBQ sauce","Bavarian sausages","Onion rings",Pasta,Chicken}	4
2662	4890	184	Peanut Butter	5.25	http://oawqbdk.com/	{Milk,Milk,Tomatoes,Meat}	1
749	8423	218	Pizza Texas	5.15	https://oaojech.net/RduuRBK.svg	{"Caramelized onions",Milk,Pasta}	5
2655	989	183	Saint Frank Coffee	4.99	http://gpnmmnm.org/	{Bacon}	5
2640	9628	183	Angel Food Cake	4.85	http://tomesyn.ru/IZCdlAg.php	{Strawberry,Flour,Grapes}	4
4513	1383	253	Pizza	5.89	https://hssjbdc.top/dDujupJ.webp	{Nori,Meat,Bacon,"Caramelized onions",Grapes}	5
2658	4946	184	Angel Food Cake	3.31	http://xjnxiad.info/evTXxfo.html	{Nori,Pasta,Butter,Potatoes,Nori,Rice}	1
2669	5712	184	Sweet Potato Pie	7.86	https://vdgwijq.org/TxDlivn	{Cheese,Basil,Bacon,Cucumber,Potatoes,Rice}	2
2677	869	184	Wallmart	6.47	https://ynwrexl.org/	{Meat,"Caramelized onions",Basil,"Cottage Cheese",Onion}	3
2657	8582	184	Angel Food Cake	5.04	https://fjcmnax.biz/LePSQtJ.svg	{Carrots,Cucumber,Milk,Flour,Meat,Peperoni}	2
2656	8787	184	Pizza Florida	6.61	https://obsalek.com/gnuqwpF.js	{"Original sauce",Peanuts,Butter,"Chili Pepper",Mushrooms}	5
2661	833	184	Saint Frank Coffee	7.84	https://gtsbbqw.ru/dPaaPiv.js	{"Cheese cheddar",Mozarella}	5
2653	8788	183	Pizza Texas	6.52	https://jjugnwu.net/	{Mushrooms,Mushrooms,"Bavarian sausages",Cheese,Pasta}	3
2670	3822	184	Unagi Philadelphia	5.95	https://tqeioxt.ru/yKBohwk.webp	{Chicken,"Original sauce",Rice}	5
2652	4300	183	Wallmart	2.26	https://mnbrjoi.info/qbGQvXL.svg	{Mozarella}	1
4150	7769	243	Pizza Ocean	4.75	https://wuiqdwv.biz/hxgIWXh	{Cheese,"Unagi sauce",Salmon,Potatoes,Bacon,"Cottage Cheese"}	3
4521	5764	253	Grape Jelly Sandwich	6.09	http://sdjhsrd.biz/KBeweeV.jpg	{Peas,"Caramelized onions",Cucumber,Peas}	3
4151	3212	243	Peanut Butter	2.94	https://waosxdg.org/	{"Cream cheese",Milk,Butter,Peanuts,Tomatoes,Chicken}	4
4523	5643	253	Pizza	6.84	https://ejbwgvc.info/	{Peas,"Cream cheese",Butter,Mozarella,Mushrooms}	2
4520	3568	253	Saint Frank Coffee	3.35	http://www.hsgbnot.org/lclirSq	{Cucumber,"Original sauce","Original sauce",Meat,Chicken}	2
4529	7810	253	Sweet Potato Pie	4.88	http://lqjdkhs.top/dxWoJJJ.svg	{"Cheese cheddar",Peas,Peanuts}	3
2684	224	184	Crispy Chicken burger	4.53	https://locxagi.edu/WEthBAw.webp	{"Japanese tamago"}	2
1990	4387	154	Unwrapped Burrito Bowl	4.72	http://wddwjit.com/xgaCmZk.svg	{Garlic,Mayo,Garlic,Pasta,Flour}	5
2689	6018	184	Unwrapped Burrito Bowl	2.65	https://jxfkzqe.biz/MRuTIHv	{Tomatoes,Flour,"Cream cheese","Original sauce"}	5
4155	9982	243	Pizza Italiano	5.74	http://toqqtal.ru/KKZLMxI.css	{"BBQ sauce",Salmon,Peanuts,Cheese,Carrots,Cheese}	2
4531	6138	253	Peanut Butter	6.96	http://ctzudrv.org/xMZaelm.js	{"Chili Pepper"}	5
2693	7000	184	Pizza	2.12	http://occarxr.com/yothtTa.html	{Bacon,Mushrooms,Flour,"Japanese tamago"}	5
1998	7241	154	Chicken Pot Pie	7.45	http://bwxadan.edu/SeErpss.css	{Chicken,Cucumber,"Unagi sauce",Peperoni}	3
4524	1941	253	Pizza	7.30	http://lgmqlmc.top/KDCCUNC	{"Original sauce",Sugar,Butter,Cheese}	4
4515	5955	253	Wallmart	3.76	http://gaslxwc.top/qNdFDtY.html	{Nori,Mayo,Cheese,Mayo}	5
2694	6103	184	Chicken Pot Pie	7.90	https://www.jrsdndv.org/GnfvqCw	{Nori,Pasta,Carrots,Salmon}	4
4519	4058	253	Bean Green Chili Burritos	2.46	https://ugtmloc.biz/ZDPQKEP	{Bacon,"Caramelized onions"}	2
4149	3658	243	Peanut Butter	2.54	http://www.cgqzulm.edu/VtguEUf	{Meat,"Bavarian sausages","Chili Pepper"}	3
795	9141	219	Sweet Potato Pie	6.16	http://ffhtfap.edu/DmjLryR.js	{Grapes,"Original sauce"}	4
4517	1143	253	Bacon Cheese Burger	4.06	https://zcoueci.top/ZeUuKja.css	{Mozarella,Bacon,Peas,Peas}	3
2688	688	184	Peanut Butter	2.14	https://tejkcal.biz/RhxggED.svg	{Cheese,Peperoni,Nori}	4
2685	8771	184	Peanut Butter	4.66	http://nblljfu.biz/TTfFlNO.html	{Basil,Butter,"Cheese cheddar",Mushrooms}	3
4528	7723	253	Grape Jelly Sandwich	2.30	https://www.ockfxrp.edu/	{"Bavarian sausages",Grapes}	3
4526	3325	253	Wallmart	5.67	http://www.bmfedyc.ru/ZSnsvwo	{Cucumber,Flour,Nori,Milk,Strawberry}	5
2681	9985	184	Pizza Florida	7.91	https://ieokhqr.ru/KjkxSju.html	{Peanuts,Onion,Potatoes,Bacon}	4
1991	5731	154	Wallmart	2.65	https://uppxzdn.ru/vFCUIyB.jpg	{"Unagi sauce",Mushrooms,Cheese,Peanuts,Pasta}	2
4527	1932	253	Pizza Hawaiian	6.08	https://fzkbdyi.info/jIaPaOM.php	{Flour,"Caramelized onions",Rice,Corn,Mayo,Flour}	3
4350	9326	249	Wallmart	3.05	http://foxtaed.com/dRaCJrQ.jpg	{Pasta,Corn,"Cheese cheddar",Nori,Carrots}	4
2680	2206	184	Swedish Meatballs	4.27	https://sapekww.top/hsoqyIn.css	{Flour,Carrots,"Unagi sauce"}	5
2875	6320	187	Chicken Pot Pie	3.83	https://qoxzgeu.com/	{Flour,"Bavarian sausages",Tomatoes,Cucumber,"Original sauce"}	4
2687	7232	184	Tortellini Bowls	2.28	https://llfeasn.com/finLIFR	{Corn,Cucumber,Sugar,Mushrooms,Potatoes,Onion}	5
2690	6280	184	Original burger	7.25	http://rcisvjy.top/AvbaDoR.webp	{Nori,"Cheese cheddar","Cream cheese","Japanese tamago",Strawberry}	2
4518	919	253	Pizza	5.82	https://www.ksjjprz.net/IePAyXt	{"Japanese tamago",Mozarella,Chicken,Garlic,Strawberry,Cheese}	3
3127	9400	191	Pizza Italiano	5.10	http://syugaob.net/yFcUcEY.php	{"Unagi sauce",Peas,Flour,"Cream cheese","Cheese cheddar",Flour}	3
4148	3549	243	Pizza Hawaiian	2.11	https://unfffht.info/pbhinCf.css	{Peperoni,Basil}	4
2686	7464	184	Sweet Potato Pie	7.95	https://wqcpdkd.com/AFeJRge	{Rice,Mozarella,Sugar,Peperoni,Cucumber,Pineapple}	3
4532	2161	253	Philadelphia with salmon	3.87	http://azuizmh.biz/vbuogQp.jpg	{Garlic,Flour,Garlic,"BBQ sauce"}	5
4522	8983	253	Pizza	3.01	http://gejbttp.org/HUjJoLD.php	{Peas}	3
4516	4845	253	Pizza Florida	2.95	http://aqkfofb.ru/IBvYAWZ.jpg	{Chicken}	2
4525	5184	253	Himawari	6.71	http://lclblyd.top/HoLThNe	{Mayo,Rice,Onion,Peas,Pineapple,Milk}	5
4530	9243	253	Pizza	7.89	https://www.obqiddg.biz/	{Mushrooms}	5
2682	2853	184	Chicken Pot Pie	3.79	https://cyemfid.info/oDkhPTc.js	{"BBQ sauce","Japanese tamago"}	2
2683	7345	184	Original burger	7.86	http://lhnkxry.biz/uDLWTYC.webp	{Potatoes,"Cottage Cheese","Japanese tamago",Peperoni,Cheese,Garlic}	1
4548	8040	254	Sweet Potato Pie	2.49	http://bxxcige.biz/TCpOSWX.php	{Strawberry,"Onion rings",Mushrooms,Flour,Peperoni}	5
4539	8947	253	Himawari	7.24	http://fhvbmhh.org/ofMgMAk.jpg	{Mushrooms,"BBQ sauce",Grapes}	5
4156	9857	243	Sweet Potato Pie	5.32	http://vwxkkhw.edu/YEZSsJZ.html	{Grapes,Mayo}	2
4540	4922	253	Peanut Butter	2.06	https://www.cypapsy.info/vCjHitF	{Onion}	2
4547	9189	254	Wallmart	5.76	https://cgkccry.top/acLekwR.php	{Salmon,Corn,Cucumber,Peperoni}	5
4571	6040	254	Pizza Florida	2.80	https://qzjkjum.ru/TJxqVlS	{"Cheese cheddar",Salmon}	1
4544	9060	254	Peanut Butter	3.15	https://dkkimgl.biz/mTtYBHN.webp	{"Onion rings",Mushrooms,Peas,Bacon,"Cream cheese"}	4
4549	539	254	Bacon Cheese Burger	4.99	http://ergzhow.com/RJefHnh.html	{Onion,Mayo,Mayo,Mushrooms}	5
4560	6313	254	Swedish Meatballs	4.56	http://ovxpcpy.net/	{Cucumber,Flour}	2
4564	7932	254	Original burger	2.52	https://etyhqrs.com/rvXTfUF.js	{Pasta}	2
4561	6029	254	Bacon Cheese Burger	3.40	https://iekbqho.edu/ucpjrpO	{"Onion rings",Bacon}	2
4574	4621	254	Tortellini Bowls	2.41	https://wusbfhd.net/LAnJrmL.php	{Flour,"Japanese tamago",Peperoni,Meat}	4
4563	7518	254	Angel Food Cake	5.49	https://ikdexpm.com/ctAMfNA.css	{"Onion rings",Meat}	4
4565	4788	254	Swedish Meatballs	3.80	http://www.cwbmvso.info/	{"Japanese tamago"}	4
4559	6100	254	Grape Jelly Sandwich	4.36	https://www.vrvuoln.ru/DRqqhWq	{Flour,Flour}	4
4566	5878	254	Grape Jelly Sandwich	6.64	https://gxkwagx.edu/TKsmpnH	{Butter}	2
4572	3589	254	New York Style Cheesecake	2.99	http://htwbcit.biz/	{Salmon,Basil,Strawberry,Peas}	1
4558	1153	254	Original burger	6.92	http://www.qtcjdsn.net/	{Peperoni,Mushrooms,"Chili Pepper",Corn,Cheese,Nori}	2
4562	4474	254	Unagi Philadelphia	5.74	https://egwqpid.info/	{Tomatoes,Nori,"Original sauce",Basil}	1
4567	6779	254	Pizza Hawaiian	6.29	https://oibmehe.org/	{"Caramelized onions",Onion}	4
4581	6196	254	Wallmart	4.46	https://tsygcji.com/tNNNmWE.svg	{Garlic,Rice}	3
4579	4720	254	Chicken Pot Pie	5.30	https://www.oaaxpar.edu/	{Bacon,Strawberry}	1
4576	6790	254	Himawari	6.97	http://kvtfkjl.org/KHmhtIU.css	{"Cottage Cheese","BBQ sauce",Pasta,"BBQ sauce"}	2
4577	6340	254	Bean Green Chili Burritos	3.25	http://kvizdnt.net/ZlNcyaN.js	{Basil,"Cheese cheddar",Garlic,Nori,Flour,Mozarella}	1
4550	2846	254	Wallmart	6.29	https://wjmrikm.info/EPrsPNK.js	{Rice,Mushrooms}	5
4583	6686	254	Chicken Pot Pie	2.98	http://cvjarnq.org/tQXMceF.js	{"Cheese cheddar"}	4
4569	3143	254	Chicken Pot Pie	6.13	http://www.ysreinx.net/Jsfwysl	{"Original sauce"}	3
4580	9413	254	Saint Frank Coffee	2.89	https://ugxwrvn.ru/oeixTwc.css	{Milk}	3
4585	6287	254	Sweet Potato Pie	5.48	https://www.qwcejao.org/XhPkyCG	{Mushrooms}	3
4584	8426	254	Pizza Italiano	6.38	https://rpimczq.info/yfrQmTL.js	{"Japanese tamago","Onion rings",Garlic,Salmon,Sugar,Salmon}	2
4535	639	253	Himawari	6.35	https://gsreuyp.ru/EacvlJC.jpg	{"Cream cheese",Tomatoes}	1
4586	7170	254	Pizza Texas	4.62	https://ybsrqaq.ru/ktTYNWO.js	{"Japanese tamago","Bavarian sausages",Mozarella,Mayo,Cheese}	3
4587	8428	254	Pizza Ocean	3.08	https://dzeybyh.biz/XTHCYeL.css	{"BBQ sauce",Mushrooms,Cucumber,Garlic}	4
4533	1994	253	Pizza Hawaiian	6.80	https://jzauawv.net/Abpuwoa.css	{"Bavarian sausages",Strawberry,Potatoes,"Cottage Cheese",Mushrooms}	4
4582	3686	254	Pizza Texas	6.23	http://rrdelbu.top/cpQCbdM.css	{Mozarella,Meat,Flour,Bacon}	1
4546	3963	254	Unagi Philadelphia	5.80	http://hxgagxg.top/kUGxLsS.css	{Peanuts,Pasta,Bacon,"Unagi sauce",Sugar,Strawberry}	2
4537	3746	253	Bean Green Chili Burritos	2.08	https://qamaswo.com/SpTvbCt.webp	{Milk,Chicken,Cheese,"Japanese tamago",Flour}	1
4534	9021	253	Crispy Chicken burger	2.29	https://yguabmc.ru/JfBMoHD.webp	{Mushrooms,Salmon,"Cream cheese","Cottage Cheese",Pasta,Mushrooms}	2
4538	2513	253	Chicken Pot Pie	5.17	http://kyxajvw.biz/	{"Cream cheese",Sugar}	3
4536	2982	253	Unagi Philadelphia	6.95	http://www.piffqli.edu/qpLmUjP	{Nori,Chicken}	2
4541	9869	253	Pizza Italiano	4.15	http://enelrdo.info/TsDSFgm.html	{Pasta,Cucumber,Tomatoes,Peperoni,Onion}	5
843	7416	219	Pizza Italiano	5.81	https://onatdbe.net/mIyAEDE.js	{Onion,Carrots}	5
4543	4194	254	Pizza Texas	4.28	http://urmqlco.top/PUpAKgF.php	{Cucumber,"Onion rings",Mozarella}	4
4542	5047	253	Bean Green Chili Burritos	3.09	https://rlnjzmb.com/Eiteats.css	{Carrots,Onion,Peas,"Chili Pepper",Carrots,"Cream cheese"}	5
4578	1127	254	Grape Jelly Sandwich	2.96	http://lqvumsl.ru/EsDOvWQ.webp	{Onion,Carrots,"Unagi sauce"}	2
4589	8035	254	New York Style Cheesecake	6.53	http://fcqdgqz.org/YDHfdTm.svg	{Pasta,Pasta,"Japanese tamago",Onion}	4
2003	5496	154	Swedish Meatballs	2.81	https://nhknhmz.top/ohuTWyC.html	{Cheese,Milk,Rice,Cheese}	4
4608	245	254	Sweet Potato Pie	4.65	http://lvxxyvg.org/foNJAij.js	{"Onion rings",Sugar,Rice,Flour,Grapes,Meat}	3
4163	8861	244	Unagi Philadelphia	2.80	http://wkimstb.biz/yFskyrx.php	{Flour}	1
3686	4967	205	Pizza Pepperoni with tomatoes	2.50	https://ffgbffx.top/VIMOUbW.js	{"Japanese tamago",Mushrooms,"Original sauce",Rice,"Japanese tamago",Mushrooms}	3
4166	6544	244	Saint Frank Coffee	5.83	https://www.utcynps.ru/	{"Japanese tamago",Peperoni,Flour}	4
4175	5440	244	Pizza	7.88	http://wfyinyl.ru/lKdOFLS.css	{Basil}	5
4171	3071	244	Pizza Italiano	6.57	http://www.vnnklsf.info/	{Strawberry,Mushrooms,Tomatoes,"Cream cheese",Garlic}	5
4603	6897	254	Bean Green Chili Burritos	5.75	http://sjtlrqg.net/osmeSYf.webp	{"Original sauce","Caramelized onions","BBQ sauce",Rice,Strawberry}	2
4169	7526	244	Original burger	2.54	https://lsvzaop.ru/nSBLCFF.svg	{Meat}	1
4180	1826	244	Crispy Chicken burger	4.56	https://amgvrch.biz/fXdapIw.svg	{"Japanese tamago",Onion,Basil,Flour}	1
4177	1048	244	Chicken Pot Pie	6.72	http://wckboye.top/ENGyHbm.js	{"Bavarian sausages",Basil,Mushrooms,Peperoni,Chicken}	5
4604	2517	254	Unagi Philadelphia	2.03	https://txkczim.top/	{"Japanese tamago",Basil}	3
890	7648	222	Grape Jelly Sandwich	6.86	http://tbwzjuv.biz/VaMYpuv.html	{"Bavarian sausages",Mushrooms,"Bavarian sausages","BBQ sauce"}	4
2002	6552	154	Crispy Chicken burger	6.47	http://hfojjqv.com/oorvdWY.php	{Butter}	4
4602	7888	254	Peanut Butter	7.97	https://grwqfqo.net/TgSQwWG.php	{"Bavarian sausages","Cheese cheddar",Butter,Peas,"Cheese cheddar"}	3
2004	9302	154	Sweet Potato Pie	6.79	https://nhlgldo.org/tkmtiLS.jpg	{Onion,Mushrooms,Rice,Peperoni}	2
4165	2951	244	Pizza Florida	5.95	http://qdthpmw.edu/	{"BBQ sauce","Cheese cheddar","Caramelized onions",Onion,Sugar}	3
4173	7185	244	Philadelphia with salmon	7.45	https://www.pyuwwow.org/YsGicLP	{Peanuts,Cheese,Mozarella,"Chili Pepper",Sugar,Cucumber}	3
4168	9232	244	Bacon Cheese Burger	3.92	https://oymcnfp.ru/woeweaF.svg	{"Chili Pepper","Bavarian sausages","Japanese tamago",Grapes,Salmon,"Chili Pepper"}	1
4590	7573	254	Original burger	3.63	https://mydqlbi.org/BVmtvVk.js	{Mushrooms,Potatoes,Butter,Salmon,Chicken}	3
4176	8827	244	Bean Green Chili Burritos	6.21	https://dbnrsar.top/EQjyXGi.jpg	{Garlic,Flour,Butter,Flour,Potatoes}	3
4160	5114	244	Crispy Chicken burger	5.12	http://www.fepgvyw.info/fKhwwYw	{"Chili Pepper",Pasta,"Onion rings",Mushrooms}	5
4167	9118	244	Wallmart	5.22	http://mjyasyv.com/ZShuujp.css	{Strawberry,Peperoni,"Original sauce","Japanese tamago",Mushrooms,Sugar}	4
4607	8828	254	Unwrapped Burrito Bowl	2.66	https://pnbvsbs.org/XfMQbDD.js	{Sugar,Mushrooms}	4
2001	5494	154	Peanut Butter	6.08	http://ddyjxjx.biz/Ihpmofl.html	{Onion,Onion,Pineapple}	1
4605	7261	254	New York Style Cheesecake	2.83	http://pqclfhv.edu/oksNvoM.php	{Cheese,Strawberry,Basil,Flour,Pineapple}	3
4157	1894	243	Pizza Italiano	7.06	http://aslvoft.net/lxusAcU.webp	{Sugar,Nori,"Onion rings",Garlic}	1
4172	3281	244	Original burger	5.36	https://www.pbahwhu.ru/dPAZYZU	{"BBQ sauce",Sugar}	1
842	9003	219	Saint Frank Coffee	7.28	https://ihdajky.top/WKTvMGS.svg	{Cucumber,"Cream cheese",Pineapple,Chicken,Mushrooms}	1
4170	5886	244	Pizza Pepperoni with tomatoes	7.43	https://tqshcwe.org/HvRMwid.php	{Cucumber,Pineapple,Mayo,Onion,Peanuts,"Cheese cheddar"}	2
4588	5490	254	Peanut Butter	6.29	http://rpbnnzr.ru/	{Cheese}	5
4158	5887	243	Tortellini Bowls	3.27	https://www.fxblaqx.com/wgkNyVr	{Mushrooms,Mushrooms,Peanuts,Milk,Salmon,Mushrooms}	4
4174	9993	244	Himawari	2.71	https://xyzncjv.net/IujJRgS	{Pineapple,"Cream cheese","Bavarian sausages",Carrots}	2
889	3926	222	Pizza Italiano	2.20	https://nqvxepa.com/HyokKUI.jpg	{Salmon,"Onion rings"}	5
4162	6307	244	Pizza Pepperoni with tomatoes	6.91	https://jajypbo.edu/MHwUpij.php	{"Japanese tamago",Mushrooms,Flour,Corn,Butter}	2
4159	7130	243	Pizza	2.77	https://qfbmtux.edu/vBLPwGN.svg	{Pineapple,Rice,Sugar,Pineapple}	2
4606	2921	254	Crispy Chicken burger	2.69	http://www.vgrurbu.ru/	{Pineapple,Mushrooms,Cucumber,Basil,Butter}	2
4164	9123	244	Wallmart	6.01	https://bmaegem.top/FjSTRjH.webp	{Basil,"Cream cheese",Peas,"Unagi sauce"}	3
4609	7957	254	Original burger	7.83	https://iesoizn.info/PMMAeBt.svg	{Strawberry}	5
4161	4274	244	Pizza Hawaiian	4.22	https://ndpwmby.edu/RfrEFoy.php	{Tomatoes,Sugar,Flour,Flour}	1
2879	474	187	Pizza Florida	6.30	http://www.hwucaxv.org/	{Cucumber,Salmon,Meat,Onion,Chicken,Garlic}	5
2902	4310	187	Original burger	6.48	https://vlcprhw.com/xpVKdDp.html	{Nori,Garlic,Mayo}	2
2903	4782	187	Pizza Pepperoni with tomatoes	7.38	http://yxalnmk.ru/	{Milk,Pineapple,Rice,Potatoes,Garlic}	1
2027	1014	154	Angel Food Cake	4.31	https://www.xodokrd.ru/qVjptYZ	{Peanuts}	1
2884	7607	187	Pizza Pepperoni with tomatoes	7.04	http://jnfbyvi.org/lOBJmeL.html	{Salmon}	1
2886	8138	187	Himawari	4.57	https://kiihlao.net/DuVKYMv.css	{Nori,Mushrooms}	5
4575	1080	254	New York Style Cheesecake	6.87	http://gweiccb.net/TCjYmEo.css	{"Cheese cheddar",Basil,Grapes,Salmon,"Caramelized onions",Butter}	2
2023	2247	154	Sweet Potato Pie	3.67	http://yexmsnb.edu/ntSlEKj.svg	{Onion,"Original sauce","Cheese cheddar","Caramelized onions"}	4
2890	2000	187	Angel Food Cake	7.36	https://afahysq.top/nBPFZcY.css	{Mozarella,Nori}	4
939	366	222	Original burger	6.03	https://tmmwteg.edu/VddpZZs	{Potatoes,Corn}	2
2883	7681	187	Unwrapped Burrito Bowl	6.66	https://www.ohiduvu.biz/	{Flour,"Original sauce",Corn,Potatoes,"Japanese tamago",Carrots}	3
4181	9989	244	Unagi Philadelphia	4.72	http://wucaleh.com/hVKQdBq.svg	{Chicken,Carrots,"Unagi sauce",Salmon,Mushrooms}	3
2895	8497	187	Pizza	4.63	https://nykgdvg.org/	{Mushrooms,Cheese,Flour,"Cheese cheddar","Japanese tamago",Salmon}	1
2898	5956	187	Bean Green Chili Burritos	5.56	https://rfackci.net/THJMqoK.css	{Salmon}	1
2880	1491	187	Pizza	2.55	http://wdcsqsx.com/UbxyiEZ.jpg	{Cheese,"Cottage Cheese"}	1
2897	8825	187	Saint Frank Coffee	5.66	https://lcqghia.biz/ccoHDEe.webp	{Mushrooms,"Bavarian sausages",Butter}	5
2899	3914	187	Sweet Potato Pie	5.34	https://ldexbxm.top/	{Potatoes}	1
2896	8006	187	Wallmart	3.07	http://qchvbrl.edu/ZBNuVOS.jpg	{Strawberry,Onion,"Caramelized onions"}	2
2900	8244	187	Unagi Philadelphia	5.06	http://ihiysbb.net/	{"Cottage Cheese"}	1
2894	2931	187	Pizza	2.93	http://tfybpqd.info/amhSmQR.svg	{Carrots,"Cream cheese"}	2
758	9293	219	Bacon Cheese Burger	5.36	https://www.nerstii.biz/TOxsEej	{"Cheese cheddar",Basil,Rice,Onion,Grapes,"Original sauce"}	5
2877	5616	187	Pizza Florida	2.04	https://rnkhdtn.net/AScTOHM.css	{"Caramelized onions"}	2
2878	9138	187	Pizza Florida	7.08	https://sonrlhv.edu/eQAcqUt.php	{Cheese,Meat,Mushrooms,Meat,Chicken}	3
2019	3208	154	Chicken Pot Pie	6.68	https://qtgqqwb.info/rUCqskD.webp	{Basil,"Onion rings",Salmon}	5
2017	8248	154	Tortellini Bowls	6.93	https://mzwqdde.ru/pdSQSII.jpg	{"Cream cheese",Pasta,"Cottage Cheese",Pasta,"Unagi sauce"}	3
2881	2758	187	Sweet Potato Pie	6.33	https://www.keftwxg.com/VwTpQQS	{Rice,"Caramelized onions","Cottage Cheese"}	3
2882	618	187	Angel Food Cake	7.37	https://ifuhlus.org/XMoEbyF.webp	{"Cheese cheddar","Japanese tamago",Mushrooms}	1
2022	1685	154	Pizza Italiano	6.45	http://stxanwl.com/	{"BBQ sauce",Grapes,Mushrooms,Nori,Cucumber}	1
2026	2916	154	Unagi Philadelphia	2.94	https://rnjnnjo.net/ystkkAZ.svg	{Chicken,Nori,"Chili Pepper",Cucumber,"Chili Pepper"}	2
2025	8887	154	Sweet Potato Pie	7.09	https://oonqaew.biz/ePPcsMg	{Pineapple,Chicken,Grapes,Nori,Nori,"BBQ sauce"}	5
2887	5984	187	Philadelphia with salmon	5.40	http://pepnbsp.info/RqWYBCj.jpg	{"Chili Pepper",Nori}	4
2888	5760	187	Saint Frank Coffee	2.16	http://opdowws.net/YbblkUW.html	{"Unagi sauce",Nori}	3
936	6082	222	Philadelphia with salmon	6.51	https://mmqopkg.biz/xlqaxbC.js	{Mozarella,"Japanese tamago",Bacon}	5
937	2599	222	Peanut Butter	4.54	https://vubwlca.top/DNGEWWc	{Onion}	3
2892	2696	187	Chicken Pot Pie	3.25	https://tebjdco.info/wufTGYF.css	{"Cheese cheddar",Peperoni}	2
2893	646	187	Original burger	6.76	https://www.qujnuce.biz/XARcaaE	{Peperoni,Meat,"Unagi sauce"}	1
2015	9267	154	Bean Green Chili Burritos	6.02	http://tijnlmx.net/caalJhP.svg	{Pineapple,"Cream cheese",Corn,Potatoes,Corn}	3
2889	289	187	Peanut Butter	5.54	https://www.ktreemu.ru/xRuDoLS	{Pasta}	3
2024	600	154	Pizza Ocean	7.25	http://www.xuqsjvu.ru/	{Salmon,Corn,Bacon,Mayo,"Chili Pepper",Butter}	2
4211	9223	244	Grape Jelly Sandwich	6.94	http://aoteeus.net/hEAqQIO.webp	{Flour,Mushrooms,"Caramelized onions","Chili Pepper",Pineapple}	2
2028	1642	154	Original burger	7.26	https://www.mymepsx.biz/	{Rice,"Caramelized onions"}	1
2007	8432	154	Wallmart	3.97	http://xxsgquh.ru/sfbMsrO.html	{Corn,Peas,Rice,Chicken,Mushrooms,"Chili Pepper"}	3
2016	423	154	Philadelphia with salmon	6.79	http://pksslrv.top/DwiahIl.jpg	{Potatoes,"Cottage Cheese","Japanese tamago",Cucumber,Bacon,Peas}	1
5139	9627	261	Pizza Ocean	2.84	https://gpvnvfb.com/	{Mushrooms,Cheese,Salmon}	2
5140	3916	261	Himawari	4.91	https://tyidfgv.top/NWYadjh.js	{"Japanese tamago"}	2
5175	6595	262	Bacon Cheese Burger	6.99	https://hofevax.edu/fdsKZMx.jpg	{Tomatoes,"Cheese cheddar","Unagi sauce",Onion,Mushrooms}	2
5131	9263	261	Himawari	4.31	http://hqyrsmp.net/KhRbhAo.html	{Meat,Strawberry,Onion,Milk}	3
5132	9169	261	Original burger	2.60	https://tvbymnf.com/dEsKUGh.php	{Basil,Flour,Mushrooms,Potatoes,Rice,Flour}	3
5178	277	262	Pizza Texas	5.71	http://xbaccrs.info/GfHIDOS.html	{Mayo,Strawberry,Cucumber,Pineapple,Bacon,Mozarella}	1
5134	5210	261	Pizza Ocean	5.46	http://gudxwbe.ru/ECaAqZR.svg	{Carrots,Cheese,Basil,Mayo,Strawberry}	4
5135	2988	261	Angel Food Cake	6.38	https://www.fiowmep.org/	{Grapes,Carrots}	1
5133	2131	261	Original burger	5.62	https://fyekkpb.org/WCyVWqt.js	{Potatoes,Mushrooms,Mozarella,"Bavarian sausages"}	1
2906	5366	187	Pizza Texas	4.77	https://qlgkjfn.info/viJlFMV.php	{"Bavarian sausages",Corn,Bacon,Nori}	3
5125	6171	261	Tortellini Bowls	6.01	http://kikeisb.biz/HYBlqiP.webp	{Cucumber,Strawberry}	4
5136	5867	261	Pizza	7.47	https://www.hxekitk.top/SHvMrfD	{Chicken,Salmon,Mushrooms,Sugar}	2
5137	9378	261	Pizza Texas	3.84	http://rhewffv.biz/bdKcVRD.php	{Mushrooms,Cheese}	4
5141	1743	261	Philadelphia with salmon	3.00	http://rnlbdhd.edu/tvtCSNu.html	{Chicken,"Cheese cheddar",Flour,"BBQ sauce"}	5
5142	3380	261	Pizza Italiano	4.94	http://www.xyxzrub.info/	{"Onion rings",Corn,Corn,Sugar,Garlic,"Japanese tamago"}	5
5143	4430	261	Grape Jelly Sandwich	4.66	http://cbibwpb.info/bYJcJMi.html	{Peas,Peanuts,Basil,Potatoes,Nori}	3
5144	3184	261	Pizza Italiano	4.11	http://ktdvdhe.info/xjYqWsm.css	{Cheese}	2
5148	1578	261	Pizza Ocean	6.70	http://ciagdwl.top/DGwUXUp.html	{Basil,"Chili Pepper",Pineapple}	3
5150	1303	261	Pizza Florida	6.00	https://kisdnyw.net/SbuFrAx.jpg	{Onion,Cheese,Strawberry}	3
5154	4093	261	Pizza Ocean	5.30	http://brdbzfr.info/RVEoKxw.css	{"Cottage Cheese"}	1
5155	6167	261	Original burger	4.66	https://vfjnkdg.biz/EZaOEux.webp	{Pineapple}	1
5156	4039	261	Pizza Italiano	3.74	http://rqnuggd.biz/BBrAcJp.svg	{Basil}	1
5157	4750	261	Pizza	2.80	http://nqrwyql.com/UonwTQI	{"Onion rings"}	2
5158	4972	261	Peanut Butter	7.69	https://www.hjiiehf.com/TfXxHcL	{Mayo,Salmon,Mozarella,Sugar,"Onion rings"}	1
5159	4945	261	Chicken Pot Pie	7.72	https://dsuyuqf.net/WBVVDXt.js	{Mushrooms,Meat,Butter,Rice,Cheese}	1
5160	8658	261	New York Style Cheesecake	2.29	http://gnwknqa.top/vODZHwK.jpg	{Corn}	3
5173	433	262	Peanut Butter	2.30	http://gdbvcow.info/HbpKgbT.js	{Bacon,Mushrooms,Tomatoes,"Onion rings","Unagi sauce",Cheese}	5
2905	9827	187	Pizza Italiano	6.58	http://vljsqdb.com/cevGWPs.php	{Tomatoes}	2
5176	8355	262	Angel Food Cake	5.63	http://sfuculi.com/	{Strawberry,Rice,Garlic}	1
5177	1233	262	Philadelphia with salmon	7.30	https://rsuruml.ru/jKyXsis.css	{Peas,Cheese,Salmon,Flour}	5
5179	7039	262	Pizza Pepperoni with tomatoes	4.12	https://rvfmlwm.info/dyljcIU.svg	{Milk,"BBQ sauce","Unagi sauce"}	4
5180	5819	262	Saint Frank Coffee	7.87	http://gkwaypj.com/yoPteHN.php	{Basil,"Onion rings"}	2
5181	1140	262	Unagi Philadelphia	7.44	https://bdysmfn.info/	{Tomatoes,Peanuts,Corn,"Caramelized onions",Chicken}	1
5182	6577	262	Saint Frank Coffee	6.95	http://jdjzhjw.edu/LKZABJJ.jpg	{Mayo,Bacon}	3
5183	881	262	Bean Green Chili Burritos	3.56	http://spqijbw.edu/vCFZgsA	{Butter,Basil,Mushrooms}	4
5184	3304	262	Unagi Philadelphia	7.33	http://xxuibtl.biz/jELfHBP.php	{Carrots,"Caramelized onions",Milk}	5
2904	513	187	Grape Jelly Sandwich	5.22	https://fvqdsar.net/UutKisI.jpg	{Bacon,Pasta,Peperoni,Grapes}	3
5120	1128	261	Pizza Texas	2.30	https://www.ztbmguv.info/	{Meat,"Japanese tamago",Potatoes}	4
985	5869	223	Himawari	3.00	https://ndfdakv.top/mbyLVCQ.php	{Peperoni,Milk}	2
5119	2253	261	Sweet Potato Pie	7.86	http://www.rxetire.org/	{Peas}	5
983	2752	223	Angel Food Cake	7.82	http://uxsncrn.top/AXHQMgo.webp	{Onion}	3
5124	1852	261	New York Style Cheesecake	3.38	http://yfqbeyp.ru/iZcZJbl	{Mushrooms}	1
5138	1186	261	Wallmart	3.98	http://utujrey.net/ZrAbUxT.php	{Carrots,Tomatoes,"Unagi sauce",Chicken}	5
5147	2651	261	Pizza Ocean	3.60	https://csccgar.info/ZfFrULf.php	{Cheese,"Chili Pepper"}	3
5145	8685	261	Pizza Texas	4.96	https://uazunud.biz/rWYedcM.php	{Cheese}	2
5146	9215	261	Swedish Meatballs	6.17	https://www.trdoedx.net/ESrTxHW	{"BBQ sauce"}	2
5189	7935	262	New York Style Cheesecake	4.10	https://agkzucc.edu/UFWAVrI.php	{Salmon,Potatoes,Bacon,"Cottage Cheese",Mushrooms}	2
5197	9406	262	Pizza Ocean	5.63	https://yjmkiqr.biz/itQGjge.html	{"BBQ sauce",Strawberry,Strawberry,Onion}	3
2916	355	187	Pizza Italiano	4.59	http://vnlpulc.net/xbhIokt	{Tomatoes,Sugar,"Cottage Cheese",Peperoni,Peperoni,"BBQ sauce"}	2
2909	8217	187	Tortellini Bowls	6.58	http://xgptvbo.edu/XdFyGbu.php	{Grapes,Pasta,Basil,Grapes,"Cream cheese","Onion rings"}	4
2918	6146	187	Pizza Pepperoni with tomatoes	7.00	http://jwzwmpq.com/PZxZtXg.css	{Peas}	3
2914	1857	187	Peanut Butter	3.74	https://loaueld.edu/	{Peas,Corn}	4
2921	1980	187	Chicken Pot Pie	6.91	https://pzpzbaw.net/RipsJAg.svg	{Peanuts,"Cheese cheddar",Cucumber,Garlic,Peas,Pasta}	2
3504	7283	201	Grape Jelly Sandwich	3.07	http://eryaztt.com/jCZNALr.html	{Mushrooms,"Cottage Cheese",Tomatoes,Potatoes,Nori}	2
5194	7462	262	Wallmart	6.27	https://snfmyjc.top/	{Flour,Tomatoes}	5
5187	6758	262	Angel Food Cake	7.45	https://hnetfdd.ru/XxHluKO.js	{Peas,Chicken,Peperoni,Peas,Meat,"BBQ sauce"}	3
5188	2031	262	Pizza	7.67	https://scrryxo.com/oglOowZ.svg	{"Caramelized onions"}	5
5212	430	262	Angel Food Cake	7.05	http://zatihuw.org/FdIWsKN.webp	{Mushrooms,Rice,"Original sauce",Rice,Rice,Peperoni}	3
3506	1962	201	Himawari	3.60	http://jjgciqn.com/rUPZiGQ	{Peanuts,Mushrooms,"Chili Pepper"}	2
5213	7603	262	Original burger	7.81	http://uwutven.net/ySpVXEs.php	{Basil,Tomatoes,Garlic,Mushrooms,Flour,Nori}	1
2911	273	187	Unwrapped Burrito Bowl	3.65	https://czhhrre.top/bHNNjbm	{Onion,Chicken,Mushrooms,Butter}	2
5191	5056	262	Angel Food Cake	6.78	http://iaothcg.net/CCcXjvk.html	{Sugar,Mayo,"Bavarian sausages","Onion rings",Chicken}	3
5186	1357	262	Unwrapped Burrito Bowl	2.41	http://www.gpwgsdf.net/rAIUUCj	{Onion,Garlic,Peanuts,Pineapple,"Chili Pepper"}	1
5193	4820	262	New York Style Cheesecake	7.80	http://xislzdt.top/jtEdafO.css	{Salmon}	5
2910	9738	187	Pizza Italiano	2.53	http://xdbzkbe.edu/ttoDiJw.html	{Meat,"Japanese tamago",Sugar,Sugar}	3
5215	2889	262	Philadelphia with salmon	5.89	https://www.itcfjsp.edu/	{Meat,Corn,Peanuts,Flour,Butter}	2
5217	1017	262	New York Style Cheesecake	6.47	https://chkhheb.edu/HESqMbp.js	{Cheese,Basil,Flour,Flour,"Cottage Cheese"}	1
5185	4243	262	Tortellini Bowls	2.89	http://vfkfhhw.ru/IesCofB	{Onion,"Unagi sauce",Corn}	3
2915	9282	187	Bacon Cheese Burger	2.49	https://rpzxnbo.info/CqgryGn.js	{"Cheese cheddar",Milk,"Onion rings","Cottage Cheese",Chicken,"Cottage Cheese"}	5
2917	5052	187	Chicken Pot Pie	2.56	https://www.bddomiv.ru/mFEWvnM	{Sugar,"BBQ sauce",Flour,Grapes,Nori,Milk}	4
2919	553	187	Unwrapped Burrito Bowl	7.64	http://www.inuejbq.ru/	{Mozarella}	5
5211	4876	262	Philadelphia with salmon	4.05	https://jvnmbnd.net/rhppHaI.js	{Onion}	3
5195	2081	262	Pizza Texas	6.30	http://gvfrvdv.biz/YPXPtRq.webp	{Flour,Salmon}	5
5196	4110	262	Unagi Philadelphia	2.19	https://www.bgvgbuq.net/	{Corn,Peanuts,"Unagi sauce",Cheese,Mushrooms}	5
5214	8436	262	Bean Green Chili Burritos	5.00	https://ilgiucn.biz/qiVOdXR.php	{"BBQ sauce",Flour,"Bavarian sausages"}	4
5216	2942	262	Bacon Cheese Burger	4.12	http://www.ddrwkxq.ru/rdJqJFE	{Butter,Nori,Nori,"Cottage Cheese",Nori,Salmon}	4
5218	1095	262	Pizza Italiano	4.66	http://knvmnkn.edu/qdAbEPa	{"Original sauce",Meat}	3
1030	5398	224	Original burger	4.95	http://ebyuuwd.biz/hjgBius.jpg	{Mushrooms,"Onion rings",Tomatoes}	4
2907	8588	187	New York Style Cheesecake	3.12	http://fzbcylf.edu/jNsRUqg.webp	{Cheese,Mozarella,"Unagi sauce",Rice,Milk}	2
2908	9538	187	Bean Green Chili Burritos	5.09	https://www.ynsypbw.com/	{Peas,"Chili Pepper",Bacon,Butter,Rice,Milk}	1
3507	3603	201	Pizza Italiano	7.89	https://wcjdgqs.net/iCfLKtR	{"Caramelized onions"}	3
2913	3937	187	Peanut Butter	4.62	https://azwbgfc.net/WyEUDuy.svg	{"Caramelized onions",Mayo,Pasta,Pineapple,Bacon,Pasta}	5
5190	2259	262	Pizza	7.70	http://www.qeflyqx.com/	{"Original sauce"}	5
5192	7897	262	Grape Jelly Sandwich	6.27	http://bcjetes.ru/bXcElqk.php	{Nori,Strawberry}	2
2920	1461	187	Angel Food Cake	5.57	https://rugubpo.edu/GLxdvoJ.html	{"Onion rings",Meat,Mushrooms,Milk,"Bavarian sausages",Pasta}	1
5198	3278	262	Chicken Pot Pie	2.15	https://www.jtdwghg.com/	{"Chili Pepper",Strawberry,Basil,Basil,Peperoni}	4
5210	2774	262	Pizza Hawaiian	4.11	https://hulhudk.net/Pbduodn.php	{"Original sauce","Bavarian sausages"}	4
3505	4831	201	New York Style Cheesecake	7.01	http://rnsjgnw.info/FrXpLfj	{Mozarella}	3
3427	23	199	Grape Jelly Sandwich	4.83	https://cpaupsq.info/RynXnGm.php	{"Cream cheese",Flour}	3
3462	7126	199	Tortellini Bowls	6.52	http://lputydk.org/	{Potatoes,"Cheese cheddar",Sugar,"Chili Pepper",Grapes,Peas}	1
3470	7775	199	Pizza Pepperoni with tomatoes	7.17	https://mwezcly.org/fqurvfX.svg	{"Onion rings",Mayo,Salmon,"Japanese tamago"}	5
3457	3749	199	Wallmart	5.05	https://xcwakqn.top/tmIfYqM.svg	{Salmon}	1
3474	3853	199	Pizza Pepperoni with tomatoes	3.75	https://qvthhbr.ru/WetFYUT.webp	{Peas,Mayo,Grapes,Grapes}	3
3477	3307	199	Peanut Butter	4.79	https://hjqohch.org/tdYRwxN	{Mayo,Potatoes}	5
3480	4205	200	Philadelphia with salmon	2.30	https://pxszafg.edu/kWoACaK.svg	{Milk,Milk,Mayo,"Cottage Cheese","Chili Pepper"}	5
1689	5	2	Crispy Chicken burger	4.00	https://316024.selcdn.ru/wiget/4d4c871a-107f-11e7-80df-d8d38565926f/93bce037-709e-41a0-9beb-ab3670663b40_Medium_.jpg	{Chicken,Tomatoes,Mushrooms,Onion,"BBQ sauce"}	3
3435	906	199	Unwrapped Burrito Bowl	7.98	https://qwtpzba.com/LoKGtmk.svg	{Mushrooms,Flour,Nori,Rice}	1
3442	4368	199	Peanut Butter	6.12	https://eaviuwn.edu/RxykeOS.svg	{Butter,Cucumber,Sugar,"BBQ sauce",Peperoni}	3
3449	213	199	Grape Jelly Sandwich	4.54	http://hhxhurs.com/cExVbFO.webp	{"Cream cheese",Mayo,Meat,Butter}	2
3450	679	199	Unagi Philadelphia	7.93	http://zsrrixb.top/oXdNrXy.js	{Salmon,"Unagi sauce",Milk,Corn}	4
3455	3065	199	Unwrapped Burrito Bowl	2.49	https://sbitwqx.biz/tiLmVGI.php	{"Cottage Cheese"}	2
3453	5519	199	Grape Jelly Sandwich	3.50	https://rfgdyil.edu/	{Peperoni}	3
3464	4253	199	New York Style Cheesecake	3.68	http://tgnwlgg.org/	{Mushrooms,"Chili Pepper",Salmon,Sugar,Pasta,Cucumber}	2
3465	1072	199	Pizza Italiano	5.04	https://szqcjdp.top/MWfyHUx.html	{Basil,"Bavarian sausages","BBQ sauce",Onion,"Chili Pepper","Japanese tamago"}	1
3467	9796	199	Wallmart	6.17	https://bjzidsx.org/tSueKLK.php	{"Bavarian sausages",Basil,Mayo}	3
3468	2934	199	Pizza	7.74	http://tfeotge.top/lExHokH.js	{"Cheese cheddar",Milk}	2
3469	4177	199	Pizza Florida	4.37	https://rumdddo.ru/uUPoSTX.webp	{Salmon,"BBQ sauce",Tomatoes}	5
3471	2459	199	Tortellini Bowls	6.86	http://passwji.org/MIfNSUN.jpg	{Chicken,Tomatoes,"Japanese tamago"}	5
3472	2480	199	Philadelphia with salmon	4.83	https://yabubmk.net/dCmMGyq.php	{Mushrooms,"Caramelized onions"}	5
3476	9814	199	Grape Jelly Sandwich	3.66	https://eznpmah.com/hPKUHFw.js	{Pineapple,Peas,"Unagi sauce",Flour,Sugar,Potatoes}	3
3478	815	199	Pizza Hawaiian	4.71	http://osgtmks.org/	{Pasta,Pasta}	2
1075	7305	224	Himawari	4.38	http://qkfrsvx.top/LHnlxRe.css	{Peperoni,"Onion rings",Tomatoes,Mozarella}	3
5023	8360	259	Unagi Philadelphia	6.35	http://ppbvfpv.biz/ZsiUKwf.svg	{"Bavarian sausages","Bavarian sausages",Meat,Tomatoes}	5
3426	4118	199	Himawari	7.67	http://upvahfr.info/AMUTRFc.js	{Grapes,"Original sauce",Onion,Peas,Pasta,Salmon}	4
3454	5885	199	Pizza Texas	7.76	https://eptvbri.info/NGUeyVW	{"BBQ sauce",Garlic,Basil}	4
2891	2384	187	Original burger	5.04	http://wsbhuux.com/mpKgFTC.jpg	{"Caramelized onions",Grapes,Sugar,Carrots,Tomatoes,Peperoni}	1
3452	3064	199	Pizza Hawaiian	7.95	https://rvjntkr.biz/rpcnJKI.svg	{Pasta,Flour,Corn,Mozarella,"Caramelized onions"}	2
3458	8700	199	Himawari	7.68	https://aywiphi.edu/dIJlcSw.jpg	{"Original sauce",Pasta}	3
3461	3519	199	Pizza Italiano	6.72	https://hnaumau.com/lFEhPqD.webp	{Mayo,Salmon,Pineapple,Peas,Mayo}	2
3473	7461	199	Crispy Chicken burger	6.05	http://hgfauyx.ru/vdXOrrY.svg	{Bacon,Salmon,Peas,Cheese}	4
3479	6986	199	Pizza	3.43	https://ajwqgpl.biz/	{Pasta,Strawberry,Mozarella,Potatoes,Pineapple,Tomatoes}	1
3508	6418	201	Pizza Hawaiian	6.48	https://clksklw.ru/	{"BBQ sauce","Onion rings","Original sauce"}	1
3448	5057	199	Tortellini Bowls	5.95	http://mcucjxo.net/QGgBciG.webp	{"Caramelized onions",Strawberry,Butter,"Unagi sauce"}	1
3446	3448	199	Bean Green Chili Burritos	3.49	https://bwwxvbg.info/qQBEpUr.js	{Peanuts,"Caramelized onions",Tomatoes,Strawberry,Flour}	1
3451	2603	199	Bacon Cheese Burger	4.31	https://www.ktlvexm.biz/YsyXevF	{Mozarella,Flour,"Chili Pepper",Meat,Garlic}	5
3459	5703	199	Pizza	5.73	https://vvoeosy.ru/GwhciWX.jpg	{Cucumber,Salmon,Rice}	2
3463	4793	199	Pizza Italiano	5.50	http://onppwlx.top/OIxqsdN.php	{Pasta}	2
3460	2432	199	Wallmart	7.67	https://pivmkjv.net/	{"Bavarian sausages",Flour,Peanuts,Peperoni,Mushrooms,"BBQ sauce"}	2
3456	1326	199	Pizza	3.07	http://hqtodaf.net/	{Mayo,Butter,"Cheese cheddar"}	5
3447	9970	199	Wallmart	6.77	https://uqubwhc.com/uOvKmgr.jpg	{Salmon,Cucumber,Peperoni,Salmon}	2
1122	386	226	Pizza Pepperoni with tomatoes	2.57	http://agsbylh.biz/joQVGMK.html	{Milk,Pineapple,Tomatoes,Potatoes,"Onion rings"}	2
3929	8239	239	New York Style Cheesecake	5.84	https://ppecnqx.info/aIYhSfm.webp	{Onion,"Cottage Cheese","Bavarian sausages",Cheese,"Japanese tamago",Bacon}	5
3509	6483	201	Grape Jelly Sandwich	4.67	http://yakirbf.edu/MaMYubu.webp	{Pasta,Sugar}	1
3510	7899	201	Bean Green Chili Burritos	5.39	https://ywmjadv.info/hvwNopF.jpg	{"Bavarian sausages",Potatoes}	4
3511	4917	201	Unagi Philadelphia	5.73	https://www.fghtynb.info/	{"Original sauce"}	2
3513	3451	201	Philadelphia with salmon	7.02	https://sqgjysf.com/xwejvLS.webp	{Pasta,Cheese,"Japanese tamago",Mayo,"Original sauce"}	4
3514	9601	201	Pizza Hawaiian	6.99	http://www.yytxiup.top/cSwxQRS	{Bacon,Butter,Tomatoes,Pineapple,Peperoni,Milk}	1
3515	4162	201	Wallmart	4.09	http://www.xplqvki.net/oIWlsbb	{"Chili Pepper","Japanese tamago"}	4
3516	8449	201	Saint Frank Coffee	5.11	http://www.necgmfn.net/	{Sugar,Nori}	4
3517	6031	201	Saint Frank Coffee	6.61	https://bugjxli.net/eraoYmf.svg	{Peas,Basil,Peas,Pasta,Pineapple}	1
3518	2175	201	Pizza Pepperoni with tomatoes	4.27	https://www.xgepvwh.com/vqdtmun	{Carrots,Potatoes,Peanuts,Chicken}	3
3519	6487	201	Chicken Pot Pie	4.32	https://ptmpqam.info/UepEZVR.svg	{"Caramelized onions",Flour,"BBQ sauce"}	3
3520	1208	201	Saint Frank Coffee	3.09	http://cvsjojm.biz/pltOGuE.css	{"Bavarian sausages","BBQ sauce","Cottage Cheese"}	4
1168	7200	227	Crispy Chicken burger	4.03	http://www.sqhhpug.ru/	{Flour,Meat}	5
1170	7074	227	Bean Green Chili Burritos	2.67	http://jddqfgn.org/pJkcYgK.webp	{Onion,Butter}	2
1215	5134	228	Pizza Italiano	3.32	http://dxrkqlp.org/ojGCwqa.php	{Pasta}	3
1229	8884	228	Pizza Italiano	3.42	https://tylodgl.edu/	{Bacon}	4
1261	2688	229	New York Style Cheesecake	7.39	http://tcjolvq.ru/	{Pineapple,Mozarella,Peas,"Bavarian sausages"}	5
1306	3409	230	Swedish Meatballs	3.19	https://rwenjur.com/	{"Caramelized onions",Butter,Mozarella,Peas}	2
1312	2244	230	Crispy Chicken burger	2.72	http://byfvcti.info/kyXcvZk.webp	{Milk,"Cottage Cheese"}	2
1352	2904	231	Crispy Chicken burger	2.79	https://lhxxbkg.net/	{"Onion rings","Caramelized onions",Mushrooms,"Unagi sauce"}	1
1398	9679	232	Unwrapped Burrito Bowl	2.33	https://mgodmrt.edu/rCEKUUt.js	{"Cream cheese",Salmon,"Unagi sauce",Flour,Corn}	3
1444	4585	232	Swedish Meatballs	4.91	https://orflbpl.com/HFdQnti.js	{Mayo,Basil}	2
1446	1859	232	Pizza Texas	6.16	http://qmvjhfy.ru/ooOWsME.jpg	{Carrots,Flour}	2
1491	6214	233	Pizza Italiano	2.28	https://pwbplgh.com/GGmvZbu.svg	{Onion,Cheese,Cucumber,Garlic,Cucumber,Cucumber}	2
1492	1777	233	Pizza Italiano	6.96	http://www.owehgid.ru/TDbpket	{Peanuts,"Onion rings",Peas}	4
1535	5053	235	Unagi Philadelphia	3.22	http://hwigaka.org/GjIIHXQ.webp	{"Cheese cheddar",Butter,Flour}	5
1536	3232	235	Chicken Pot Pie	4.46	http://www.sckikll.org/	{"BBQ sauce",Butter,Onion,"Bavarian sausages"}	5
1581	2371	235	Philadelphia with salmon	7.01	https://zobagvu.info/kvepVnC.css	{Salmon,Butter}	1
1582	634	235	Peanut Butter	2.49	http://www.ddmhbba.top/	{"BBQ sauce"}	5
1628	9268	236	Saint Frank Coffee	2.10	http://fexqgad.net/qeiWHov.php	{Cucumber,Onion,Peperoni}	3
1630	3343	236	Bean Green Chili Burritos	2.18	http://gkwwrtn.edu/qXFZsJU.webp	{Butter,"Japanese tamago"}	3
1676	9544	236	Pizza	4.94	https://qelroyk.biz/MhpDXux.js	{Flour,"Cream cheese",Corn}	3
1677	3861	236	Pizza Pepperoni with tomatoes	6.26	https://ocvpfjs.ru/	{Carrots,Rice,"Unagi sauce",Basil,Mushrooms,"Original sauce"}	3
1722	270	8	Pizza Florida	4.52	https://ehgqdgj.com/HFMdmJl.js	{Nori,Mozarella,Grapes,Mushrooms,Nori}	3
1723	8016	8	Grape Jelly Sandwich	7.01	http://pwcppvg.biz/	{Rice,Basil,Peas}	4
1764	1359	9	Pizza Hawaiian	2.90	https://vcdcina.net/WWMogbK	{Potatoes,Cheese,"Bavarian sausages",Basil,"Bavarian sausages"}	1
1765	3555	9	Himawari	4.05	http://lipzdgi.info/turhCqb.php	{"Cottage Cheese"}	3
1810	5740	9	Himawari	7.34	http://www.zfewczi.edu/	{Carrots,Meat}	3
1816	4552	10	Pizza	6.77	http://nmywgrl.org/	{Carrots,Peas,Milk}	1
1859	7907	151	Bean Green Chili Burritos	2.56	http://ikobtyo.net/	{Milk,Strawberry,Onion,Garlic,Garlic}	5
1904	3043	153	Pizza Italiano	3.97	http://edaicrl.com/KGjdTRl.js	{Butter,Rice}	5
1905	9462	153	Wallmart	5.89	https://www.moxujei.org/	{"Cream cheese"}	2
1951	2275	153	Chicken Pot Pie	5.04	http://www.gvoctfj.info/	{"Original sauce","Onion rings",Basil,Basil,Salmon,Butter}	4
1952	1116	153	Bacon Cheese Burger	4.56	http://www.trqwwea.biz/YRUPBTW	{Peperoni}	2
1996	9956	154	Tortellini Bowls	4.19	http://tmsnxut.info/GXiXkqc.php	{Salmon,"BBQ sauce",Cucumber,Onion,"Cottage Cheese"}	3
2044	4459	154	Pizza Hawaiian	5.57	http://qgrczsr.info/	{Garlic,"Original sauce",Bacon}	5
2045	4539	154	Original burger	2.42	http://ecgrprr.org/kRfWVXu.webp	{"Cream cheese",Cucumber,Flour}	1
2089	776	155	Pizza Ocean	4.83	http://yjvarup.edu/CGhQHkM.php	{"Original sauce",Garlic,Peanuts,Tomatoes}	1
2090	9901	155	Pizza Ocean	2.27	https://owqtway.com/iQuyIld.css	{"Chili Pepper",Chicken,"Japanese tamago",Peas}	2
2135	4406	155	Pizza Hawaiian	4.24	https://sojpkca.info/DrFLkDP.html	{Corn,Flour,"Onion rings",Butter,Carrots,"Caramelized onions"}	2
2181	3726	156	Unagi Philadelphia	2.34	https://cibjadb.top/SgokUVq.js	{"Onion rings",Pasta,Sugar,Milk,Peanuts}	2
2228	3000	157	Saint Frank Coffee	3.03	http://aoitshu.edu/	{Pineapple}	1
2274	7993	158	Pizza Hawaiian	4.09	http://www.boaeymv.com/	{"Cream cheese",Pineapple}	2
2275	3541	158	Pizza	7.40	https://dguxnea.info/YFytKSb.css	{Cheese,"Unagi sauce",Pasta,Mushrooms,Tomatoes,Butter}	4
2931	6049	188	Pizza	5.16	https://www.gesqhpk.edu/	{Onion}	5
2322	127	158	Saint Frank Coffee	6.88	https://uosefqi.biz/	{Chicken,Peperoni}	5
2368	6338	159	Philadelphia with salmon	4.20	http://sktepuf.com/xdmONkC.svg	{Onion,"Japanese tamago"}	5
2369	5606	159	Pizza	2.86	http://wckiivm.net/PrDvXnA.svg	{"BBQ sauce","Caramelized onions",Mushrooms}	1
1555	3195	235	Grape Jelly Sandwich	3.74	http://www.yvdketl.top/	{Nori}	4
1556	5644	235	Pizza Ocean	7.29	http://ceizouf.biz/shNSfGC.html	{Garlic,Sugar,Garlic,Carrots}	5
2461	7407	181	Unagi Philadelphia	3.05	https://www.wonqecv.info/	{Bacon,Carrots,Sugar,Peanuts}	2
2464	6262	181	Pizza Pepperoni with tomatoes	3.04	http://jmvvcih.info/yCGpKGB.svg	{"Japanese tamago",Mushrooms}	2
2505	4402	182	Unagi Philadelphia	7.77	http://xrzkpce.ru/OMrKahs.svg	{Milk,Mayo}	3
2507	624	182	Himawari	2.75	http://ibtdlpw.org/LbOnshv.js	{Strawberry}	5
2552	9154	182	Wallmart	4.24	https://fgjwsxc.top/dgFORuR.jpg	{"Original sauce",Pineapple}	1
2598	4306	183	Pizza Pepperoni with tomatoes	5.20	http://ixhfiqt.org/rAQtcyy.js	{Butter,Flour}	1
1713	8791	8	Angel Food Cake	2.96	https://www.ofcvekx.info/	{Corn}	3
1714	5584	8	Swedish Meatballs	4.01	https://bovambo.org/vfrdTfH.svg	{"Cottage Cheese"}	5
2691	4544	184	Pizza Pepperoni with tomatoes	2.78	https://fhndozk.ru/tuvlrkv.php	{"BBQ sauce",Grapes,Butter}	4
2692	482	184	Pizza Ocean	3.95	http://zoxrueg.ru/AgLCVNW.jpg	{"Cottage Cheese"}	2
2736	6860	185	Himawari	3.51	http://nwnjfie.org/rExGPds.php	{Cheese,"Cheese cheddar",Grapes}	1
2738	9088	185	Unwrapped Burrito Bowl	3.84	http://jggwvkv.biz/UvjYaFK.js	{Cheese,Corn}	4
2782	9459	185	Grape Jelly Sandwich	4.90	http://cbufakf.info/	{Mushrooms,"Chili Pepper",Mayo}	2
2783	3884	185	Peanut Butter	7.34	http://gzipbza.info/ERPjgFr.svg	{"Cream cheese",Pineapple,Potatoes,"BBQ sauce"}	3
2829	2834	186	Unwrapped Burrito Bowl	4.93	https://qslmtvf.org/xafYxHS.svg	{Flour,Mushrooms,Onion}	4
2830	9681	186	Pizza Hawaiian	5.54	http://mlbevvj.biz/MvPFAts.webp	{Tomatoes}	3
2876	5253	187	Swedish Meatballs	3.13	https://www.zsordls.ru/	{"Unagi sauce"}	5
2923	9456	188	Angel Food Cake	6.68	https://sahslkx.top/RwbgfVG.webp	{"Cottage Cheese","Onion rings",Flour,Butter,Milk,Grapes}	5
2970	6528	188	Chicken Pot Pie	4.48	http://oibcsva.com/KDWwqjj.svg	{Peas}	5
2971	5527	188	Unwrapped Burrito Bowl	2.18	http://www.tjczpni.org/	{"Chili Pepper"}	3
3015	7685	189	Pizza Ocean	3.47	http://zhutnno.biz/	{"Cream cheese",Basil,Butter}	4
3016	949	189	Pizza Italiano	2.20	https://deqwnrr.org/rMAsBRq.css	{Chicken}	2
3064	113	190	Swedish Meatballs	4.75	https://www.dxkmvjd.biz/	{Butter,Corn,"BBQ sauce",Potatoes,Tomatoes}	2
3065	9759	190	Pizza Florida	6.18	https://ojficbs.info/bvqVdaW.jpg	{"Chili Pepper",Cucumber}	1
3110	8285	190	Swedish Meatballs	7.99	https://wjypdkw.ru/gdeyMZR.webp	{Peas,"Chili Pepper",Onion,Flour}	2
3155	6691	192	Tortellini Bowls	6.29	https://ieammsn.info/YlrMnIm.php	{"Original sauce"}	5
3156	9616	192	Unwrapped Burrito Bowl	4.54	https://lhpuygy.com/LhWZQpT.jpg	{Tomatoes,Mushrooms,Tomatoes,Pasta}	2
3201	5400	193	Bacon Cheese Burger	6.18	https://pskowqb.com/dnIjinu	{Nori,"Cheese cheddar","Cottage Cheese","Chili Pepper",Peanuts}	4
3248	9972	193	Peanut Butter	5.42	https://www.swibfrd.top/ZCSpMBq	{Mushrooms,"Caramelized onions",Pineapple,Mayo,Cheese}	2
3295	5582	195	Wallmart	3.23	http://kwwieke.com/MtmPUdw.js	{Rice,Garlic,Flour}	4
3296	8795	195	Chicken Pot Pie	4.66	https://otiqqiq.top/anMOfBj.html	{Potatoes,Mushrooms}	3
3297	2311	195	Bacon Cheese Burger	4.06	https://txzdrto.ru/FCfOXNf.css	{Carrots,"Onion rings",Nori,Carrots}	4
3342	1592	196	Philadelphia with salmon	7.98	https://www.lgmsknf.info/	{Mozarella}	3
3343	7833	196	Saint Frank Coffee	5.11	http://swzbscj.biz/kjjadQY.css	{Strawberry}	4
3370	6711	198	Saint Frank Coffee	2.68	https://www.ntdnqpa.ru/	{Pasta}	4
3389	9694	198	Pizza Ocean	7.83	https://csapqxa.biz/	{Butter,Peperoni,Tomatoes,"Bavarian sausages",Basil}	4
3436	5181	199	Original burger	2.95	http://ldccfaw.com/ypoGngg.svg	{Strawberry,"Japanese tamago","BBQ sauce","Chili Pepper",Mushrooms}	3
3437	5633	199	Pizza Hawaiian	6.79	http://www.osarjhx.ru/tWiDVuu	{"Japanese tamago","Cheese cheddar"}	5
3481	4000	200	Philadelphia with salmon	7.56	http://zlsepek.edu/XlhDsSM.php	{Peas,Butter}	4
3482	2352	200	Chicken Pot Pie	6.45	https://pnokedr.com/	{Grapes,Flour,Corn}	5
3527	2624	201	Bean Green Chili Burritos	4.86	https://zjpfpms.ru/CEGGtsh.webp	{Mozarella,Flour,Mushrooms}	1
3575	7300	203	Saint Frank Coffee	3.52	http://scdofyp.com/dxpTyXq.php	{Nori,Flour}	4
3608	2059	203	Grape Jelly Sandwich	4.65	http://yzgfdub.top/	{Grapes}	1
3621	3140	203	Tortellini Bowls	6.59	https://gdamumm.org/	{"Cottage Cheese"}	2
3622	8595	203	Pizza Italiano	4.59	https://bxodedx.com/YeVgpwi.php	{"Onion rings",Flour}	4
3668	6574	205	Bacon Cheese Burger	7.40	https://phvmyym.info/chPpavv	{"Onion rings",Nori,Peanuts,Mozarella,Bacon,Mozarella}	2
3669	7177	205	Grape Jelly Sandwich	3.92	http://vhomawc.edu/NaWdDVJ.html	{Basil,Mushrooms,Peas,Rice}	4
3715	3194	205	New York Style Cheesecake	7.83	https://lwsdfpr.com/qtsvGgC.jpg	{Mushrooms,Peas,Onion,Peas,Mozarella}	3
3716	3814	205	Swedish Meatballs	7.28	http://myhyfxe.com/SuuFwst.php	{"Cheese cheddar",Strawberry,Mozarella,Sugar}	4
3760	1374	206	Wallmart	5.07	https://www.skiydnb.biz/	{Peperoni,Cucumber}	5
3761	910	206	Swedish Meatballs	3.39	https://mcnstiv.org/GLGotyd.php	{Strawberry,"Chili Pepper",Cucumber,"Cottage Cheese",Onion}	1
3804	5063	206	Bean Green Chili Burritos	2.32	https://www.sqnreqb.info/SpirDYd	{Mozarella,Peanuts}	3
3806	3760	206	Pizza Ocean	3.52	http://www.wdkvtie.net/pmOhTXf	{Strawberry,Mayo,Nori,Corn,Onion}	1
3851	3805	207	New York Style Cheesecake	3.57	http://nlsavbq.top/vPMRpbZ.html	{Tomatoes,Garlic,Peas,"Cream cheese",Pasta,"Chili Pepper"}	5
3898	5716	239	Pizza Italiano	6.95	https://jngidmk.info/fDJQHsb.jpg	{Peanuts,Onion,"Original sauce",Corn,"BBQ sauce","Caramelized onions"}	4
3944	2573	239	Angel Food Cake	5.76	http://www.vhpbcqq.org/LPxulGw	{Flour,Chicken}	5
3946	2425	239	Chicken Pot Pie	6.15	http://fmogonm.info/jsIovcE.html	{Pineapple,"Cottage Cheese",Cucumber}	3
3991	4932	240	Bacon Cheese Burger	7.33	http://kbuvopx.com/qnWkAYk	{Bacon,"Bavarian sausages",Mayo,Potatoes,Carrots}	1
3895	5302	239	Tortellini Bowls	7.83	http://tpnllel.top/	{Flour}	2
3896	2449	239	Wallmart	6.01	https://www.mgmofeq.info/gsaElWj	{"Unagi sauce","Cream cheese",Cheese,Sugar}	4
4084	7640	242	Sweet Potato Pie	2.02	http://www.pacirda.info/TlWWeEA	{Chicken,Butter,"Japanese tamago",Peperoni,Pasta}	2
4130	8905	243	Angel Food Cake	4.43	https://cbbqvwq.info/NeLpVeI.jpg	{Pineapple}	4
4131	2837	243	Pizza Florida	7.99	http://eolwsjl.top/ARFDlZT.css	{Basil,Mushrooms,Milk}	5
4178	448	244	Swedish Meatballs	3.35	https://dcverqh.edu/	{"Cheese cheddar",Garlic}	3
4179	9939	244	New York Style Cheesecake	3.29	https://gptfcso.ru/IiOyjId.webp	{Bacon,Pasta,Pineapple}	2
4188	3310	244	Swedish Meatballs	2.54	https://cimwiep.org/MoxMStB.svg	{Cheese}	5
4223	5335	244	Chicken Pot Pie	5.10	https://itqpjlz.ru/cPcwsvr.html	{"Original sauce"}	3
4269	9674	246	Crispy Chicken burger	5.48	http://jvltgdn.com/	{Flour,Basil,"BBQ sauce",Bacon}	2
4270	9494	246	Pizza Italiano	2.74	http://xupddhx.edu/IMuPkSP.jpg	{Peanuts,Mushrooms,"Cheese cheddar",Strawberry,"Bavarian sausages"}	3
4315	9071	248	Pizza Florida	3.72	http://www.abeoure.ru/	{"Cottage Cheese",Flour,Pineapple,Cheese,Onion}	4
4316	3027	248	Philadelphia with salmon	7.49	http://crosoqk.top/OYkoUXW.js	{Onion,Salmon}	4
4360	4914	249	Himawari	4.03	https://www.jeafsjr.net/	{Cheese,Butter,Chicken,Corn,Mozarella}	2
4361	3503	249	Pizza Hawaiian	4.85	https://atgytbt.ru/ylOPOcU.js	{"Cheese cheddar"}	1
4253	426	244	Sweet Potato Pie	7.40	https://ftdpdtj.ru/	{Rice}	3
4254	601	244	Pizza Florida	7.71	https://vqxcmjm.net/jaIZKud.php	{Onion,Butter,"Unagi sauce",Grapes,Flour,Peanuts}	2
4452	4293	252	Pizza Texas	3.64	https://dynsyot.top/JLysTWH	{"Caramelized onions","Cream cheese",Chicken}	3
4499	7047	253	Chicken Pot Pie	2.07	http://www.vrygggs.info/jxWcSLv	{Grapes}	4
4500	7212	253	Unagi Philadelphia	3.31	http://pgdkpub.info/xLAgpVh.php	{Meat,Peanuts}	2
4545	5508	254	Pizza Texas	7.64	http://ddxhaqj.edu/bTGyqCM.webp	{Cucumber,Potatoes,Meat,Butter,Sugar}	4
4591	5419	254	Tortellini Bowls	4.81	https://www.rxcvghp.org/cBiLgTA	{"Original sauce",Strawberry,Salmon,Chicken,Cucumber}	4
4638	2130	255	Pizza Italiano	6.54	http://xulciot.com/YZsCwTS	{Nori,"Onion rings",Grapes,Mayo}	4
4639	6882	255	Unwrapped Burrito Bowl	5.04	http://hbgrhum.org/QxWvvcW.jpg	{Peanuts,Salmon,Milk,Peanuts}	3
4684	5640	255	Wallmart	3.56	http://mqvmksb.biz/eNkRqfH.js	{"Cream cheese",Tomatoes,"Caramelized onions",Grapes,"Japanese tamago"}	4
4730	6169	256	Crispy Chicken burger	3.16	http://ecvpszq.org/	{"Bavarian sausages",Onion}	2
4731	9386	256	Chicken Pot Pie	2.22	https://pkbcdrr.org/pTgJgxo.css	{Flour,Flour,"Cottage Cheese",Peperoni}	3
4777	3234	256	Saint Frank Coffee	5.31	http://cnhlavn.com/	{Pineapple,Grapes,Cucumber,"Unagi sauce",Bacon,"Caramelized onions"}	3
4825	4655	257	Grape Jelly Sandwich	2.70	http://wboanuq.edu/UXacNxq.svg	{Cucumber}	2
4826	1771	257	Angel Food Cake	4.77	http://www.jddgyjh.top/PVHHnHO	{Nori}	3
4835	8740	257	Pizza Texas	7.66	http://qrmbjwm.info/FgegvRs	{Bacon}	3
4872	2605	258	Sweet Potato Pie	7.81	http://fipytwg.biz/ChFEsqh.css	{Potatoes}	4
4873	7748	258	Pizza Florida	4.97	http://www.ablvelj.edu/	{Garlic,Mushrooms,"Cheese cheddar",Strawberry,Rice,Pasta}	2
4919	1663	258	Unwrapped Burrito Bowl	3.22	http://yeybijo.info/jLwkiYy.php	{"Caramelized onions"}	1
4920	2505	258	Pizza Italiano	5.30	https://fxlgkxa.top/xwDacGs.php	{Peperoni,"Cottage Cheese","Original sauce",Salmon,Mayo}	2
4966	2690	259	Unagi Philadelphia	7.40	https://qehvvwt.edu/	{Tomatoes,Meat}	2
4967	8559	259	Wallmart	6.74	https://rfiahuf.top/kJXNBtF.js	{Sugar,Sugar,Flour}	3
5012	9524	259	Swedish Meatballs	5.42	https://spcuqth.top/etXocbt.css	{Pineapple,Grapes,"Chili Pepper"}	2
5057	2485	260	New York Style Cheesecake	6.64	https://www.oazsere.ru/	{Potatoes,Sugar,"BBQ sauce"}	4
5058	8163	260	Saint Frank Coffee	7.83	https://fjubhin.com/EXlUjpL.js	{Sugar}	4
4255	4334	245	Pizza Florida	4.33	http://ywzcdjo.net/	{Peperoni,Mayo}	3
4406	8149	249	Philadelphia with salmon	5.66	http://jiaammj.net/MTOHFcE.svg	{Cucumber,Potatoes,Rice}	4
4610	2995	254	Pizza	4.78	http://xckvubx.edu/DNCIhEN.html	{Garlic}	3
4611	5082	254	Pizza Pepperoni with tomatoes	4.73	http://meyjxqd.org/nWiMUEA.php	{Bacon,Carrots}	3
5199	6579	262	Himawari	2.97	http://zhcvdsi.org/vBNKnoA.js	{Onion}	2
5247	6157	262	Wallmart	5.95	https://wknvvps.edu/atooRrP.css	{Mushrooms,Pasta,"Cheese cheddar",Peanuts,Grapes,Peas}	3
5248	4295	262	Swedish Meatballs	2.36	https://wllmqmx.edu/aDFqYgO.jpg	{Mayo,"Bavarian sausages","Unagi sauce","Cottage Cheese"}	3
5018	6361	259	Pizza Texas	6.34	http://www.zqldxjf.top/	{Mushrooms}	3
5066	6351	260	Bacon Cheese Burger	2.95	http://irfeklb.ru/DAHKmAs.php	{Strawberry,"Original sauce"}	1
5340	7580	264	Pizza Italiano	4.52	https://rxjepgb.com/bDMjOVh.html	{Nori,Cheese,Basil}	2
5341	5700	264	New York Style Cheesecake	2.94	http://lwivunl.ru/fQsAwDp.js	{Cucumber,Carrots}	5
5387	9185	237	Sweet Potato Pie	5.37	https://hcsmmba.biz/vydjlxv.webp	{"Chili Pepper",Milk,Mushrooms}	5
5369	9730	264	Pizza Texas	5.56	https://yobfndy.info/	{Potatoes}	3
5406	3428	237	Bacon Cheese Burger	4.76	http://oemtuhv.top/xJeUaFR.js	{Flour}	1
301	2975	211	Bean Green Chili Burritos	3.36	https://vbjmmwb.net/ObQUpuX.webp	{Flour,Mozarella,Grapes,Grapes,"Chili Pepper",Mozarella}	5
1307	6628	230	New York Style Cheesecake	2.33	http://hjnuxoe.com/tUvbIiU.html	{Milk,"Cream cheese",Peanuts,"Unagi sauce",Cucumber}	3
1406	3373	232	Tortellini Bowls	4.44	http://pwuslcf.biz/cGceMVN.html	{Peanuts}	5
1543	3824	235	Wallmart	2.66	https://bxxdygn.org/SwhPgix.svg	{Potatoes,Onion,Tomatoes,Basil}	3
2236	4963	157	Bacon Cheese Burger	5.11	http://fzjnfrj.com/DNMLQQG.svg	{"Original sauce",Grapes,Cheese,"Cottage Cheese",Peanuts,Flour}	3
330	9416	211	Philadelphia with salmon	4.32	http://jmxbhnu.edu/qGxaweX.svg	{Rice,"Bavarian sausages"}	1
379	6810	213	Pizza Hawaiian	7.10	https://pstpjfu.info/qeBfYQh.svg	{Mayo,"Japanese tamago",Mayo,"Onion rings",Chicken}	1
4092	122	242	Chicken Pot Pie	5.66	http://jrjqqsi.org/BpbtkcR.jpg	{Salmon,Bacon,"Cottage Cheese",Peanuts,Sugar,"Cream cheese"}	4
380	8925	213	Tortellini Bowls	6.23	http://jtisnrm.edu/HdgBOwx.php	{Pineapple,Nori,Mayo}	5
381	9296	213	Unagi Philadelphia	3.32	https://www.fojodbt.org/	{Mushrooms}	2
384	1955	213	Bean Green Chili Burritos	2.90	https://aolmbqu.top/xbddfOj.webp	{"Chili Pepper",Garlic}	2
382	9269	213	Angel Food Cake	6.47	https://www.uckvsrs.top/	{Onion,"Onion rings",Peperoni,"Bavarian sausages"}	3
231	3471	210	Pizza Florida	5.09	http://upgiqsr.biz/ixAUZlA.php	{Basil,Flour,Cucumber,Flour,Flour}	2
225	4527	210	Sweet Potato Pie	2.63	http://jxvicua.net/	{Mozarella,Salmon}	2
243	1428	210	Unagi Philadelphia	5.97	http://cyebjqr.ru/pCbmLKh.svg	{Mozarella,"Bavarian sausages","Onion rings"}	4
205	5913	209	Peanut Butter	3.61	https://wrsbdqy.info/jyfJbtJ.html	{Meat,Corn,Tomatoes,Mozarella,Carrots,Rice}	4
228	3111	210	Peanut Butter	3.59	http://kkwkxhs.org/rKXWFtQ.webp	{Peperoni,"Cheese cheddar",Peperoni,Mushrooms,Mayo}	4
222	6614	210	Pizza Ocean	3.86	http://pilguhu.net/	{"Original sauce","Cottage Cheese","Onion rings","BBQ sauce",Peanuts,"Onion rings"}	5
208	9577	209	Chicken Pot Pie	3.31	https://fqweprq.top/KifGGOK.php	{Basil,Chicken,"Japanese tamago",Mayo,"Cream cheese",Mushrooms}	1
246	158	210	Pizza Texas	2.19	http://vyruqot.ru/xBAJHyk.svg	{Meat,Pasta,"Unagi sauce","Cheese cheddar",Flour,Corn}	5
5091	7446	261	Sweet Potato Pie	2.03	http://zqqlerw.org/hDgcMUG.js	{"Onion rings","Original sauce",Tomatoes,"Cream cheese",Tomatoes,Milk}	1
216	2431	209	New York Style Cheesecake	7.86	http://www.kyjzfve.biz/	{Mushrooms,"Unagi sauce",Sugar,Chicken,Garlic,"Onion rings"}	3
247	5815	210	Tortellini Bowls	3.53	http://vqsygit.com/JapZdPE	{Mushrooms,Peas,Pineapple,Corn}	2
206	4011	209	Wallmart	7.98	http://www.bkymtft.net/AZjBIJk	{"Japanese tamago",Mozarella,Mushrooms,Grapes}	5
207	6997	209	Chicken Pot Pie	2.87	http://shkivee.edu/YXtnRUG.css	{Bacon,Pineapple,"Cottage Cheese",Potatoes}	5
217	4353	209	Original burger	3.10	http://evtfpbn.com/kVRpTBp.jpg	{Peas,Sugar,Chicken}	2
229	102	210	Bacon Cheese Burger	3.21	https://amvbicc.top/XqvIPmo.css	{"Onion rings"}	3
232	589	210	Wallmart	7.03	http://hlmkmda.net/regGBCi.php	{Pasta,Strawberry,Tomatoes,Sugar}	4
219	9396	209	Pizza Italiano	4.26	http://pvgdxmo.org/BQXuEBh.svg	{"BBQ sauce","Cream cheese",Meat,Bacon}	2
212	7498	209	Philadelphia with salmon	6.46	http://ugngnlb.edu/UeMRrMC	{Strawberry}	3
4886	6644	258	Crispy Chicken burger	5.35	http://www.tnbblex.net/IHcCaBO	{Mushrooms,Strawberry,Mushrooms,"Cheese cheddar",Milk}	2
242	9270	210	Pizza Pepperoni with tomatoes	7.75	http://yxylgfw.biz/rbgehbm	{Pineapple,Mayo,"Cream cheese","Cream cheese",Strawberry,Flour}	1
244	7725	210	Sweet Potato Pie	6.86	http://flffffc.top/suNWZYU.html	{Sugar,"Japanese tamago",Flour,Milk}	2
218	882	209	Saint Frank Coffee	7.21	http://asqmqol.top/qnoMAYd.js	{Milk,Garlic,Rice,Mozarella,"Cream cheese",Grapes}	4
383	4265	213	Bacon Cheese Burger	2.82	https://www.eiqwbgy.info/HWWATuR	{Peanuts,Carrots}	3
220	5164	209	Saint Frank Coffee	2.13	http://gflftlp.biz/nTxtemb	{Salmon,"Unagi sauce",Tomatoes,Bacon,Strawberry}	1
221	7598	209	New York Style Cheesecake	6.90	http://wnogmwc.info/EIYtEiC	{Corn,Nori,Butter,Meat,Mushrooms,Meat}	2
223	8161	210	Pizza Hawaiian	6.12	http://yyuvnlx.edu/vJhOUGf	{Milk,Peanuts,Sugar,Flour,Carrots,Garlic}	5
213	9806	209	Pizza	2.36	https://nkxcdvx.net/XWVUdgS.css	{Peas}	2
226	723	210	Tortellini Bowls	6.12	http://zntofyj.biz/ZRAcEFY.html	{Strawberry,"Chili Pepper",Nori,Mozarella,Cucumber}	2
227	6968	210	Swedish Meatballs	6.04	https://www.pnnmaem.net/	{"Cream cheese",Cheese,Mushrooms,Flour}	2
245	1439	210	Bean Green Chili Burritos	3.55	http://badyyvu.ru/ChRSHeX	{Grapes,"Cottage Cheese"}	5
204	6963	209	New York Style Cheesecake	7.15	https://fvwziqv.com/LDjmLIp.js	{Mayo}	5
209	5906	209	Pizza Italiano	6.70	https://afpnukr.info/NAssMmv.webp	{Salmon}	3
224	3881	210	Angel Food Cake	5.13	https://uicugfs.info/vweWhoU.jpg	{Mayo,"Chili Pepper"}	5
230	6847	210	Pizza Hawaiian	6.72	https://abfpdky.ru/tsKCiYC.js	{Pineapple}	1
210	8921	209	Tortellini Bowls	7.46	https://cdwmawr.com/	{Pasta,Garlic,Onion,"Japanese tamago","Onion rings",Peas}	1
214	2591	209	Pizza Hawaiian	7.44	http://www.emxnxnf.net/	{"Bavarian sausages",Bacon,Peas}	3
215	3595	209	Pizza Hawaiian	7.79	http://sjtqcgp.info/axGNTqT.html	{"Unagi sauce"}	5
291	320	211	Bacon Cheese Burger	5.93	https://www.nuvqmis.top/DUdEhrj	{Pasta,"Bavarian sausages","Onion rings"}	2
292	6589	211	Swedish Meatballs	3.61	https://pgvepux.ru/buWxTLY.svg	{Strawberry,Peanuts}	5
235	3689	210	Grape Jelly Sandwich	3.66	http://juxdwus.org/tapCYHd.php	{Chicken,Meat,Carrots,"Onion rings"}	4
236	7726	210	Angel Food Cake	4.21	https://whxjouu.edu/HtTpMkd.jpg	{"Unagi sauce","Unagi sauce",Garlic}	4
237	2251	210	Tortellini Bowls	2.53	http://tneygot.top/ItTFbJw.php	{Grapes,"Original sauce"}	3
238	570	210	Swedish Meatballs	2.63	http://qvmdapf.biz/dtMrbFI	{Peperoni,Flour,"Chili Pepper","Original sauce","Bavarian sausages",Grapes}	4
239	8176	210	New York Style Cheesecake	7.28	https://bqbdzwh.net/	{"BBQ sauce",Chicken,Sugar,Sugar}	5
240	4740	210	Swedish Meatballs	6.90	https://kcdrvsb.biz/XyDcVJE	{Flour,Chicken,Mayo}	1
249	26	210	Chicken Pot Pie	7.79	http://bgurfau.ru/PBGtpHy.jpg	{Cucumber,Butter,Cucumber}	4
250	7847	210	Pizza Hawaiian	2.04	http://ssaugma.com/	{"Original sauce","Cottage Cheese",Bacon,"Japanese tamago",Tomatoes}	5
251	6872	210	Tortellini Bowls	2.08	https://dbddkgx.com/	{"Bavarian sausages",Bacon,"Bavarian sausages",Peperoni,"Original sauce",Milk}	4
252	7501	210	Unagi Philadelphia	2.24	https://www.initbyr.ru/xeQUjQO	{"Caramelized onions","Cheese cheddar",Nori,"Caramelized onions",Carrots}	2
253	2312	210	Pizza Florida	2.21	https://tnowvga.net/oOQOPRv.jpg	{Flour,Cucumber,Chicken}	1
254	8742	210	Grape Jelly Sandwich	7.24	http://byyvcpj.biz/cSlSkdi.php	{Mozarella,Peperoni,Garlic,Mozarella}	1
255	7314	210	Original burger	6.07	https://mnxgrvy.ru/	{Mozarella,"Bavarian sausages",Sugar,Salmon,Mushrooms}	2
256	9329	210	Bean Green Chili Burritos	4.45	http://ljkirvw.biz/xFfdLMr	{Bacon,Rice,Milk,Mushrooms,"Cottage Cheese"}	1
257	558	210	Grape Jelly Sandwich	5.31	http://cuxnvbe.com/LNvAFpl.html	{Mozarella,Flour,"Onion rings",Mushrooms,Grapes,Basil}	2
267	1207	210	Sweet Potato Pie	6.53	https://bapsleh.biz/HISMxMQ.svg	{Flour,Mushrooms,Potatoes,Peas}	4
259	4949	210	Grape Jelly Sandwich	3.72	https://aiaahfb.com/	{Pineapple}	3
260	4847	210	Original burger	2.81	http://www.lznrscq.edu/	{"Bavarian sausages","Cheese cheddar",Pineapple,Butter}	3
261	9884	210	Pizza Italiano	3.15	https://ifqyxbu.top/CqlBgkB.js	{"Original sauce","Chili Pepper",Tomatoes,"Original sauce",Mayo,Rice}	5
262	2021	210	Saint Frank Coffee	3.20	http://cjjngmb.org/	{Grapes,Chicken,"Caramelized onions","Original sauce",Flour,"BBQ sauce"}	4
263	3155	210	Pizza Hawaiian	5.67	https://www.trynnxq.com/WjlqLZd	{Mushrooms}	1
264	8832	210	Unagi Philadelphia	4.89	https://www.yebjirm.com/ScBcfDm	{Corn,"Original sauce","Original sauce",Peperoni}	1
265	4861	210	Pizza Ocean	2.07	https://qkghpyt.com/HkXRmdf.webp	{"BBQ sauce",Bacon,Mozarella,Chicken}	2
258	3009	210	Unwrapped Burrito Bowl	4.69	http://scadvoa.com/LnZNKRw.js	{"Unagi sauce","Unagi sauce"}	4
266	692	210	Original burger	6.98	https://zbhykxf.com/wgvdRte.svg	{Strawberry,Nori,Butter,"Unagi sauce",Chicken}	2
268	8212	210	Bean Green Chili Burritos	2.63	http://haskxvh.info/KyVNmyX.php	{"Caramelized onions",Mushrooms}	4
269	5739	210	Saint Frank Coffee	5.71	https://vamjmjm.top/MhmaDWY.webp	{Mushrooms,Garlic}	5
270	4069	210	Himawari	5.09	http://plopixa.edu/MaDKFNp.webp	{Cheese,Corn}	3
271	5689	210	Unagi Philadelphia	4.44	https://www.vfjvgxm.com/	{"Cheese cheddar","Unagi sauce",Nori}	5
272	754	210	Pizza Texas	4.91	http://ynneptj.com/JyYCicy.webp	{Tomatoes,Peperoni}	3
274	9089	210	Unagi Philadelphia	6.22	http://tpcslnp.org/HrdUHkr.jpg	{Butter,Butter,Mozarella}	4
275	4204	210	Crispy Chicken burger	4.56	https://pcuzbaq.edu/NeaYCok.php	{Peperoni,"Cottage Cheese",Mushrooms}	1
276	3668	210	Bacon Cheese Burger	6.39	https://ykyjnpg.ru/gHSsIYD.html	{Grapes,Cheese,Salmon,Basil}	3
277	1612	211	Pizza Pepperoni with tomatoes	6.96	https://yhhlwpw.info/TgLcWVS.svg	{Mushrooms,Tomatoes,Flour}	1
278	4706	211	Bean Green Chili Burritos	7.83	https://dqavaft.net/xXHvaGn	{Potatoes,"Onion rings","Chili Pepper","Cream cheese",Grapes,Flour}	4
279	5477	211	Swedish Meatballs	6.51	https://fzkwnjj.top/jYFJwyd.svg	{Mushrooms}	2
280	2890	211	Tortellini Bowls	6.76	https://iakyhty.biz/EyqHriD.webp	{"Caramelized onions",Flour,"Unagi sauce",Garlic}	4
289	9971	211	Philadelphia with salmon	2.22	http://www.dfqfkbp.net/	{Salmon,Mayo,"BBQ sauce",Nori,Cheese,Tomatoes}	2
290	9520	211	Pizza Florida	7.16	http://sqqujvj.net/wADLnME.html	{Flour,Mayo}	4
234	9252	210	Bean Green Chili Burritos	5.08	https://logzyru.info/ihvnThl.js	{Mushrooms,Basil,"Unagi sauce",Meat,Strawberry,Grapes}	5
324	2278	211	Pizza Ocean	7.79	https://www.mifwqgs.top/	{"Chili Pepper",Peas}	4
313	4696	211	Tortellini Bowls	6.14	http://pvtekjo.biz/unLicMH.svg	{Carrots,Strawberry,Bacon,"Japanese tamago",Onion,"Original sauce"}	1
325	7049	211	Philadelphia with salmon	6.57	https://keiktkb.info/TlJOYvt.html	{Pineapple,Cucumber,Mozarella,Milk}	1
329	2338	211	Pizza Texas	3.09	http://ljtjxkv.ru/VjudiYL.js	{Cheese,Peas,Carrots}	4
332	6840	211	Pizza Pepperoni with tomatoes	7.41	https://www.dzjvhzv.top/	{Cucumber,Mushrooms}	1
333	7948	211	Bacon Cheese Burger	3.06	http://www.wkqqlkb.com/avsMULq	{Tomatoes,Corn,Mushrooms}	3
334	9625	211	New York Style Cheesecake	7.08	https://qdxbqtw.org/VupwhQB.html	{Flour}	5
336	194	211	Peanut Butter	3.59	http://rhrrweq.net/GOHfECl	{"Caramelized onions",Bacon,"Cottage Cheese"}	4
337	8323	211	Pizza	2.36	http://sykhvdn.com/rsuRiDH.svg	{Meat,"BBQ sauce",Grapes,Cucumber,Rice}	1
338	7546	211	Angel Food Cake	3.82	https://mvotdvy.org/EmAHjKh.svg	{Grapes,Peas,"Bavarian sausages",Mayo,Onion}	5
339	89	211	Pizza Texas	6.92	http://immnnba.top/XFQWwHS.svg	{Corn,"Onion rings"}	2
282	8522	211	Unagi Philadelphia	7.36	https://www.gsycfgi.edu/nYAOpDX	{Chicken,Mushrooms}	3
283	131	211	Grape Jelly Sandwich	6.96	https://lvewljq.org/MsBUklZ.html	{Corn,Onion,Grapes}	2
284	5948	211	Pizza Ocean	4.15	http://grdgesw.info/	{"Unagi sauce",Carrots}	3
285	8843	211	Original burger	3.85	https://www.lhqaneb.top/	{"Unagi sauce",Onion,"Original sauce"}	3
294	7383	211	Angel Food Cake	4.14	http://mqculyc.net/xkSllLB	{Bacon,Potatoes,Pineapple,Pineapple,Onion,Garlic}	3
295	3524	211	Pizza Ocean	4.01	https://tlkwpew.net/	{Carrots,Cucumber,"Cottage Cheese",Bacon,Chicken}	5
296	6233	211	Pizza Texas	6.57	http://mhxmjrb.com/HUxYWnT.html	{Meat}	4
297	9457	211	New York Style Cheesecake	3.34	http://vghnrhm.com/DliiSnd.svg	{Mayo}	5
298	9051	211	Bean Green Chili Burritos	2.29	http://jvyvkiv.net/REEIeoI.webp	{Mozarella,"Original sauce","Original sauce"}	2
299	5397	211	Angel Food Cake	4.29	http://vamnoua.biz/HuHYnBY.js	{"Original sauce"}	2
300	1277	211	Pizza	4.47	https://gfvkkkv.biz/ePdyEUV.webp	{Potatoes,Tomatoes}	4
303	2944	211	Himawari	2.29	https://ovmypdc.top/yrCBiaA.webp	{Potatoes}	3
304	5568	211	Bean Green Chili Burritos	5.69	http://tnrwhtb.ru/QMABnbM.webp	{Pineapple,Mushrooms,Flour}	3
305	4304	211	Bean Green Chili Burritos	7.50	http://ovshngz.biz/mOimRqT.js	{"Unagi sauce",Mozarella,Grapes}	2
306	7284	211	Pizza Texas	4.31	http://gtxuldc.com/FyMlBBc	{Strawberry,"BBQ sauce","Japanese tamago"}	3
307	4389	211	Angel Food Cake	5.53	https://uyecifd.info/wpuaqkI.jpg	{Grapes,Cheese,Sugar,Cheese,Pineapple,Corn}	2
308	9211	211	New York Style Cheesecake	7.86	http://www.toxpczs.net/AnQvRcv	{Flour,Peas,Pasta,"Onion rings",Bacon,Mayo}	3
309	6553	211	Chicken Pot Pie	4.38	https://cdkimpb.ru/FbgPlOY.css	{Peperoni,Mushrooms}	5
310	3438	211	Pizza	2.91	https://www.qkvdpym.ru/KZFOBYl	{Peanuts,"Bavarian sausages","Unagi sauce","Caramelized onions",Butter}	3
311	5318	211	Pizza Ocean	2.53	https://ozbxlij.biz/gyyfsuU	{"Original sauce",Salmon,Chicken}	5
312	428	211	Bacon Cheese Burger	8.00	http://izhupcr.com/	{Pasta,Peperoni,Grapes,Pasta,Cheese}	1
314	524	211	Pizza Hawaiian	2.58	http://ffmzpfi.info/XlTFsfT.js	{Peanuts,Chicken,"BBQ sauce",Flour,Mushrooms}	5
315	2354	211	Bacon Cheese Burger	6.32	https://akaspot.org/iCNmjle.css	{Milk,"Original sauce",Corn}	1
316	1286	211	Bacon Cheese Burger	7.56	https://www.uaklutb.edu/	{Peas,"Cottage Cheese",Peanuts,"Bavarian sausages"}	3
317	5790	211	Himawari	4.03	https://lhydily.org/AWPQoIK.html	{"Caramelized onions","Caramelized onions"}	3
318	6587	211	Sweet Potato Pie	2.62	https://ujwhdlf.com/IGvNkXk.webp	{Rice,Rice,Milk}	4
319	5131	211	Bean Green Chili Burritos	5.10	http://tggqyxf.biz/	{"Cottage Cheese",Mushrooms,Pasta}	2
320	4520	211	Himawari	6.22	http://uompydi.com/CHrCPMn	{"Cream cheese",Butter,Flour,"Original sauce"}	1
321	8235	211	Himawari	2.60	https://uccyvfz.info/AluXKrE.jpg	{Cheese,Chicken}	4
322	2714	211	Himawari	4.75	http://xnpjsll.org/IupoLZE.webp	{"Japanese tamago",Mushrooms}	4
323	2534	211	Saint Frank Coffee	5.82	https://www.qflowcp.net/CpxGceF	{Mushrooms,Mushrooms}	1
326	1811	211	Bacon Cheese Burger	2.74	https://zkavjpk.biz/YfRmvPI.php	{Flour,Cucumber,Cheese,Salmon,Bacon}	2
327	5870	211	Swedish Meatballs	6.28	https://mydmdta.org/VgdACxE.jpg	{"BBQ sauce",Bacon,Butter,Corn}	3
343	3475	211	Angel Food Cake	6.59	https://weevptn.edu/pmKQfTU	{"Japanese tamago"}	2
374	3346	212	Philadelphia with salmon	2.18	https://knbgviv.org/SdOLRIy.js	{"Cottage Cheese","Japanese tamago","Cottage Cheese","Caramelized onions"}	1
361	3417	211	Swedish Meatballs	2.71	https://www.jwzmbms.ru/jFjuagc	{Pasta,Tomatoes,"Caramelized onions","Japanese tamago",Mayo,Mayo}	1
350	958	211	Pizza Florida	5.54	https://nmubcmw.ru/kyowENJ.js	{"Japanese tamago","Cheese cheddar"}	4
363	3602	211	Peanut Butter	6.12	https://rvqaxyi.edu/cUFsqxH	{Mushrooms,Mayo,"Cheese cheddar",Cheese,Cheese,Basil}	2
356	7946	211	Chicken Pot Pie	6.01	https://bfnfwft.top/SMdqqlH.css	{Mushrooms,Peperoni,"Cream cheese",Garlic,Peperoni}	4
358	5051	211	Pizza Ocean	2.86	http://bzhsnin.info/IQFXvuj.php	{"Cheese cheddar",Basil,"BBQ sauce"}	1
362	9414	211	Pizza Texas	3.79	http://rqntzot.org/pEIRikD.html	{Mushrooms,Onion,Meat,Flour,Peperoni}	5
352	5575	211	Peanut Butter	6.67	https://ftzfkcu.com/OcccEXI.html	{"Japanese tamago",Onion,Sugar,"Original sauce",Chicken,Flour}	1
365	5550	212	Chicken Pot Pie	3.99	https://chgsiqj.org/fDUBARs.js	{"Cottage Cheese",Potatoes,Mozarella,"Caramelized onions"}	3
389	1404	213	Bean Green Chili Burritos	7.07	http://bsureuh.top/pESODaQ.php	{"Cheese cheddar",Cucumber,Garlic}	4
376	8325	213	Bean Green Chili Burritos	3.39	http://fhmubwo.net/YDvnxGK.js	{Garlic,"Cream cheese",Meat,Pineapple,Rice}	3
372	8555	212	Pizza Hawaiian	5.95	https://rzoqacs.com/SWVldpV.svg	{Corn,"Onion rings","BBQ sauce",Corn}	1
353	2098	211	Tortellini Bowls	2.12	http://qyhqhgf.net/YVHKGYR.jpg	{Peas}	2
430	6569	213	Tortellini Bowls	4.10	http://zzljxph.com/vVlTfKk.js	{Potatoes,Potatoes,"Original sauce",Rice,"Onion rings"}	3
391	9536	213	Pizza	5.87	http://zxqqofx.info/rVZUaoR.html	{Cucumber,"Caramelized onions",Mozarella}	5
344	7753	211	Crispy Chicken burger	5.92	http://nhwechm.ru/wpAKMCC.css	{Mozarella}	3
428	2444	213	New York Style Cheesecake	7.88	http://kljdjul.net/sYdykDp	{"Cream cheese"}	2
354	5292	211	Wallmart	6.82	http://bypkamx.top/MOycRmc.js	{Grapes,Mushrooms}	2
357	1486	211	Grape Jelly Sandwich	2.79	http://www.humcxvp.net/	{Mushrooms}	3
373	9631	212	Tortellini Bowls	4.50	https://www.qiuvpsy.net/SJBnWMD	{"BBQ sauce",Potatoes}	1
385	4667	213	Angel Food Cake	6.56	https://amtojdt.biz/JSguGss.webp	{Mushrooms,Corn,Strawberry,Strawberry,Butter}	2
390	3258	213	Original burger	7.39	https://www.raybjwo.org/PPJhZmE	{Grapes}	3
364	1966	211	Pizza Ocean	5.13	http://cmhjdun.com/yfWImGI.js	{Peanuts,"Onion rings","Cottage Cheese"}	3
355	3769	211	Chicken Pot Pie	2.65	http://cmjuume.top/BlCiSgh.webp	{"Caramelized onions",Flour,Potatoes}	3
426	4878	213	Pizza Pepperoni with tomatoes	3.32	http://uimmxwj.org/Vpgdnqv.webp	{Mushrooms,Salmon,Strawberry,Peanuts,Mozarella,Basil}	4
377	6220	213	Saint Frank Coffee	3.36	https://ryiwuxd.edu/yyjHxom.svg	{"BBQ sauce",Mushrooms,Cucumber}	4
371	8629	212	Pizza Ocean	3.10	https://mhtsqls.org/OtpiOwM	{"BBQ sauce","Onion rings",Peperoni,"Onion rings",Milk}	3
387	3890	213	Crispy Chicken burger	2.93	http://vwvltgh.com/VMtrKSf.js	{Flour}	3
347	729	211	New York Style Cheesecake	3.75	https://fvvobgb.top/MgHfciW.js	{Mozarella,"Unagi sauce",Salmon}	4
351	5246	211	Tortellini Bowls	5.19	https://xodlsdz.ru/CTdTink.js	{Corn,"Caramelized onions",Peanuts}	1
476	7427	214	Pizza Texas	7.43	http://xcbaumc.org/XHNNgMk	{Strawberry}	1
375	2698	212	Pizza Florida	4.98	https://fpspwnw.info/ttvHpWS.svg	{Chicken,Mushrooms,Mushrooms,Onion}	2
429	8005	213	Grape Jelly Sandwich	3.79	http://hlpisit.ru/iBFOuOV	{"Cheese cheddar",Mozarella,Grapes,Tomatoes}	4
346	4467	211	New York Style Cheesecake	7.47	https://ruiyvmf.info/	{Cheese,Cheese,"Cottage Cheese",Cucumber,"BBQ sauce"}	1
348	7014	211	Wallmart	7.46	http://www.wrnkvbh.edu/	{Butter,"Original sauce","Cheese cheddar",Corn,"Bavarian sausages",Corn}	4
359	2193	211	Crispy Chicken burger	4.47	http://fprneuj.net/AwuUGgI.html	{Cheese}	5
360	8626	211	Sweet Potato Pie	5.17	https://buvreld.org/eDiKVZh.jpg	{Carrots,Peas,Basil,Mushrooms,Peanuts,"Original sauce"}	3
393	9799	213	Saint Frank Coffee	6.93	http://efoofrv.ru/UnHGsWq.jpg	{"Cheese cheddar",Meat}	3
435	1165	213	Angel Food Cake	6.14	http://eoedjct.net/SpexYLb.js	{Onion,Peanuts,Rice,Potatoes,"Bavarian sausages"}	4
406	2749	213	Chicken Pot Pie	3.04	http://fdfofxz.edu/qHQHVbL.css	{Carrots}	3
394	4595	213	Pizza Texas	4.69	http://jepgzif.net/XvyqKuX	{"Bavarian sausages",Potatoes,Tomatoes}	4
399	2897	213	Original burger	4.99	https://fkejuua.com/uCxKIhB.js	{Milk,"Cheese cheddar",Flour,Mushrooms}	5
400	8616	213	Swedish Meatballs	7.42	https://lortdiw.com/ludewBW.webp	{Meat,"Japanese tamago"}	1
475	2111	214	Tortellini Bowls	5.84	https://oivixja.ru/FuEXhuD.js	{Peas,Peperoni,Meat,Nori}	5
403	8095	213	Pizza Ocean	2.00	http://xkkkput.biz/mFvWfjt	{Sugar,Grapes,"Cottage Cheese","Caramelized onions"}	3
404	8453	213	Grape Jelly Sandwich	5.75	http://www.nezunjn.org/tsMWSTZ	{Garlic,Rice,"Cream cheese","Cottage Cheese",Garlic,Grapes}	5
405	8900	213	Tortellini Bowls	7.64	http://xhbliph.biz/uPBIkZG.js	{Cucumber,Corn}	2
407	3629	213	New York Style Cheesecake	5.15	http://mwbjplz.ru/FYufrBa.php	{"Caramelized onions",Cucumber,"Japanese tamago","Unagi sauce","Cottage Cheese"}	4
398	3863	213	Himawari	4.45	https://mvnyfvf.info/	{Mushrooms,Mozarella,Onion}	5
408	4001	213	Unagi Philadelphia	2.45	http://www.llizrld.top/UlPcdGy	{Cheese,Rice,Grapes,Cucumber,"Onion rings",Pineapple}	2
409	6646	213	Angel Food Cake	5.65	http://zyjngtn.org/NTqMkpk.php	{Carrots,Mayo,Flour,Peperoni}	1
410	1142	213	Pizza Florida	6.85	https://bfjwuij.net/MQRIrhS.jpg	{Potatoes,Peas,Grapes,"Onion rings","Cream cheese"}	5
411	8150	213	Bean Green Chili Burritos	6.06	http://lbrmftz.com/mXsLVBW.php	{Salmon,Sugar,Milk}	5
412	5799	213	Pizza Florida	8.00	http://www.mnbteqe.edu/biBOOLL	{Peas,Butter}	2
413	7249	213	Sweet Potato Pie	5.04	https://wwddict.info/	{Chicken,Peanuts,"Cheese cheddar",Peperoni}	2
414	1333	213	Chicken Pot Pie	3.71	https://sbgclst.ru/BjpCwJJ.js	{Chicken,Salmon,Strawberry}	5
421	1906	213	Sweet Potato Pie	6.63	http://mrfuqmw.ru/NMrugjG.php	{Nori,Garlic,Flour}	4
423	9959	213	Pizza Hawaiian	5.41	https://fsolkam.biz/IcAKdSF.svg	{Cucumber,Bacon,Onion,Butter,Cheese,"Bavarian sausages"}	1
416	8320	213	Pizza Italiano	5.32	https://ohskctl.net/gaRlIsf.jpg	{"Caramelized onions",Cucumber,Mayo,"Onion rings"}	5
417	1689	213	Sweet Potato Pie	5.98	https://wertieq.info/xbwyhaD.html	{Peperoni,Cheese,Tomatoes,"Bavarian sausages",Butter,"Cream cheese"}	3
418	2685	213	Peanut Butter	5.41	http://www.scejsbj.net/kYParJO	{"Original sauce","BBQ sauce",Carrots}	3
419	9290	213	Peanut Butter	7.38	http://trbkfqx.com/vAAXHTr.jpg	{"Cream cheese","Unagi sauce"}	5
420	5655	213	Pizza Hawaiian	7.64	http://geoyaxv.net/	{"Caramelized onions","Japanese tamago",Chicken,"BBQ sauce",Tomatoes,Nori}	5
422	9918	213	Wallmart	2.05	https://hnsvatr.edu/AhQVcnF.html	{Flour}	3
432	4157	213	Bean Green Chili Burritos	3.72	https://stvvkzt.edu/OtpiNYu	{Peperoni,"Cottage Cheese",Onion}	5
415	1835	213	Crispy Chicken burger	6.39	https://xkquspk.net/LUIqSRf.css	{Mozarella,Milk}	5
433	6479	213	Pizza Ocean	3.08	http://wkrwfsa.top/	{Carrots,Mayo,"Japanese tamago","Chili Pepper","Chili Pepper"}	4
434	1990	213	Pizza Florida	7.35	https://jphvxpo.ru/vDVeiby.php	{"Caramelized onions",Milk,Peanuts,Potatoes}	5
436	938	214	Chicken Pot Pie	3.81	http://uxuqvgf.com/CLWDxgb.php	{Butter,Corn,"Cream cheese",Meat}	3
437	3449	214	Pizza Florida	3.53	http://lujsojc.top/YAsFNGl.css	{Peanuts}	2
470	2858	214	Tortellini Bowls	5.03	https://hqkknii.info/aXGrjTc.html	{"Cream cheese",Garlic}	4
471	4024	214	Unagi Philadelphia	3.21	https://ehlbkqu.org/gecUXAY.webp	{Nori,"Bavarian sausages",Bacon,Garlic,Flour,Meat}	4
472	7572	214	Crispy Chicken burger	3.47	https://pixgiqt.org/	{Onion,Cheese,"Cheese cheddar",Nori,Flour}	2
473	5669	214	Pizza Florida	7.98	https://ffumydh.top/BbAnTRY.php	{Mushrooms,Peperoni,"Chili Pepper",Flour,Garlic,"Cheese cheddar"}	5
474	5638	214	Swedish Meatballs	5.77	https://jgryuhf.ru/fHMMhWw.php	{Peperoni,Pineapple}	4
401	1659	213	Pizza Texas	3.75	https://nrrhiau.net/VvHNFRB	{Nori,"Cheese cheddar"}	4
397	1462	213	Angel Food Cake	6.60	https://phcjupz.top/OYsQQXs	{Tomatoes,Butter,Basil,Strawberry,Flour,Tomatoes}	2
402	3314	213	Himawari	2.32	https://qyurxoh.edu/ldrYeQN.webp	{Cheese,Flour,"Caramelized onions","Unagi sauce"}	2
519	3160	215	Swedish Meatballs	2.54	http://uzsjpis.org/fsHddfK.svg	{"Chili Pepper",Peanuts,Peas,"Bavarian sausages"}	2
482	4036	214	Bean Green Chili Burritos	3.87	http://arloahr.org/ojhVEEG.php	{Nori,"Unagi sauce",Pasta}	1
445	4808	214	Philadelphia with salmon	3.67	https://bdpuzsi.ru/DXUHExs.css	{"Chili Pepper","Bavarian sausages","Chili Pepper",Onion,Salmon,"BBQ sauce"}	5
522	3599	215	Tortellini Bowls	5.18	http://okfexpb.info/sIJHkRI.css	{Basil,Corn}	3
452	4805	214	Sweet Potato Pie	2.09	https://vuvbtyp.edu/ATEyaCO.php	{"Japanese tamago"}	3
440	8990	214	Unagi Philadelphia	6.09	http://darbupu.info/aoitxyp.css	{Cucumber}	2
454	2743	214	Pizza Pepperoni with tomatoes	6.48	http://numrofr.net/LBPxjdN	{Bacon,Peas,Mayo}	2
450	6763	214	Swedish Meatballs	2.03	https://isfwtgk.net/	{Flour,Meat,"Caramelized onions",Nori,"Japanese tamago","Cream cheese"}	2
447	2817	214	Swedish Meatballs	7.05	http://vfhmxnx.net/oHBWeGH.webp	{Mozarella,"Cream cheese","Caramelized onions",Garlic,"Original sauce"}	2
448	3779	214	Pizza Florida	3.54	http://fgawuyg.info/XPRNFXt.svg	{"BBQ sauce",Corn,"Onion rings","Chili Pepper"}	4
439	8366	214	Sweet Potato Pie	5.21	http://fsqsesb.biz/WoIFnVw.webp	{Cucumber,Mayo,Onion}	4
451	7387	214	Peanut Butter	2.86	http://ohxhroh.top/sluFtQB.html	{Strawberry,Tomatoes,"Caramelized onions",Tomatoes,Cheese,Corn}	5
449	4030	214	Grape Jelly Sandwich	2.68	https://yzmmekm.ru/	{Peas,Onion,Potatoes,Chicken,Tomatoes,Bacon}	4
446	4143	214	Unwrapped Burrito Bowl	7.52	https://www.phdcsxv.net/	{Garlic}	2
453	8117	214	Original burger	7.38	https://inkfkaf.top/mtnPnRX.css	{"Bavarian sausages",Flour,Cucumber}	2
458	4634	214	Pizza Texas	3.58	https://jwsqvia.org/fcZyNNN	{Pasta,Peperoni,Pasta}	2
455	2212	214	Unagi Philadelphia	4.41	https://ewhvyyg.net/UVISGbP.css	{"Chili Pepper",Strawberry}	4
460	1730	214	Crispy Chicken burger	7.62	https://kqhnbqd.info/oXgFQDJ.webp	{Nori}	1
441	8274	214	Peanut Butter	7.14	https://bskxlnb.top/nRJiFgk	{Pasta,Nori,Strawberry}	2
462	4087	214	Original burger	7.31	https://cniguct.edu/hKJahSG.svg	{Sugar,Peperoni,Peperoni,Salmon,"Onion rings"}	1
459	210	214	New York Style Cheesecake	4.57	http://erunicy.edu/DnsXwUL.svg	{Salmon,Peperoni,Potatoes}	3
465	4642	214	Pizza Hawaiian	7.44	http://szthuhi.info/OqJOnLl.php	{Rice,"BBQ sauce","Cottage Cheese","Chili Pepper"}	5
456	1692	214	Philadelphia with salmon	2.58	http://aujypuu.com/iIyVKGR.webp	{"Cottage Cheese",Pasta,Bacon,Butter,"Unagi sauce"}	4
463	1021	214	Bean Green Chili Burritos	4.49	https://psedfuu.info/	{"Unagi sauce",Onion,"Caramelized onions"}	3
457	8979	214	Pizza Texas	6.45	http://www.ctmgkhq.biz/	{Mushrooms,Pasta,Flour,Peanuts,Mayo}	5
478	9868	214	Philadelphia with salmon	6.89	http://xprycdy.com/aZqBaJZ.html	{Tomatoes}	4
481	209	214	Philadelphia with salmon	7.49	http://ryosvae.com/DkjhikH.php	{Corn,Onion,Strawberry,Mushrooms,Sugar,Salmon}	5
466	1624	214	Pizza Italiano	7.18	https://cjxxgtw.org/WljIJiw.jpg	{"Cream cheese",Peperoni}	3
461	7669	214	Angel Food Cake	4.48	https://www.fruutjt.edu/	{Tomatoes}	3
468	9986	214	Pizza Italiano	6.40	https://ktwhssd.ru/jLHZHsh.webp	{Peperoni,Meat,"Unagi sauce",Pineapple,Potatoes}	3
480	7910	214	Wallmart	3.98	https://vuguasg.net/GmQYHBS.svg	{Butter,Strawberry,"Onion rings","Cheese cheddar","Original sauce",Garlic}	3
464	3697	214	Pizza Italiano	8.00	https://gqmmatp.info/NtpuyQJ	{Garlic,Onion,Mayo,"Original sauce","Caramelized onions","Chili Pepper"}	2
520	3034	215	Chicken Pot Pie	4.74	http://uiznbun.biz/GJnpKVx.css	{Meat,Pasta,Carrots}	1
483	3098	214	New York Style Cheesecake	4.41	http://www.frgouve.info/VwbNoVw	{"BBQ sauce",Cheese,Butter,Sugar}	5
489	7771	215	Unwrapped Burrito Bowl	5.95	https://kdrecyl.org/ZHBGJiu.html	{"Cottage Cheese","Caramelized onions",Basil}	1
485	2024	214	Swedish Meatballs	2.21	https://www.krozwac.edu/	{"Cream cheese",Flour}	3
486	7382	214	Himawari	4.23	http://qpnlsnq.info/tMZnnNU.php	{Flour,"Cheese cheddar","Chili Pepper","Cottage Cheese",Peas}	3
488	8377	214	Tortellini Bowls	6.96	http://aiuwtff.edu/ZxHBufV.svg	{Milk,"Cream cheese"}	4
487	7645	214	Unwrapped Burrito Bowl	7.26	https://mdjeolk.com/CWFRKpx.html	{"Original sauce","Cottage Cheese","Japanese tamago",Rice}	3
518	914	215	Pizza Italiano	3.63	https://www.wrrhhoo.biz/WGCJLvq	{Corn,"Bavarian sausages"}	1
484	8419	214	Angel Food Cake	7.27	https://pjeyvpd.edu/	{Garlic,"Unagi sauce","Bavarian sausages"}	3
467	441	214	New York Style Cheesecake	2.29	http://rimtkgf.net/KYUbWeH.html	{Tomatoes}	2
527	653	215	Sweet Potato Pie	6.51	https://fbktmip.biz/uJojIlc.php	{Meat,"Original sauce",Meat}	1
536	3204	215	Peanut Butter	7.16	https://rpaeogy.edu/BuiuUdk.svg	{"Japanese tamago","Cheese cheddar"}	2
513	3390	215	New York Style Cheesecake	2.53	https://baszhsm.org/otIokOq.js	{Pineapple,Pineapple,Flour}	4
568	4464	216	New York Style Cheesecake	4.93	https://pehomug.biz/ZOZCWPP.js	{Mozarella,Meat}	2
563	3198	216	Pizza Ocean	3.23	https://vvgmjgo.ru/mirImmm.html	{Peanuts,Peanuts}	4
564	1429	216	Bean Green Chili Burritos	4.58	http://ygnkasb.edu/KPHtwDG.html	{Onion,Corn}	4
565	8169	216	Sweet Potato Pie	4.57	http://jzossmg.ru/kqEBOyu.js	{"Cream cheese",Garlic,Salmon}	1
494	2589	215	Unwrapped Burrito Bowl	5.95	http://uewwoeh.org/uIwSOGA.js	{"Cottage Cheese",Butter,Carrots}	3
567	6127	216	Sweet Potato Pie	2.18	http://yfkaiow.info/COvOhcK	{"Bavarian sausages",Carrots,"Chili Pepper","Cream cheese",Basil,Chicken}	1
491	9860	215	Pizza Ocean	6.91	https://xuiooey.ru/	{Tomatoes,Flour,Bacon,Flour,Nori,Milk}	5
504	5011	215	Tortellini Bowls	2.89	https://znbunws.ru/uBjUktX	{"Japanese tamago",Chicken,"Cream cheese",Pasta,Mozarella}	5
562	3090	216	Pizza Italiano	7.81	https://www.ouqgpmx.edu/	{"Unagi sauce","Cottage Cheese",Tomatoes}	2
506	141	215	Swedish Meatballs	5.22	https://www.ypmcagl.edu/	{Mushrooms,Strawberry,"Original sauce"}	3
493	1317	215	Unagi Philadelphia	5.90	https://www.icdwfez.top/	{"Onion rings"}	4
495	7876	215	Wallmart	3.83	http://www.titdcxk.com/	{Mayo}	2
566	1148	216	Pizza Italiano	4.96	https://wokycyt.top/GIqyOJF	{Nori,Nori,Cheese,Mozarella,Mayo,Mayo}	4
496	7924	215	Original burger	3.59	http://www.xyegadg.com/	{"Onion rings",Grapes}	2
498	7936	215	Pizza Pepperoni with tomatoes	3.04	https://www.hjppkhp.org/OcjbYZX	{Mayo}	2
539	7475	215	Bean Green Chili Burritos	5.76	http://www.eduhtoo.net/jROspXN	{Meat,Carrots,"Bavarian sausages"}	2
500	8192	215	New York Style Cheesecake	7.65	https://dcxmjeb.net/vWSYleJ.css	{"BBQ sauce",Corn}	2
492	2614	215	Pizza Ocean	3.96	http://txwkyee.ru/	{"Caramelized onions"}	3
508	2426	215	New York Style Cheesecake	2.21	http://nnsncov.biz/	{Tomatoes,Salmon}	4
502	9522	215	Wallmart	7.98	http://ksmosgq.top/YadDwfc.svg	{Salmon,"Unagi sauce",Tomatoes,Strawberry,Strawberry,Potatoes}	2
528	4623	215	Original burger	4.87	https://vnbdygd.biz/vIDjKZq.php	{Peas,"Cheese cheddar",Tomatoes,Butter}	3
505	9256	215	Bacon Cheese Burger	6.83	http://stybbee.biz/ZGLDCqT.svg	{Sugar}	1
497	4101	215	Sweet Potato Pie	7.85	http://www.cfgrfyv.edu/	{Strawberry,"Japanese tamago"}	3
507	3732	215	Original burger	6.19	http://gsbgvxf.info/IGBsEme.html	{Mayo,Garlic,Flour,"Caramelized onions"}	2
524	8202	215	Peanut Butter	4.71	http://sailfax.top/DBYQodK.html	{Potatoes,Potatoes}	4
499	606	215	Pizza	4.28	https://kjnrshf.com/dsjXkUy.php	{Mayo,Mushrooms,Salmon,Meat}	1
509	5065	215	Bean Green Chili Burritos	6.42	http://mxmkhwe.org/LqjaIHe.jpg	{Garlic,Mushrooms,Corn,Bacon,Basil,Basil}	5
503	81	215	Pizza	2.92	http://hmijill.biz/fNIdetk.svg	{Garlic,"BBQ sauce",Onion,Corn,"Unagi sauce"}	3
510	8974	215	Sweet Potato Pie	4.96	http://mdvogme.edu/QGNViXk.jpg	{Potatoes,Bacon,Pasta,"Bavarian sausages",Cheese}	5
514	511	215	Crispy Chicken burger	5.73	http://eikuuyg.info/RJkmWSI.html	{Mayo,Mayo}	1
533	1193	215	Sweet Potato Pie	4.08	https://oqufcen.net/yrENKnY.html	{Basil,Salmon,Meat,Corn}	3
529	7886	215	Crispy Chicken burger	5.30	https://dklikky.edu/	{"Cottage Cheese",Meat,"Cream cheese",Bacon}	2
526	2565	215	Wallmart	6.41	http://www.sbeapjq.biz/QgUbfWk	{Flour,"Cottage Cheese",Tomatoes}	3
501	7453	215	Chicken Pot Pie	2.82	http://mbpnemm.org/VyXVJCy.js	{Mozarella,Mushrooms}	5
512	625	215	Pizza Florida	2.94	http://sbeabma.ru/dRLmaqy	{"Chili Pepper","Unagi sauce","Onion rings"}	4
530	5384	215	Pizza Hawaiian	3.83	https://nihvxkp.com/cTxVSlq.svg	{Garlic,Onion,"Chili Pepper",Butter}	1
537	4084	215	Unagi Philadelphia	6.98	http://pgbnsun.ru/	{Peanuts,Nori,Strawberry,Mushrooms,Peas,Mozarella}	3
531	436	215	Crispy Chicken burger	7.15	https://pswcoyr.edu/EwjWWHp.js	{Milk}	5
532	3515	215	Bean Green Chili Burritos	3.60	http://eucsrtj.net/mPHDcZS.jpg	{"Bavarian sausages",Flour,Grapes}	4
535	6185	215	Unwrapped Burrito Bowl	3.57	https://www.yrhowbc.top/GmwGLOd	{Cheese,Pineapple,"Chili Pepper","Onion rings","Caramelized onions",Butter}	5
538	5274	215	Pizza Pepperoni with tomatoes	5.58	http://www.gflvpkw.ru/EhOIlaL	{Potatoes}	2
613	1141	217	Saint Frank Coffee	5.90	http://www.lpuqhbi.top/	{Strawberry,Grapes,Flour,"Cheese cheddar"}	5
609	8931	217	New York Style Cheesecake	2.49	http://vtktaow.info/NTYMEIN.svg	{Carrots,"Chili Pepper"}	4
572	411	216	Original burger	4.39	http://www.yhlhwmv.ru/FnmdwpU	{Carrots,Chicken,Milk}	5
610	7844	217	Angel Food Cake	2.68	https://www.jusbyno.info/YlGaUmQ	{Basil,Potatoes,Peperoni}	4
558	4065	216	Himawari	5.33	http://yyuhsfd.info/nSTKmfY.css	{Cucumber}	4
546	1988	215	Swedish Meatballs	3.92	http://samkhii.top/MNyIHsU.css	{"Bavarian sausages",Cheese,Potatoes,Potatoes}	4
614	6701	217	Bean Green Chili Burritos	7.12	http://fbdfmcx.net/UOPIdWZ.php	{Cucumber,Mozarella,"Cream cheese"}	3
588	5449	216	Grape Jelly Sandwich	5.89	https://www.jyxalhq.org/PiGQLIs	{Rice,"Cottage Cheese",Tomatoes,Corn}	2
662	1815	217	Pizza Ocean	6.89	http://tnbvnia.net/	{Corn,Nori,Carrots,Pasta,Chicken}	5
544	6639	215	Pizza	6.69	https://www.wpwiuyg.top/JKKhrAH	{Pineapple,"Cheese cheddar"}	1
586	3277	216	Saint Frank Coffee	3.46	http://fulbxcm.edu/KeUnrSP.webp	{"BBQ sauce",Mushrooms,Corn,Corn,Flour}	5
545	8263	215	Pizza Pepperoni with tomatoes	5.37	https://uduhlbp.top/YBaOelu.css	{Salmon,Salmon,Garlic,"Onion rings"}	2
587	6854	216	Bean Green Chili Burritos	4.78	http://rigiurt.net/SSTHWih.css	{Peanuts,"Cheese cheddar","Original sauce"}	1
560	80	216	Wallmart	7.15	https://cydumcf.com/eKZZSYv.js	{"BBQ sauce",Tomatoes,Bacon}	5
548	578	215	Unwrapped Burrito Bowl	7.67	http://bpwsehh.info/mCtcixo.php	{Flour,Flour,Flour,Cheese,Peperoni,Peanuts}	2
557	1584	215	Bacon Cheese Burger	7.82	https://hvmynlw.ru/yUQDgpF.php	{Chicken,Pineapple,Onion,"Cheese cheddar"}	4
584	6933	216	Pizza Ocean	4.22	http://vbqwncv.com/	{"Caramelized onions"}	4
550	9363	215	Pizza Texas	4.46	https://olfknxf.info/	{"Unagi sauce",Flour,"Chili Pepper","Cream cheese",Bacon,Garlic}	2
547	3675	215	Pizza Florida	4.28	http://ekdrvuz.org/eMweuVZ.html	{"Caramelized onions","Cottage Cheese",Chicken,"Cottage Cheese",Grapes,Basil}	3
611	9090	217	Unwrapped Burrito Bowl	5.52	https://aedbhyr.biz/rwmvIlD.js	{"Cheese cheddar",Strawberry}	3
554	4104	215	Pizza Pepperoni with tomatoes	4.41	http://umafrld.info/xtnGeat.css	{Chicken,"Onion rings",Mozarella,"Original sauce"}	3
555	1369	215	Pizza Hawaiian	7.27	http://dxrelrn.org/NZuJmlW.css	{Butter,Flour,Butter,Mushrooms,"Onion rings","Japanese tamago"}	3
556	8688	215	Angel Food Cake	4.09	http://gnyekoe.edu/XeNYOMn.jpg	{Corn,"Cottage Cheese",Peperoni}	3
577	6209	216	Pizza	2.89	https://kivhtxn.info/LSAaJqy.webp	{Mayo,Salmon,Mushrooms}	1
559	4550	216	Grape Jelly Sandwich	4.15	https://lhxowbl.top/TpBhEPP.js	{"BBQ sauce",Mayo}	2
580	2633	216	Pizza Italiano	6.52	https://juyylsl.net/clgFFuI.html	{Milk,Nori,Grapes,Butter,Strawberry,Peanuts}	1
552	9426	215	Philadelphia with salmon	6.14	https://ktfnqxq.biz/qVQNHfs.js	{Peanuts}	3
575	771	216	Himawari	4.09	https://rwqbhml.ru/EBvDApf.php	{Mushrooms,Basil,Nori,Peperoni}	5
590	5113	216	Himawari	4.20	http://tnsvwco.org/vxZhjEe.css	{Sugar}	4
576	7136	216	Original burger	2.35	http://pbnnhte.top/XdFSIFH.svg	{Mushrooms,"Unagi sauce"}	1
578	585	216	Pizza Texas	3.19	https://bhwtcmf.ru/cwitfCC.jpg	{Mushrooms,Cheese,"BBQ sauce","Unagi sauce",Potatoes}	3
579	6195	216	Unagi Philadelphia	5.51	http://qpghtha.info/NjitiIt.webp	{Butter,Onion}	2
612	36	217	Unagi Philadelphia	2.02	http://jpqtlxd.edu/lpoLKNA.webp	{Peas,Grapes,"Japanese tamago",Milk,Corn}	1
542	2564	215	Bacon Cheese Burger	6.90	https://www.ctevdjj.info/	{Mozarella,"Bavarian sausages",Peas}	2
582	6468	216	Wallmart	4.15	https://rqarlgj.info/RrEREoP.php	{Meat,"Cottage Cheese",Flour,Mushrooms}	2
583	5357	216	Pizza Italiano	6.87	https://cnwxgmc.biz/vdWFUGb	{Pineapple,Flour,Milk,Strawberry}	2
549	9008	215	Original burger	6.73	https://ionevts.org/skXqkgc.svg	{Basil,Grapes,Meat,"Chili Pepper",Flour,Rice}	2
585	8136	216	New York Style Cheesecake	4.90	https://www.whavrbo.org/oicwWnO	{Peanuts,Rice,Nori}	4
551	2680	215	Pizza Italiano	5.12	http://ahwtavg.com/YkoqHls.php	{"Cream cheese",Flour}	2
553	4147	215	Pizza Pepperoni with tomatoes	6.89	http://pqcskcc.org/	{"Chili Pepper"}	1
573	6655	216	Saint Frank Coffee	5.17	http://aauihpm.com/yXmohNK.jpg	{Corn}	4
589	3060	216	Pizza Florida	2.86	https://aejdqzt.ru/XFCXuIR.php	{Chicken}	1
581	9298	216	Pizza Florida	4.40	http://lqxvgot.edu/eybpCKZ.php	{Strawberry,Cucumber,Flour}	4
656	1054	217	Unagi Philadelphia	5.03	http://fgqzsca.top/	{Cucumber,Flour,Peanuts,"Onion rings"}	1
626	7371	217	Unagi Philadelphia	2.89	http://htdmunw.ru/rnaZuAE.php	{Corn,Peas,Rice,Butter,Flour}	2
657	5693	217	Philadelphia with salmon	7.65	https://nbyeueu.org/oPgchUQ.js	{Peperoni}	2
630	1161	217	Grape Jelly Sandwich	2.06	https://lxcqyao.edu/ZyLUcCR.webp	{Corn,"Japanese tamago",Garlic,Salmon}	5
660	5363	217	Pizza Florida	3.30	https://havygkk.com/vltwiOf.php	{"Cottage Cheese",Sugar,Carrots,Cucumber}	4
592	9665	216	Pizza Hawaiian	5.69	https://ixcrkvi.net/JjwLpBL.js	{"Cottage Cheese",Garlic,"Cream cheese",Peanuts,Chicken,"Caramelized onions"}	1
593	2319	216	Bacon Cheese Burger	5.96	https://htagoxk.net/kyoesCN.php	{Carrots,"Cream cheese","BBQ sauce",Peperoni,"Cottage Cheese"}	3
594	7901	216	Bacon Cheese Burger	5.23	https://idoeqie.net/vNWRCCi.css	{Corn,Corn,Mushrooms,Mushrooms}	2
595	1440	216	Peanut Butter	5.21	http://gicymax.com/iMKZyfa.svg	{Mushrooms,Salmon,"BBQ sauce",Tomatoes,"Cream cheese","Bavarian sausages"}	5
596	2648	216	Pizza Texas	3.36	http://iwpaqve.top/IesoQcD.css	{Cheese}	5
598	8008	216	Chicken Pot Pie	2.27	https://woacohc.info/UZlHUCb.js	{Basil,Mushrooms,"Onion rings"}	2
607	3611	217	Original burger	7.75	http://ukeffyk.biz/lBrWvQC.html	{"Caramelized onions"}	2
599	940	216	Unagi Philadelphia	5.50	https://czrvkxc.biz/	{Onion,Peas,"Chili Pepper"}	2
600	5745	217	Saint Frank Coffee	5.24	https://ofrlphq.edu/qPkyvEP.svg	{"Unagi sauce",Flour}	3
601	6808	217	Pizza Hawaiian	3.31	https://wvpppyp.ru/oespfiT.webp	{Tomatoes,Mayo,Basil,Basil,"BBQ sauce","Onion rings"}	4
602	7631	217	Saint Frank Coffee	6.66	https://hwjibja.biz/SPRfkuT.webp	{Mayo,Carrots,Flour,Strawberry}	3
603	7556	217	Sweet Potato Pie	7.06	https://rbbcutj.biz/	{Cucumber,Flour,"Cream cheese",Butter}	2
605	7843	217	Unagi Philadelphia	5.24	https://ipatvyn.top/TJpQvwl	{"Cheese cheddar",Cheese,"Caramelized onions"}	2
616	8348	217	Pizza Florida	3.11	https://hbgeffe.edu/QCljpQn.js	{"Bavarian sausages"}	1
617	3650	217	Angel Food Cake	6.79	http://vmjnaqa.info/JJIWrqk.webp	{Pasta,Mushrooms,Butter}	5
618	2283	217	Wallmart	2.82	https://txejaeo.info/RAHVCBq.html	{"Chili Pepper"}	1
619	6678	217	Peanut Butter	7.97	https://www.hagmuqx.ru/	{Peanuts,Milk}	3
620	5459	217	Himawari	5.96	http://iuuvpdf.top/UWppIDa.webp	{Butter,"BBQ sauce",Chicken,Flour}	3
628	6111	217	Swedish Meatballs	2.27	http://mhygjoq.net/ugIGGsw.html	{Mozarella,Cucumber,Grapes,"Bavarian sausages"}	4
621	4624	217	Pizza Florida	7.48	https://xcpxbki.net/lFdWBqo	{Milk,Basil,Flour}	5
622	2446	217	Pizza Florida	2.33	https://www.hoovbyf.top/MlELxDu	{Cheese,Peanuts}	3
624	1876	217	Chicken Pot Pie	3.04	http://ogvdgux.top/yOiWBdv.svg	{Bacon,Milk}	4
625	3570	217	Pizza	2.69	https://mvsosrs.org/njTFXdF.js	{"Cheese cheddar","Japanese tamago",Strawberry,Mozarella,Grapes}	3
627	1868	217	Bean Green Chili Burritos	4.30	http://jxxdoiw.ru/XFFoHEB.webp	{Corn,"Chili Pepper",Tomatoes,"Chili Pepper",Basil,"Onion rings"}	1
629	5189	217	Sweet Potato Pie	5.67	https://kkatemv.info/wkbjKaW.jpg	{Pineapple,Mozarella,Potatoes,Meat,"Cream cheese",Mozarella}	4
635	8461	217	Sweet Potato Pie	4.83	http://www.kpfmifq.biz/	{Meat,Sugar,"Japanese tamago",Bacon,"Chili Pepper",Grapes}	1
631	4640	217	Wallmart	6.99	http://fbyglhe.edu/baViyMM.svg	{"BBQ sauce",Pasta}	1
654	3527	217	Swedish Meatballs	5.07	https://qosohiu.com/QWFKMmj.jpg	{Flour,Peas,Tomatoes,Mushrooms,Flour}	3
632	476	217	Bean Green Chili Burritos	7.72	http://rpijpfv.top/	{Flour,Nori,Potatoes,"Onion rings"}	5
633	4898	217	Unwrapped Burrito Bowl	7.01	http://orhkxkl.biz/PIcwMZR.html	{Pineapple,Basil}	3
634	6992	217	Unagi Philadelphia	5.68	http://nebxafm.ru/BVbRsXC.html	{Rice,Meat}	2
636	6717	217	Unwrapped Burrito Bowl	3.88	https://lbseecl.edu/laZRQqe.html	{"Chili Pepper",Mozarella,Pasta,Corn,Chicken}	1
637	5308	217	Himawari	7.30	http://njppdqx.edu/SvofytS.jpg	{Peperoni,"Chili Pepper",Mushrooms}	4
655	6269	217	Angel Food Cake	4.70	http://www.anmpals.net/vAuLiiW	{Butter,Carrots,"Cheese cheddar"}	3
658	4723	217	Swedish Meatballs	2.22	https://bwlrkfn.net/cjxgbkY.jpg	{Tomatoes,Cheese,"Japanese tamago",Salmon}	5
659	1978	217	Pizza Texas	7.83	https://fldnygk.info/YjETHSg.webp	{Flour}	5
661	9873	217	Bacon Cheese Burger	6.06	http://twsspoe.com/riSBTGf.css	{Flour}	4
687	8804	218	Chicken Pot Pie	5.66	http://xrzisqs.top/	{Mushrooms,Butter,Cucumber,Cucumber,Pasta}	3
686	2495	218	Pizza	7.38	http://www.gmuexaa.ru/nIgMHFc	{Flour}	4
676	8613	217	Swedish Meatballs	5.59	https://exbjxfe.net/CdODkWE.php	{Peas,Flour,Peas,"Onion rings",Peas,Chicken}	3
650	6549	217	Himawari	4.24	https://smaljyn.info/eqvJdIy	{"Japanese tamago"}	4
705	495	218	Pizza Pepperoni with tomatoes	3.69	https://wpnpwjg.ru/sgmZSQj.webp	{Cheese,Basil}	5
689	5266	218	Saint Frank Coffee	7.24	http://xetewlo.top/MCdieEX.svg	{Mayo,"Caramelized onions",Onion}	1
679	2133	217	Pizza Ocean	7.09	https://plmggbg.top/iCOAYZb.webp	{"Chili Pepper",Meat,"BBQ sauce","Cheese cheddar"}	2
706	3458	218	Wallmart	5.56	https://www.yhhjrpt.info/PKtGeuf	{"Cheese cheddar",Onion,Salmon,Strawberry}	2
708	1526	218	Sweet Potato Pie	7.23	http://www.dzhvdnh.net/ZiqTtxR	{Peanuts,Onion,"Cheese cheddar"}	3
682	4535	217	Swedish Meatballs	3.87	https://www.wzukplw.info/	{Cheese,Sugar,Butter,"Cream cheese"}	5
756	2404	218	Himawari	4.51	http://www.ftxqdbp.info/	{"BBQ sauce"}	1
685	1275	217	Wallmart	5.39	http://vitzoog.info/DUlBDOk.webp	{Carrots,Peas,Cheese,"Cheese cheddar"}	5
639	3925	217	Tortellini Bowls	7.28	http://wipnuro.edu/oeKXFyf.php	{Pineapple,"Chili Pepper",Peanuts,Butter}	3
640	7565	217	Pizza Florida	4.32	http://wfcashm.ru/PShqTxF.html	{Nori,"Caramelized onions"}	4
641	7920	217	Original burger	6.69	http://vluriqh.net/WIfWlAx.css	{"Cottage Cheese","BBQ sauce",Nori}	3
642	6673	217	Pizza Florida	6.08	http://wicjtcm.top/kJCphtf	{Grapes,Nori}	1
645	5157	217	Original burger	5.28	http://yceqqhc.org/mlaPhJs.html	{Carrots,Peanuts,Basil,"Unagi sauce","Chili Pepper",Mayo}	3
704	8478	218	Himawari	3.57	http://ruxcsko.org/MULdVPt.svg	{Peas,Carrots,Flour,"Unagi sauce",Peas,Rice}	5
646	2392	217	Philadelphia with salmon	2.01	https://www.iuzmowb.top/mhJOrsQ	{"BBQ sauce",Peanuts}	3
647	7040	217	Pizza Ocean	5.37	http://ptsrpkp.org/lUDrFwD	{Peanuts}	3
649	2003	217	Himawari	6.00	https://eqeigol.ru/	{Salmon,Flour,Nori,Cheese,Carrots,"Unagi sauce"}	1
688	8259	218	Pizza Texas	2.30	https://wqjkxwp.org/KvKEpfg.jpg	{Corn,Sugar,Bacon}	2
651	1672	217	Tortellini Bowls	7.99	http://www.eroihdd.biz/ZkSKkHb	{Mayo,Flour,Milk}	2
652	7023	217	Original burger	2.01	https://mewoqsr.top/	{Pasta,"Bavarian sausages",Onion,"Onion rings"}	1
664	1355	217	Unagi Philadelphia	3.65	https://sklxqcn.net/YfIpitM.jpg	{Tomatoes}	4
666	1505	217	Swedish Meatballs	3.99	https://bsclitj.biz/uskHnFI.jpg	{Pasta}	4
667	4149	217	Sweet Potato Pie	3.31	http://zxmrxna.top/rALsHiQ.php	{Potatoes,Nori,"Chili Pepper",Onion,"BBQ sauce",Mushrooms}	4
668	9772	217	Peanut Butter	2.90	https://www.evxsboj.net/	{Peas,Pasta,"Caramelized onions","BBQ sauce",Cheese}	5
669	5245	217	Pizza Texas	5.74	http://reciakj.ru/	{Carrots,Flour}	2
670	800	217	Philadelphia with salmon	7.26	http://www.sesoixu.com/WLDOBoH	{Salmon,Corn,Sugar}	3
671	9995	217	Philadelphia with salmon	5.02	https://wfqyjtg.org/yfYQXpI	{Milk,Strawberry,Butter,Cheese}	3
672	4839	217	Tortellini Bowls	7.06	http://pkltxwe.net/	{Strawberry}	3
674	5166	217	Unagi Philadelphia	5.03	http://lpvjhse.com/SjxVgBk.php	{Pineapple,Cucumber,Bacon,Peperoni}	2
677	8295	217	Unwrapped Burrito Bowl	4.79	http://lnjffgd.edu/PQBRjJX.svg	{"Chili Pepper"}	3
644	3635	217	Crispy Chicken burger	6.49	https://gxrtqlc.biz/WxmDuIb.html	{Pasta,Cucumber,"Caramelized onions",Mayo}	2
680	9714	217	Swedish Meatballs	3.74	http://dusxstz.ru/	{Pasta,Chicken,Grapes,"Cream cheese","Onion rings",Basil}	5
678	5428	217	Sweet Potato Pie	3.14	http://jbvvoxv.org/nsBZkMd.jpg	{Carrots,Strawberry}	1
681	4889	217	Pizza Florida	6.11	https://dbvoqks.biz/sRxpNrr.css	{Milk,Chicken,Salmon,Cucumber,Milk,Flour}	1
707	5133	218	Saint Frank Coffee	6.90	https://zfrkhqk.ru/mDHMCpJ.html	{Garlic,Sugar,Butter}	3
683	6413	217	Sweet Potato Pie	6.18	http://ikqrqas.info/NjfCTSM	{Garlic,Mushrooms,Peanuts}	1
684	5061	217	Pizza Pepperoni with tomatoes	7.95	https://vxitsaa.ru/PUeEntH.jpg	{Butter,Mushrooms,Tomatoes}	3
792	3912	219	Pizza Italiano	5.75	http://oxublmm.com/CfKKuAW.webp	{"Unagi sauce",Bacon}	3
675	3590	217	Crispy Chicken burger	7.61	https://fcsphzs.info/qDvJArm.webp	{Chicken,"Cottage Cheese",Flour,Butter,Peas}	1
702	6410	218	Crispy Chicken burger	5.69	https://ohyqnqo.top/XRIVnir.jpg	{"Bavarian sausages",Peperoni}	1
736	4646	218	Philadelphia with salmon	5.48	https://dsvbwrs.net/OBNVOll.js	{"Bavarian sausages"}	2
737	8256	218	Pizza Ocean	4.81	https://pgheghc.info/BcRLqKQ.js	{"Japanese tamago","Caramelized onions",Grapes,Grapes}	4
724	6330	218	Saint Frank Coffee	7.00	https://jotjjbh.ru/IEOTgue.jpg	{Grapes}	5
740	7099	218	New York Style Cheesecake	7.98	http://ljgscln.info/MViajUa.svg	{Mushrooms,Corn,Flour}	3
741	3989	218	Pizza	3.26	https://kcnxkhi.ru/dooRUKC.svg	{"Original sauce",Potatoes}	5
750	1948	218	Unwrapped Burrito Bowl	7.12	http://wmmxdle.edu/iXcZabp.js	{Basil,Butter,Garlic,Peas,Mushrooms,"BBQ sauce"}	4
751	2730	218	Wallmart	2.39	https://rcalxyr.net/	{Onion,Peas,Chicken,"Onion rings",Pasta}	2
752	3075	218	Pizza Texas	5.83	https://dkojncd.net/iAcKDcp.html	{Cucumber,Peas,"Cheese cheddar"}	2
753	7362	218	Unagi Philadelphia	2.55	http://www.dareyiu.com/	{Meat,"Unagi sauce"}	4
754	9466	218	Philadelphia with salmon	6.37	http://smxjsfv.com/TnwrmyO.jpg	{Mayo,"Cottage Cheese"}	1
755	352	218	Grape Jelly Sandwich	7.98	http://www.xbsdxco.top/yEtOBgI	{Cheese,Peas,Flour,Potatoes,Strawberry}	5
691	3026	218	Bacon Cheese Burger	4.97	http://vzajdnb.top/bBPVxKq.html	{Flour,"Onion rings",Meat,Basil}	3
692	8231	218	Saint Frank Coffee	3.74	https://rclqfya.info/ELlVCki.html	{Peas,"Cream cheese","Unagi sauce"}	5
693	8777	218	Pizza Ocean	4.05	http://qopmqsq.biz/xsWFhyo.php	{"Cheese cheddar"}	5
694	941	218	Bean Green Chili Burritos	2.14	http://usciyef.top/GUlPAVn	{"Japanese tamago",Flour,Corn,"Japanese tamago"}	2
695	5592	218	Saint Frank Coffee	3.43	https://eahnuwf.biz/	{Grapes,"Cottage Cheese",Flour,Milk,"Cottage Cheese",Butter}	2
696	8726	218	Pizza Florida	4.31	http://ssvsbqq.net/jOVDLdP.js	{Basil,"Caramelized onions",Corn}	1
697	2339	218	Pizza Ocean	5.58	https://mvcomxm.edu/PvoGQQs.css	{Onion,Nori,Peperoni,"Original sauce"}	3
698	1711	218	Pizza Florida	2.45	http://xtgbovg.top/lIoFwin	{Meat,"Onion rings",Peas,Meat}	3
699	2773	218	Pizza Texas	4.20	https://ftregwp.info/wcarBfn.php	{"Cream cheese"}	5
700	4296	218	New York Style Cheesecake	4.11	http://www.slpnxyf.info/jvVLPXe	{"Chili Pepper",Peas,Bacon,Tomatoes}	2
710	8735	218	Wallmart	4.84	https://www.lfudetc.biz/	{Peas,Pineapple,"Chili Pepper",Basil,"Unagi sauce",Potatoes}	4
713	4132	218	Pizza Florida	3.11	http://asypchv.top/	{Chicken,"Original sauce",Basil}	2
714	5658	218	Tortellini Bowls	7.90	https://fseihyu.info/VglMgpP	{Milk,Pineapple,Flour,Garlic}	2
715	3116	218	Pizza Hawaiian	5.60	https://llshxiq.top/ASrkDiK.js	{Bacon,"Chili Pepper"}	1
716	1082	218	Peanut Butter	6.34	https://thkxkcx.info/tOgkOyb.php	{Salmon,"Japanese tamago",Basil,"Chili Pepper"}	2
718	4792	218	Bacon Cheese Burger	2.14	https://smuwkvs.info/xZIMcCm	{"Cheese cheddar",Strawberry,Mushrooms,Chicken,Meat,Peanuts}	4
719	2168	218	Sweet Potato Pie	4.72	http://kypnzhd.top/IGhMNfp.css	{Flour}	3
720	5239	218	Swedish Meatballs	6.57	https://pzwlwzk.com/elbOhjS.php	{Pineapple,Garlic,Rice,Bacon,Meat}	5
721	6504	218	Crispy Chicken burger	4.25	http://www.sryxsqp.com/apERxxT	{"Cheese cheddar",Onion,"Cheese cheddar",Pasta}	2
722	2658	218	Pizza Italiano	2.67	http://ofthgrp.org/VMvEKiu.css	{Mushrooms,"Original sauce"}	1
723	396	218	Philadelphia with salmon	4.17	http://cjcuogk.info/IkDQCDi.php	{"Cream cheese"}	1
725	725	218	Pizza Italiano	3.08	https://jedbfch.biz/BodCoYV.html	{Sugar,Cucumber}	5
726	7540	218	Swedish Meatballs	4.55	http://fzjibuk.edu/eRhMhbb.html	{Peanuts,Pasta}	4
727	3136	218	Pizza Pepperoni with tomatoes	2.27	http://luqwput.net/iTQgSQE.svg	{Corn}	3
728	1387	218	Saint Frank Coffee	3.51	https://rtuomcm.ru/dGdItZH.js	{Onion,Mayo,Rice,Bacon}	2
729	6411	218	Bacon Cheese Burger	6.70	https://fkwjjkz.com/dxxJbma.js	{Salmon,Onion,Flour}	5
730	6066	218	Bean Green Chili Burritos	4.52	https://www.ysmsomz.ru/	{"Cottage Cheese"}	2
731	5139	218	Unwrapped Burrito Bowl	7.08	http://ugxrtjj.top/RCDLGEH.html	{"BBQ sauce",Rice}	4
732	306	218	Pizza Pepperoni with tomatoes	3.48	https://rardmwf.edu/gdJAQNv.svg	{"Unagi sauce"}	4
734	6331	218	Unwrapped Burrito Bowl	3.25	https://mwkluhh.net/ioiudgg.html	{"Unagi sauce","Unagi sauce","Caramelized onions",Onion,Rice,Mayo}	1
735	4351	218	Bean Green Chili Burritos	6.24	https://hgloehu.net/TsHeiYb.php	{Cheese,Basil,"Original sauce",Peanuts,"Cream cheese"}	1
738	552	218	Pizza Hawaiian	5.94	https://www.xeiwtto.net/stNgThq	{"Caramelized onions"}	1
739	8495	218	Pizza Florida	2.81	http://www.pvshgsi.ru/mEiURWT	{Strawberry,Cucumber}	4
796	9131	219	Angel Food Cake	4.87	http://www.jcrravi.org/vjVDgVg	{Carrots,Corn,Flour,Grapes,"Cottage Cheese"}	5
797	5762	219	Peanut Butter	4.59	https://www.qttwlri.top/	{Flour,Garlic,Peperoni,Carrots}	1
781	9859	219	Grape Jelly Sandwich	2.58	https://qnyjjnh.net/noBHMWJ	{Pasta,Strawberry,Nori,Butter,Nori}	5
784	2844	219	Angel Food Cake	4.72	http://ztcdtss.top/dfwldvM.jpg	{"Caramelized onions",Milk,Cheese,"Onion rings",Grapes,Potatoes}	5
801	7168	219	Unwrapped Burrito Bowl	2.18	http://rojxurh.com/	{Potatoes,Mayo,Peanuts}	3
802	9300	219	Philadelphia with salmon	2.31	https://gvmxsym.ru/fAigjGW.jpg	{Cucumber,Strawberry,Garlic,Peperoni}	4
798	6551	219	Pizza Texas	3.02	http://aulnqeu.biz/dAWVQwt.php	{Meat,Chicken}	5
744	8961	218	Bean Green Chili Burritos	2.16	http://nkkfbnx.net/XqrWctP	{Flour,Sugar,"Cottage Cheese",Flour,Bacon,Flour}	5
745	680	218	Pizza Texas	6.76	https://itdwoev.top/RVaUrmS.php	{Mushrooms,Peperoni}	5
746	1874	218	Pizza Texas	6.58	https://ipiajnh.net/yQryTBx.php	{Garlic,"Unagi sauce",Onion}	5
747	1249	218	Philadelphia with salmon	5.64	http://rjbtemi.biz/bExiwSn.css	{Peas,Sugar,Cheese,"Original sauce",Carrots}	1
759	6438	219	Swedish Meatballs	6.03	http://www.tupggjs.org/yLfJTmp	{"Cottage Cheese"}	5
760	5083	219	Bacon Cheese Burger	5.48	http://qsuqqfk.com/YBOjeHQ	{"Cottage Cheese",Chicken,Pasta,Mozarella}	1
761	9233	219	Swedish Meatballs	2.66	http://iohkrjx.com/nxJTwpU	{Butter,"Caramelized onions",Mushrooms}	5
762	3521	219	Pizza Hawaiian	2.65	https://iagkeyw.info/EJPbSZa.jpg	{Potatoes,"Cheese cheddar",Pasta,Strawberry,"Original sauce"}	5
763	1819	219	Pizza	7.28	http://odinunp.biz/pvOtETQ.svg	{Corn,Rice,"Cream cheese",Meat,Tomatoes,"Onion rings"}	2
764	5087	219	Himawari	4.79	https://ajmbluv.edu/BJGHNac.svg	{Mayo,Mushrooms,Cucumber,Chicken,Mayo,Cheese}	3
765	1566	219	Philadelphia with salmon	4.35	https://qllkyvh.top/wWqfrqB.js	{"Japanese tamago",Peas,Butter,Pineapple}	5
766	7550	219	Swedish Meatballs	4.30	http://rhpythw.org/NXimFYr.css	{Mozarella,Sugar,Mayo,"Cream cheese"}	1
767	3785	219	Pizza Ocean	7.64	https://xxhgysn.edu/LUBwWVH.html	{Butter,Mushrooms}	4
770	5237	219	Unwrapped Burrito Bowl	3.86	http://cvtryua.org/xjwtMdN.jpg	{Milk,"Chili Pepper"}	2
771	4431	219	Wallmart	5.16	http://www.otktmvr.com/	{"BBQ sauce",Pineapple,"Cream cheese"}	1
772	2029	219	Chicken Pot Pie	2.49	https://kenqtut.biz/UJQwhkB	{Bacon,Meat,Corn,Peanuts,Flour,Onion}	5
773	2377	219	Unagi Philadelphia	8.00	http://www.qqblyra.biz/akfTSPU	{Milk,Meat}	5
774	5240	219	Saint Frank Coffee	4.25	https://lfjmeac.ru/	{"Cottage Cheese",Chicken,"Caramelized onions","Chili Pepper","Japanese tamago","Cream cheese"}	4
775	4596	219	Angel Food Cake	4.82	https://www.nxipett.biz/	{Basil,Corn}	3
776	2115	219	Unagi Philadelphia	2.72	https://ygcrliy.info/okcJDpI.css	{Flour}	3
777	4568	219	Unwrapped Burrito Bowl	3.39	http://cxxrucc.biz/EiRHvSH.php	{Tomatoes,Carrots,Salmon,Rice,Tomatoes,Basil}	3
778	3113	219	New York Style Cheesecake	6.93	http://suxjqwv.biz/BniPIrN.svg	{Peas,Onion,Rice,"Cheese cheddar"}	1
779	8846	219	Chicken Pot Pie	7.36	http://yaxfvpj.top/LnRcAwU.js	{Peperoni,"Onion rings",Chicken,Nori,Milk}	3
780	857	219	Wallmart	6.76	http://tldxjhw.com/ZWDGXoE.webp	{"Original sauce"}	4
782	9890	219	Crispy Chicken burger	2.20	http://www.ylsqien.biz/	{"Original sauce","Unagi sauce"}	5
783	1086	219	Saint Frank Coffee	5.31	http://www.evqodfi.edu/	{Mushrooms,"Original sauce",Peas,Peanuts}	4
785	6572	219	Grape Jelly Sandwich	6.87	https://wetxgzg.com/	{Salmon}	1
799	7440	219	Tortellini Bowls	2.70	http://www.ctwrksf.biz/KAvQdxi	{Mushrooms}	5
786	4870	219	Pizza	4.41	https://axwhwvj.org/sEBaqaK.jpg	{Pasta,Cheese,Salmon,Mayo,Butter,Peperoni}	4
787	4028	219	Pizza Hawaiian	5.97	http://kcabbah.ru/gIGXKPK.php	{"Original sauce",Cheese,"Cottage Cheese",Milk,"Cheese cheddar",Meat}	2
788	6123	219	Sweet Potato Pie	4.28	https://ttutuad.info/UunIbsI.html	{"Onion rings",Sugar,Onion,"Cream cheese"}	5
790	8664	219	Tortellini Bowls	5.42	https://gedguqf.org/JZZPAIE.html	{Cheese}	4
791	5593	219	Grape Jelly Sandwich	6.70	https://www.izuxsph.biz/hDqvuUd	{"Cottage Cheese","Caramelized onions","Cottage Cheese",Peanuts,"Onion rings",Milk}	4
789	3712	219	Angel Food Cake	7.36	http://yasbnyf.edu/mUqwfFn.php	{Mushrooms}	4
743	6624	218	Grape Jelly Sandwich	4.56	https://icfluao.info/MYZvDhH	{Corn,Salmon,Pineapple}	1
800	893	219	Pizza Ocean	7.14	https://bptelnn.ru/HYDXdfS.svg	{Cucumber,"BBQ sauce",Corn,"Onion rings",Sugar,Mayo}	1
808	8717	219	Unwrapped Burrito Bowl	2.91	http://vavgcyk.biz/SqkekWX.php	{"Unagi sauce",Rice,Bacon,Milk,Garlic}	1
825	4789	219	Pizza Ocean	2.21	https://ecvuimi.biz/	{Nori,Mayo,Mayo}	4
818	3740	219	Peanut Butter	5.77	http://guhcrlh.ru/igMCSrx.js	{"BBQ sauce","Caramelized onions",Potatoes}	5
831	4962	219	Pizza Italiano	5.04	http://xrcyove.com/	{Rice,"Onion rings","Caramelized onions","Caramelized onions"}	2
836	2532	219	Pizza Ocean	7.97	https://kfryojw.net/SYVwtrh.jpg	{Strawberry,Mushrooms,Sugar,Garlic,Potatoes}	3
833	2610	219	Pizza Ocean	6.79	http://bxmvzal.org/usnuLbv.webp	{"Bavarian sausages"}	4
834	5896	219	Grape Jelly Sandwich	2.05	https://cyxkeea.top/KLbYAwD	{"Unagi sauce"}	3
835	151	219	Pizza	5.84	https://www.qlcvpqt.top/	{Sugar,Nori,"Bavarian sausages"}	4
823	1775	219	Chicken Pot Pie	2.89	http://gylubdd.edu/KkmtIGI.css	{"Cottage Cheese",Carrots,Mushrooms,Onion}	3
841	3776	219	Pizza Hawaiian	6.11	https://vnrxaqh.ru/OlPiGIj	{"Cottage Cheese",Peperoni,Carrots,Cheese,Onion}	5
838	5377	219	Pizza Italiano	6.74	https://ncarrbh.info/tIjfBJa.js	{Butter}	5
839	9495	219	Chicken Pot Pie	5.37	https://www.nkscpvr.edu/XaZdkCK	{Milk,Salmon,Grapes,Cheese,"Onion rings"}	2
840	3720	219	Unwrapped Burrito Bowl	3.79	http://vewnmjh.biz/eCdBHnw.php	{Peperoni,Flour}	3
830	2188	219	Angel Food Cake	5.64	https://goqrvyx.edu/XyARKLH.jpg	{"Japanese tamago","Unagi sauce","Original sauce","Unagi sauce",Sugar,Peas}	4
844	2669	220	Pizza Italiano	3.49	http://bsixtya.edu/wVhWWZg.html	{Milk}	2
845	3419	220	Pizza Italiano	5.24	http://euuqofp.info/XgyJULD.php	{Basil,Potatoes,Carrots,Mushrooms}	5
846	5310	220	Pizza Ocean	5.61	https://pkkjgna.net/CmkymWn.svg	{Flour}	4
847	9794	220	Chicken Pot Pie	5.51	http://www.oryjmlh.ru/ArkAtPY	{Corn,Mozarella,Mushrooms,"Cheese cheddar",Bacon}	2
848	4636	220	Himawari	6.27	http://njyfwnv.net/TnVjSjV.svg	{Meat}	2
794	644	219	Chicken Pot Pie	4.39	https://gruukqo.net/	{Tomatoes,Garlic,Peanuts,Cheese,"Original sauce",Strawberry}	4
804	2621	219	Pizza Florida	4.95	http://pspoinz.edu/	{Mozarella,"Bavarian sausages"}	1
805	6215	219	Sweet Potato Pie	3.55	http://zctnoto.org/NfELFZf.css	{"Japanese tamago"}	1
892	8021	222	Wallmart	7.39	https://npoqjnu.top/lMeIJKD.php	{Peanuts,Mozarella,Chicken,Peas,Basil}	4
893	8218	222	Wallmart	7.02	https://nfqxfqr.edu/	{"Bavarian sausages",Mayo,Mayo}	3
813	9349	219	Wallmart	4.23	http://axhxkzf.ru/	{Mayo,Milk,"Caramelized onions","Cream cheese","Bavarian sausages"}	4
793	5049	219	Pizza Ocean	6.00	http://www.mqnxcxr.ru/KeueYkT	{Salmon,"BBQ sauce"}	3
807	7008	219	Tortellini Bowls	7.67	http://ummertk.top/GwaeryZ	{Milk}	2
896	2760	222	Pizza Texas	2.10	http://kcraqww.net/UtOXJqo.js	{"Japanese tamago",Mushrooms,Nori}	2
809	1873	219	Pizza Florida	2.66	http://lfknudn.info/dPgSjyR.webp	{Milk,Flour,Butter,Flour}	5
814	8758	219	Wallmart	7.52	http://ahrdqpw.biz/TaorYQu.webp	{Grapes,Peperoni,Cucumber,Butter}	2
849	961	220	Pizza Florida	3.08	http://wxnjomf.biz/rBnCOEC.jpg	{Basil,Mayo,"Unagi sauce","Bavarian sausages"}	2
850	7275	220	Unagi Philadelphia	6.39	https://www.vfxyskm.com/	{Grapes,Mayo,Garlic,Bacon,Peperoni}	1
810	2998	219	Philadelphia with salmon	6.61	http://trwywhd.ru/pbqYape.php	{"Chili Pepper"}	3
812	1423	219	Pizza Florida	5.24	https://yxmkwhk.biz/GxvhUfP.html	{"Onion rings"}	5
822	3616	219	Unwrapped Burrito Bowl	7.30	https://abhanie.info/qtcHYjE.jpg	{Mushrooms,Rice}	5
815	9463	219	Himawari	2.92	https://tbthwhg.info/KODpqoQ.svg	{"Cream cheese",Pineapple,Cucumber}	2
816	1129	219	Sweet Potato Pie	7.37	http://tvlgmnl.info/YrutVOo	{Strawberry,Strawberry,"Cream cheese",Chicken,Milk}	3
817	3045	219	Sweet Potato Pie	2.80	https://www.pkptzdk.biz/	{Peperoni,"Unagi sauce"}	5
806	7152	219	Chicken Pot Pie	5.28	https://ylkjklh.top/spYWPeB.jpg	{Onion}	5
819	6417	219	Pizza Italiano	2.38	http://www.jljuvts.ru/	{Nori}	2
821	648	219	Pizza Texas	2.04	https://www.dntmqfc.edu/	{"Unagi sauce",Mushrooms}	2
826	7411	219	Saint Frank Coffee	7.07	https://sdjkjbu.ru/RXpmhWu.svg	{Peperoni,Mayo,Flour}	3
832	8508	219	Pizza Texas	5.05	http://ekhxenf.info/EOgKxkO.html	{Strawberry}	3
824	6975	219	Pizza Florida	6.86	https://utcdozc.net/tYLycwS.js	{"Cottage Cheese",Salmon,Meat}	2
827	7502	219	Chicken Pot Pie	2.53	http://kcadbrg.ru/AlMjiLZ.webp	{Butter}	4
837	6268	219	Pizza Florida	2.97	https://ayjecth.info/	{Potatoes,"Chili Pepper",Bacon,Chicken,"Caramelized onions"}	2
859	3625	220	Pizza Italiano	3.18	http://fgdlobp.net/mJnCPuF.webp	{Bacon,"Caramelized onions","Japanese tamago","Cottage Cheese"}	4
870	3450	220	Himawari	4.29	http://aypykdg.net/qemdvLk.css	{"Onion rings",Corn}	4
871	3735	220	Angel Food Cake	4.63	https://sysfcgh.biz/bbpAHky.jpg	{Grapes,"Unagi sauce",Grapes,Milk,"Japanese tamago"}	3
874	4027	220	Original burger	4.14	https://www.qnobovl.net/KQPouiV	{Bacon,Bacon,Chicken,Potatoes}	4
875	2015	220	Philadelphia with salmon	3.23	https://ersqvvo.biz/fpqoGJr.webp	{Rice,Strawberry,Mushrooms}	4
876	50	220	Peanut Butter	5.98	https://www.fljuqwm.com/	{Corn,Potatoes,Pineapple,Potatoes,Peas}	3
878	3821	222	Chicken Pot Pie	6.09	https://chvskrm.org/XQinNjw.jpg	{Basil,Mushrooms,Potatoes,Garlic}	4
879	775	222	Peanut Butter	7.54	https://nybxbrg.net/	{Pineapple,Carrots}	2
880	7698	222	Sweet Potato Pie	6.75	https://movovpe.org/IxtLsIH.webp	{Corn,Potatoes,Carrots}	2
881	1998	222	Grape Jelly Sandwich	3.57	http://cjxdego.com/ZnsUfrP.js	{Cheese,Nori,Peas,"Unagi sauce"}	5
882	8418	222	Original burger	4.05	https://hrtxgns.info/wUrNhxf.php	{Carrots,Mushrooms}	2
883	329	222	Saint Frank Coffee	7.15	https://oaaldwk.org/CcQdkQA.css	{"Cream cheese"}	4
884	7369	222	Chicken Pot Pie	5.78	http://dkaqhxb.biz/pTcjGji	{Mayo,Tomatoes,"Original sauce","Japanese tamago"}	3
886	5563	222	Pizza Hawaiian	2.35	http://iflcjmt.info/hZkaBay.jpg	{Flour,Corn}	1
887	954	222	Swedish Meatballs	3.10	https://arboahg.biz/NNPiCqt.webp	{Rice}	3
888	5243	222	Pizza Italiano	2.63	http://qykkhvp.com/hcROOco.svg	{Garlic,Flour,Potatoes,Basil,Onion,Peperoni}	5
894	8219	222	Pizza Italiano	4.90	http://yduopmu.edu/mVBKWpi.jpg	{Rice,"Original sauce"}	1
895	8630	222	Unwrapped Burrito Bowl	5.42	http://nnaukku.org/ljfSUQw.js	{Flour,"Bavarian sausages"}	1
899	6115	222	Chicken Pot Pie	6.30	https://www.kswlnbe.edu/bfvOdqe	{Flour,Milk,"Chili Pepper"}	1
900	3267	222	Pizza Hawaiian	2.35	https://yxszsxm.com/CjSkTdR.css	{"Cottage Cheese",Peas,Tomatoes,Grapes}	5
938	9162	222	Sweet Potato Pie	3.93	https://bmodjrp.biz/	{Butter,"Cheese cheddar","BBQ sauce",Cheese}	4
940	629	222	Grape Jelly Sandwich	2.90	http://kgbwfog.biz/QNgCnGB.html	{Bacon,Peas,Carrots,"Original sauce",Basil}	5
941	1871	222	Bacon Cheese Burger	2.38	https://wngmuqg.ru/AgULieJ.php	{"Cheese cheddar",Salmon,"BBQ sauce",Salmon,Mushrooms}	5
942	2806	222	Saint Frank Coffee	3.19	http://plkuzeh.ru/QbeeSyP.webp	{Corn,"Caramelized onions"}	3
943	5043	222	Peanut Butter	5.25	https://wwyusih.com/	{Mushrooms,Cheese}	2
944	1162	222	Pizza	2.42	http://iutsuuu.net/GCxGovZ.css	{Basil,Rice}	3
852	7779	220	Pizza Hawaiian	3.49	https://gkkcdim.ru/byEFIvs.svg	{Butter,Meat,Peperoni}	3
853	8754	220	Saint Frank Coffee	2.36	http://xmqsbpp.com/PSmCPTj.svg	{Pasta,Pasta,Flour,Butter,Mayo}	4
854	9279	220	Philadelphia with salmon	7.63	http://tstvknt.info/VIonLos.jpg	{"Caramelized onions",Peas,Sugar}	3
856	8639	220	Wallmart	3.32	http://ydymmlp.edu/PWrwtaA	{"Original sauce",Flour}	1
857	401	220	Angel Food Cake	6.03	https://www.vjejsge.biz/	{Chicken,Bacon,Rice,"Cream cheese"}	5
860	2964	220	Saint Frank Coffee	3.61	https://www.wewaodk.info/vvyxWXH	{Grapes,Flour}	3
861	575	220	Angel Food Cake	5.67	http://gfxgolc.ru/YVRSEjQ	{Mozarella,Onion,Grapes,Mushrooms,"Unagi sauce"}	5
862	8499	220	Saint Frank Coffee	3.95	https://www.jdjbczs.ru/kPhOgsb	{Sugar,Mozarella,"Cream cheese",Pineapple,Grapes,Flour}	2
863	3695	220	Unwrapped Burrito Bowl	5.43	http://eabrcri.ru/WIiFbZY.jpg	{Onion,Rice}	2
864	3531	220	Bean Green Chili Burritos	5.31	https://zjfrzrv.org/JJhdOko.php	{Strawberry,Salmon,Mayo,Nori,Mushrooms}	4
865	9077	220	Original burger	6.42	https://gcetryx.biz/vHVqnOV.html	{"Unagi sauce","Original sauce","BBQ sauce",Cucumber}	5
866	4491	220	Chicken Pot Pie	6.76	https://wpgpfiz.info/oXFPhHx.php	{Flour,Strawberry,"Caramelized onions","Cheese cheddar",Flour,"Original sauce"}	5
867	685	220	Saint Frank Coffee	5.35	http://mqtfwab.com/KlaOSdt.css	{Corn,Onion,Strawberry,Mushrooms,Bacon,"Bavarian sausages"}	4
868	1025	220	Chicken Pot Pie	2.80	http://icybhxl.com/xjBfNMg	{Salmon,"Bavarian sausages",Mozarella}	3
869	4322	220	Pizza Florida	7.72	http://tquxqts.biz/UqiIoJm.svg	{Potatoes,Mushrooms,Pasta,Chicken,"Cheese cheddar"}	4
872	6521	220	Pizza Ocean	7.73	https://www.nhgaiok.info/ibHxwGQ	{Nori,"Cheese cheddar",Butter,"Onion rings","BBQ sauce"}	2
873	7263	220	Angel Food Cake	5.32	http://vwqdioz.biz/kMXIqOc.webp	{Nori,Mayo,Salmon,Garlic,Mushrooms}	2
935	8673	222	Himawari	2.46	https://www.musuagj.org/	{Salmon,Pineapple,Grapes}	5
946	5331	222	Pizza Florida	2.31	https://yiadytr.info/fikSXZV.svg	{Cheese,Butter,Nori}	4
923	7471	222	Pizza	5.16	https://xfydhad.biz/nmAKBsL.webp	{"Onion rings",Pineapple,Butter,Chicken}	3
951	5999	222	Peanut Butter	4.24	https://www.oclfpal.org/jEneeff	{"Japanese tamago",Sugar,"Unagi sauce"}	5
986	5250	223	Tortellini Bowls	6.41	http://qelattj.org/GBgwCoK.html	{"Chili Pepper",Pineapple}	4
903	5783	222	Original burger	3.76	https://xbqjbal.edu/PWAFVUZ.webp	{Mushrooms,Potatoes,Meat,Butter,Salmon,Mushrooms}	1
987	5280	223	Crispy Chicken burger	5.55	https://cjdshvg.org/AuSjbJy.js	{"Caramelized onions",Milk,Garlic}	3
988	1421	223	Pizza Hawaiian	7.08	https://doxyhlr.biz/guOqwbO.jpg	{"Caramelized onions",Basil,"Caramelized onions",Flour,"Cream cheese",Chicken}	3
989	2571	223	Angel Food Cake	6.38	https://www.xxjolwb.ru/hYQxhQZ	{"Unagi sauce","Japanese tamago"}	4
990	1268	223	Pizza Italiano	5.01	http://www.kpstvxd.net/	{Strawberry,Peperoni,"BBQ sauce",Milk}	2
991	1121	223	New York Style Cheesecake	3.45	http://sayihis.net/sthluwT.svg	{Bacon,Peperoni,Basil,Peperoni,Mushrooms}	2
984	7465	223	Pizza Hawaiian	7.94	http://ealzcda.ru/aaseBFE.jpg	{Peperoni,"Japanese tamago"}	5
904	9812	222	Wallmart	2.46	https://rqdwgdh.ru/CJLYUPU.svg	{Carrots,Rice,Milk,"Cottage Cheese"}	5
911	1710	222	Himawari	2.12	https://vwrapbv.biz/GpZIoRM.webp	{"Unagi sauce"}	3
905	2023	222	Wallmart	3.00	http://www.orxbvbf.biz/lRtfVox	{Peanuts,Nori,Cucumber,Corn}	2
906	9358	222	Wallmart	2.12	https://kffzcif.net/	{Mayo,"Onion rings",Milk,Rice,Grapes}	3
907	4241	222	Unwrapped Burrito Bowl	4.06	https://bhideve.com/XysYljb.js	{Garlic,Peas}	2
909	38	222	Wallmart	7.37	https://cdvyvtz.ru/eiHwXCp.js	{Basil,Chicken,Peanuts}	4
916	425	222	Chicken Pot Pie	2.44	http://bowlfei.biz/TZRaVmw.css	{Meat,"Original sauce","Caramelized onions"}	5
902	3131	222	Pizza Texas	3.17	http://www.iawixch.org/	{Peanuts,Mozarella,Meat,"Caramelized onions"}	3
910	2246	222	Saint Frank Coffee	4.34	http://www.rgewcxu.top/	{Onion,Basil,Sugar,Grapes}	4
912	5465	222	Philadelphia with salmon	2.54	https://ptxsfnp.info/aPxWLFs	{Chicken,Carrots,Basil,"Onion rings"}	4
914	1921	222	Wallmart	5.99	https://dyzkxlx.biz/joKWZMJ.webp	{"Cottage Cheese",Sugar,"Chili Pepper",Peperoni,"Onion rings",Mayo}	1
921	5050	222	Swedish Meatballs	3.45	http://gvkwbmx.org/vUuPyAl.html	{Mushrooms}	4
915	9837	222	Unagi Philadelphia	5.84	http://gduimhb.biz/	{Peanuts}	2
917	2871	222	Unwrapped Burrito Bowl	7.28	http://ugvfwgx.edu/wiYpXli	{"Cheese cheddar"}	3
924	5109	222	New York Style Cheesecake	5.90	http://lsebyws.org/jbgWLdF.webp	{Peperoni,"Cream cheese",Cucumber,Potatoes,Carrots,Grapes}	5
919	2066	222	Unwrapped Burrito Bowl	2.46	https://www.wmbetqd.org/	{Peanuts,Sugar}	1
926	9586	222	Bean Green Chili Burritos	6.41	http://kcekbss.biz/AiPCOXS.css	{Grapes,"BBQ sauce","Japanese tamago",Mushrooms}	2
920	3946	222	Saint Frank Coffee	7.00	https://dwhefvt.info/TmoHshZ	{Peas,Meat}	2
922	1026	222	Pizza Texas	3.70	https://wmwcsgb.ru/duJSlgK.js	{"Cheese cheddar",Tomatoes,Garlic}	1
929	8751	222	Pizza Italiano	4.95	http://oavnhby.net/XclmJvF.jpg	{"Cottage Cheese",Cucumber,Peperoni}	3
908	8391	222	Crispy Chicken burger	7.14	http://vdfpswi.com/	{Flour,Mushrooms}	5
918	895	222	Sweet Potato Pie	7.69	https://oqrfrsh.top/Onqqwdk.js	{Potatoes}	1
927	6004	222	Sweet Potato Pie	5.48	http://klarovi.org/FDPaOll.svg	{Carrots}	1
928	6887	222	Pizza Ocean	6.21	http://pkwmozo.biz/CsUgJIE.css	{"Chili Pepper",Mozarella,"Cottage Cheese",Garlic}	1
913	3533	222	Himawari	3.52	http://www.ngppubr.top/hoAtfhA	{Flour,Peperoni}	4
930	1737	222	New York Style Cheesecake	3.09	http://soqnqrg.top/XUYtAWr.svg	{Pasta,"Cream cheese","Caramelized onions"}	5
931	7061	222	Peanut Butter	2.55	http://lrgyfrp.top/	{Bacon,"Original sauce",Peas,"Original sauce",Mozarella}	1
932	7533	222	New York Style Cheesecake	2.06	http://axtdywc.com/CSNGXYT.css	{Nori,Grapes,Flour}	3
925	820	222	Peanut Butter	3.14	https://www.ytyxgdh.com/	{Corn,Onion,Flour,Chicken,Mayo,Flour}	2
934	9229	222	Pizza Pepperoni with tomatoes	6.67	http://www.jekrdbb.com/	{Peanuts,Flour,Flour}	1
949	6559	222	Original burger	4.77	https://nhltraq.org/rrsCVud.svg	{Tomatoes,"Unagi sauce",Potatoes}	5
950	2607	222	Pizza Florida	6.77	https://anqqfgf.biz/WnooHsF.js	{Flour,Pasta}	1
998	8632	223	Bean Green Chili Burritos	2.65	http://kxfsrhd.org/EAhcwYb	{"Unagi sauce",Potatoes,Mushrooms,Garlic,Meat,"BBQ sauce"}	5
999	3596	223	Philadelphia with salmon	4.34	http://xtmriyt.org/CuUsQQa.php	{Milk,Milk}	3
976	4904	223	Peanut Butter	5.20	http://ysakugh.com/rxGWUhQ	{Mushrooms,Carrots,Garlic,Flour,"BBQ sauce"}	1
1002	3347	223	Peanut Butter	2.25	http://ndlfpco.net/nKgXWTb.css	{"Original sauce",Nori}	5
1003	3591	223	Pizza Italiano	5.46	http://www.gtxtbyi.org/	{"Japanese tamago",Pineapple,Milk,Corn,Grapes}	5
1031	9352	224	New York Style Cheesecake	3.73	https://www.rlnacyd.biz/	{Mushrooms,"Original sauce","Onion rings"}	4
1032	2862	224	Grape Jelly Sandwich	5.00	https://cjyixtt.org/mhQdaQb.html	{Tomatoes,Carrots,Sugar,"Bavarian sausages",Mushrooms,"Caramelized onions"}	4
1033	5821	224	Chicken Pot Pie	2.62	https://kbdvvvx.net/VDKyyeA.jpg	{Butter,Mushrooms}	1
1034	8434	224	Pizza	2.91	https://aogiruc.org/VpDBROw.jpg	{Peanuts}	5
1035	9366	224	Chicken Pot Pie	7.22	https://bfhlzaq.org/JXMPiZZ	{Corn,Rice,Strawberry,"Caramelized onions",Garlic,Mayo}	2
1036	1766	224	Pizza Pepperoni with tomatoes	5.98	http://dynljos.edu/	{Strawberry,Milk,Peanuts,Corn,Flour,Tomatoes}	5
953	3955	223	Tortellini Bowls	3.15	http://gjcjytn.top/LXWIvUa.webp	{"Unagi sauce",Mushrooms,"Onion rings",Flour,Bacon}	1
954	6449	223	Pizza Florida	2.82	https://hibllnd.biz/gnCtLyQ	{Flour,"Unagi sauce",Grapes,Cucumber,Grapes}	5
961	5000	223	Original burger	4.93	https://dnmqzle.info/aFYcjbD.svg	{Rice,Sugar,Peperoni,Butter,Mayo,Strawberry}	5
956	7531	223	Tortellini Bowls	4.21	http://ihersgc.info/Irfrcfy.webp	{"Bavarian sausages",Flour,"BBQ sauce"}	2
957	6230	223	Tortellini Bowls	2.08	https://hyjkvwt.biz/EJssNVb.jpg	{"Chili Pepper",Peas,"Bavarian sausages"}	3
958	1324	223	Pizza Florida	2.69	https://iqmpzkw.ru/EefofpP.svg	{Flour}	5
959	6352	223	Pizza	4.99	http://nhtfjrt.net/oRaOSLn.html	{"Cheese cheddar",Salmon,Chicken}	3
960	8654	223	Pizza Ocean	5.87	https://berjvsx.info/jUTGpql.jpg	{Salmon,"Chili Pepper","Original sauce",Mayo}	5
962	7892	223	Pizza Ocean	5.64	http://ljsqqdu.info/HUKdlJO.php	{"Cheese cheddar"}	3
955	2560	223	Crispy Chicken burger	2.26	http://cjfkaii.net/	{Meat,Carrots,Onion,Carrots,Cucumber}	4
963	5129	223	Pizza Ocean	3.61	https://phalypb.biz/uDZjbdU.css	{Sugar,Cheese,Chicken}	5
964	4999	223	Pizza Ocean	4.98	https://kwsthud.org/XJKaltK.svg	{Bacon}	4
965	2962	223	Bean Green Chili Burritos	7.90	https://pywbthd.top/nTJfDUR.js	{Pasta}	3
966	8065	223	Unagi Philadelphia	3.81	http://komsrwm.com/jvLPadI	{Peas,Pasta}	1
967	3497	223	Wallmart	6.48	https://ezmhvxz.edu/XKvmbMu.html	{Pineapple}	5
968	1914	223	Chicken Pot Pie	2.36	http://yfdlape.ru/vUeoPuY.css	{"Japanese tamago",Peanuts,"Caramelized onions"}	1
969	2178	223	Bacon Cheese Burger	2.68	http://daokiji.ru/HKoeVuh.webp	{Peas}	5
971	3826	223	Pizza Ocean	3.73	http://btsospy.net/qbCoUpT.css	{Meat,Onion,Strawberry,Milk,"BBQ sauce"}	2
972	5154	223	Pizza Texas	5.14	https://ygavbab.ru/TmUoKpt.jpg	{"Japanese tamago",Pasta,"Cheese cheddar"}	3
974	6578	223	Unwrapped Burrito Bowl	6.09	https://llryqst.top/qRQtTnv.html	{Pasta,Sugar,"Onion rings",Carrots}	4
975	3665	223	Pizza Hawaiian	3.81	http://www.kwxajpf.edu/jioWpvX	{Garlic,"Chili Pepper",Mayo}	1
977	3845	223	New York Style Cheesecake	7.96	http://qrbwngj.ru/LsejUyV.jpg	{Bacon}	1
979	8954	223	Chicken Pot Pie	4.62	http://yxlfume.edu/RasqLly.svg	{Sugar}	3
980	6752	223	Pizza Florida	3.71	https://rloscyn.top/xMrtqRl.js	{"BBQ sauce",Flour,"Caramelized onions"}	1
981	6035	223	Tortellini Bowls	5.73	http://ajwrcwe.net/OJOgWnA.html	{"Original sauce",Chicken,Sugar,Milk}	4
982	9454	223	Original burger	5.60	http://kggkkxo.top/FExYtVD.html	{"Onion rings",Pineapple,Sugar}	4
993	9587	223	Pizza Italiano	2.78	https://gradunu.info/NVOkcnQ.php	{"BBQ sauce",Tomatoes}	4
994	6864	223	Angel Food Cake	7.76	http://dpvjmos.com/IrCpaZK	{Basil,Carrots,Corn,"Cream cheese","BBQ sauce",Sugar}	5
995	6939	223	Pizza Texas	5.56	https://ntmzjms.edu/lhqQmXM.js	{"Unagi sauce","Bavarian sausages",Butter,Nori}	1
996	4049	223	Grape Jelly Sandwich	7.14	http://wdlfynb.net/kVAmDFv.html	{"Cream cheese","Onion rings",Peas,"Cheese cheddar"}	1
997	356	223	Grape Jelly Sandwich	2.56	https://qvafpyq.edu/ltERdYO.js	{Flour,Mushrooms}	2
1000	2409	223	Himawari	2.55	http://dhtidtn.top/EBdPrtb.html	{"Cottage Cheese"}	2
1001	5968	223	Philadelphia with salmon	6.35	http://www.kyeqktv.net/	{Pasta,"Unagi sauce",Corn}	4
1077	8515	224	New York Style Cheesecake	7.41	http://wqytilh.biz/gDIOMeE.webp	{Garlic,Chicken,Cucumber}	3
1078	9059	224	Pizza	2.54	http://stdmqby.ru/WQfECxs.css	{Flour,"Bavarian sausages",Carrots,Mushrooms,Corn,Onion}	4
1040	8607	224	Wallmart	7.23	https://vwxyahh.com/LyLoUbR.php	{Potatoes}	3
1081	7790	224	Pizza Florida	3.43	https://eudvpoi.com/IhVyGHH.php	{Strawberry}	5
1082	6074	224	Pizza	2.70	http://evmvflk.edu/wNygWBY.jpg	{Flour,Peanuts,Onion,"Bavarian sausages"}	3
1083	67	225	Himawari	2.21	https://www.potdsxr.com/JbKaJpj	{"Cream cheese",Garlic,Onion,"BBQ sauce"}	3
1005	5804	223	Himawari	7.63	http://ljjstaj.com/qxXFXLk.webp	{"Cheese cheddar","Unagi sauce",Meat,Butter,"Original sauce",Rice}	1
1006	6955	223	Swedish Meatballs	7.10	https://www.tmcankx.edu/	{Nori,"Cottage Cheese",Potatoes,"BBQ sauce",Carrots,Peperoni}	5
1007	5800	223	Pizza Ocean	3.25	https://zenmevx.top/AgAXlFW.svg	{Pasta,"Cottage Cheese"}	1
1008	979	223	Crispy Chicken burger	6.31	https://ybowgpp.org/sdkZqAQ.jpg	{"Japanese tamago",Pasta,Flour,Milk}	1
1009	9512	223	Swedish Meatballs	6.28	https://bvyliui.info/Asxbdnk.webp	{Milk,"Onion rings","Cream cheese",Garlic}	5
1010	1802	223	Pizza Florida	4.77	http://hoegpod.biz/fUKJWQf.html	{Grapes,Mushrooms,Bacon,Cheese}	4
1012	4123	223	Himawari	7.76	https://irwpafg.ru/HkZyVdE.webp	{Cheese,Rice,"Cottage Cheese",Cheese,Rice}	3
1015	9922	223	Pizza Ocean	6.24	http://plzcoqi.biz/ZMuQZYN.jpg	{Flour}	2
1014	8293	223	Pizza Hawaiian	7.75	https://qtildtx.biz/phWqeTV.webp	{Grapes,Peperoni,Bacon,Tomatoes,"Unagi sauce",Peanuts}	1
1027	2643	224	Grape Jelly Sandwich	3.52	https://ngfytie.top/KePWtGv.css	{Butter,Milk}	1
1016	8634	223	Saint Frank Coffee	2.40	http://www.rzbrigf.ru/lLXOllX	{Meat,"Unagi sauce",Sugar,Carrots}	5
1017	1145	224	Pizza Pepperoni with tomatoes	2.01	http://www.diwivwg.ru/	{Mushrooms,Sugar,Pasta,Potatoes}	5
1018	6566	224	Grape Jelly Sandwich	5.94	https://xwnfnmw.ru/yvUDmCa.webp	{"Cottage Cheese",Mozarella}	4
1019	6481	224	Pizza Texas	6.81	https://zqpkvrm.info/pZltpEj	{Peanuts,"Cream cheese","Original sauce"}	5
1021	9933	224	Original burger	3.99	http://xgdhvib.edu/	{Mushrooms,Mayo,"Original sauce",Bacon,Mushrooms}	3
1022	2258	224	Saint Frank Coffee	3.68	http://juackwo.info/SpBxDTc.html	{Chicken,"Bavarian sausages",Peanuts,Bacon}	3
1023	6465	224	Pizza Ocean	7.51	https://fdbiwoc.org/	{"Chili Pepper",Flour,Milk,Potatoes,"Original sauce",Garlic}	1
1024	9934	224	Philadelphia with salmon	6.60	https://xufnpro.edu/Hnpyder.svg	{Grapes}	4
1025	1172	224	Pizza Texas	6.52	http://bycglyx.ru/SmgdJym	{"Chili Pepper",Onion,Peas,Chicken,"Chili Pepper",Mozarella}	4
1026	5097	224	Pizza	3.33	https://www.nayeqoc.org/	{Garlic,"Cheese cheddar",Cheese,"Bavarian sausages",Cucumber,Basil}	4
1013	6761	223	Pizza Pepperoni with tomatoes	3.55	http://fmthjlw.biz/CauxmIj.jpg	{"Original sauce",Flour,Garlic,"Original sauce",Pasta}	3
1028	2173	224	New York Style Cheesecake	6.83	http://mpdgadm.top/ipKJfYZ.svg	{Garlic}	1
1029	7522	224	Chicken Pot Pie	6.56	https://bcdtabb.com/idJMcGg.php	{Corn,"Bavarian sausages",Milk,Tomatoes}	1
1038	9626	224	Pizza Pepperoni with tomatoes	6.48	https://tedhnax.info/AQMyXIE.webp	{Rice,Pineapple,Meat,Mayo,Mayo,Garlic}	4
1039	2896	224	Pizza	3.55	http://ydllqmj.ru/	{Peanuts,Sugar,Carrots,Cucumber,"Chili Pepper",Strawberry}	3
1041	673	224	Pizza Florida	7.79	https://cxllwgb.biz/CkfjLlC.jpg	{"Original sauce",Carrots,Flour,Tomatoes,Rice}	1
1043	4298	224	Pizza Ocean	2.79	https://hsbcycz.net/DGOqPxG.jpg	{Peanuts,Sugar}	1
1045	443	224	Saint Frank Coffee	7.51	https://eowchnt.info/jJimNvs	{"Cream cheese"}	2
1046	2613	224	Wallmart	6.53	http://ienakoi.org/OVgykmc.css	{Cucumber,Mayo}	2
1047	6302	224	Chicken Pot Pie	4.47	http://ewinmjq.com/GhIxGbR.webp	{Butter,Flour,Sugar,"Cheese cheddar",Grapes}	4
1048	5341	224	Pizza Italiano	5.79	http://ahvqhpi.biz/dakGiyy.jpg	{Rice}	4
1049	3007	224	Pizza Italiano	3.36	https://www.ajywqgs.com/lxTXFap	{Butter}	1
1050	2136	224	Grape Jelly Sandwich	7.40	http://tejcfow.ru/nGwQxGF.html	{Flour}	2
1051	6255	224	Saint Frank Coffee	4.49	https://bmdtsbu.info/qUWnxDf.js	{"Cheese cheddar",Bacon,Flour}	3
1076	9611	224	Philadelphia with salmon	4.96	https://tbosagv.org/xacBAgt.webp	{Peanuts,Rice,"Cottage Cheese",Meat,"Onion rings"}	3
1079	2786	224	Pizza Pepperoni with tomatoes	7.44	https://www.jsiqeli.edu/	{Peanuts,Peperoni,Chicken}	5
1080	5636	224	New York Style Cheesecake	2.63	http://ktjdlxb.com/wMyokDb.jpg	{"BBQ sauce"}	4
1124	9467	226	Chicken Pot Pie	5.74	http://evelfbg.top/mqZqgor.js	{Flour,Bacon,"Cottage Cheese",Bacon,Garlic}	2
1125	2189	226	Swedish Meatballs	5.75	https://ocknuxv.ru/rpUAIRM.webp	{"Caramelized onions",Mushrooms,"Onion rings",Flour}	2
1089	5504	225	Bean Green Chili Burritos	5.36	https://hakyfvj.com/wJlUERG.webp	{Onion,"Chili Pepper",Cucumber}	2
1128	5136	226	Saint Frank Coffee	4.51	https://uynilyj.biz/CkUlvZS.jpg	{"Japanese tamago",Peas}	2
1129	6901	226	Angel Food Cake	5.57	http://www.ovlpafi.top/	{Bacon,Mushrooms,Rice,Grapes}	4
1150	9516	226	Saint Frank Coffee	3.96	http://fnhyrqh.ru/NUsftiS.svg	{"Chili Pepper",Bacon,Milk}	2
1053	2398	224	Bean Green Chili Burritos	3.31	https://vimustm.top/jdTKGTr.jpg	{Rice}	4
1054	782	224	Pizza Florida	5.98	https://www.lcwrfqx.com/	{"Bavarian sausages"}	5
1055	6434	224	Bacon Cheese Burger	4.32	http://vxgvogb.top/BCGxhvi	{Milk,Basil,Carrots,Meat,"Japanese tamago",Mushrooms}	4
1056	4986	224	Pizza Hawaiian	2.11	http://www.jbuygot.top/	{Flour,Corn,Mozarella,Basil,Mushrooms,Pasta}	5
1057	8194	224	Saint Frank Coffee	4.32	https://gbpjkka.org/aguCIsK.html	{Peas,"Chili Pepper",Flour,Corn,Tomatoes,Cucumber}	2
1058	8713	224	Bean Green Chili Burritos	4.34	https://www.xcimshe.edu/WXxlyLJ	{Tomatoes,"Cream cheese"}	5
1059	6627	224	Unwrapped Burrito Bowl	5.85	http://osalvtw.net/IbQGVEY.jpg	{Peas,Milk,Tomatoes,"BBQ sauce"}	3
1060	5924	224	Pizza Ocean	6.18	https://www.homdqsi.biz/	{Meat}	1
1061	3104	224	Wallmart	4.56	https://jdoonta.net/UMcKhoO.jpg	{Peanuts,Nori,Nori,Peas,Peas}	5
1062	5037	224	Pizza Texas	2.19	http://dgivmru.top/	{Basil,Peanuts,Peas,Peas,Peanuts,Garlic}	2
1063	1159	224	Pizza Ocean	5.85	http://jdwkrrk.top/FpFAYTY.js	{"Cottage Cheese"}	1
1064	7785	224	Pizza	6.65	https://kiyumep.biz/tUGMtEB.jpg	{Carrots,Peanuts,"Cream cheese",Rice,"Cottage Cheese",Pineapple}	3
1065	2025	224	Sweet Potato Pie	4.32	http://vwswvqt.org/jTCJRDC.php	{Peanuts,Mozarella,Mozarella,"Chili Pepper",Carrots,Onion}	5
1067	1065	224	Pizza Italiano	6.77	https://www.rrujdfb.biz/	{Mozarella,"BBQ sauce","Bavarian sausages"}	1
1068	9789	224	Angel Food Cake	2.77	http://redxees.biz/	{Bacon,Meat,"Original sauce",Onion,Corn,Peas}	3
1069	8122	224	Swedish Meatballs	2.29	https://sxvuyro.org/ToLISay.js	{Peas,Onion,Carrots}	4
1070	9609	224	Saint Frank Coffee	4.77	https://lvdylcn.edu/SKkrgyu	{"BBQ sauce",Basil,Pasta,Grapes,Bacon}	2
1071	2310	224	Angel Food Cake	7.13	http://www.mibvtcj.org/	{Milk}	2
1072	7630	224	New York Style Cheesecake	4.95	https://nmuulkx.info/TCkxDZV.webp	{Pasta,"Cream cheese",Basil,Mozarella,Nori}	5
1073	4433	224	Sweet Potato Pie	6.13	http://xtjbqxf.top/fHxLSOr.svg	{Mayo}	4
1074	1259	224	Peanut Butter	6.37	https://hydywpj.biz/hrVEJrB.webp	{Tomatoes,"Cream cheese",Carrots}	2
1085	3351	225	Tortellini Bowls	6.26	http://lgvhoxg.ru/cTDyydR.js	{"Chili Pepper","Japanese tamago","Unagi sauce",Cucumber,"Japanese tamago","Unagi sauce"}	2
1086	920	225	Tortellini Bowls	6.92	http://lysrfsa.info/HwsWobS.php	{Pasta,"Cottage Cheese",Meat}	5
1087	58	225	Saint Frank Coffee	5.79	http://ldyzrbr.top/JhyQibt.jpg	{Chicken,Mayo,Pasta,"Unagi sauce"}	5
1088	4427	225	Philadelphia with salmon	4.62	http://hkognhn.org/nYZrodr.html	{Flour,"Chili Pepper",Flour,Carrots,"Original sauce"}	3
1090	5549	225	Pizza Italiano	7.39	http://judxusn.org/tbHuKXG	{"Unagi sauce"}	1
1091	5601	225	Pizza Pepperoni with tomatoes	5.75	https://rstoxhg.org/tJqWVWB.php	{Milk,Nori,Rice,Strawberry}	5
1092	6609	225	Chicken Pot Pie	7.92	http://eduviht.net/tjTkNgR	{Pasta,Mozarella,Pineapple}	4
1093	9049	225	Chicken Pot Pie	2.95	http://kjheasp.edu/HgJwMpe.webp	{Chicken,Cucumber,"Chili Pepper",Pasta,Mushrooms}	3
1094	7306	225	Swedish Meatballs	2.74	http://www.ywprnuk.net/RqBXULT	{Butter,Mozarella,Bacon,Tomatoes}	2
1095	8130	225	Himawari	2.41	http://bmjmuxy.net/agUtlbo.webp	{"Japanese tamago"}	5
1096	91	226	Swedish Meatballs	3.30	http://dcxegsp.info/XPmMbIX.css	{Pineapple,Garlic,Mozarella}	2
1097	5860	226	Himawari	2.14	http://uvvpdlt.org/qmykuNa.svg	{Corn}	2
1098	9946	226	Pizza Hawaiian	4.18	https://bnbytrr.ru/wXVPnaR.php	{Rice,"Chili Pepper",Basil}	3
1123	3014	226	Unwrapped Burrito Bowl	5.31	https://ynhlmqn.top/	{Nori,Basil,Flour,Basil}	4
1126	2383	226	Original burger	4.55	https://lapkfld.com/BhkQTaM.php	{Peanuts,"Cottage Cheese",Basil}	1
1127	8079	226	Angel Food Cake	5.55	http://www.wlbudpv.edu/dVqsnHQ	{"Caramelized onions",Pasta,"Bavarian sausages","Cheese cheddar",Peperoni,Bacon}	1
1145	4942	226	Unagi Philadelphia	5.57	https://phlecwt.org/bHQWMPQ.jpg	{Mayo,Pineapple}	2
1146	9518	226	Grape Jelly Sandwich	5.49	http://rsgvuqs.edu/tipSBvS.html	{"Cheese cheddar",Grapes}	2
1141	6942	226	Angel Food Cake	6.53	http://www.fkkoynl.org/	{Mayo,Potatoes,"Cream cheese","Cream cheese",Mozarella}	1
1149	4978	226	Grape Jelly Sandwich	3.48	http://ndpobab.top/RjNtZHJ.js	{Mozarella,Meat,Tomatoes,Pasta,"Japanese tamago",Mozarella}	3
1169	710	227	Himawari	2.56	https://cygodbf.edu/ypZyYmo.js	{"BBQ sauce","Chili Pepper","BBQ sauce",Mozarella,Basil}	1
1171	780	227	Pizza	5.97	http://pvslvez.info/eWBvhKb.jpg	{Meat,"Caramelized onions"}	4
1172	1933	227	Pizza	6.93	https://gdjrdhl.top/jaoVqyI.html	{Bacon}	1
1173	9397	227	Himawari	6.23	http://ljfbkgv.biz/DtHhZdq.jpg	{"Cottage Cheese",Pineapple,Milk,Flour,Nori,Flour}	5
1174	9499	227	Tortellini Bowls	2.48	http://kxqyyep.biz/NSlveZi.php	{Nori,Corn,Garlic,"Cheese cheddar",Rice}	2
1175	7406	227	Philadelphia with salmon	2.31	http://rmfiagp.com/nJWJcCK.svg	{Corn,Grapes,"Cheese cheddar","Cream cheese",Pineapple,Cheese}	3
1176	7609	227	Chicken Pot Pie	4.43	http://lqjcqgb.info/yxhagEU.jpg	{Nori,Carrots,Tomatoes,"Cheese cheddar"}	5
1108	8581	226	Crispy Chicken burger	7.14	http://efostjx.top/duKwqNR.css	{Flour,Grapes,Mozarella,Mushrooms,Peas,"Onion rings"}	3
1101	6065	226	Chicken Pot Pie	4.80	https://fernxjm.info/jEMPgYN.html	{"BBQ sauce",Sugar,"Cottage Cheese"}	1
1103	8690	226	Philadelphia with salmon	2.46	http://ghevqmx.info/lYeIWMS.html	{Salmon}	3
1104	4953	226	Unwrapped Burrito Bowl	6.31	https://www.wrmafek.net/	{"Cream cheese",Flour,Flour,Chicken,Garlic}	4
1105	3543	226	Saint Frank Coffee	3.11	http://ghojajx.com/mPmmsOd.js	{Garlic,Potatoes}	4
1106	6985	226	Pizza	2.05	https://www.qkkodle.net/	{Cucumber,Rice,Peanuts}	5
1114	8780	226	Grape Jelly Sandwich	7.37	http://cixqdvs.org/cSdwwQL	{Basil,"BBQ sauce",Bacon}	2
1109	9880	226	Pizza Ocean	3.18	http://iokferq.biz/	{"Japanese tamago",Milk,Cucumber,"BBQ sauce"}	3
1116	657	226	Bacon Cheese Burger	4.47	http://emvpice.ru/wfcteCs.css	{Sugar,Basil}	3
1102	1051	226	Sweet Potato Pie	5.25	https://www.ownoits.net/IjvFjbP	{Rice,Flour,"Cheese cheddar"}	2
1118	3486	226	Original burger	2.95	http://xrzphxt.net/VDIsTDS.svg	{Peanuts,"Cream cheese"}	3
1111	9069	226	Peanut Butter	5.26	https://wsvfofn.top/GeJhSVn.css	{Cheese,Pasta,"Caramelized onions",Mushrooms}	5
1112	5234	226	Swedish Meatballs	7.09	https://ucxfhdy.com/xetSFPj.webp	{"Cottage Cheese",Bacon,Mozarella}	4
1115	8698	226	Unagi Philadelphia	7.83	http://gktpzva.com/vdJRIGu.html	{"Original sauce"}	5
1107	8586	226	Swedish Meatballs	5.21	https://www.zjsbyjs.org/RPmUYtj	{Carrots,Flour}	5
1135	9125	226	Chicken Pot Pie	2.63	http://oioljnh.com/	{Mayo}	4
1110	97	226	New York Style Cheesecake	3.85	http://kfisskc.biz/IFqLOmE.css	{Pasta,Pasta}	5
1137	6722	226	Bean Green Chili Burritos	3.53	https://bqsqlgu.ru/rQxYaAV.css	{Onion,"Caramelized onions",Flour,Garlic,"BBQ sauce"}	1
1132	4701	226	Grape Jelly Sandwich	7.03	https://www.hbmqnog.edu/sJbLmPx	{Cucumber,"Cream cheese","Chili Pepper",Grapes,Flour,Mozarella}	3
1133	2886	226	Sweet Potato Pie	3.28	https://azhoybj.com/nrtViTp.html	{Mayo}	4
1113	6243	226	Swedish Meatballs	5.45	https://qfgaxvp.edu/JCOlNCa.webp	{"Onion rings","Cottage Cheese"}	2
1136	6254	226	Peanut Butter	7.96	https://ndskiib.net/	{Nori,"Bavarian sausages",Onion,Cheese}	4
1117	6034	226	Crispy Chicken burger	5.59	https://tssxabq.net/uOhlNwv.css	{"BBQ sauce","Original sauce"}	5
1138	9921	226	Sweet Potato Pie	3.77	https://segftkf.top/	{Milk,Grapes,Rice,Salmon}	3
1120	3004	226	Wallmart	5.48	http://whlkwmg.net/LSlDeZR	{"Cottage Cheese"}	4
1139	1348	226	Philadelphia with salmon	5.58	https://fubnwoz.info/IuFvuFB.css	{Corn,Mushrooms,Tomatoes,"Bavarian sausages"}	3
1140	7311	226	Pizza Ocean	3.52	https://www.ujnlcpl.net/	{Mozarella,"Original sauce",Rice,Flour,Pineapple,Cucumber}	3
1142	6072	226	Grape Jelly Sandwich	2.86	https://pgcfifh.info/XXWSFuD.css	{Flour}	2
1134	2969	226	Saint Frank Coffee	3.64	http://tdjnffr.edu/cNyBcNa.css	{Peperoni,"Caramelized onions"}	5
1143	9330	226	Unagi Philadelphia	2.77	http://psewcdi.com/rFNrOEC.jpg	{Peas}	1
1144	2481	226	Saint Frank Coffee	4.04	http://nrkjpad.biz/	{"Chili Pepper",Strawberry,Potatoes,"Cream cheese","Cottage Cheese"}	3
1147	9597	226	Unagi Philadelphia	4.96	https://lemqtzw.ru/NYXKSvB.js	{Mozarella,"Japanese tamago","Original sauce","Chili Pepper",Peperoni}	1
1148	9607	226	Pizza	4.70	https://lurmtfr.info/	{"BBQ sauce",Potatoes}	5
1200	951	228	Saint Frank Coffee	5.29	http://www.mjtgyjr.ru/	{Pasta,Peanuts,Flour,Meat}	2
1185	292	228	New York Style Cheesecake	6.23	http://duzcfci.ru/MkmFCej.svg	{Grapes,Chicken,Pineapple}	4
1189	2022	228	Pizza	6.11	https://www.lqxdddn.top/	{"Bavarian sausages",Cucumber,Mozarella,Onion,Cucumber}	4
1216	4154	228	Angel Food Cake	7.43	https://xunsoee.com/	{Butter,"Original sauce",Strawberry}	1
1219	9213	228	Crispy Chicken burger	6.52	http://mnwppgj.top/NcMtxCW.js	{Peperoni}	4
1218	6638	228	Crispy Chicken burger	6.90	http://gstbevn.edu/ZdMYrPG.svg	{Pasta,Mayo,Salmon,Mushrooms,"Original sauce"}	5
1191	971	228	Philadelphia with salmon	5.48	http://ohnavcr.com/	{Pineapple,"Onion rings","Japanese tamago",Cucumber,Carrots}	5
1220	3557	228	Sweet Potato Pie	3.55	https://ldyjcvc.com/KjOgaAY.css	{Cheese}	4
1251	2671	229	Pizza Hawaiian	4.32	https://uvoysfx.org/vrTgWwC.svg	{"Japanese tamago",Chicken}	2
1222	9915	228	Wallmart	4.72	http://bptexgh.ru/YPGmnBK.svg	{Garlic,"Bavarian sausages",Pasta}	5
1195	3372	228	Pizza Florida	4.75	http://rnzuydi.com/mAdFCKc.js	{"BBQ sauce","Bavarian sausages",Potatoes,Peanuts,Mozarella}	1
1152	2953	226	Pizza Ocean	6.16	http://vrrtdok.info/	{Strawberry,Mozarella,Cucumber,Meat,Pineapple,Peas}	4
1153	599	226	Himawari	4.10	https://egycxpg.edu/	{Mayo,"Bavarian sausages",Pasta,Rice,Flour}	3
1154	2458	226	Original burger	6.31	http://ltlxpec.com/HXrZuxA.html	{Garlic}	3
1155	4851	226	Pizza Pepperoni with tomatoes	4.20	http://ylpyofr.net/CYamUDu.js	{Peperoni,Chicken,Rice}	5
1156	7376	226	Pizza Florida	7.05	http://rhdddne.net/LMQEstc.php	{Chicken,Mushrooms,Nori}	5
1157	3396	226	Crispy Chicken burger	7.78	http://uedqljv.info/MstfPhU.php	{Cheese,"Bavarian sausages",Peperoni,Rice}	4
1158	4686	226	Pizza Ocean	5.66	https://svtemvk.ru/UmFpkcQ.php	{Mayo}	4
1159	2966	226	Swedish Meatballs	2.46	http://www.stmpuux.biz/ItkGafA	{Potatoes,Cucumber,"Original sauce"}	5
1186	1499	228	Pizza Pepperoni with tomatoes	5.42	https://pmuuktf.edu/jjFrFqm.jpg	{Mayo,"Cream cheese","BBQ sauce",Mushrooms}	1
1187	8386	228	Chicken Pot Pie	4.91	http://lhfjsjg.info/jbbRnDR.svg	{"Chili Pepper",Butter,"BBQ sauce",Pasta,Onion}	5
1163	2825	226	Chicken Pot Pie	2.10	http://www.rbyblds.org/	{Nori}	1
1164	1194	226	Unagi Philadelphia	2.85	http://www.rrodfhr.biz/XUTXVCv	{Cucumber,Cucumber}	4
1165	2553	227	Himawari	8.00	https://dxrallu.top/	{Mayo}	3
1167	806	227	Bacon Cheese Burger	4.31	https://www.rqxusqv.com/	{Milk}	5
1192	4897	228	Bean Green Chili Burritos	3.60	https://rfmlvrq.org/mniXJDI.php	{"Original sauce"}	3
1179	1472	228	Bean Green Chili Burritos	2.16	http://wrsapry.com/uCEdZOA	{Sugar,"BBQ sauce",Chicken,Cheese}	5
1178	4275	228	Saint Frank Coffee	7.79	https://tbsxaej.ru/	{"Bavarian sausages","Cream cheese",Corn,Basil}	3
1183	2308	228	Chicken Pot Pie	3.64	http://rybtake.top/FriSfpn.js	{"Bavarian sausages",Meat,Flour,"Cream cheese","Caramelized onions",Milk}	2
1181	1748	228	Original burger	7.06	http://tnfiivx.top/	{Cheese,Tomatoes,Meat,Peperoni,Mozarella,Flour}	5
1197	5072	228	Peanut Butter	4.69	http://mneazxb.net/YSgbMdI.svg	{Salmon,"Bavarian sausages",Peanuts,"Japanese tamago","Cream cheese",Cheese}	3
1184	690	228	Tortellini Bowls	3.86	https://bndahko.net/elQcHTS.js	{"Chili Pepper","Original sauce",Garlic,"Cream cheese"}	2
1160	7459	226	Pizza	4.07	http://www.xakradh.top/qybfrjw	{"Caramelized onions",Pineapple,Mozarella}	3
1201	5483	228	Grape Jelly Sandwich	7.95	http://www.qrtkczl.ru/LJEoAcv	{Peperoni,"BBQ sauce",Nori}	2
1190	593	228	Angel Food Cake	5.23	http://crkaugi.biz/WfrrHHM.js	{Cheese,"Japanese tamago"}	4
1161	4660	226	Chicken Pot Pie	3.61	http://pltnvfc.biz/jaMITOr	{Butter,Strawberry,Tomatoes,Rice,"Onion rings"}	4
1194	6060	228	Tortellini Bowls	6.50	https://rqrjoer.org/	{"Onion rings",Basil,Pasta,Milk}	3
1193	1287	228	Bean Green Chili Burritos	7.72	https://mkiyini.org/VIJquuQ.css	{Peperoni,Peperoni,Butter,"Chili Pepper"}	2
1196	2915	228	Pizza Florida	2.65	http://poeurtu.info/NvjBxUl.webp	{Garlic,Salmon,Corn,"Caramelized onions"}	4
1221	6069	228	Pizza Pepperoni with tomatoes	2.05	http://ojcfhei.top/cIEHdWJ.svg	{Chicken}	4
1198	7104	228	Original burger	2.67	https://ivwsldp.biz/wfGaslO.php	{Peperoni}	2
1199	5265	228	Chicken Pot Pie	4.82	https://bjhapbi.org/EgGAxnY.jpg	{Grapes,"BBQ sauce",Meat}	5
1188	472	228	Original burger	3.49	https://xhskoht.top/qrFEKLT	{Carrots,Grapes,"BBQ sauce","BBQ sauce",Basil,"Japanese tamago"}	5
1217	3667	228	Pizza	7.57	http://vdazhsf.net/	{"Bavarian sausages","Cheese cheddar"}	5
1250	3261	229	Tortellini Bowls	6.11	https://lgphmqv.org/LvmVlho.svg	{"Cream cheese","Chili Pepper","Original sauce",Strawberry}	4
1238	7679	229	Saint Frank Coffee	6.94	https://prfmsqa.info/MLZtYxS.webp	{Pineapple}	3
1262	5873	229	Chicken Pot Pie	5.83	https://chkumas.edu/WjyTOhZ.php	{Pasta,Nori,Rice,Milk,Flour}	5
1266	8210	229	Bacon Cheese Burger	4.07	http://www.bchnepj.net/	{Peanuts,Tomatoes}	4
1267	1651	229	Sweet Potato Pie	6.12	https://tifngdy.edu/lsKsoWQ	{Sugar,"Caramelized onions","Onion rings",Corn}	1
1268	4679	229	Unagi Philadelphia	6.64	https://xjbtfuv.info/xCXxEYg	{"Caramelized onions",Tomatoes,Corn,"Caramelized onions",Peas,"Bavarian sausages"}	5
1203	5338	228	Tortellini Bowls	4.55	http://obhkivt.org/vBQGsKE.webp	{Potatoes,Pasta,Garlic,Cucumber,Milk,"Unagi sauce"}	5
1204	8957	228	Original burger	4.44	https://www.fbmqeay.org/	{"Unagi sauce",Sugar}	5
1205	1822	228	Pizza Ocean	2.96	http://www.xkaeipw.biz/	{Carrots,Butter,Mayo,"Original sauce",Grapes,Basil}	1
1206	1306	228	Angel Food Cake	3.29	https://apikqlo.edu/xDyuIaC	{Onion,"BBQ sauce",Nori,Corn,Onion,Rice}	5
1207	1727	228	Himawari	4.29	http://eafxvph.edu/vJubBBE.css	{Corn,Mushrooms,Peperoni,Sugar}	1
1208	328	228	Pizza Ocean	2.96	http://qocbkwj.top/VqhbUvw	{Cucumber,"Cottage Cheese"}	1
1209	7360	228	Grape Jelly Sandwich	4.62	http://zgwcsxd.com/plaOLyY.js	{Mozarella,Rice,Basil}	2
1210	8838	228	Pizza Pepperoni with tomatoes	5.62	http://svigwwj.edu/rSjhMGX	{Chicken,"Unagi sauce"}	5
1211	5044	228	Unwrapped Burrito Bowl	3.81	https://piniqum.ru/isXXMWT	{Pineapple,Strawberry,Peas,Pineapple,"Cream cheese",Cucumber}	1
1212	8835	228	Pizza Florida	5.96	http://www.ddigbeg.com/nkqiwZN	{Onion}	3
1213	8762	228	Bacon Cheese Burger	6.86	http://www.jyqsdmw.edu/	{"Cheese cheddar"}	5
1214	888	228	Pizza Texas	2.15	https://foghaoe.edu/	{"Cream cheese","Cream cheese"}	3
1224	6879	228	Tortellini Bowls	7.73	https://natjajz.net/kRyVHrF.svg	{Bacon}	2
1225	1561	228	Bean Green Chili Burritos	6.95	http://www.ysevhkg.top/	{"Cream cheese",Strawberry,Pasta,Basil}	2
1226	3247	228	Pizza Florida	6.20	https://sswleug.ru/Ukdpiuv.jpg	{Strawberry,Flour}	1
1227	6217	228	Saint Frank Coffee	2.17	https://www.qnvbvmy.net/imyYsGi	{Salmon,Onion}	2
1228	9205	228	Saint Frank Coffee	5.40	http://www.thycrab.com/NPWroPi	{"Unagi sauce","Original sauce",Basil,Corn,Grapes}	4
1230	703	228	Wallmart	5.96	http://dwzzgqw.org/	{Basil,Salmon,Pasta,Chicken,Onion,Grapes}	1
1231	8317	228	Sweet Potato Pie	2.49	https://zpgfxqj.ru/gSRnflq.jpg	{Cucumber,"Onion rings",Sugar,Grapes,Sugar,Mushrooms}	4
1232	6304	228	Pizza Ocean	5.71	https://bheqjdj.top/PRTsSQr.php	{Strawberry,Bacon,Milk,Tomatoes,Meat,Nori}	5
1233	8103	228	Sweet Potato Pie	7.39	http://vxsmaut.top/	{Carrots,"Onion rings",Peperoni,Pineapple}	3
1234	6075	228	Pizza Florida	2.31	http://dsocstb.biz/KQytnFp.html	{Meat,Peperoni,Mayo,Carrots,"Bavarian sausages",Basil}	1
1235	2558	229	Pizza	4.73	https://www.fxmggqq.ru/NhEXKSa	{Peanuts,Flour,Flour}	2
1236	8068	229	Unagi Philadelphia	4.41	https://qxikfub.ru/	{Grapes,"Bavarian sausages","Onion rings",Flour,Cucumber}	5
1237	3501	229	Chicken Pot Pie	4.93	https://befnpvo.edu/PekjPCt.js	{Strawberry,Nori,Mushrooms,Carrots}	4
1239	6272	229	Philadelphia with salmon	7.50	http://tzdiopo.net/CiZYJkv.css	{"Japanese tamago"}	2
1240	6773	229	Pizza Hawaiian	2.06	http://ksgsbsq.top/JJiqYOT.js	{Cheese,"Onion rings",Pasta,Sugar}	3
1241	8496	229	Unwrapped Burrito Bowl	4.65	http://ukizuhj.ru/YoEXSba.webp	{Flour,Grapes,Butter,Mozarella}	4
1242	3069	229	Pizza	4.56	http://tkszstd.top/QKqnpQS.js	{Potatoes,Garlic,Strawberry,Pasta}	2
1243	1132	229	Sweet Potato Pie	6.31	http://jfeduuw.ru/YkBmOUs.svg	{"Cheese cheddar",Chicken,Corn,Corn,Rice}	5
1244	2042	229	Pizza Florida	6.52	http://osruqxe.edu/INNYHvL.svg	{Mozarella,Garlic}	4
1245	5094	229	Grape Jelly Sandwich	2.28	http://ksqktwc.net/	{Strawberry,Pasta,Carrots,"Cream cheese",Bacon}	1
1246	2901	229	New York Style Cheesecake	7.93	https://ewpgaez.top/	{Cheese,Pineapple,Pineapple,Meat}	4
1247	3305	229	Sweet Potato Pie	2.91	https://jharkvb.ru/IMLTDfS.jpg	{Rice,"BBQ sauce","Chili Pepper"}	4
1249	5396	229	Pizza Ocean	4.90	http://www.bqevkpc.edu/	{"Japanese tamago",Salmon,"Chili Pepper",Pasta,Flour}	2
1264	2660	229	Pizza Italiano	3.98	http://www.agloamo.ru/qLXYGDY	{Milk}	4
1265	5095	229	Tortellini Bowls	5.14	http://tupbymn.edu/TUhaWqX	{Cucumber,"Caramelized onions"}	1
1313	6637	230	Crispy Chicken burger	4.18	http://wipoiyp.com/	{Milk,Carrots,Mushrooms}	1
1296	3297	230	Pizza Hawaiian	3.91	https://dztpvbd.top/	{"Unagi sauce",Cucumber,Pineapple}	3
1253	7389	229	Pizza Texas	4.75	http://xbmxyxl.edu/vgcyVmZ	{Peanuts,Peas,"Original sauce",Peas}	3
1254	4612	229	Pizza Texas	3.91	https://www.vutgdeq.info/tPRoXfv	{Nori,Pasta,"Cream cheese",Basil}	5
1257	9095	229	New York Style Cheesecake	5.67	http://hwoqwml.ru/LNRghqF.jpg	{Pineapple,Nori,Pineapple,Nori,"Onion rings"}	1
1281	9927	229	Philadelphia with salmon	5.32	http://qdzzlmn.ru/EkJRFZe.svg	{Peanuts,Mozarella,Mayo,Bacon,Pineapple,Sugar}	1
1259	7141	229	Himawari	6.48	http://civkjnt.edu/xdWOKUU.webp	{Salmon}	5
1260	9407	229	Sweet Potato Pie	5.50	https://www.pkmffzk.com/	{Rice,"Chili Pepper",Nori,Mozarella,"Cream cheese"}	3
1272	5612	229	Tortellini Bowls	4.47	https://ucsrclt.biz/FVyUbGR.svg	{Peanuts,"Unagi sauce","Japanese tamago",Sugar,Tomatoes}	1
1310	1157	230	Chicken Pot Pie	7.60	http://www.oejgfya.org/	{"BBQ sauce",Pineapple,Strawberry,"Japanese tamago",Basil}	3
1274	5441	229	Himawari	7.26	https://www.nsquhwi.ru/oFXrJBo	{Peanuts}	3
1271	168	229	Swedish Meatballs	6.81	http://pjocybw.top/TdigqNH.svg	{Sugar,Cucumber}	3
1275	4136	229	Peanut Butter	4.80	https://www.uqdlzxi.biz/	{Mozarella,"BBQ sauce",Pasta,Garlic,Butter,"Unagi sauce"}	5
1276	8842	229	Pizza Texas	5.39	https://khdxgma.edu/vpAiEed.html	{"Unagi sauce",Peanuts,"Caramelized onions",Potatoes,Carrots}	3
1277	4077	229	Pizza Texas	3.81	https://ohlxapf.top/dgGMJMv	{Peperoni,Bacon,Mushrooms,Mozarella}	2
1278	9348	229	Chicken Pot Pie	5.33	https://qflvbia.edu/aDSJLZt.svg	{Milk,Peperoni,Tomatoes,Cheese,Salmon,Flour}	4
1283	1806	229	Wallmart	4.99	http://enntstp.info/gtrvvxb.html	{"BBQ sauce","Unagi sauce"}	5
1282	2790	229	Unagi Philadelphia	4.12	https://www.fdpotis.net/	{"Chili Pepper",Peperoni,Butter}	2
1258	1702	229	Pizza Italiano	2.80	https://pksamhq.biz/	{Nori}	3
1284	8412	229	Peanut Butter	5.66	https://www.seusipv.biz/kPZjXpP	{Pineapple,"Japanese tamago",Chicken,"BBQ sauce","Caramelized onions",Rice}	1
1285	7919	229	Crispy Chicken burger	4.02	https://aedxhbp.net/BHNdOQN.html	{Basil}	5
1287	6775	229	Bacon Cheese Burger	2.73	http://khefncc.net/GDyFWdu.svg	{Bacon,"Caramelized onions","Bavarian sausages"}	4
1288	7272	229	Himawari	3.77	https://kklvqik.net/wjSxkKx.html	{"Bavarian sausages",Carrots,"Cream cheese","Cheese cheddar",Peperoni}	2
1286	4119	229	Bacon Cheese Burger	5.47	http://qgelnrj.top/TQVUqIZ.jpg	{"Unagi sauce",Basil,Basil}	3
1290	1687	229	Original burger	5.53	http://ghynupm.ru/IqmFRAh.css	{"Chili Pepper","Onion rings"}	1
1291	3795	229	Grape Jelly Sandwich	7.52	http://www.hntongk.org/TnUMsvL	{Cheese,"Cheese cheddar",Strawberry,Chicken,Flour,Mushrooms}	5
1289	6704	229	Swedish Meatballs	6.06	http://www.yrqvygl.info/TVRVfDt	{Sugar,Grapes,"Caramelized onions",Butter,Cheese}	5
1292	531	229	Wallmart	3.83	http://iayynnr.org/	{Mushrooms,Strawberry}	3
1294	7781	229	Pizza Pepperoni with tomatoes	3.92	http://laslxrj.edu/JJZWRGj.php	{Mozarella,Mushrooms,Onion}	3
1295	3178	229	Philadelphia with salmon	6.34	https://autholu.top/DceQEmV.jpg	{Cheese,"BBQ sauce",Sugar,Butter,Potatoes,Nori}	5
1293	3883	229	Sweet Potato Pie	5.94	http://kovpxwv.net/AmdEvSU.html	{Chicken}	4
1297	5285	230	Pizza Pepperoni with tomatoes	2.84	https://lqprnmx.top/DTERajP.jpg	{Corn,Mayo,Peas,"Cheese cheddar",Strawberry}	2
1298	2830	230	Grape Jelly Sandwich	2.02	https://www.kxorgdj.top/VpQoqgW	{Sugar,Flour,Peperoni,Cheese,"Cream cheese"}	2
1299	6596	230	Pizza Texas	7.28	http://www.hqaxiuy.net/	{Cheese,Milk}	4
1300	8836	230	Pizza Hawaiian	4.70	http://ibxisoh.com/GkANbqH.jpg	{Strawberry,Basil,Onion,Cucumber,Nori}	3
1308	594	230	Chicken Pot Pie	5.46	http://yptbgtt.edu/xpdiaPX.svg	{Cheese,Grapes,Sugar,Strawberry}	1
1309	1009	230	Crispy Chicken burger	3.30	http://glkmdkj.ru/eEKQFqg.webp	{"Unagi sauce","Cheese cheddar","Cottage Cheese",Tomatoes}	5
1301	8062	230	Crispy Chicken burger	5.48	https://mhwarlc.net/NocErur.css	{Onion,Flour,Flour}	2
1270	4405	229	Peanut Butter	7.47	https://ntaflag.ru/	{Bacon,Mozarella}	2
1311	8409	230	Philadelphia with salmon	7.90	http://dgavfth.info/xsmbliM	{Sugar,Peperoni,Nori,Pasta}	1
1455	5919	233	Wallmart	4.09	https://smoxdfy.net/lmhDPTf.css	{Rice}	4
1348	1774	231	Chicken Pot Pie	3.15	https://bkwwdyu.net/CxFoRKU.jpg	{"Onion rings",Basil,Chicken,Sugar,"Cream cheese"}	2
1346	9963	231	Pizza Texas	3.12	http://urenyfr.org/nqrHNno.js	{Onion,"Cottage Cheese",Mozarella,Chicken}	1
1322	5719	230	Peanut Butter	7.61	https://www.guhjseg.ru/	{Salmon,Rice,Mushrooms}	4
1353	8637	231	Swedish Meatballs	6.50	http://qltcmoh.org/mryohcY	{Butter,Meat}	5
1354	3736	231	Pizza Pepperoni with tomatoes	6.44	http://epxxwjp.top/STLCCdQ.svg	{Mayo,Basil,"BBQ sauce",Mushrooms,Pineapple,Strawberry}	2
1355	859	231	Pizza Florida	4.99	https://www.nybeyrv.edu/	{Sugar,Basil,Peas,"Japanese tamago",Corn}	5
1357	216	231	Grape Jelly Sandwich	7.39	http://kfmmlei.info/cnHeOIM.js	{Mushrooms,Strawberry,Strawberry,Onion,Garlic}	3
1358	8286	231	Angel Food Cake	4.94	https://www.hnonqyw.top/iVhSbLJ	{"BBQ sauce",Mushrooms,Flour}	1
1356	6913	231	Saint Frank Coffee	2.86	https://hlisdbn.ru/eaWYxCi.html	{Mushrooms,Meat,Grapes,Chicken,Grapes}	5
1359	7617	231	Tortellini Bowls	2.18	https://gshilha.org/qxtQewN.webp	{Butter,Peperoni,Flour}	5
1506	992	233	Pizza	4.30	http://hwvklqa.top/	{Pasta}	4
1303	2046	230	Tortellini Bowls	4.38	https://jyhkcrc.org/AKIyqmw.html	{Flour,Flour}	5
1304	2233	230	Pizza Florida	2.73	https://uzwpyjy.top/nfVPcJN.webp	{"BBQ sauce",Mozarella,Carrots}	3
1305	3172	230	Crispy Chicken burger	6.60	https://oduarir.ru/oamgbJe.php	{Grapes,Flour,Cheese,Cucumber}	3
1315	1520	230	Saint Frank Coffee	7.04	http://www.qiicymx.top/DbOTvMF	{Pineapple,Peanuts,Mushrooms,Rice,Flour}	5
1316	3714	230	Unwrapped Burrito Bowl	5.61	https://eacggsv.edu/	{Flour,Chicken,Tomatoes,Milk}	5
1318	9485	230	Pizza Texas	5.72	https://wxwkucf.biz/qHQyBVO.php	{Onion,"Cottage Cheese"}	3
1319	296	230	Unagi Philadelphia	4.68	https://aixvdqn.biz/CESEvIF.jpg	{"Caramelized onions"}	2
1323	7015	230	New York Style Cheesecake	3.40	https://mtietbr.top/TXHYEHH	{Peanuts,Cucumber,Onion,Cheese,Rice}	3
1333	2893	231	Bacon Cheese Burger	6.33	http://iyxnoos.top/vbsfuFX.css	{Meat,Peperoni,Pasta}	3
1320	6906	230	Pizza Ocean	3.30	http://sidbnjl.info/MxoNEof.js	{Salmon}	1
1324	2245	231	Pizza Texas	6.10	http://cjyungt.top/RPqgtyd.html	{"Cheese cheddar","Onion rings"}	2
1325	7661	231	Angel Food Cake	6.62	https://nqqydvp.edu/	{Sugar,Rice,Cheese}	4
1326	4270	231	Pizza Hawaiian	4.44	http://slskgjr.info/yEUspwr.svg	{Flour,Basil,Cheese,"Japanese tamago",Milk,Cucumber}	2
1327	3398	231	Pizza	5.63	http://sbeiqay.net/iMfQxgB.js	{"Japanese tamago"}	3
1328	3894	231	Pizza Hawaiian	2.05	http://yrkqkqb.info/VrDeeLk.js	{"Japanese tamago",Mushrooms}	3
1329	3803	231	Pizza Florida	3.58	http://tlcmplh.net/MEhiyuV.svg	{"Cream cheese",Basil,"Caramelized onions",Nori,Mayo,Peas}	1
1330	2504	231	Pizza Italiano	4.15	http://vbvadyk.com/wDMfQrc.html	{Butter,Chicken,"Bavarian sausages",Mushrooms}	4
1331	4494	231	Pizza Pepperoni with tomatoes	5.83	https://saoqnxu.net/OwAsnov.css	{"Cottage Cheese",Strawberry}	3
1332	9621	231	Pizza Florida	7.56	https://povagpr.biz/AFukaML.php	{Mayo,"Unagi sauce",Sugar,Corn,Mayo,"Caramelized onions"}	2
1334	8703	231	Saint Frank Coffee	7.46	http://twbhqvh.info/BRUCBZk.svg	{Garlic,Rice,"Bavarian sausages",Carrots,Milk,Mushrooms}	5
1335	29	231	Unagi Philadelphia	4.43	https://bmofghq.top/DFRjPho.js	{Meat,Nori,Mayo,Chicken}	3
1337	5212	231	Pizza Ocean	5.73	http://ijuhndn.org/eQUYcau.webp	{Corn}	3
1339	6391	231	Chicken Pot Pie	2.57	http://ivhakgi.top/oIeArbL	{Salmon,"Onion rings",Cheese}	5
1336	2554	231	Sweet Potato Pie	5.19	http://hlotcwi.org/txvsELm.html	{Onion}	1
1340	6133	231	Grape Jelly Sandwich	4.27	http://iprcsus.org/kYxsDYY	{Potatoes,Carrots,Milk,Rice,Mozarella,"Cheese cheddar"}	1
1342	7763	231	New York Style Cheesecake	7.37	http://qpiffmt.edu/dPOrYKf.css	{"Original sauce"}	1
1343	5290	231	Unwrapped Burrito Bowl	4.24	http://www.dapnhji.biz/wiAqMkd	{Peas,Peperoni,Flour,Flour,Sugar,"Japanese tamago"}	3
1341	5811	231	Swedish Meatballs	3.10	https://www.brquctm.org/	{"Cream cheese"}	3
1344	2001	231	Crispy Chicken burger	5.07	http://zvaqtvr.ru/BCyiGna.php	{"Japanese tamago"}	4
1345	8971	231	Unagi Philadelphia	7.60	http://mbodnji.top/ZjMCWaG	{Flour,Strawberry}	3
1347	1724	231	Wallmart	4.18	https://khlnndx.top/jrNTPMd	{Peanuts,Flour,Nori}	2
1349	1248	231	Philadelphia with salmon	5.12	https://yhmkfwo.net/yuprKsE	{Butter,Peanuts,Peas}	1
1350	7164	231	Pizza Pepperoni with tomatoes	7.85	http://gwepskf.info/jmGgkML.webp	{"Japanese tamago","BBQ sauce"}	2
1386	8440	232	Himawari	3.64	http://iprjpme.com/	{Rice,Meat,Flour,Carrots,Sugar,Strawberry}	4
1402	6164	232	Pizza Florida	6.04	https://blrvljh.org/kFYkMTw.webp	{Mushrooms,Potatoes,Bacon,Basil,Flour,"Bavarian sausages"}	5
1389	4816	232	Pizza Ocean	8.00	http://www.ohnslaq.top/EhyOPKA	{"Cottage Cheese",Grapes}	1
1405	4651	232	Pizza Ocean	4.98	https://vulhogq.info/	{"BBQ sauce","Unagi sauce",Salmon,"Bavarian sausages",Flour,Mayo}	5
1445	9476	232	Chicken Pot Pie	6.35	https://mcdlnwb.ru/uMCXjNb.webp	{Sugar,Milk,Bacon,Salmon,"Japanese tamago",Flour}	3
1447	1603	232	Tortellini Bowls	4.44	http://ehqozav.edu/vNjgRka.html	{"Cheese cheddar","Cottage Cheese",Cheese,Chicken,Basil}	5
1361	3122	231	Unagi Philadelphia	7.95	https://qxdzqnl.biz/	{"Cheese cheddar",Mayo,Peas,Milk}	5
1362	8358	231	Pizza Texas	4.47	http://hhfnqpz.org/ugFBgTj.svg	{"Caramelized onions"}	5
1397	1228	232	Pizza Hawaiian	4.33	https://heppagt.com/ukeXRrI.css	{Rice}	3
1364	2174	231	Pizza Hawaiian	6.82	http://xmodxcu.ru/dZRsyOg.webp	{Corn,"Unagi sauce",Mushrooms,Chicken}	5
1365	7694	231	Pizza Hawaiian	4.22	https://fypdqef.info/cOSOYqL	{Corn,Potatoes,Peanuts}	2
1366	1468	231	Peanut Butter	5.67	http://www.ekxikwl.net/IwrycpI	{Flour,Corn,Carrots,"Japanese tamago",Chicken}	1
1367	7538	231	Tortellini Bowls	7.91	http://djlfoir.com/	{Basil}	4
1368	5531	231	Pizza	3.84	https://tccnkeo.ru/vjkEeof.css	{Peanuts,Nori,Peas,"Bavarian sausages","Chili Pepper",Mayo}	1
1369	2550	231	Sweet Potato Pie	4.76	http://ltybscl.com/RiontIR.html	{Butter,Peanuts}	5
1370	4043	231	Pizza	4.75	https://rkeyrfv.top/peJEjfr.webp	{Sugar,"Unagi sauce"}	2
1371	9237	231	Philadelphia with salmon	2.96	http://www.jzeyqyk.info/TXuwJgM	{Cheese,Peanuts}	2
1372	1028	231	Pizza Hawaiian	3.29	https://vpoxgfh.ru/jZwvsIj.svg	{Mushrooms,Mozarella,Basil,Flour,Carrots}	4
1373	8340	232	Pizza Texas	4.49	http://www.jiqagwj.ru/	{Flour,Butter,Basil,Meat,Milk}	4
1374	9161	232	Angel Food Cake	3.36	https://hrvuyia.edu/wugunhp.js	{"Japanese tamago",Mushrooms,Sugar}	2
1375	801	232	Sweet Potato Pie	2.82	http://fjjbxby.top/	{Mayo}	4
1376	7034	232	Philadelphia with salmon	7.07	http://awsknyo.com/RhMWEqG.php	{Mozarella,"Cream cheese"}	5
1378	4883	232	Himawari	6.18	http://egvkcmt.net/aPJDCum.html	{Peperoni,Nori,Mozarella,Mushrooms,"Original sauce"}	5
1379	1887	232	Pizza Hawaiian	5.31	http://www.txkddog.top/	{"Original sauce",Corn}	4
1380	4855	232	Bean Green Chili Burritos	2.68	https://fhhzjey.com/DJOAGxB.jpg	{Nori}	3
1382	380	232	Original burger	2.25	https://psxcbrh.org/gHmNGJZ.js	{Chicken,Grapes,Rice,Salmon,Grapes,Garlic}	3
1383	3796	232	Chicken Pot Pie	7.24	https://gxmtoyk.info/aPGrThE.jpg	{Milk,Peas,Salmon,"Cheese cheddar"}	5
1384	8073	232	Pizza Texas	6.75	https://www.veekxnh.com/bUcPvRM	{"Onion rings",Corn,Onion,Onion,Mayo,"Unagi sauce"}	3
1385	8007	232	Pizza Italiano	7.16	https://ryzhhxr.org/gBpJvqG.jpg	{"Original sauce"}	5
1388	6951	232	Original burger	6.82	http://pbjkedw.net/uTNLcqN.js	{Basil,Flour,Mushrooms,Corn,Chicken,Meat}	4
1401	200	232	Angel Food Cake	6.84	https://pmcokyf.ru/gYtpTiu	{Butter,Mayo,Nori,"Cream cheese",Mushrooms}	1
1390	5006	232	Himawari	5.39	http://ezphthi.info/UXNdTje.js	{Meat,Nori,Cheese,"Caramelized onions"}	2
1391	6503	232	Philadelphia with salmon	6.96	https://amenyhw.biz/EdLOodj.js	{Flour,Nori,Basil}	4
1392	2536	232	Peanut Butter	2.90	http://www.lsrtvkx.org/	{"Japanese tamago",Pineapple,"Caramelized onions",Rice,"Cheese cheddar"}	5
1393	5709	232	Angel Food Cake	3.57	http://www.mluhqkq.biz/jvghQdF	{"Original sauce",Sugar,"Cheese cheddar",Garlic}	4
1394	1341	232	Himawari	5.02	https://aieokos.top/XcjQgYp.svg	{Grapes,Flour,Onion,Mushrooms,Milk,"Chili Pepper"}	3
1395	7436	232	Bacon Cheese Burger	3.57	http://kcaxvrk.org/vsLjLxN.css	{Peperoni,Salmon,Meat,Flour}	1
1396	8584	232	Peanut Butter	7.44	http://www.ssoziol.net/	{Mayo,"Bavarian sausages",Cucumber,Carrots}	3
1399	469	232	Grape Jelly Sandwich	3.80	https://ssndlpv.info/	{Cucumber}	4
1363	9629	231	Crispy Chicken burger	3.64	https://rciqqhj.org/PLLTxZX.js	{"Caramelized onions",Chicken,"Caramelized onions",Corn,Milk,Sugar}	5
1400	3856	232	Pizza	6.84	http://qrsanko.ru/hpxJPXU.html	{"Caramelized onions",Mushrooms,Strawberry,Flour,"Chili Pepper",Peas}	2
1403	2053	232	Tortellini Bowls	4.21	http://slekneo.org/WMADTKy	{Grapes,Onion,"Onion rings"}	2
1404	3759	232	Swedish Meatballs	6.94	https://goftvge.edu/	{Tomatoes,Butter,Milk,Peas,Milk,"Original sauce"}	5
1448	5782	232	Original burger	2.33	http://www.dkcimtx.ru/FUyIqVm	{"Onion rings",Rice,Bacon,Mayo,"Unagi sauce"}	5
1449	1649	232	Tortellini Bowls	3.95	https://amevbro.edu/	{Meat,"Cream cheese",Sugar}	2
1443	4869	232	Sweet Potato Pie	4.30	http://rflineg.ru/	{Bacon,Mozarella}	4
1494	5697	233	New York Style Cheesecake	7.28	http://nfyxyue.net/cXcSiqE.php	{Peas,"Original sauce",Mushrooms}	1
1451	2351	232	Saint Frank Coffee	2.80	https://gelcvhj.com/dTpGMwO.php	{Salmon,Peanuts,Mayo,"Cream cheese"}	4
1453	821	232	Bean Green Chili Burritos	6.32	http://ycdwmcj.com/GrNnPrR	{Bacon,"Onion rings"}	3
1454	1979	232	Philadelphia with salmon	6.28	http://yhvfdpu.info/MvxBBJI.php	{Nori,"Cream cheese","Japanese tamago",Flour}	5
1542	82	235	Unwrapped Burrito Bowl	4.17	https://www.bihltwx.ru/	{Salmon}	5
1495	3455	233	Chicken Pot Pie	6.95	http://chomqag.org/RxxqsUS	{Peanuts,Potatoes,"Unagi sauce",Chicken}	4
1450	6911	232	Swedish Meatballs	5.08	http://rrovanr.edu/ceXoPgp.html	{Onion,Corn,Cucumber,"Chili Pepper"}	2
1496	6039	233	New York Style Cheesecake	5.08	http://ieisted.biz/	{"Original sauce"}	5
1412	6728	232	Pizza Italiano	2.49	http://www.supgtrs.edu/	{Flour,Garlic}	1
1493	9917	233	Grape Jelly Sandwich	2.12	https://xyucysp.top/fPyAGat	{Milk,Pasta,Peas,Cucumber}	4
1411	7093	232	Pizza	5.35	https://xrehytl.ru/vwQJIJT.webp	{Mushrooms,Strawberry,"Unagi sauce",Bacon}	3
1416	3017	232	Bean Green Chili Burritos	4.47	https://ajpahra.top/LywaYUd	{"Unagi sauce",Corn,Garlic,Corn,"Cream cheese",Butter}	1
1417	6273	232	Pizza Italiano	4.57	https://phnwhwj.ru/eAmuyOP	{Basil}	4
1410	5610	232	Tortellini Bowls	6.05	https://epipcmp.edu/fUoayfr.html	{Strawberry,"Cream cheese",Flour}	4
1415	4976	232	Himawari	5.26	https://lvmpohg.edu/PslfWek.html	{Bacon,"BBQ sauce",Basil,Meat}	3
1418	5912	232	Sweet Potato Pie	5.01	http://baqinji.com/NCDcsMk.svg	{"Japanese tamago",Mayo,Potatoes,Chicken,Nori,Basil}	2
1419	9833	232	Pizza Ocean	5.07	http://ihpmumv.top/AkHLUdj.jpg	{"Cream cheese"}	4
1422	2208	232	Chicken Pot Pie	6.05	http://ziykdxt.net/inpqTrO.html	{"Onion rings",Carrots,Flour,Cheese,Basil}	4
1413	5533	232	Pizza Hawaiian	3.80	http://ducjcxl.biz/sJjcyXZ.php	{Tomatoes,Flour,"Cheese cheddar",Chicken}	1
1414	1760	232	Sweet Potato Pie	5.48	http://ogfrfll.edu/aZxgJVg.js	{Garlic,Carrots,Grapes,Mushrooms,Chicken,Peas}	1
1421	1331	232	Bacon Cheese Burger	2.79	http://rjfwucw.edu/bMpqqbV.js	{Pasta,Flour,Potatoes}	1
1420	3621	232	Pizza Texas	6.60	http://www.pvzkrjt.com/	{Butter,Pasta,Meat,Strawberry,Nori}	4
1427	7606	232	Pizza Ocean	2.39	https://dhqjejy.edu/JQYTrWx.webp	{Rice,Milk,"Chili Pepper","Bavarian sausages"}	5
1424	143	232	Original burger	5.05	https://pcmagkf.top/fmqHRRw.css	{Pasta,Garlic,Pineapple,"Chili Pepper",Butter,Peas}	3
1426	288	232	Sweet Potato Pie	5.51	https://www.iilsfta.com/	{Peas,Sugar,Mushrooms}	3
1432	3226	232	Tortellini Bowls	7.00	https://miepaok.com/UeGjjFw	{Carrots}	2
1425	2974	232	Sweet Potato Pie	5.38	http://hmgwizj.top/HWSyDrn.svg	{"Chili Pepper"}	1
1428	5323	232	New York Style Cheesecake	7.24	http://www.pyubzxx.net/KodYncK	{Grapes,Mushrooms,Peas,"Onion rings",Milk}	3
1429	8181	232	Pizza Ocean	4.77	http://www.wdvggsy.top/CbDqPrM	{"Japanese tamago",Mushrooms,Rice,"Caramelized onions"}	4
1433	1523	232	New York Style Cheesecake	7.71	https://cbyyxvq.ru/rQNMkJW.webp	{Sugar}	4
1434	5755	232	Pizza Hawaiian	2.80	https://bndsuki.com/FgIPhhW.js	{Sugar,Potatoes,Peperoni,Cheese,Peperoni}	1
1438	9448	232	Angel Food Cake	4.52	http://blhxofx.info/ElteHoD.webp	{Tomatoes,Pineapple,Corn,"Onion rings","Cream cheese",Bacon}	5
1436	7968	232	Sweet Potato Pie	5.03	http://rmscdcg.org/mQGlKBg	{Meat,Chicken,Basil,"Chili Pepper",Mayo,"Cream cheese"}	3
1435	3365	232	Pizza	7.30	http://ddblacb.edu/FdrwLmD.html	{"Japanese tamago","BBQ sauce"}	5
1423	5242	232	Crispy Chicken burger	6.65	https://www.rfddoqw.edu/YGfBsWC	{Peperoni}	5
1437	3152	232	Crispy Chicken burger	6.95	https://fzcpywk.net/	{Meat,Salmon,Basil,"Chili Pepper","Caramelized onions"}	3
1439	4341	232	Swedish Meatballs	3.76	https://rqubydt.info/xfkbekI.css	{"Cheese cheddar","Cheese cheddar",Potatoes,"Cream cheese",Pineapple,"Cream cheese"}	1
1441	4098	232	Pizza	3.53	http://wgmukvn.info/twPHNwu.css	{Pasta,Pineapple,"Cheese cheddar"}	5
1440	9100	232	Pizza Texas	5.90	http://dtykgyg.org/NiDeKft.svg	{"Japanese tamago",Meat,Carrots}	4
1431	1293	232	Pizza Texas	5.30	https://www.uuyystw.top/	{Pineapple,"Original sauce"}	2
1442	6118	232	Philadelphia with salmon	4.95	http://iofgqpc.org/SJBQkPW.js	{Milk,Peanuts}	1
1460	5107	233	Bacon Cheese Burger	5.33	https://uvytdcg.top/nQiuKjf.html	{Mayo,"Unagi sauce",Mayo,Strawberry,Nori}	3
1462	9385	233	Pizza Florida	6.23	https://www.nnbaetz.net/	{Mushrooms,Salmon}	4
1505	7335	233	Pizza Hawaiian	4.04	http://kjouaho.net/OseDesv.svg	{Onion,Mushrooms,Mushrooms,"Unagi sauce"}	5
1537	9907	235	Grape Jelly Sandwich	4.80	http://jlbfcpy.top/oJahZxV	{Butter}	1
1464	2337	233	Pizza	5.12	http://gmrulcc.edu/XPkqIlq.svg	{Peanuts,Cheese,Cucumber,Butter,"Caramelized onions",Corn}	5
1465	6788	233	Original burger	2.12	http://olhqolq.com/mfhVrfy.html	{Grapes,Flour,Bacon}	3
1466	8301	233	Bean Green Chili Burritos	5.19	https://eewqjyc.info/pRChygM.html	{Peas,Rice}	4
1467	3609	233	Pizza Pepperoni with tomatoes	6.82	https://fvstjcx.com/QSgwAfj.jpg	{"Japanese tamago","Onion rings",Flour,Cucumber,"BBQ sauce"}	5
1468	3852	233	Unwrapped Burrito Bowl	4.55	http://www.ibqxjvh.edu/	{Butter}	2
1469	1950	233	Swedish Meatballs	3.93	https://aucnepm.edu/yYTCMrG.webp	{Sugar,Pineapple,Carrots,Salmon,Garlic}	5
1470	6774	233	Pizza	3.65	https://tehnivd.biz/VCgoqBg.js	{Meat,"Cheese cheddar",Rice,Onion,Meat}	4
1471	864	233	Pizza Ocean	4.92	https://uukwycp.biz/EwBkyMg.svg	{Carrots,Meat,Pineapple,"Caramelized onions",Garlic,Pasta}	4
1472	3358	233	Crispy Chicken burger	3.40	http://ubpaoxh.org/XNdSKAI.svg	{Flour,Peas,Pasta,Chicken}	4
1474	1190	233	Original burger	7.35	http://www.rxwevcn.edu/	{Grapes,Carrots,Mozarella,Carrots,Basil}	3
1475	9312	233	Pizza Florida	5.36	http://bktnbkj.net/ArZhsSm.svg	{"Unagi sauce",Sugar,Rice,"Original sauce",Mushrooms,"Unagi sauce"}	1
1476	2192	233	Pizza Ocean	2.67	http://leajckp.com/	{Flour,"Unagi sauce",Milk}	2
1477	2465	233	Original burger	7.68	https://www.grqklud.top/	{Mozarella,"Caramelized onions",Mayo,"Bavarian sausages",Corn,Onion}	4
1478	8813	233	Grape Jelly Sandwich	2.86	http://oefkrpk.info/IehjbkI.svg	{"Chili Pepper",Flour,Meat,"Cheese cheddar","Onion rings",Mayo}	5
1479	419	233	Pizza Ocean	2.20	https://www.fldccld.org/EblvWur	{Sugar,Carrots,Flour,"Chili Pepper","Unagi sauce","Chili Pepper"}	3
1480	656	233	Crispy Chicken burger	5.20	https://goktfjw.com/YJouYQq.svg	{Chicken,Basil,Flour,Rice,Milk}	3
1481	4886	233	Pizza Italiano	3.30	http://www.lxloxmn.ru/ccEnjvu	{Pineapple,"Onion rings",Garlic,Mushrooms,Grapes,"Caramelized onions"}	4
1482	9058	233	Angel Food Cake	4.83	http://jxgggod.org/YJkxaCH	{Mozarella}	5
1483	8101	233	New York Style Cheesecake	3.89	https://uyfikxv.org/dOxLGcc.webp	{"Caramelized onions",Mozarella}	4
1484	7965	233	Pizza Florida	2.96	http://www.hsofafo.edu/IEOclBA	{Milk,Chicken,"Cheese cheddar","Cheese cheddar","Japanese tamago",Rice}	2
1485	4313	233	Grape Jelly Sandwich	5.81	https://www.alqzqiu.com/	{Cucumber,Chicken,Garlic,Salmon}	5
1486	3357	233	Tortellini Bowls	7.78	https://sxelmsn.net/TJJQcKN.svg	{Mushrooms,Butter}	3
1487	4180	233	Saint Frank Coffee	3.41	http://kvroxie.org/YlaEPPN.html	{Peperoni}	2
1488	8313	233	Swedish Meatballs	6.56	http://sjnsnnx.info/eTZKmWM.jpg	{Peas,Pineapple}	2
1489	7871	233	Pizza Pepperoni with tomatoes	6.89	https://vydwfxu.ru/yWRyRKC.js	{Basil,Mozarella,"Cheese cheddar",Flour,"Chili Pepper"}	2
1490	3086	233	Pizza Texas	6.76	https://www.gjgevtv.com/XMgHRlW	{Rice}	1
1498	1613	233	Philadelphia with salmon	4.28	https://lnjxnhl.org/KXaZcye.php	{Butter}	2
1499	3742	233	Sweet Potato Pie	3.48	https://kfucsrp.com/HALccgh.jpg	{Corn,Butter,"Chili Pepper",Mayo,Potatoes}	1
1500	6206	233	Crispy Chicken burger	2.61	http://lexrugl.info/HUijIAL.svg	{Grapes,Pineapple,"Cottage Cheese"}	3
1503	6068	233	Unagi Philadelphia	7.53	http://loietrx.top/GSlKUKH.webp	{"Onion rings",Carrots,Flour,Milk}	5
1502	9673	233	Chicken Pot Pie	5.91	https://xlhxhxm.net/SJWjwFM.jpg	{Carrots,Sugar,Potatoes,Mushrooms,"Cottage Cheese"}	4
1504	4737	233	Philadelphia with salmon	4.93	http://qdyoxav.ru/	{Mushrooms,Mushrooms}	4
1501	4880	233	Saint Frank Coffee	6.90	http://pmdcflt.biz/MbNMguZ.html	{Mushrooms,"Cream cheese",Mushrooms,Grapes,Flour,Cheese}	2
1538	2935	235	Pizza Pepperoni with tomatoes	7.64	http://deagcbl.org/YiLYtxu.php	{"Cream cheese"}	5
1457	4441	233	Himawari	3.66	https://ppiycek.ru/sykLqDc.jpg	{Peas,Carrots,Strawberry,Grapes}	2
1459	7768	233	Pizza Florida	6.66	https://tqnyfhq.org/HJSEdLR.css	{Mushrooms}	1
1463	779	233	Philadelphia with salmon	4.80	https://www.hswlhrl.edu/qYKwsig	{Peanuts,"Cream cheese",Mozarella,"Cream cheese"}	3
1548	6246	235	Pizza Florida	4.79	http://zvcnaty.ru/WuSkLqA.css	{"Caramelized onions",Onion,Flour}	1
1531	2082	235	Angel Food Cake	2.09	http://wxkemdy.com/kIUwnDH.css	{"Onion rings","Onion rings",Peperoni,Peperoni,Bacon}	1
1533	9489	235	Pizza Italiano	6.72	https://www.mslxcdl.biz/	{Flour,Potatoes,"Cream cheese"}	2
1545	5625	235	Saint Frank Coffee	4.28	http://rfuebuh.biz/VBYCNZA.php	{Mushrooms,Chicken,Bacon,Peanuts}	5
1550	4436	235	Himawari	6.86	https://alomhnh.edu/klClVdT	{"Cream cheese"}	5
1525	8560	235	Philadelphia with salmon	2.87	http://tgtxaao.info/xdkAiWp.webp	{"Cream cheese","Chili Pepper",Mushrooms,Corn,Carrots}	4
1517	5190	235	Swedish Meatballs	4.37	https://abakkiy.org/eTWrTDx.svg	{Flour,"Chili Pepper",Carrots,Chicken}	3
1552	4547	235	Pizza Florida	2.61	https://wmznsti.net/KtuoeHU.svg	{Mozarella,Peperoni,"Japanese tamago",Grapes,"Original sauce",Flour}	5
1553	8852	235	Pizza Texas	2.47	http://uuoejvy.org/deXxNmA.php	{"Cheese cheddar","Japanese tamago",Carrots,Milk,Onion}	1
1583	1845	235	Swedish Meatballs	7.07	https://hbygmer.ru/NDTmxHY.webp	{Nori,Flour,Butter,Corn,Tomatoes}	3
1585	3556	235	Bacon Cheese Burger	2.74	https://rkrgyjl.com/IANJLdT.css	{"Cottage Cheese",Peanuts,"Cheese cheddar",Flour,Cucumber,Milk}	1
1586	8898	235	Tortellini Bowls	3.56	https://vbkvwuq.info/jycfOTQ.svg	{"Chili Pepper","Cheese cheddar",Peanuts}	1
1588	2265	235	Pizza	2.38	https://bibxpwh.info/RahrRZV.svg	{"Unagi sauce",Corn,"Chili Pepper"}	2
1508	4616	234	Philadelphia with salmon	2.06	https://ujhoull.biz/FlJEViL.html	{Nori,Garlic,"Cream cheese","Onion rings",Mushrooms}	4
1509	9839	234	Pizza	5.09	http://lwvmqlf.biz/MbnXlBK.php	{Mushrooms}	5
1511	4287	234	Unwrapped Burrito Bowl	7.49	http://idenelu.top/xtqywYH.css	{Chicken}	2
1513	7439	234	Peanut Butter	3.08	http://zfbfjzl.biz/BKinVZD.js	{Meat,Strawberry}	1
1515	9194	234	Crispy Chicken burger	2.39	https://wlsplxw.biz/FDLPyuK.webp	{Pineapple,Peas,Peperoni,Basil,Mayo}	4
1520	6928	235	Philadelphia with salmon	2.13	http://dvpprlb.net/JUDVxQP.js	{Carrots,"Japanese tamago",Rice,Tomatoes,Corn,Garlic}	4
1521	7512	235	Angel Food Cake	6.44	http://wvnxiox.com/oavlAtT.html	{Grapes,Peperoni,Pineapple,Mayo,Nori,Pineapple}	3
1522	2814	235	Wallmart	2.98	http://smpgyre.com/qjDuvCi	{Nori,Salmon,Pasta,Salmon,Bacon,"BBQ sauce"}	1
1526	8241	235	Original burger	7.38	http://ijgvvtw.ru/TwAmuYv.jpg	{Nori,Onion,Tomatoes,Chicken,Basil}	3
1549	7992	235	Pizza Pepperoni with tomatoes	2.66	http://kdynpha.net/ONWqKKN.html	{Carrots,"Japanese tamago",Potatoes,Flour,Strawberry,Nori}	5
1512	1762	234	Tortellini Bowls	5.11	http://jfboeld.ru/mwVruUM.jpg	{Pasta,"Cheese cheddar",Rice,Potatoes,Pasta}	1
1514	9311	234	Bean Green Chili Burritos	4.07	https://www.xeccswb.ru/	{"Cottage Cheese",Mushrooms,"BBQ sauce","Japanese tamago"}	4
1516	6373	235	Bacon Cheese Burger	7.42	https://dfzvceo.com/EhZLSvp.html	{"Original sauce",Cheese,"Chili Pepper"}	3
1519	8833	235	Unwrapped Burrito Bowl	5.28	http://stblthq.top/WpAaYKf.html	{"Original sauce"}	1
1524	678	235	Bean Green Chili Burritos	2.55	https://ohorgis.com/MDQgTFj.jpg	{Carrots,"Original sauce",Potatoes,Butter,Pasta}	3
1528	8945	235	Wallmart	6.08	http://nqlnmtp.top/pYRYHkS.css	{Grapes,Tomatoes}	3
1532	403	235	Unagi Philadelphia	2.35	http://vyksxyg.com/BaxqJRR.webp	{Carrots,Bacon,"Cream cheese","Cheese cheddar"}	3
1544	9186	235	Peanut Butter	4.91	http://crxnfms.edu/cQmDksq.php	{"Chili Pepper"}	5
1551	2292	235	Himawari	7.49	https://ybrogof.info/YtMjVfH.html	{Pasta,Potatoes,Cheese,"Original sauce"}	5
1587	950	235	Wallmart	4.67	http://pjutvvq.org/PoeKJMm.svg	{"Cottage Cheese",Meat,Tomatoes,Chicken,Peanuts,Peas}	3
1554	8926	235	Grape Jelly Sandwich	3.00	http://ksmokbz.info/SCSTsXG.js	{"Cream cheese",Onion}	2
1584	9427	235	Pizza Pepperoni with tomatoes	7.68	http://occxntn.biz/gXlOWQb	{Garlic,"Unagi sauce"}	3
1546	5907	235	New York Style Cheesecake	3.27	http://www.glehjjb.top/	{Pasta,"Onion rings","Original sauce",Cucumber}	1
1589	5343	235	Chicken Pot Pie	7.09	https://njlzvdk.info/xWQgHqM.html	{Strawberry,"Cream cheese",Peanuts}	5
1510	9220	234	Grape Jelly Sandwich	6.59	https://uzlpdrh.biz/hQUJQvd.php	{Potatoes,"Chili Pepper"}	4
1608	357	235	Tortellini Bowls	2.86	http://www.exfcagv.biz/	{"Caramelized onions","Chili Pepper"}	5
1578	1995	235	Pizza Texas	5.92	http://jkppnum.top/gBsToaU.html	{Flour,"Caramelized onions"}	4
1601	7410	235	Pizza	6.88	https://gcvkcjs.edu/	{Flour,Rice}	1
1603	2740	235	Peanut Butter	2.93	https://gnnqppu.top/FNsXwMq.php	{Peanuts,Mozarella,Milk,"Cheese cheddar",Sugar}	3
1604	8955	235	Pizza	6.46	https://upecpqy.org/MimXJHY.php	{Potatoes}	1
1606	9288	235	Chicken Pot Pie	7.49	http://eqmocfx.top/ksqbmkU.html	{"Caramelized onions",Pineapple,Sugar}	5
1607	5522	235	Philadelphia with salmon	5.48	https://xjmlwwh.top/chNpkgx	{Milk,Cheese,Corn,Potatoes,Milk,"Caramelized onions"}	3
1598	9013	235	Unwrapped Burrito Bowl	5.99	http://yrjwchm.biz/bsSGCci.html	{Basil,Peas}	5
1609	7124	236	Tortellini Bowls	6.13	https://lddlxfe.com/	{Garlic,Grapes,Corn,Strawberry,Mayo}	1
1600	8638	235	Tortellini Bowls	2.37	http://hhflwyw.org/iaOlhkT.js	{Mozarella}	5
1610	5437	236	Swedish Meatballs	2.16	https://ptnsybx.com/ZSeYxTi.svg	{Mushrooms,Mushrooms,"Chili Pepper","Bavarian sausages",Mushrooms}	3
1631	8203	236	Pizza	3.73	https://vfgzkap.com/	{Bacon}	4
1632	54	236	Bacon Cheese Burger	4.95	http://www.aduqusp.org/MGGHLeV	{"Japanese tamago","BBQ sauce",Tomatoes}	5
1562	3563	235	Chicken Pot Pie	3.93	http://www.ynegjoy.top/	{"Caramelized onions",Pineapple,Strawberry,Bacon,Flour,"Bavarian sausages"}	5
1634	1977	236	Pizza Texas	4.76	https://www.wjmribc.com/	{Peas,Nori,Carrots,"Original sauce",Mushrooms}	2
1635	2058	236	Philadelphia with salmon	6.93	https://www.vpiyebt.info/buLPbXy	{Pasta,Garlic,"BBQ sauce",Pasta}	2
1636	9411	236	Saint Frank Coffee	6.40	http://jlaihfq.ru/	{Tomatoes,Potatoes,Onion}	1
1558	5202	235	Pizza Texas	5.82	https://xuiweds.com/oWHtpYS.svg	{Rice}	1
1560	2655	235	Philadelphia with salmon	3.04	https://vmnxjbh.net/toPekUu	{Corn,Mushrooms}	4
1561	1443	235	Angel Food Cake	7.90	https://choirbu.ru/wOOQOjP	{Mozarella,Grapes,"Cheese cheddar"}	1
1563	3425	235	Pizza Florida	5.49	https://ywetnim.edu/gXfNtwK.svg	{Nori}	5
1633	7984	236	Pizza Hawaiian	7.42	http://cijgqpc.ru/UibnPmi	{"Caramelized onions",Onion,Milk,"Cheese cheddar","Unagi sauce"}	1
1564	6291	235	Philadelphia with salmon	2.01	http://xtoiboi.ru/bQsRYdG.css	{Flour,"Cream cheese",Mushrooms,Salmon}	5
1574	145	235	Original burger	5.61	http://www.uwbjrat.top/GaBydMY	{"Cheese cheddar"}	1
1566	2148	235	Tortellini Bowls	5.24	http://dutkrpp.net/XxLsGsG	{"Unagi sauce",Meat,"Chili Pepper"}	4
1568	8374	235	Original burger	3.56	http://www.pclpgvk.ru/	{"Cheese cheddar",Mushrooms,Butter,Butter,Bacon}	3
1569	5137	235	Bean Green Chili Burritos	2.72	http://www.qtwnmoi.com/RUFKber	{Strawberry}	1
1570	1697	235	Angel Food Cake	7.33	http://ufxfgfh.edu/HslBmXZ.webp	{Onion,Chicken}	2
1571	4606	235	Swedish Meatballs	6.95	http://firyhca.com/VHTREmV.html	{Cheese,Pasta}	4
1572	5691	235	Crispy Chicken burger	7.17	https://dfdornr.org/FiPhElP.svg	{"Cottage Cheese","Original sauce",Sugar}	4
1573	8080	235	Swedish Meatballs	2.52	http://yfceyru.org/MUQoxQE	{Peas,Flour,"Bavarian sausages",Peanuts,Nori}	3
1575	5159	235	Chicken Pot Pie	7.22	http://scrtgkq.top/UAtiAXe.html	{Mushrooms,Milk,Rice,Pasta}	3
1565	3239	235	Grape Jelly Sandwich	2.40	http://ylskcoc.edu/gwquthI.css	{Carrots,Mayo,Nori}	5
1576	7796	235	Wallmart	5.13	http://www.trfsklk.org/RNDCmPH	{Milk,Meat,Meat,Sugar,Potatoes,Flour}	5
1580	986	235	Bacon Cheese Burger	7.14	http://www.yakmpjv.edu/	{Basil,Pineapple}	3
1597	8538	235	Unagi Philadelphia	3.77	http://tvgewwg.com/LyHAOYk.css	{Flour,Flour,Cheese}	3
1592	2667	235	New York Style Cheesecake	2.34	http://uceccwh.biz/	{Rice,Cucumber}	1
1593	6987	235	Wallmart	6.42	https://nwepvxn.org/ianlPoq.svg	{Salmon,Mushrooms,Bacon}	5
1594	331	235	Peanut Butter	3.14	http://nfjpwxs.org/KRmMAwP	{Flour,"Chili Pepper",Mushrooms}	2
1595	6969	235	Pizza	5.88	http://xcdqqef.biz/EtIkoto.js	{"Cottage Cheese",Milk,Mushrooms,Pineapple,Peperoni}	2
1596	2585	235	Peanut Butter	2.18	https://www.puuwziv.biz/	{"BBQ sauce","Japanese tamago",Potatoes}	2
1605	5059	235	Philadelphia with salmon	4.26	http://axmycga.top/ODhNmrJ.html	{Peanuts,Flour,"Original sauce"}	5
1599	9835	235	Tortellini Bowls	2.60	https://isfbytt.info/ujwmehU.html	{Butter,Peanuts}	1
1602	431	235	Pizza Hawaiian	3.71	http://jgrvwmg.ru/JNFUMug.webp	{Flour,Corn,"Cream cheese",Sugar,"Cream cheese"}	3
1577	9251	235	Angel Food Cake	7.52	https://muibxhd.edu/mPeGufO.php	{Basil,Mayo,Meat}	1
1662	4451	236	Pizza	4.47	https://qgtqbmc.top/KAxKVSA.webp	{Peas,Peperoni,Onion}	3
1678	3024	236	Pizza Hawaiian	7.16	http://ubmtrul.org/icepmYw.js	{Garlic,Grapes,"BBQ sauce",Cheese,"Unagi sauce",Chicken}	2
1648	7736	236	Pizza	3.45	https://muyrhaj.net/IxINRCx.jpg	{Mushrooms,Cucumber,"Cottage Cheese","Original sauce"}	5
1681	5626	236	Pizza Italiano	4.28	https://wzsujui.com/ilKvqwT.webp	{Basil,Peas,Flour,"Caramelized onions",Peperoni}	5
1682	121	236	Swedish Meatballs	2.56	https://hycrijq.org/iGTNdRu.svg	{Milk,Carrots,Mayo}	5
1683	2824	236	Crispy Chicken burger	7.64	https://kbgyvix.info/MapEEbG.webp	{Meat,Cheese,"Japanese tamago","Japanese tamago",Pasta,Peas}	2
1611	7024	236	Himawari	2.02	https://mquxwox.ru/dUfmdfc.js	{"Cheese cheddar",Basil}	1
1613	5029	236	Himawari	5.77	http://leqyejw.org/sNiIxHU.svg	{Garlic}	3
1614	2875	236	Pizza	7.83	https://www.nghzlqe.net/	{Salmon,Mayo}	5
1615	2656	236	Himawari	3.24	https://aggegbo.com/FmBmVUO.jpg	{Flour,Corn,Mozarella,Milk,Chicken}	5
1616	9399	236	Original burger	6.31	https://icwaiin.top/EMvxRhC.svg	{Grapes,Milk,Basil,Rice,Cucumber,Cheese}	5
1617	9453	236	Pizza Pepperoni with tomatoes	2.34	http://gaylyoj.biz/NDDcRpc.html	{Cucumber,Pineapple}	4
1618	343	236	Tortellini Bowls	7.62	http://ptrqbxt.net/oklpqJg.js	{Pasta,Pineapple,Grapes,Meat,"Japanese tamago"}	1
1619	4220	236	Swedish Meatballs	7.39	http://www.muunvdv.com/ctYHwvF	{"Original sauce","Chili Pepper","Onion rings","Unagi sauce"}	3
1620	9888	236	Pizza Florida	3.22	https://fxsxdqi.edu/wHIOLnB.svg	{Mushrooms}	5
1621	8344	236	Unagi Philadelphia	5.31	https://www.skdqkke.ru/ctiNBnL	{Pineapple,Flour,"Caramelized onions",Basil}	3
1622	8197	236	Grape Jelly Sandwich	5.05	http://wfoiemi.biz/irLQQla	{Mushrooms,Salmon,Butter}	1
1623	3005	236	Pizza Texas	3.45	http://kywwnnq.com/tQSSxpF.jpg	{Peperoni,Nori,Chicken,Basil,Nori,"Caramelized onions"}	4
1624	6197	236	Pizza Florida	7.50	https://jzgnjms.biz/SVZqZSu.css	{"Japanese tamago",Meat,Peperoni,Potatoes,"Japanese tamago"}	5
1625	2429	236	Pizza Texas	6.93	https://www.gpjaaqo.biz/QVjuobT	{Salmon,Carrots,Strawberry,Pineapple,Strawberry,Onion}	5
1626	6027	236	Pizza Pepperoni with tomatoes	7.79	http://hfaiumy.net/lHoLZQM.js	{Rice,"Cottage Cheese",Pasta,Flour}	3
1627	5347	236	Grape Jelly Sandwich	5.18	https://qnqcswq.ru/	{Garlic,Basil,"Caramelized onions",Meat,Onion,Peas}	4
1638	4415	236	Pizza Texas	5.94	http://www.tinehts.top/	{"Cheese cheddar",Milk,Peanuts,Butter,"Original sauce",Milk}	2
1640	8398	236	Pizza Ocean	2.16	https://fnspboy.info/	{"Cream cheese",Mozarella,"Unagi sauce",Flour}	4
1641	4259	236	Pizza Hawaiian	2.52	http://www.ymgssiw.top/vrXUEcT	{Flour}	1
1642	4393	236	Pizza Texas	7.74	https://tkfuaht.edu/CYQawuU.css	{Meat,Mushrooms,Potatoes,Flour,Peas,Pasta}	2
1643	1782	236	Pizza Florida	3.39	http://qvuqjcx.org/JIHeKRL.jpg	{Carrots,"Japanese tamago",Mushrooms,Butter,Onion}	1
1644	3988	236	Chicken Pot Pie	6.17	https://ongmcxz.edu/NoWSuQt.webp	{Peas,Pineapple,Meat,Bacon}	3
1645	7649	236	Unagi Philadelphia	7.67	https://nchdyoi.com/ADcxpbF.svg	{Strawberry}	3
1646	3203	236	Wallmart	5.83	https://egbggnr.net/PogDtMV.webp	{Salmon,Strawberry,Flour,Sugar,Cucumber}	1
1647	1501	236	Saint Frank Coffee	4.72	https://iwdplol.biz/	{Salmon}	3
1649	517	236	Pizza Italiano	3.00	http://www.lfdhdvl.ru/SgyrXBg	{Butter,Cucumber,Butter}	4
1650	9886	236	Himawari	4.65	http://eebwsdb.info/oCpVldQ.svg	{"Cheese cheddar",Butter,Onion,Basil}	1
1651	867	236	Unagi Philadelphia	4.57	http://fpprdqc.ru/dEOWGbA.html	{Garlic,Bacon,Mushrooms,"Original sauce"}	2
1652	9531	236	Pizza Ocean	2.53	http://rsnygbd.info/ZTxKiNS.jpg	{Potatoes,Milk,"Original sauce",Rice}	4
1653	3941	236	Original burger	7.38	https://rrabyxo.top/lEclPlw.webp	{"Cheese cheddar",Mushrooms,Cucumber}	2
1654	3153	236	Sweet Potato Pie	5.41	http://dxwydsz.org/	{"Bavarian sausages"}	1
1657	3302	236	Bacon Cheese Burger	6.05	https://moeanlb.info/xjKKPtM.js	{Grapes}	1
1658	6629	236	Angel Food Cake	5.37	http://doqausa.info/HJMFnkr.webp	{Salmon}	5
1659	7792	236	Pizza Italiano	3.19	http://paqwbry.ru/	{"Caramelized onions"}	5
1661	4952	236	Pizza	6.76	http://www.warsqjy.com/	{Pineapple,"Onion rings",Rice,Mushrooms}	1
1679	3859	236	Pizza Hawaiian	3.59	http://dmygals.biz/TDHXDJd.css	{Carrots,Milk,Pineapple,"Chili Pepper"}	3
1680	535	236	Angel Food Cake	7.10	http://yenhsdf.biz/oEmUrDH.html	{Cucumber,"Cheese cheddar",Bacon,Milk}	4
1666	5599	236	Philadelphia with salmon	3.04	http://www.rdjyvja.com/	{"BBQ sauce"}	2
1704	4160	8	Pizza	7.26	https://wybuedp.info/fcfZAeJ	{Meat,Basil,Peanuts,"Unagi sauce",Salmon}	2
1686	2759	236	Sweet Potato Pie	4.56	https://muquonw.org/	{"Bavarian sausages",Cucumber,Flour,Corn,"Onion rings",Bacon}	3
1702	21	7	Sweet Potato Pie	5.35	https://i5.walmartimages.com/asr/7bd145de-7975-4c04-842e-188a5a0be79d_2.57a9e072cd4d529d16ccd9125f6a035d.jpeg	{Potatoes,Flour,Sugar,Milk}	7
1670	6917	236	Swedish Meatballs	6.79	https://yihcwdo.com/WgYfBNB.css	{Mozarella,Pineapple}	5
1667	5624	236	Bacon Cheese Burger	4.61	http://eioqxnq.net/LOnbGfN	{Grapes,"Cheese cheddar","Japanese tamago",Salmon}	5
1701	20	7	New York Style Cheesecake	2.23	https://i5.walmartimages.com/asr/7df68f47-78dc-4308-8a46-2ca7e1fa50e6.b2973bca56a71b9dc3e773ee08aeb1a6.jpeg	{"Cottage Cheese",Sugar,Butter}	2
1706	4362	8	Sweet Potato Pie	3.86	https://rprlsmt.net/OgZqXwT.css	{"Original sauce",Butter,Bacon,Grapes,Butter}	4
1692	8	3	Pizza Florida	7.88	https://roll-club.kh.ua/wp-content/uploads/2015/09/4-syra.jpg.webp	{Corn,Onion,Mushrooms,"Bavarian sausages",Mozarella,"BBQ sauce"}	4
1671	4447	236	Himawari	6.93	https://iiplauk.biz/hHUBqpJ.jpg	{"Onion rings",Potatoes,Flour}	3
1672	1418	236	Crispy Chicken burger	5.32	http://wxohpxp.info/uvaqewD.js	{"Chili Pepper",Peanuts,Pineapple,"BBQ sauce"}	4
1669	8656	236	Bacon Cheese Burger	4.40	https://bwxuxsj.info/hOdjWVI.jpg	{Corn}	3
1668	2190	236	Pizza Texas	3.31	http://www.ogabegf.edu/	{Garlic,"Chili Pepper",Peanuts,Basil,Mushrooms,Cheese}	4
1674	9042	236	Himawari	6.54	https://www.qpwfziv.edu/	{Milk,"Cheese cheddar"}	5
1707	9196	8	Philadelphia with salmon	6.00	http://www.vpehpwb.info/hVYITud	{Rice,Corn}	1
1685	3037	236	Pizza Hawaiian	3.83	https://epdjpan.org/ubEhVWH.js	{Onion,Pineapple,"Chili Pepper"}	4
1705	3057	8	Wallmart	3.69	http://dgjufpg.edu/eemFSEo	{Bacon,Peanuts,"Japanese tamago",Carrots,Grapes}	1
1698	14	5	Unwrapped Burrito Bowl	5.40	https://target.scene7.com/is/image/Target/GUEST_7c640617-96cd-4236-96f0-38a995828861?wid=1416&hei=1416&fmt=webp	{Corn,Onion,Rice}	5
1700	19	7	Angel Food Cake	7.92	https://i5.walmartimages.com/asr/7be23ae2-0733-4fe1-a13c-13c1121db61a.37700bee4e0c25b6a3f93496ae17c7c7.jpeg	{Flour,Strawberry,Butter}	2
1710	1889	8	Pizza Italiano	7.20	https://wjpyhjq.net/	{Peanuts,Mushrooms,"BBQ sauce","Japanese tamago","Chili Pepper"}	3
1665	6667	236	Himawari	3.96	https://cbeixif.biz/NcSHecI.webp	{"Cottage Cheese","Bavarian sausages",Rice,Peperoni}	5
1694	10	4	Philadelphia with salmon	5.60	https://ninjasushi.com.ua/img/452.png	{Salmon,Nori,Rice,Cucumber,"Cream cheese"}	1
1696	12	4	Himawari	2.18	https://roll-club.kh.ua/wp-content/uploads/2014/08/ukrainskaja.jpg.webp	{Salmon,Nori,Rice,Cucumber,"Cream cheese","Unagi sauce","Japanese tamago"}	1
1695	11	4	Unagi Philadelphia	4.98	https://ninjasushi.com.ua/img/102-600x600.png	{Salmon,Nori,Rice,Cucumber,"Cream cheese","Unagi sauce"}	1
1703	5694	8	Pizza Ocean	5.61	http://avnldwf.biz/LXcofhm.html	{Peas,"Japanese tamago"}	5
1699	15	5	Tortellini Bowls	6.79	https://target.scene7.com/is/image/Target/GUEST_dd195641-5a34-4be1-9e14-c4632ee5942e?wid=1416&hei=1416&fmt=webp	{Garlic,Basil,Mozarella}	5
1675	228	236	Unagi Philadelphia	3.24	https://yiuouiz.edu/	{Meat,"Unagi sauce",Cheese,Mozarella}	2
1724	1238	8	Angel Food Cake	6.59	https://rglqdth.com/	{Potatoes,Tomatoes}	4
1712	1363	8	Pizza Hawaiian	3.10	https://www.pvvtrnb.com/kNIdhrP	{Grapes,Corn,Flour}	2
1697	13	5	Swedish Meatballs	3.73	https://target.scene7.com/is/image/Target/GUEST_9066181d-e570-4eb1-b85d-1c8a547857fe?wid=1416&hei=1416&fmt=webp	{Pasta,Meat,Mayo}	5
1709	4584	8	New York Style Cheesecake	7.52	https://yyjntsp.org/wCNPtOE.html	{Mayo,Salmon,Onion,"BBQ sauce",Sugar,Milk}	1
1690	6	2	Bacon Cheese Burger	2.25	https://316024.selcdn.ru/wiget/4d4c871a-107f-11e7-80df-d8d38565926f/ba3a1ca2-2ec6-4cf4-a843-f7f0fc0f175a_Medium_.jpg	{"Cheese cheddar",Bacon,"Original sauce","Onion rings"}	3
1664	6247	236	Angel Food Cake	6.17	http://bepxnan.com/JUTtbxY.php	{Flour}	2
1687	9690	236	Chicken Pot Pie	7.08	http://tzmyccu.net/	{Tomatoes,"Onion rings",Peanuts,Grapes}	2
1708	7109	8	Peanut Butter	2.44	https://vumqcut.com/utvyiMk.js	{"Original sauce",Potatoes,Basil,"Original sauce","Onion rings"}	2
1693	9	3	Pizza Italiano	4.55	https://roll-club.kh.ua/wp-content/uploads/2014/08/ukrainskaja.jpg.webp	{Chicken,Pineapple,Mozarella}	4
1711	8171	8	Pizza Ocean	3.36	http://ypmvndl.com/tjqwBmN.svg	{Cheese,"Original sauce",Milk,Peas,Pasta}	5
1673	6626	236	Unwrapped Burrito Bowl	6.34	http://yyotavd.net/	{"Chili Pepper",Pineapple,Grapes,"Bavarian sausages"}	1
1719	6534	8	Sweet Potato Pie	2.08	https://kyinhqm.com/slvICUx.webp	{Peperoni,Flour}	2
1761	9612	9	Unagi Philadelphia	3.09	https://pecavda.com/NNthEbp	{Peperoni,Strawberry,"Onion rings",Peas,Mayo}	2
1766	3588	9	Crispy Chicken burger	2.74	http://flrceka.info/IFdSlng.php	{Corn}	4
1720	5946	8	Pizza	5.37	http://mlkeitz.info/ElraShE.php	{Salmon,Bacon,Flour,Peas}	5
1727	5511	8	Sweet Potato Pie	6.48	http://www.xcmtljs.edu/oQABnsV	{Tomatoes}	5
1769	4314	9	Peanut Butter	5.71	http://asdztni.ru/ENRSfwy.svg	{"Chili Pepper"}	2
1729	5118	8	Tortellini Bowls	7.58	https://oipmunf.com/gINWWiy.svg	{Rice,Sugar}	3
1771	3248	9	Pizza Florida	7.85	http://xmxhjzx.biz/hVOvkKL.jpg	{Strawberry,Cucumber}	2
1731	757	8	Pizza	2.23	http://rdhhthh.edu/nZUBWuy.svg	{"Onion rings",Rice,Peas,Pasta,Mushrooms,Butter}	3
1755	5579	9	Grape Jelly Sandwich	3.98	http://vowpwmo.org/xEZOlEh.webp	{Flour,Bacon,Onion,Corn,"Cottage Cheese"}	5
1716	7805	8	Original burger	5.88	http://sidmuya.ru/yNQDnBP.jpg	{"Chili Pepper",Garlic,Bacon,Meat}	2
1741	2489	9	Pizza	4.87	http://garyvnl.edu/	{Basil,"Bavarian sausages",Cucumber,Salmon,Flour}	1
1759	8707	9	Tortellini Bowls	6.81	http://lmupytp.edu/gjgeeHU.js	{Pasta,Garlic,Bacon}	5
1728	7756	8	Pizza Pepperoni with tomatoes	4.18	http://bfqsduh.top/uqtpWAS.jpg	{Onion}	5
1721	7634	8	Pizza Italiano	7.94	http://jyjgiyl.biz/MEmyJqa.css	{Peperoni,Potatoes,Peperoni,Pasta}	4
1768	718	9	Wallmart	4.05	http://dosbmgg.ru/yrWyGss.php	{Bacon,Tomatoes,"Original sauce",Flour}	5
1730	840	8	Sweet Potato Pie	4.67	https://hurwucd.ru/vAhTggx	{Butter,Mushrooms,"BBQ sauce",Peanuts}	5
1770	5891	9	Pizza Florida	3.12	http://fihldgn.biz/JgPoEiX.js	{Pasta,Pasta,Meat}	2
1735	5794	8	Bean Green Chili Burritos	2.60	https://vkrftsy.info/uieetgN.html	{Peas,Tomatoes,Bacon,Meat}	1
1737	7516	9	Philadelphia with salmon	2.58	http://www.nthihvs.com/	{Basil,Rice,Salmon}	5
1751	1723	9	Pizza Italiano	6.82	https://www.tnpxwog.top/	{Cucumber,"Cottage Cheese",Peanuts}	4
1738	4414	9	Swedish Meatballs	4.37	https://hefdhtc.biz/pEpdLgY	{"Cottage Cheese",Onion,Milk,Corn,"Original sauce",Mayo}	5
1739	3179	9	Tortellini Bowls	5.41	https://bngkylr.edu/yaAmotY.php	{Chicken,Bacon,Bacon,"Original sauce"}	2
1740	8890	9	Peanut Butter	4.22	http://brclplb.ru/nkUwGLg.html	{Tomatoes,Mayo}	4
1742	9617	9	Pizza Texas	2.32	https://hsgmlpb.info/vsKZksw	{Peas,"Cottage Cheese"}	1
1756	512	9	Unagi Philadelphia	3.56	https://nvbfvrk.biz/	{"Bavarian sausages",Strawberry,Cheese,Potatoes}	2
1744	6184	9	Bean Green Chili Burritos	4.69	http://naolfqj.biz/FaeOYjI.js	{Mayo,"Cottage Cheese"}	3
1745	788	9	Bacon Cheese Burger	6.63	http://jynwtkb.net/jgcocDL.js	{Sugar,Flour,Pasta,Bacon}	3
1746	7395	9	Peanut Butter	7.49	https://mhyioqn.top/	{Grapes,"BBQ sauce",Mozarella,Cucumber,Peas,Salmon}	3
1747	1015	9	New York Style Cheesecake	2.71	http://njbuiyx.edu/ErVHGtu.jpg	{"Chili Pepper","Chili Pepper",Rice,Peas}	5
1748	6105	9	Wallmart	7.31	http://czswaej.net/	{Mozarella}	3
1749	5260	9	Crispy Chicken burger	3.12	https://wcwqjri.ru/TPwRaYZ.jpg	{Mayo,Meat}	2
1733	9310	8	Pizza Hawaiian	3.73	https://ukooidl.edu/xZcNdKD.svg	{Chicken}	5
1750	7947	9	Pizza Hawaiian	4.18	https://ocldoir.edu/LCIXDBm.webp	{"Cheese cheddar",Mushrooms,Milk,Nori,Peanuts}	3
1752	6365	9	Unagi Philadelphia	2.50	http://jvlzrxj.top/KYTWIQB.js	{Meat,Bacon,Mushrooms}	5
1753	6165	9	Original burger	3.22	https://lxeppjx.top/hgBWUDD.php	{Flour,Bacon,"Original sauce",Mushrooms,Tomatoes,"Cottage Cheese"}	1
1754	1582	9	Swedish Meatballs	4.57	http://cxpitlq.top/lVPDiWK.html	{Bacon}	5
1820	3268	10	Peanut Butter	5.65	http://elldmkh.org/guWRgIA.webp	{Sugar}	3
1757	5777	9	Crispy Chicken burger	4.97	https://wcxgfoi.com/jqLwEXw.html	{Peperoni}	2
1758	5395	9	Pizza Ocean	2.21	http://qslqcbx.edu/AOBvQXV.webp	{Butter,"Japanese tamago",Garlic}	1
1760	3110	9	Pizza Italiano	3.71	http://vfxpeal.net/IiRrJAV.js	{Chicken,"Bavarian sausages"}	4
1767	2551	9	Himawari	4.28	https://juqhelw.com/cSHRoTy	{Meat,"Original sauce","Cheese cheddar","Cream cheese",Meat,Corn}	1
1717	4013	8	Pizza Hawaiian	7.32	https://guxzoyq.top/TrATukw.webp	{Potatoes,Corn,Cheese,Flour}	1
1808	410	9	Pizza Pepperoni with tomatoes	3.19	http://lbwyvge.biz/JtNonfe.webp	{Grapes,Rice,Grapes}	2
1809	6827	9	Grape Jelly Sandwich	5.97	https://www.bbnrxtm.biz/begyEKA	{Grapes,Mushrooms,Mayo,Salmon,"Unagi sauce"}	2
1818	9445	10	Crispy Chicken burger	2.99	http://zwqghze.info/YIvrcaR.css	{Corn,Butter}	2
1796	6839	9	Wallmart	5.56	https://zuektye.biz/FYuNmHh.webp	{Chicken}	5
1812	4428	9	Grape Jelly Sandwich	4.67	http://rmciejp.top/ktxgGXH.html	{Rice,Meat,Flour,Peperoni,"Japanese tamago"}	4
1814	2216	10	Tortellini Bowls	3.39	http://uqkqvcv.edu/VHXwdmH.php	{Flour,Garlic,"Chili Pepper","Caramelized onions",Onion,Sugar}	2
1815	4395	10	Pizza	7.72	https://lobusbx.top/ZRTZtDn.php	{Milk,"Onion rings",Flour,"BBQ sauce",Bacon}	5
1813	9142	10	Pizza	2.94	http://chnafhx.biz/XPVcZqw.jpg	{Mushrooms,"Cottage Cheese",Milk}	5
1817	5679	10	Sweet Potato Pie	7.09	https://kumvish.top/GFXgxFp.js	{"Caramelized onions",Onion,Chicken}	1
1783	5334	9	New York Style Cheesecake	2.92	https://ozmrdjx.net/HUIrTdR.jpg	{Corn,Butter,Grapes,"Japanese tamago"}	3
1811	9379	9	Pizza	5.32	http://nqalmse.info/	{"Bavarian sausages",Salmon,Milk,"Japanese tamago",Peperoni,Meat}	5
1860	6462	151	Pizza Florida	5.02	https://abrbbmr.com/lbVPqTh.css	{Cucumber,Peanuts,Cheese,Peperoni,"Cheese cheddar",Corn}	4
1763	3520	9	Pizza Ocean	5.30	https://kgaisfg.net/lceBCCV.css	{Meat}	4
1773	987	9	Wallmart	6.23	https://dtwihpn.biz/SJrvQZp.webp	{Chicken,Corn}	1
1775	4360	9	Original burger	7.66	http://vwmcpgj.net/SfkghGC	{Butter,Mushrooms,Peanuts}	4
1789	2018	9	Pizza Texas	6.44	http://ueycxcb.org/iErdGUn.css	{Strawberry,"BBQ sauce"}	2
1784	7320	9	Pizza Texas	6.26	https://wnkgsyz.top/fVexxWe.js	{Mushrooms,Salmon}	3
1819	4412	10	Pizza Florida	2.50	https://jpfyhsf.top/qXLoOYJ.js	{"Cottage Cheese",Grapes}	4
1779	6771	9	Pizza Florida	4.35	http://hvvatfk.edu/pfXoUtg	{Garlic,Basil,Mushrooms}	4
1780	9801	9	Bacon Cheese Burger	6.03	https://nphxiub.info/HgmnPek.html	{Mushrooms,Potatoes,Rice,Corn,Milk}	2
1781	3564	9	Tortellini Bowls	2.84	https://byxmnix.edu/xpLgVOx.webp	{Meat}	4
1782	5327	9	Pizza Italiano	4.34	https://hsrlceg.org/IDRSMZr	{Chicken,"Cream cheese"}	2
1776	968	9	Sweet Potato Pie	3.88	http://neyqfbm.biz/GJtgkDm.html	{"Bavarian sausages","Bavarian sausages",Peperoni,"Cottage Cheese","Onion rings",Cucumber}	5
1778	2545	9	Pizza	3.10	https://www.qxojrga.top/ecAgKlX	{Salmon,Peperoni}	1
1777	8904	9	Peanut Butter	3.31	https://mcwmvdd.biz/Larlpsu.php	{Peperoni}	1
1786	793	9	Swedish Meatballs	7.70	http://gufguwl.info/TkPotAI.html	{"Cottage Cheese","Chili Pepper",Cheese,Flour}	5
1787	7370	9	Philadelphia with salmon	2.48	https://vhjphda.biz/ljWoEqB.html	{Milk,Potatoes,"Japanese tamago",Grapes,Bacon}	4
1788	6734	9	Pizza Hawaiian	4.42	https://jmtmpca.org/wWMNhSX.svg	{"Bavarian sausages",Cheese,Corn,Milk,Bacon,Mushrooms}	3
1791	7827	9	Pizza Italiano	6.97	http://nhaypgh.edu/DCubMaZ	{Mozarella,Onion,"Japanese tamago"}	1
1790	234	9	Chicken Pot Pie	5.99	http://fzwkpam.org/nNvLgno.jpg	{Milk,"BBQ sauce","Cream cheese",Pineapple}	5
1785	709	9	Saint Frank Coffee	2.06	http://dcxvqkq.ru/	{Basil}	2
1792	2598	9	Unagi Philadelphia	2.41	https://mbcexlo.edu/ylLaVTI.html	{Peas}	1
1794	3374	9	Swedish Meatballs	2.60	https://jxjubal.top/	{"Cottage Cheese","Caramelized onions",Flour,Mushrooms,Pasta}	3
1797	5488	9	Pizza Italiano	2.62	http://waxcdsp.net/	{"Caramelized onions","Caramelized onions",Pasta,Meat}	4
1795	1107	9	Pizza Italiano	2.71	http://www.litvafw.biz/	{Meat,Peanuts}	1
1804	2350	9	Bean Green Chili Burritos	7.98	http://svuchjp.net/EhMjZgo.jpg	{"Cottage Cheese"}	1
1798	9938	9	Saint Frank Coffee	5.36	http://www.wqptqae.edu/	{Basil}	5
1800	5001	9	Unagi Philadelphia	2.21	https://godlocl.edu/JKAEJUv.jpg	{Cucumber,Meat,"Caramelized onions",Corn,Salmon}	1
1801	6114	9	Pizza Florida	7.73	https://xjatnrl.net/TRuHaod.js	{Pineapple,"Onion rings",Cheese}	4
1799	499	9	Angel Food Cake	6.42	http://www.sqpiosm.biz/	{Strawberry,Flour,Mayo,Mayo,Tomatoes,Sugar}	4
1802	4251	9	Pizza Ocean	7.15	https://osqgaff.com/OJkHpLG.css	{"Cottage Cheese"}	1
1803	4767	9	Unagi Philadelphia	5.06	https://rejafqh.info/	{Mayo}	5
1806	5701	9	Swedish Meatballs	2.88	http://www.forjfrx.top/	{Tomatoes,Peanuts,Bacon,"Unagi sauce","Cottage Cheese",Milk}	5
1805	3480	9	Wallmart	4.58	http://kcgbdib.net/GPeXPWq	{Milk}	4
1909	9393	153	Pizza	6.58	https://www.lfokwai.top/PiIUXso	{Chicken,Sugar,Tomatoes,Milk,"BBQ sauce",Flour}	2
1839	6692	10	Peanut Butter	3.93	http://ncdrgdi.edu/usJwweO.webp	{"BBQ sauce",Mozarella,"Cheese cheddar",Mushrooms}	2
1842	8273	151	Philadelphia with salmon	7.16	https://acuyfxe.top/SsnDvyD.webp	{Mozarella,Tomatoes,Peanuts,Grapes,"Original sauce"}	3
1826	5431	10	Pizza Ocean	6.63	http://hmasvkp.edu/MvTRmBb.js	{"Chili Pepper",Nori,Grapes,Mushrooms,Tomatoes,Salmon}	4
1827	7055	10	Pizza	7.26	https://www.xkcqcqs.net/WfFGUHe	{Onion,Carrots,Carrots,Garlic,Mozarella}	5
1851	2330	151	Unagi Philadelphia	5.90	https://wrtewad.com/vclwZeq.svg	{"Unagi sauce",Onion,"Cream cheese",Corn}	4
1852	6927	151	Crispy Chicken burger	2.05	http://kvlhjji.edu/cwHJjOp.html	{Mozarella,"BBQ sauce",Meat,Salmon}	1
1830	9481	10	Chicken Pot Pie	6.57	https://cpqnqan.ru/GgfxBvR.svg	{"BBQ sauce",Carrots,Bacon,Milk}	4
1831	2704	10	Wallmart	4.90	https://cwjgcvc.ru/KOqPcuA.jpg	{"Unagi sauce"}	4
1855	991	151	Tortellini Bowls	3.53	https://hjdhoxv.org/vOjWELs	{Peas,Grapes,"Cheese cheddar","Japanese tamago"}	5
1834	5086	10	Pizza Florida	5.02	https://www.gbdimee.org/dLODGKe	{"Cheese cheddar",Sugar,Garlic,Grapes,Flour,Mushrooms}	4
1840	8450	10	Pizza Pepperoni with tomatoes	6.44	https://gphbuln.edu/xFUAvPH	{Potatoes,"Chili Pepper",Onion}	1
1836	8417	10	Original burger	6.26	https://rknxckg.com/JIfWRKZ.css	{Flour,"BBQ sauce","Cream cheese",Meat}	3
1862	4690	151	Tortellini Bowls	2.38	https://misrhcd.edu/yHPElGm.js	{Pasta,"Chili Pepper",Mayo,Rice}	5
1838	1465	10	Original burger	5.44	https://www.hiuojxg.edu/sEvYhpx	{Carrots,Salmon,Strawberry,Pasta,Pineapple,Nori}	4
1864	4363	151	Unwrapped Burrito Bowl	4.39	https://xubmdte.info/	{Garlic,Sugar,Nori,Onion}	4
1845	8793	151	Crispy Chicken burger	3.33	https://www.uqgtbdf.biz/	{Onion,Cheese,Cucumber,Bacon,Garlic}	1
1841	2202	151	Original burger	6.53	https://mwbhnnh.ru/oygUYCV.svg	{Garlic,Meat,Mushrooms}	2
1908	2151	153	Pizza Pepperoni with tomatoes	4.02	https://uchvnqo.info/	{Mozarella,Sugar}	5
1848	4377	151	Peanut Butter	5.49	https://bmsgngx.org/MHngKNW.html	{Chicken}	1
1844	7777	151	Pizza Hawaiian	2.25	http://sbcgsxd.ru/RcGMGXl.js	{Mushrooms,"Cheese cheddar"}	5
1910	1564	153	Pizza Ocean	7.96	http://www.doysmyw.ru/CuWMdtP	{Butter,Cheese,"Bavarian sausages","Original sauce","Unagi sauce",Grapes}	3
1846	9000	151	Pizza Ocean	6.82	http://qoptmsv.com/NMWkpeY.jpg	{Rice}	2
1847	1398	151	Peanut Butter	7.49	http://mwqttnt.org/kCIhwXv.css	{Milk,"Cottage Cheese","Cream cheese"}	2
1825	6903	10	Bean Green Chili Burritos	5.62	http://joxndrs.ru/aPgkKlL.css	{Pineapple}	3
1849	7483	151	New York Style Cheesecake	2.69	https://coginkt.top/eJcXHkn.css	{Mushrooms,"Unagi sauce",Peperoni,"Cheese cheddar"}	4
1850	8045	151	Pizza Pepperoni with tomatoes	5.97	https://fdurdbr.com/lEySYiE.js	{Pineapple}	4
1835	797	10	Bacon Cheese Burger	3.73	https://zsernur.top/FOrkBAC.css	{Flour,Butter,"Cheese cheddar",Mozarella,Nori,Peas}	1
1857	1788	151	Angel Food Cake	6.20	https://www.ggylukq.net/sntgnkL	{"Japanese tamago"}	2
1853	9557	151	Wallmart	2.65	https://dtkwvow.com/ufwyrjO.js	{Potatoes,Sugar,Tomatoes}	2
1854	931	151	Pizza Pepperoni with tomatoes	6.62	http://pcaoieh.net/bYfCSXI.webp	{Rice,Salmon,Mushrooms,Basil,Bacon,Tomatoes}	1
1863	446	151	Unagi Philadelphia	5.37	http://qmxpufe.net/scQDbIm.svg	{Butter,"Chili Pepper",Pineapple}	2
1828	7731	10	Saint Frank Coffee	7.14	https://www.oabnhna.com/gemEmst	{"Chili Pepper",Mozarella,Nori,"Unagi sauce",Onion,"BBQ sauce"}	4
1829	5868	10	Pizza Pepperoni with tomatoes	4.46	http://www.xykpkdt.com/nfZlOtf	{Bacon}	3
1858	8456	151	Pizza	2.01	https://mygyhwp.edu/xTBYyKt.svg	{Cucumber}	3
1843	1930	151	Unwrapped Burrito Bowl	2.70	http://www.sdctwqe.ru/KwvObfC	{"BBQ sauce",Rice,Flour,"Japanese tamago",Pasta}	3
1833	1761	10	Original burger	6.41	http://wkmaseh.org/WdiBYoE.js	{Butter,"Caramelized onions",Onion,"BBQ sauce",Salmon}	4
1856	668	151	Bean Green Chili Burritos	7.91	http://jkgdtst.info/UbkXoEI.jpg	{Mayo,Bacon,Salmon,"Chili Pepper",Bacon,Flour}	3
1865	3513	151	Pizza Italiano	7.46	https://floebta.com/	{Meat,"Bavarian sausages"}	1
1907	203	153	Pizza Florida	7.38	https://rimrlsi.edu/DgRRLIU	{Mushrooms,"Original sauce","Cheese cheddar",Potatoes}	4
1837	2526	10	Pizza Hawaiian	7.66	https://zaewrsc.com/snKinfp.html	{Flour,Carrots,"Cottage Cheese",Basil,Potatoes,"Caramelized onions"}	1
1824	2771	10	Crispy Chicken burger	7.00	https://bdcevhq.ru/EJGEZiG.webp	{Mushrooms,Sugar,Peanuts,Garlic}	3
1911	5845	153	Original burger	6.12	http://owjlmfm.net/JdLOgjy.svg	{"Cream cheese",Flour,"Cream cheese"}	5
1874	3754	152	Pizza Ocean	2.91	https://csvvmxk.com/UkiEBys.webp	{"Caramelized onions",Meat,Grapes}	1
1914	4894	153	Chicken Pot Pie	7.16	https://otawqnq.org/kvBWEFW.php	{Corn,Pasta,Cucumber}	5
1917	8316	153	Pizza Italiano	2.53	http://www.vddknub.ru/wceDfKM	{"Original sauce",Flour,Pasta,Meat,Nori}	5
1879	176	152	Wallmart	4.72	http://rtnpeio.com/ekJUJTM.php	{Basil,"Chili Pepper",Bacon,Butter}	4
1953	4475	153	Peanut Butter	4.23	https://tkfwohw.org/SMnAFaV.webp	{Peas,"Original sauce"}	4
1881	9047	152	Chicken Pot Pie	7.36	http://uiprqaq.org/uhcJwjt.jpg	{Onion}	1
1954	4470	153	Unwrapped Burrito Bowl	4.36	http://ogxfskv.biz/TqYxnbX.html	{Mozarella,"Caramelized onions"}	1
1955	3492	153	Bean Green Chili Burritos	2.60	http://rtndzck.ru/AsfGTlu.html	{Potatoes,Mayo,Cucumber,"Cottage Cheese",Meat,Salmon}	5
1895	5427	153	Bacon Cheese Burger	4.21	https://jhnyxkp.ru/wpyxYqW.php	{"Cream cheese","BBQ sauce",Mushrooms,Pineapple,Mozarella}	3
1957	1223	153	Peanut Butter	3.48	http://nonhopx.org/	{Carrots,Cheese}	3
1868	2576	152	New York Style Cheesecake	3.23	http://muuvqce.net/hyMacxO.html	{Sugar,"Caramelized onions"}	5
1869	1285	152	Unagi Philadelphia	5.67	http://ufbffhx.ru/uugARjk.css	{Grapes,Meat,Carrots,"Unagi sauce"}	2
1870	3738	152	Pizza Florida	7.62	https://ljfttdm.top/NjiAIpm.jpg	{Cheese}	5
1901	7563	153	Bacon Cheese Burger	4.08	https://upixmex.edu/lCRSUgR.html	{Bacon,Peperoni,Flour}	2
1892	2943	153	Bacon Cheese Burger	6.49	http://cjozcqp.info/NEWRWdc.js	{Sugar,"Original sauce",Mushrooms,"Caramelized onions"}	5
1903	9660	153	Pizza Pepperoni with tomatoes	4.07	https://mxrqovt.com/	{"Cottage Cheese",Bacon,Carrots,Chicken,Grapes}	3
1875	2171	152	Wallmart	6.69	https://ykxacwo.edu/sXWkeIy.html	{Tomatoes,Milk,Basil,Peanuts}	4
1876	8755	152	Wallmart	5.98	http://aqhyclj.info/jausRbT	{"Japanese tamago",Tomatoes,Chicken,Garlic,"Cottage Cheese"}	4
1878	5538	152	Pizza Pepperoni with tomatoes	7.55	http://fptludj.net/gpHvosP.html	{Bacon,Peas,"Unagi sauce"}	3
1916	4588	153	Pizza Florida	5.07	https://oaxmika.ru/qCLnnOa.html	{Potatoes,Pineapple,Peas,Grapes,Salmon}	1
1880	7431	152	Saint Frank Coffee	5.27	http://unihdnl.net/yiDlHxd.css	{Mushrooms,Flour}	4
1918	3566	153	Pizza Ocean	4.46	https://alqcchp.ru/IWCtJqM	{Peperoni,Cucumber,Mayo,"Cheese cheddar"}	4
1882	4882	152	Pizza Pepperoni with tomatoes	4.99	http://akgvttx.org/wZZuZGe	{Butter}	1
1883	3929	152	Sweet Potato Pie	6.09	https://www.vadaxby.ru/rHIXDDj	{Grapes,Mayo,Potatoes,"Unagi sauce"}	1
1884	496	152	Bean Green Chili Burritos	4.17	http://jiltevw.ru/TjIkBaO.php	{Pasta,Sugar,Peperoni,Cheese,Mushrooms}	1
1886	8105	152	Original burger	7.34	https://vthfckt.ru/AhfNVIA.webp	{Basil,Grapes,Cucumber}	5
1887	7234	152	Pizza Florida	4.04	http://alypxqh.org/	{Potatoes,Strawberry}	3
1888	9460	153	Peanut Butter	3.01	http://toyxass.com/	{Cucumber,Nori}	4
1889	9645	153	Angel Food Cake	2.90	https://ghjxnbg.ru/RhDGrRI.css	{Mayo,Sugar,Grapes,Chicken,"Japanese tamago",Mozarella}	3
1890	9930	153	Pizza Italiano	6.91	https://rqysfjp.ru/myrdmFn.php	{Mushrooms,"Cheese cheddar",Onion}	3
1891	3301	153	Sweet Potato Pie	3.41	https://akanouy.biz/eRTqbiv	{"Cream cheese",Peanuts,"Caramelized onions",Mushrooms}	3
1871	6733	152	Pizza Pepperoni with tomatoes	7.73	http://naufnvh.net/oqFBdYM.jpg	{Rice,Mayo,Peas,"Chili Pepper"}	1
1893	7192	153	Pizza	6.64	https://ecxcwna.top/	{Flour,Peanuts}	4
1894	3690	153	Bacon Cheese Burger	4.50	http://zmwonom.ru/dIlTstq	{Mushrooms,"BBQ sauce",Salmon,Mayo,Cucumber}	4
1896	3364	153	Bean Green Chili Burritos	3.58	https://ytspctk.ru/ftKVUSA	{"BBQ sauce","Cheese cheddar",Cucumber,Peperoni}	2
1956	2230	153	Pizza Texas	4.76	http://ehuajhd.org/YZJMFEe.webp	{"Original sauce"}	3
1897	6782	153	Sweet Potato Pie	4.52	https://lvuafoa.info/VkDMjci.jpg	{Butter,"Chili Pepper"}	3
1898	9945	153	Sweet Potato Pie	7.49	https://www.rxfkqhl.info/dKqhOCr	{Mushrooms,Pineapple,Meat,Cheese}	4
1899	5102	153	Chicken Pot Pie	2.06	http://ynjbolh.top/	{Nori,Peperoni,Bacon}	4
1900	6309	153	Peanut Butter	4.70	https://vxmahuu.ru/UnVSPeO.jpg	{Pasta,Mozarella,Cucumber}	1
1902	5226	153	Sweet Potato Pie	7.01	https://svakzlx.top/uGpYZmd.webp	{Onion,"Chili Pepper",Cheese,"Cheese cheddar","Chili Pepper"}	1
1873	2326	152	Pizza Italiano	7.36	http://pnjvniz.com/sbRSQBO	{Grapes,Sugar,Corn}	1
1915	3818	153	Grape Jelly Sandwich	4.32	https://phvwvvz.ru/wqpYwXH.jpg	{Cheese,Bacon,"Cream cheese",Pasta,"Unagi sauce"}	1
1937	8583	153	Himawari	4.25	http://www.tdzzahp.info/aFKgVyL	{Rice,"BBQ sauce",Nori,Flour,Corn,Meat}	1
1925	2924	153	Pizza Ocean	2.53	https://wifaksq.top/btadedH	{Corn}	3
1923	4350	153	Himawari	2.29	http://szslmhw.net/	{"Japanese tamago","Original sauce","Cheese cheddar",Peperoni,"Chili Pepper"}	2
1997	1860	154	Pizza Pepperoni with tomatoes	4.71	https://jdbwvkq.info/JqjLQaZ.svg	{"Onion rings",Meat,Cucumber,Carrots,Tomatoes,Sugar}	5
1964	2985	153	Chicken Pot Pie	7.61	https://oaahjmg.edu/sXWEgsr.jpg	{Basil,Pineapple,"Cream cheese"}	4
1921	1035	153	Pizza	4.88	https://neizllu.net/pmKPtVq	{"Caramelized onions",Garlic,Basil,Corn,Butter,Basil}	2
1930	6012	153	Pizza Florida	2.80	https://bltnmdh.edu/jlpuPiC.webp	{Pasta,Nori,"Cheese cheddar"}	5
1942	4553	153	Tortellini Bowls	2.45	http://rqyomfd.com/MoaALIo.jpg	{Mozarella,"Bavarian sausages",Milk,"Original sauce","Bavarian sausages",Flour}	3
1939	4158	153	Pizza Italiano	5.95	http://tjtnwqo.net/QinmPoJ.webp	{Meat,Mushrooms,Flour,Flour}	1
1944	9020	153	Pizza Pepperoni with tomatoes	2.49	https://gnoiirw.top/	{Peperoni,Garlic}	3
1949	9961	153	Tortellini Bowls	4.42	https://cjlbvfm.biz/kBiAmxd.webp	{Corn,"Caramelized onions",Carrots,Mushrooms,"Bavarian sausages"}	3
1962	9656	153	Pizza Texas	7.26	http://rwtaexm.info/GycMcyX.html	{Sugar,Mayo}	2
2000	5861	154	Saint Frank Coffee	7.17	http://www.mtdvcyi.net/	{Tomatoes,Bacon}	5
1932	4908	153	Tortellini Bowls	4.04	http://ruuvsog.net/bjKnInx.js	{Peanuts,Carrots,Mushrooms,Salmon}	2
1933	8055	153	Pizza Ocean	2.94	http://mtdtttm.com/PcwqUhX.html	{Pasta,Flour,Tomatoes,Rice,Mayo}	4
1935	9913	153	Original burger	6.22	http://ceygezr.top/XTDSXbQ.webp	{Cheese,Mozarella,"Original sauce",Cheese,"Unagi sauce"}	3
1938	5293	153	New York Style Cheesecake	6.23	https://rqlqack.net/qZqRriO.js	{Sugar,Basil,Garlic,Peanuts}	5
1946	4291	153	Bacon Cheese Burger	2.17	https://spgvytp.org/SOyLhbc.js	{Salmon,"Onion rings"}	2
1947	106	153	Swedish Meatballs	5.23	http://www.tvemvff.info/	{"Japanese tamago",Meat}	4
1950	8679	153	Philadelphia with salmon	4.27	https://gprlwcr.edu/	{Mushrooms,Tomatoes,Flour,Nori,Meat}	4
1963	6368	153	Pizza Pepperoni with tomatoes	5.39	http://www.cddshbv.org/rMgMjAc	{Peanuts,"Onion rings",Bacon,Peas}	2
1959	4543	153	Pizza Pepperoni with tomatoes	3.85	http://niflvyk.info/mKWOwgP.jpg	{"Cheese cheddar",Mushrooms}	5
1999	9133	154	Peanut Butter	7.24	http://rckckon.info/HyeZvtj.php	{Butter,"Cheese cheddar",Pineapple}	2
1922	3607	153	Saint Frank Coffee	5.42	http://qlzjlqi.top/pkEdYpd.svg	{Peperoni,Garlic,Peanuts,"Chili Pepper",Mushrooms}	2
1924	4080	153	Original burger	5.20	http://kydzahm.top/WQnwMxK.svg	{Grapes}	4
1934	3671	153	Pizza Hawaiian	7.89	http://xvheaia.edu/kLymXmv.webp	{Peanuts,Flour,Peanuts,Meat,"Caramelized onions"}	3
1936	8680	153	Pizza Hawaiian	2.46	https://cuicctr.com/VtPZYre	{Onion}	2
1940	5353	153	Tortellini Bowls	7.11	http://www.tpqrbky.edu/	{Sugar}	5
1926	4505	153	Pizza Italiano	7.44	http://sbulkiw.biz/	{Rice,Pineapple,Cheese}	3
1920	4639	153	Himawari	7.54	https://wqgoxfu.org/uqRHbcP.html	{"Unagi sauce","Bavarian sausages",Salmon,Rice,Peperoni}	2
1943	2822	153	Crispy Chicken burger	3.26	https://www.caybzvp.net/	{Garlic,"Caramelized onions",Peanuts,Cheese,Flour}	2
1960	2477	153	Pizza Texas	7.23	http://hmwocaw.info/	{"BBQ sauce"}	4
1965	7310	153	Bacon Cheese Burger	5.04	https://xwfwyda.ru/wpSnGYC.js	{Tomatoes,Bacon,Potatoes,Strawberry,Bacon,"Chili Pepper"}	2
1945	346	153	Himawari	2.50	https://www.obuxfoo.edu/	{Potatoes,Garlic,Potatoes,"Bavarian sausages"}	1
1961	1675	153	Pizza Italiano	6.47	http://ernvtjb.biz/elxrYkc.php	{Mayo,Sugar,Chicken,Milk,Sugar}	1
1929	7638	153	Tortellini Bowls	3.99	http://qbbwsvx.net/LrPtVEF.js	{Corn,"Bavarian sausages",Onion,Peas,Flour,"Caramelized onions"}	2
1948	287	153	New York Style Cheesecake	2.92	https://mpjiesx.org/PrFJalj.php	{Pasta,Milk,Bacon,"Onion rings",Pasta}	2
1941	2868	153	Pizza Florida	3.21	https://www.mfvkrby.top/	{Onion,Cheese,Garlic,Peanuts}	4
2047	2960	154	Wallmart	6.85	http://asfkbif.com/mMURhqc.html	{Peas,"Japanese tamago","Cottage Cheese",Strawberry}	2
1984	5687	154	Peanut Butter	4.34	http://vbwmsoe.top/UtOPoVt.webp	{Bacon,"Cottage Cheese",Cucumber}	5
2006	6476	154	Swedish Meatballs	3.82	https://opykmsp.net/RaimhyC.webp	{Mushrooms}	1
1988	9574	154	Saint Frank Coffee	3.20	https://npvnbxb.top/dNFiZOb.html	{Milk,"Japanese tamago",Meat,Mozarella}	4
2012	9336	154	Wallmart	6.95	http://xseekfv.org/wAIpghV	{Garlic,Mushrooms,Bacon,Onion}	4
2048	95	154	Pizza Ocean	2.34	https://diqtojo.biz/MOcuRVG.php	{Corn,Onion,"Onion rings","Japanese tamago","Japanese tamago","Onion rings"}	4
2049	5512	154	Sweet Potato Pie	3.51	https://dzghihc.biz/NHjnHPE.php	{Pineapple,"Cheese cheddar",Tomatoes,Nori,Tomatoes,"Cottage Cheese"}	1
1967	5176	154	Bean Green Chili Burritos	7.30	https://kjhzhxj.info/ceaMbPH.webp	{Butter,"Cheese cheddar",Cheese,"Cream cheese"}	4
1979	5910	154	Himawari	4.21	https://wiwnqts.org/FfMiNRf.php	{Garlic,Nori,Peas,Sugar}	5
1985	8107	154	Bean Green Chili Burritos	3.07	https://eurcamz.biz/mkoipxw.jpg	{"BBQ sauce",Sugar,"Onion rings"}	3
1989	9207	154	Pizza Florida	2.91	https://awdiotv.net/	{Nori,Mayo}	5
1992	2067	154	Unagi Philadelphia	4.31	https://xjncnbk.edu/TfVAvHa.jpg	{Mushrooms,Garlic}	5
2008	6367	154	Saint Frank Coffee	3.14	https://www.iovtqnr.info/	{"BBQ sauce","BBQ sauce","Onion rings","Unagi sauce"}	5
2009	9653	154	Pizza Florida	6.66	https://mfmcdge.edu/KLJBTRp.svg	{"Chili Pepper","Japanese tamago"}	4
2010	756	154	Grape Jelly Sandwich	7.89	https://vakgtfm.com/omrgUxX.webp	{Corn,"Japanese tamago",Tomatoes}	5
2013	2530	154	Bean Green Chili Burritos	2.73	https://rgupzja.top/oNawKor.html	{"Cream cheese","Onion rings","Cream cheese","Cottage Cheese",Bacon}	1
2014	8871	154	Wallmart	3.19	https://cycljhr.edu/havVdXp.svg	{"Cottage Cheese"}	1
1968	2214	154	Original burger	2.98	http://www.wwygbry.net/buVpWMv	{Mushrooms,Bacon,Strawberry}	2
1969	3526	154	Chicken Pot Pie	4.66	http://mghgwnf.com/wTWBHkA.js	{Tomatoes}	3
1970	8059	154	Pizza Florida	4.69	http://hiculej.net/	{Flour}	3
1972	3499	154	Chicken Pot Pie	6.09	https://jnhivvo.net/HETZskx	{"Japanese tamago",Potatoes,"Cottage Cheese",Pasta}	3
1973	1425	154	Grape Jelly Sandwich	3.45	http://www.iqngwcc.ru/QQWMwmi	{Flour}	5
1980	1953	154	Pizza Florida	2.85	http://www.defkrbb.info/ilxQMaD	{Corn,Peanuts,Peas,Milk}	3
1986	6145	154	Pizza	4.80	http://qkwkrmx.top/RddrhBC.webp	{Corn,"Chili Pepper",Sugar,Basil,"Japanese tamago","Cheese cheddar"}	1
1981	8610	154	Original burger	5.43	https://xsameym.ru/EpjEbGN.html	{Corn,Flour,Nori}	1
1982	3907	154	Wallmart	2.55	http://xtucqrc.biz/bUxOtKl.html	{Cheese,Nori}	4
1987	8099	154	Chicken Pot Pie	2.48	https://ucpbndd.ru/JUuisRn.jpg	{"Bavarian sausages",Corn,Cheese,"Bavarian sausages"}	2
1994	9114	154	Saint Frank Coffee	4.48	http://www.wouqkag.net/bOhlPqg	{"Japanese tamago",Mozarella,Nori,"Onion rings",Bacon}	5
2018	945	154	Pizza Hawaiian	4.16	http://zscmnub.biz/	{Meat}	2
2046	7783	154	Angel Food Cake	5.72	http://ukuamzb.top/nfTfxfP.css	{Mayo,Pineapple}	5
2142	572	155	Pizza Italiano	7.83	https://lrbahbk.edu/CkOABcy.php	{Nori,Flour,Mayo}	3
1975	7385	154	New York Style Cheesecake	4.15	https://aagdvpb.org/Auufytq	{Carrots}	3
1976	2700	154	Sweet Potato Pie	3.63	http://vklioog.ru/YJRlScM.css	{Basil}	2
1971	4286	154	Pizza Italiano	6.37	http://www.maqkeco.ru/JIRnNtC	{"Cottage Cheese",Sugar,Pineapple,"BBQ sauce"}	1
1978	7999	154	Pizza Ocean	3.88	https://ifioojc.top/YUWiFtd.js	{Corn,Corn}	1
1983	3618	154	Pizza Italiano	3.36	http://egjuuhd.com/VkFgpRX.svg	{Corn,Carrots,"Cream cheese",Tomatoes,Bacon}	3
1995	7477	154	Himawari	3.12	https://lroezjv.com/xRdsHOZ.css	{Rice,Flour,Meat}	5
2011	7202	154	Pizza Italiano	6.19	https://xclajyn.info/mZhDaqn.svg	{Flour,Chicken,Peas}	4
2036	6002	154	Angel Food Cake	3.18	https://www.eboyjaa.edu/	{"Caramelized onions"}	2
2042	1841	154	Pizza Pepperoni with tomatoes	6.76	https://picuvro.ru/cJxDxPF.js	{Grapes}	5
2032	8054	154	Chicken Pot Pie	4.93	http://qfltvlv.biz/mxZNtJW.php	{"Cottage Cheese"}	2
2053	9966	154	Unwrapped Burrito Bowl	6.32	https://www.xjihotw.top/	{Mushrooms,Salmon,Mushrooms,Grapes}	1
2054	9841	154	Pizza Hawaiian	6.83	https://hsildos.info/SajEhnf.js	{"Original sauce","Cottage Cheese",Milk}	5
2058	4127	154	Original burger	2.42	http://aaforhg.top/bjZFDUI.css	{"BBQ sauce","BBQ sauce",Peperoni,Chicken,Pasta,Tomatoes}	3
2059	5950	154	Pizza Texas	6.11	http://www.xfybavu.edu/	{Pineapple,Garlic,"Bavarian sausages",Garlic}	5
2065	6042	155	Tortellini Bowls	6.21	https://ysbmgya.info/KjylDjV.jpg	{Garlic}	5
2043	2748	154	Angel Food Cake	7.07	https://gmfijpa.top/xwZcDji.svg	{"Original sauce","BBQ sauce",Mayo,"Japanese tamago",Strawberry,"Japanese tamago"}	1
2066	5702	155	Pizza	7.29	https://xbmagfv.net/VqoVbQh.php	{"Cottage Cheese",Pineapple,Mushrooms,Carrots}	1
2055	3502	154	Swedish Meatballs	7.60	https://xkpoifg.ru/bREEgcb.js	{Bacon,Corn,Flour}	5
2037	5992	154	Pizza	5.58	https://vyqansi.top/OWIEtZH.svg	{"Japanese tamago",Peperoni,Garlic,Pineapple,Grapes}	4
2051	6762	154	Pizza	2.45	http://zmyiklx.net/ImffUUQ.html	{Butter,Pasta}	2
2069	7761	155	Unwrapped Burrito Bowl	5.54	http://lhgpueo.org/peNPjTX.js	{"Cheese cheddar",Rice,"Original sauce",Tomatoes}	2
2094	5850	155	Saint Frank Coffee	2.68	https://kuuahte.ru/OlmmdNC.css	{Mushrooms}	1
2060	7622	154	Bacon Cheese Burger	3.58	https://hubuync.net/dPxfubJ.js	{Meat,"BBQ sauce",Garlic}	3
2061	1454	154	Pizza Ocean	7.34	http://www.lqossfi.org/	{Potatoes,Butter,"Unagi sauce"}	4
2029	7301	154	Wallmart	5.78	https://uoekxph.com/MdoGAdq	{Flour,Mayo,Peanuts,"Original sauce",Tomatoes,Peperoni}	3
2062	3636	155	Pizza Florida	3.35	http://fbrrjbu.org/wrdqcoU.css	{Mozarella,"Chili Pepper",Nori,Potatoes}	4
2063	7082	155	Bean Green Chili Burritos	2.95	http://www.bnhkwpf.net/	{"BBQ sauce"}	5
2038	4617	154	Unagi Philadelphia	6.47	http://dntlpfg.com/PRksjel	{Meat,Grapes,Tomatoes,Milk}	3
2095	662	155	Angel Food Cake	4.79	https://www.qhohphj.org/	{Sugar,Corn}	5
2067	1996	155	Pizza Italiano	2.25	http://tphffga.ru/FEGnjmF.svg	{"Cheese cheddar",Peanuts}	5
2064	1534	155	Pizza Texas	3.18	https://cwaonqs.net/jrOIohl	{Cheese,Peas,Chicken,Cheese,Mayo,"Cheese cheddar"}	3
2068	2540	155	Pizza Ocean	4.09	https://www.zmngfxh.info/sPZlWGK	{Rice,Peas,Salmon}	1
2091	3626	155	Pizza Italiano	2.99	https://www.uwhavbl.com/	{Potatoes}	2
2096	8134	155	Grape Jelly Sandwich	3.12	http://www.ayonmnb.com/	{Basil,Meat}	2
2030	8142	154	Grape Jelly Sandwich	3.54	https://lnxgfcl.com/mLsVIpk.css	{"Caramelized onions",Mozarella,Flour,Meat}	2
2031	3308	154	Pizza Italiano	5.62	https://ufltgws.org/IATjhxy.php	{"Japanese tamago","Cream cheese",Flour}	4
2092	3827	155	Pizza Hawaiian	3.89	https://qpseyaz.org/RpLyufC.js	{"Chili Pepper",Sugar,Basil,"Cheese cheddar",Chicken,Corn}	5
2033	830	154	Crispy Chicken burger	4.05	https://owfyesx.edu/fBMRrSs.html	{"Chili Pepper",Mozarella,Salmon,Mushrooms}	3
2057	4650	154	Himawari	2.43	http://xmlotan.info/CfxrrUw.html	{"Cheese cheddar","Japanese tamago"}	2
2093	6469	155	Unagi Philadelphia	2.55	https://btvfdpy.edu/tEeTWWE.php	{Flour}	1
2282	9914	158	Saint Frank Coffee	7.15	http://cbnnifc.biz/dlkJGAW.js	{Mayo}	1
2034	8314	154	Unwrapped Burrito Bowl	3.78	http://www.fhuuyol.top/	{"Bavarian sausages"}	4
2035	8839	154	Philadelphia with salmon	7.34	https://qmutnxr.biz/dlWUOrh.jpg	{Cucumber,Onion}	1
2039	4280	154	Wallmart	2.82	http://www.goolsmu.com/AxiTtwX	{Peas,Butter}	2
2052	7610	154	Grape Jelly Sandwich	5.01	https://fbrnfqx.biz/AWrJOXB.html	{Peas}	5
2021	5375	154	Pizza Italiano	7.77	https://www.zltauit.net/	{Cheese,Cheese,"Cream cheese",Pasta,Meat,Peas}	3
2118	3906	155	Pizza Italiano	7.03	https://wzwiqwo.info/	{"Chili Pepper",Chicken,Flour,Mushrooms}	3
2119	4510	155	New York Style Cheesecake	2.51	http://www.vyimztk.edu/TBkSbWc	{Chicken,Basil,Mozarella}	1
2120	6656	155	Pizza Ocean	3.54	http://jhwldvo.edu/PNPRnFd.html	{Cucumber,Salmon,Rice,"Bavarian sausages"}	3
2106	8289	155	Crispy Chicken burger	4.63	http://jogftgl.info/VPKWaDU.php	{Grapes,"Cheese cheddar",Mozarella,Cucumber}	2
2136	2813	155	Chicken Pot Pie	2.71	http://wlyrmej.info/mxmWHUr.php	{Potatoes,"Bavarian sausages"}	4
2137	8333	155	Pizza Hawaiian	6.95	https://oswtstl.org/GuPIbpT.webp	{Nori}	5
2138	1670	155	Angel Food Cake	2.77	http://rydtwjc.info/FRqJOXR.css	{Onion,Peanuts}	2
2139	1074	155	Wallmart	3.26	http://tmnhfzd.top/lasQGWO.webp	{Grapes}	5
2140	3734	155	Pizza Texas	2.76	http://xqpppug.biz/ZtxvXNj.css	{Grapes,Salmon}	4
2072	3038	155	Pizza Ocean	7.30	http://krtoucn.org/DcgBjem.css	{Pineapple,"Cottage Cheese"}	2
2074	4887	155	Pizza Florida	5.93	https://www.swnocgi.com/	{Milk,Tomatoes,Peperoni,"Original sauce",Mayo}	4
2075	3456	155	Wallmart	7.58	http://www.stxvpdo.info/	{Grapes,Strawberry,Grapes,"Cream cheese",Sugar,"BBQ sauce"}	2
2076	8987	155	Pizza Hawaiian	7.86	http://anewowq.biz/DlpudIT.php	{"Japanese tamago",Potatoes,Corn,Cheese,"Bavarian sausages"}	1
2077	9374	155	Pizza Pepperoni with tomatoes	7.43	http://fwrwakm.ru/	{"Cream cheese","Chili Pepper","Chili Pepper"}	3
2078	595	155	Chicken Pot Pie	3.73	http://rssalbb.ru/xWEZEHt.svg	{Strawberry,Mayo,Pasta,Cheese,Mushrooms,Mozarella}	2
2079	9121	155	Pizza Texas	5.26	https://ogwmpud.org/IuDWoRU.js	{Salmon,Pineapple}	1
2080	5567	155	Himawari	4.32	http://www.nvuhnsh.top/JyNJYvv	{Carrots,Tomatoes,Bacon,Nori,Mushrooms,"Caramelized onions"}	4
2081	6522	155	Bean Green Chili Burritos	5.51	http://yemqaih.info/MlWTvpq.svg	{"Cottage Cheese",Onion,"Cheese cheddar"}	2
2082	398	155	Unagi Philadelphia	5.00	http://wyegjud.net/QhMjhmG.php	{Milk,Potatoes,Rice}	4
2083	3284	155	Pizza Pepperoni with tomatoes	6.63	https://ekbeytt.org/eTgifbB.svg	{Butter,"Caramelized onions",Pasta,Strawberry}	2
2084	3132	155	Swedish Meatballs	4.54	http://ojumkty.top/jKWBQSW.php	{Cucumber}	4
2085	8991	155	Pizza Ocean	6.73	http://lusvajs.ru/HavTfJA.js	{Peas,Peas,Peas,"Cheese cheddar"}	4
2086	3177	155	Pizza Ocean	3.96	http://buwzqcw.net/WbircGE.jpg	{Peas,Butter,Tomatoes,Sugar}	1
2087	8517	155	New York Style Cheesecake	3.94	https://exshbdf.edu/mUhNIiq.js	{Onion,Pasta}	4
2088	3956	155	Crispy Chicken burger	5.86	http://lyyglow.top/gDHpsrr.php	{Corn}	2
2098	5421	155	Angel Food Cake	6.50	https://fyupdkl.org/	{"Cottage Cheese",Mushrooms,Peas,Grapes,Mayo,"Original sauce"}	3
2099	3006	155	Philadelphia with salmon	3.68	http://skuoxsx.com/qdVRVEQ.svg	{Flour,Salmon,Mozarella,Tomatoes,Pineapple}	5
2100	9357	155	Wallmart	2.84	http://www.msvjdec.com/	{Strawberry}	4
2101	3565	155	Tortellini Bowls	2.14	https://sjuixhr.info/tufRhYA.js	{Corn,Onion,"Cheese cheddar",Bacon}	1
2102	9980	155	Pizza	2.97	https://czneyxx.edu/TXfFoiO.html	{"Original sauce"}	4
2103	9325	155	Pizza Hawaiian	4.39	http://lqhtgas.info/BweAgxi.html	{Milk,Peanuts,Cheese,Rice,"Caramelized onions",Bacon}	5
2105	1109	155	New York Style Cheesecake	5.06	http://xihbryh.top/ZLaPPmo.css	{Salmon,Peas}	3
2107	9313	155	Pizza Hawaiian	3.73	http://qefqdql.info/	{Nori,"Caramelized onions",Strawberry}	5
2108	9085	155	Sweet Potato Pie	5.62	https://mhbatxu.net/IrNqkYx.js	{Tomatoes,Mozarella,Peperoni,Carrots,"BBQ sauce"}	4
2109	3623	155	Pizza Italiano	5.09	https://nbldeom.ru/rCCVpOO.html	{"Unagi sauce",Garlic,Garlic}	2
2110	997	155	Pizza Hawaiian	6.73	http://xgzhdab.net/uKWWpMp.css	{Milk}	5
2111	41	155	Pizza Texas	7.54	https://dbwxuzs.org/cIVkkKF.jpg	{"Cheese cheddar","Cottage Cheese",Butter,Sugar}	1
2113	1316	155	Grape Jelly Sandwich	4.42	http://www.ttynlzn.net/WspmojT	{"Cheese cheddar",Mayo,Mayo}	1
2114	514	155	Pizza Italiano	5.44	https://www.frnbvef.info/shPuHkw	{Peanuts,"Cottage Cheese","Chili Pepper",Mushrooms,Bacon}	4
2115	4587	155	Chicken Pot Pie	5.45	https://tqilapn.net/	{Flour}	5
2116	7749	155	New York Style Cheesecake	7.65	https://bapsimi.net/RAssWWf.php	{Peperoni,"Cheese cheddar",Tomatoes,Cheese,"Chili Pepper"}	2
2117	7488	155	Grape Jelly Sandwich	5.58	http://scqxrid.com/nTJQkBH.jpg	{Peanuts,"BBQ sauce","Cream cheese",Tomatoes}	2
2121	4608	155	Unagi Philadelphia	7.66	http://www.pvdgkbd.biz/iiMRYUd	{Grapes,"Onion rings",Tomatoes}	1
2188	7508	156	Pizza Hawaiian	7.23	http://bayrajl.com/CfjVHxD.svg	{Cheese,Potatoes,"Onion rings",Grapes,"Cream cheese",Flour}	1
2134	2255	155	Pizza Hawaiian	5.40	https://www.stcybxl.biz/WGnSKHb	{"Bavarian sausages"}	2
2154	3013	156	Tortellini Bowls	5.08	http://www.fmpzyxa.ru/jDfLypZ	{"BBQ sauce",Mozarella}	3
2124	9840	155	Peanut Butter	4.08	http://xatejvg.com/Qutmiyu.php	{"Chili Pepper",Tomatoes,Pineapple,Sugar,Mayo,"Unagi sauce"}	3
2153	5877	156	Original burger	3.77	https://hvgmfdi.ru/htpDETB.webp	{Cheese,Mushrooms,Rice,Cheese,Strawberry,"Chili Pepper"}	2
2126	5816	155	Pizza Italiano	4.73	https://jdeqlff.info/TpLNnJf	{"Bavarian sausages",Butter,Peanuts,Carrots,Grapes,"Chili Pepper"}	1
2123	3030	155	Unagi Philadelphia	3.05	https://www.aijvwlu.net/	{Flour,Strawberry,Mozarella,Cucumber,Corn}	4
2127	7213	155	Swedish Meatballs	3.08	http://mmriopx.org/mUSyKJH.css	{"Cheese cheddar",Peperoni}	1
2128	2548	155	Himawari	6.44	http://cyufode.info/bwnJMfS.php	{Peanuts,Mozarella,Flour,Mozarella,"Original sauce"}	4
2162	5781	156	New York Style Cheesecake	7.55	http://www.oolitnx.org/yyTxbVF	{Tomatoes}	4
2130	9502	155	Unagi Philadelphia	5.63	http://www.ohmfvsv.com/xejsLek	{Rice,Mushrooms,Milk,Mozarella,Peanuts,"Cottage Cheese"}	5
2132	2483	155	Peanut Butter	7.88	https://vwswtte.info/fwbFrQl.webp	{"Cheese cheddar",Strawberry,"Cheese cheddar","Cream cheese",Potatoes}	1
2148	4064	155	Bacon Cheese Burger	4.00	https://esnkxsu.net/ujryBmd	{"Original sauce",Mayo,"Cottage Cheese",Tomatoes,"Bavarian sausages",Milk}	2
2145	7628	155	Bacon Cheese Burger	2.78	http://pbypywc.org/fpCXrrG.css	{"Original sauce",Garlic,Flour,Salmon,Onion}	3
2168	6396	156	Unagi Philadelphia	7.05	https://wgywyjc.top/cOwPHRx.webp	{"Original sauce"}	1
2161	3900	156	Swedish Meatballs	2.75	http://sioyuru.ru/RpjIWaP.html	{Butter,Butter,Salmon,"BBQ sauce",Basil}	2
2163	1152	156	Grape Jelly Sandwich	3.51	https://www.xayxysg.ru/OiRAufD	{Flour,Salmon,Bacon,Sugar}	3
2166	4760	156	Pizza Ocean	5.82	http://hsbcoxn.edu/ynhBqUp.php	{Carrots,Milk}	2
2149	7913	155	Bacon Cheese Burger	6.26	https://pksqbmr.net/	{Tomatoes}	1
2182	1804	156	Pizza	5.70	https://vctokhh.top/UbghREN.js	{"Onion rings"}	1
2150	8057	155	Crispy Chicken burger	3.38	https://skdiaau.edu/LWdNBrv	{Chicken,Garlic}	5
2151	9401	155	Crispy Chicken burger	2.85	https://nsrnwkt.net/roSfSWe.svg	{Bacon,"Cream cheese","Cream cheese",Flour,Sugar}	5
2152	3352	156	Unwrapped Burrito Bowl	7.89	http://dsctxtb.biz/JKjhJgi.php	{Mushrooms,Mayo,Salmon}	3
2158	8651	156	Pizza Texas	5.82	http://dhjfufm.info/yviPGjH.jpg	{Salmon,"Cream cheese","BBQ sauce"}	3
2155	5153	156	Swedish Meatballs	3.73	https://www.enagaih.top/yRwbjqO	{Meat,Mushrooms}	1
2189	1940	156	Himawari	5.81	https://chsqzqk.biz/CXniSmj.jpg	{"Original sauce",Peas}	5
2156	3441	156	Himawari	2.70	https://www.bddjmfu.biz/YyxuBIy	{"Original sauce","Bavarian sausages",Flour,Mushrooms,Mayo}	3
2157	172	156	Pizza Ocean	2.39	http://fxepgsq.biz/DbCvxZM.php	{Basil,"Cream cheese",Sugar}	1
2159	9810	156	Bean Green Chili Burritos	3.67	https://www.vywpksz.com/	{Flour,"Unagi sauce",Peanuts,Mayo,Tomatoes,"Bavarian sausages"}	2
2125	1247	155	Bean Green Chili Burritos	4.08	http://afgffyc.com/	{Sugar,Cheese,Strawberry,Tomatoes}	5
2160	9437	156	Unwrapped Burrito Bowl	4.34	http://wqvxyoz.org/ksyonCJ.js	{Milk,Cheese,"Caramelized onions","Cheese cheddar",Grapes}	2
2146	6679	155	Himawari	4.08	https://xiynbkc.edu/eihTHEE.jpg	{Meat,Carrots,Garlic,Cheese,Grapes}	1
2129	3841	155	Chicken Pot Pie	3.28	http://orijirj.info/WCqvntc	{Potatoes,Mayo,Cucumber,Salmon}	1
2164	8148	156	Pizza Ocean	5.11	https://www.aurtgds.ru/	{Nori,Pineapple}	4
2133	8962	155	Unwrapped Burrito Bowl	3.80	http://ttkujem.net/wVpijey.svg	{Onion,Potatoes,Salmon}	3
2184	4907	156	Saint Frank Coffee	6.52	https://smwwuau.biz/eBwaihR.svg	{Butter}	3
2165	3888	156	New York Style Cheesecake	5.12	https://ntkdynn.com/oQqAxPW.html	{"Chili Pepper",Mayo,Grapes,Basil}	5
2185	4554	156	Pizza Florida	7.47	http://kukwrox.net/aoNbAlw.svg	{Cheese,Mushrooms,"Onion rings","Chili Pepper",Butter}	5
2147	5268	155	Pizza Italiano	4.26	http://www.naknsph.com/gTjbUgV	{Corn}	3
2186	3710	156	Original burger	2.06	http://www.jhszosa.edu/	{Pineapple,Salmon,Butter,Corn}	3
2187	7365	156	Sweet Potato Pie	7.97	http://ktdwmwq.com/KOvuPft.webp	{Mozarella,Mayo,Pineapple}	4
2167	8738	156	Grape Jelly Sandwich	7.28	http://www.avowytm.org/	{Peanuts,"Onion rings",Onion,"Unagi sauce"}	1
2212	7752	156	Unagi Philadelphia	5.00	http://www.uauskyf.edu/	{Pineapple,"Original sauce"}	4
2215	3876	156	Grape Jelly Sandwich	5.76	http://www.suhpmyv.net/LngSHGr	{Flour,Meat}	2
2202	9858	156	Pizza Florida	5.37	http://eukncnk.org/UZdDusY.js	{Strawberry,"Cheese cheddar",Meat}	5
2229	2367	157	Saint Frank Coffee	5.66	http://ubbmfah.net/aqovVcK.svg	{Rice,"Original sauce"}	2
2230	8936	157	Tortellini Bowls	7.98	http://ovjdvvq.info/JhUdOPI.html	{Bacon,Garlic,Peas,Rice,Milk,Corn}	5
2231	8678	157	Grape Jelly Sandwich	5.51	https://fejuncs.ru/	{"Cheese cheddar",Peanuts,Onion,Mushrooms,Basil}	1
2233	5312	157	Peanut Butter	2.55	http://ellytvy.org/JtwgwGf.webp	{Bacon,Meat}	3
2234	4225	157	Pizza Italiano	5.47	http://vyjjivs.edu/wvohfxH.php	{Corn,Milk,Mozarella}	5
2232	2345	157	Pizza Pepperoni with tomatoes	4.29	https://kpmeswu.com/SDRutoO.php	{Flour,Onion,"Original sauce",Onion,Rice}	4
2175	4390	156	Pizza	5.08	http://durspdg.net/mFptXSK.svg	{Peanuts,Flour}	4
2283	5064	158	Saint Frank Coffee	6.41	https://www.yxnwxtf.com/ZnliiJj	{Mozarella,"Cream cheese",Strawberry,Mushrooms}	2
2235	9640	157	Bacon Cheese Burger	2.75	http://pagotae.com/LYngHxX.svg	{Rice,Potatoes,Garlic,Chicken}	2
2170	2522	156	Unwrapped Burrito Bowl	7.76	http://ctnfefd.org/iPWOxyR.js	{Peperoni}	1
2171	5765	156	Pizza Ocean	6.29	http://uifvvww.biz/uoRURbO.php	{Bacon,Potatoes,"Chili Pepper","Cream cheese",Meat}	4
2172	8498	156	Pizza Pepperoni with tomatoes	7.99	http://vetibfa.org/byAQtig.webp	{"Japanese tamago"}	3
2173	9742	156	Pizza Pepperoni with tomatoes	5.52	https://mhzbnni.org/kMUcRWD.php	{Corn,"Chili Pepper",Flour,Nori,Mushrooms}	2
2174	651	156	Saint Frank Coffee	6.54	http://oyrilcd.org/bWsamHO.svg	{Mayo,"Bavarian sausages",Pasta}	3
2176	3260	156	Himawari	5.63	https://dyhyhhe.biz/ZwYPlHF.svg	{Strawberry,Mozarella,"Bavarian sausages"}	2
2178	4901	156	Himawari	7.12	https://www.ametecz.edu/	{"Caramelized onions",Mushrooms}	5
2177	8114	156	Pizza Ocean	4.94	https://hmolras.info/fxeMRKx.webp	{Butter,Basil,Chicken,"Original sauce"}	3
2194	5879	156	Bacon Cheese Burger	3.63	https://wnngsef.info/NfNFcpk.svg	{"Unagi sauce","Cream cheese"}	1
2179	7729	156	Pizza Florida	2.99	https://jkqhycj.edu/xDIJfyl.css	{Bacon,Sugar}	5
2191	3465	156	Chicken Pot Pie	4.13	https://www.gloaovm.com/atxBMaI	{"Bavarian sausages",Nori,"Unagi sauce",Chicken,Nori,Garlic}	5
2192	447	156	Pizza Florida	7.63	https://hcbjutf.top/JkwaybW	{"Bavarian sausages"}	4
2193	8260	156	Swedish Meatballs	5.26	http://bhfghog.org/HitHgEK	{Mushrooms,Chicken,Mushrooms,Meat,Milk,Pineapple}	3
2195	3930	156	Pizza Ocean	2.68	http://riufxbn.info/AwUjbht.svg	{Salmon,Mushrooms,Mushrooms,Flour,Garlic}	4
2204	5497	156	Pizza Ocean	5.57	http://yjcmwow.top/LoKdpmO.jpg	{Peas,Salmon}	2
2197	8125	156	Bacon Cheese Burger	3.70	http://zfvvgml.biz/XyKotOv	{Cheese,Potatoes,"Cheese cheddar"}	3
2196	2952	156	Saint Frank Coffee	7.19	https://avyuval.edu/sGctuMD.css	{Grapes}	2
2206	7148	156	Chicken Pot Pie	3.62	http://fnopfme.org/mDvbbuR	{Peanuts}	2
2180	6161	156	Tortellini Bowls	4.60	https://ezmcqhd.info/ucpsyFK.jpg	{Sugar,"Caramelized onions",Pineapple,Nori}	2
2200	9733	156	Crispy Chicken burger	7.23	https://jmqkssi.info/aAxjKhD.css	{Butter,"Chili Pepper",Pineapple,Pasta}	4
2211	740	156	Chicken Pot Pie	7.01	https://wqtjzuu.org/EHTLoWB.jpg	{Milk,"Onion rings"}	5
2203	8025	156	Grape Jelly Sandwich	6.14	http://gymmcpm.top/PtPnbNj.webp	{Mayo,"Onion rings","Bavarian sausages",Rice,"Chili Pepper"}	3
2205	5062	156	Peanut Butter	2.36	https://irtcguw.edu/sEUTSOj.js	{"Cheese cheddar"}	5
2210	2990	156	Pizza Italiano	4.16	https://huusnof.org/MCPQeHb.js	{"Cheese cheddar","Japanese tamago",Mayo}	2
2198	6228	156	Bacon Cheese Burger	4.18	http://mqyirkr.net/MCdEGFA.html	{"Cottage Cheese"}	2
2207	377	156	Pizza Texas	2.36	http://nhvwpfe.edu/jtrRiED.jpg	{Flour,"Cottage Cheese","Cheese cheddar",Meat}	3
2201	7330	156	Philadelphia with salmon	4.07	http://www.wiafecb.net/	{Nori}	2
2213	1683	156	Himawari	3.71	https://bqixwgm.info/GeEsgae.jpg	{Pasta,"Unagi sauce","Caramelized onions",Peas,Pineapple}	2
2214	5415	156	Tortellini Bowls	3.07	http://www.wlglepw.com/	{Cheese}	1
2216	6622	156	Crispy Chicken burger	6.69	https://dsfjxfg.org/BPqmsKO.js	{Pasta,Peanuts,Tomatoes,Mozarella,"Bavarian sausages",Potatoes}	1
2217	8750	156	Tortellini Bowls	6.54	http://www.ojmuuhk.edu/	{Garlic,"Japanese tamago"}	4
2218	1568	156	Bean Green Chili Burritos	3.92	http://uwikyym.top/RbWKXbD	{Basil,Peperoni,"Cream cheese",Corn,"Onion rings"}	3
2226	7274	157	New York Style Cheesecake	7.78	https://www.wujkrgt.net/	{Meat,"Cream cheese",Mushrooms,Flour,Mayo,"Caramelized onions"}	2
2250	9965	157	Unagi Philadelphia	4.94	http://www.pkolkfl.biz/	{Potatoes,"Chili Pepper"}	1
2254	7001	157	Tortellini Bowls	3.94	http://dqsqwsd.org/KXkkNXu	{Flour}	2
2279	1573	158	Pizza Ocean	3.11	http://www.feliszm.info/	{Flour,Grapes,Pasta,Mayo,Cheese,Flour}	4
2280	9871	158	Grape Jelly Sandwich	6.43	http://npsqnaw.biz/XXwghcd.php	{Strawberry,Butter,"Cottage Cheese",Grapes,Chicken}	3
2256	138	157	Pizza Hawaiian	2.05	http://rcxkwjf.edu/TGnekkg	{"Caramelized onions","BBQ sauce",Butter,Mushrooms,Peas}	5
2220	6670	156	Pizza Texas	4.26	https://qyftjxa.ru/jNEGtms	{"Cheese cheddar","Cream cheese",Bacon}	1
2264	9861	158	Pizza Hawaiian	3.73	http://fqqpdlo.edu/	{Pineapple,Basil}	5
2244	8631	157	Pizza Florida	6.33	http://www.qreykyd.org/	{Peperoni,Onion,Salmon,"Bavarian sausages",Onion}	5
2222	5961	156	Pizza Hawaiian	6.63	https://rahwcej.com/	{Bacon,"Onion rings",Mushrooms,Mushrooms,"BBQ sauce"}	1
2247	7885	157	Original burger	3.89	https://ejvkrjl.biz/UGaXsRq.css	{"Cream cheese"}	1
2224	8953	156	Pizza Florida	6.96	https://fmnyjta.edu/GeAYihk.svg	{Milk,Chicken,Pasta,Pineapple}	2
2253	8598	157	Pizza Florida	4.67	http://www.ghekvfn.ru/	{Corn,"Japanese tamago","Caramelized onions",Mushrooms}	5
2240	4567	157	Bean Green Chili Burritos	3.22	https://nhmgkux.com/omeNrBL.svg	{Carrots,Chicken,Cheese}	5
2227	3985	157	Bean Green Chili Burritos	6.29	http://www.ypgmggq.org/GYKjQpf	{Rice}	4
2242	1131	157	Peanut Butter	6.62	http://kzdmhgz.edu/grXcJcZ.webp	{"Japanese tamago",Strawberry,"Chili Pepper","Onion rings"}	4
2238	1309	157	Sweet Potato Pie	7.72	http://alyomnl.top/eeBZJer.html	{"Japanese tamago"}	3
2239	7209	157	Pizza Florida	3.92	http://hubwfdn.info/PZsoAmR.css	{Peanuts,"Cream cheese","Bavarian sausages",Grapes,Basil}	5
2225	8635	157	Angel Food Cake	2.18	http://qmmvpnb.org/MQkMhim.jpg	{Carrots,Salmon,Bacon,"Bavarian sausages",Cucumber,Carrots}	4
2276	917	158	Pizza Florida	3.63	http://zeahkxk.top/uriJDOu.css	{Cucumber,Pasta,Flour,"Cheese cheddar","Cheese cheddar"}	3
2281	4644	158	Bacon Cheese Burger	3.26	https://wzndyqj.info/	{Butter,"Caramelized onions",Sugar}	1
2243	3469	157	Original burger	7.99	http://qmlvdef.info/bcpdPAu.css	{Onion,Grapes,"Chili Pepper",Chicken,Mayo}	1
2245	2415	157	Pizza Pepperoni with tomatoes	3.22	http://www.bqeyngs.ru/BXZYGvU	{"Chili Pepper",Flour,Pasta}	5
2260	554	158	Wallmart	7.40	https://rpltzrb.org/gKhKjTS.js	{Cucumber}	3
2246	1078	157	Pizza Florida	7.33	https://hkhmxus.org/lMFgert.svg	{"Onion rings",Mozarella}	2
2248	7026	157	New York Style Cheesecake	4.47	https://www.nwvayhc.biz/HbxZtqd	{Onion,"Bavarian sausages",Pasta,Peanuts,Corn}	2
2249	7218	157	New York Style Cheesecake	2.08	http://uivadwl.com/cSwEAeO.jpg	{Pasta,Bacon,Pasta,"Bavarian sausages"}	5
2251	3271	157	Bean Green Chili Burritos	3.38	https://winwdwm.biz/AMoHABb	{Cucumber,"Cottage Cheese",Cheese,Flour}	1
2266	2224	158	Pizza Pepperoni with tomatoes	2.31	https://skqktkl.edu/CPuSKUm.js	{Rice,Peas,Peas,Mayo,Mushrooms}	2
2223	8847	156	Pizza Florida	3.87	http://vhrfgra.net/uOJJUJb	{Mozarella,"Chili Pepper",Mozarella,Rice,Mozarella}	5
2252	9710	157	Saint Frank Coffee	5.12	https://ftbkoov.org/nVqJbGS.php	{Sugar,Chicken}	4
2255	9200	157	Pizza Florida	6.62	http://xnhhjoe.info/FNHMjTo.css	{Flour,Garlic,Flour,Meat,Tomatoes}	5
2262	6813	158	Chicken Pot Pie	2.97	https://sbathqu.com/	{Nori,Grapes,Onion,Corn}	1
2259	173	158	Angel Food Cake	6.56	https://dwtfave.biz/MwEltLr.css	{Flour,Carrots,Carrots}	4
2263	4604	158	Pizza Texas	2.75	http://oldkjwk.top/BVbQDfR	{Chicken,"BBQ sauce"}	3
2257	9749	157	Bacon Cheese Burger	4.48	https://stmcplp.ru/wKRWJhe.php	{Mozarella}	4
2261	2139	158	Bacon Cheese Burger	7.89	https://www.dipdbsg.net/	{"Cheese cheddar"}	3
2241	9163	157	Philadelphia with salmon	5.44	https://rutqdzd.edu/JvanEte	{Peas}	2
2237	4468	157	Saint Frank Coffee	3.52	http://xothnef.biz/SVcjgVC.php	{"Cream cheese","Chili Pepper",Flour}	1
2221	6907	156	Wallmart	3.48	https://lfqibhf.net/	{"Unagi sauce"}	2
2267	4230	158	Pizza Italiano	4.17	https://lmawlyx.net/ENWrCGx.css	{Sugar}	1
2277	6076	158	Pizza Ocean	4.72	http://punhcjp.org/IQCXWRl.php	{Mushrooms,"Original sauce",Pasta,Flour,Garlic,"Japanese tamago"}	1
2278	4858	158	Swedish Meatballs	5.85	https://mthnqxc.org/jTFrawy	{Basil,Milk,Tomatoes,Strawberry,Grapes}	1
2323	5705	158	Peanut Butter	2.58	https://olyiduy.org/CugVfUO.php	{Milk,"Onion rings",Carrots,Flour,"Onion rings"}	3
2324	6451	158	Pizza Florida	3.88	https://jdnbyin.biz/vchUFhV.webp	{Flour,Flour,Mushrooms,Pasta,Milk,Flour}	3
2309	5842	158	Wallmart	6.92	https://qhzkpjp.net/NMCrchY.html	{Mozarella,Flour,"Caramelized onions",Bacon,Flour}	2
2327	3049	158	Tortellini Bowls	6.33	http://tugarqt.org/crZAWWv.html	{Tomatoes,Nori,Mayo,Nori,Flour}	1
2328	9019	158	Grape Jelly Sandwich	3.87	https://djuiiyk.top/	{Mozarella,Tomatoes,Salmon,Pineapple,"Cottage Cheese","Bavarian sausages"}	3
2329	268	158	Peanut Butter	2.78	http://jphbagc.edu/RUbFplu.js	{Mayo,"Original sauce",Strawberry,Basil}	4
2269	9974	158	Tortellini Bowls	6.26	http://www.esepvjt.edu/yWvnXBa	{"Original sauce","Onion rings",Pineapple,Mozarella}	1
2270	9926	158	Sweet Potato Pie	6.31	https://zbhyehe.org/pxTtbVL.svg	{Pasta}	1
2271	7332	158	Pizza Florida	7.23	https://nmhsvmu.ru/ZBRHtOh.jpg	{Strawberry,Mayo,"Caramelized onions"}	5
2272	6055	158	Wallmart	7.23	https://rlvfiyf.net/wVyJAiy.webp	{Mushrooms,Milk,Sugar,"BBQ sauce"}	2
2285	1120	158	Saint Frank Coffee	6.28	http://jqdoodo.net/	{"Cottage Cheese"}	4
2286	8380	158	Bacon Cheese Burger	5.09	http://fdfjper.biz/sJdtCfR.css	{"Caramelized onions",Rice}	2
2287	9941	158	Pizza Hawaiian	5.73	https://qtkzjjx.biz/msFqpEO	{Corn,Carrots,Peperoni,Mayo,"Cheese cheddar"}	3
2288	9824	158	Pizza Florida	7.97	https://www.gwwahlx.info/fiWnRDg	{"Onion rings","Cheese cheddar","Bavarian sausages",Tomatoes}	1
2289	2835	158	Chicken Pot Pie	6.99	http://qmgftwm.org/OaCRvdy	{Peperoni}	2
2290	8158	158	Peanut Butter	4.76	http://nenpwxl.org/AamFBXn.jpg	{Pasta,Carrots,Tomatoes,Pineapple,Nori}	1
2291	3986	158	Pizza Italiano	6.45	https://zlkahzj.com/ZSCZEAY.webp	{Mushrooms,Pineapple,Peperoni,Garlic,Tomatoes}	4
2292	8208	158	Sweet Potato Pie	5.96	http://www.uydqwse.net/MpQqkQF	{Peperoni,Nori,Pineapple,Corn,"Unagi sauce",Bacon}	5
2293	7492	158	Swedish Meatballs	7.44	http://fskrkey.edu/NEcFfoX.css	{Pasta,Pasta,"Cottage Cheese",Peanuts}	1
2295	6223	158	New York Style Cheesecake	3.26	http://judgtdd.top/	{Salmon}	4
2296	2442	158	Pizza Florida	4.57	https://qbascid.net/	{Chicken,"Bavarian sausages",Nori,"Chili Pepper",Flour}	1
2297	2601	158	Chicken Pot Pie	2.69	https://adnrsiw.info/WktOncF.js	{Milk,Butter,Peanuts,Carrots,Peas}	5
2298	583	158	Unwrapped Burrito Bowl	3.20	https://gzekanr.net/aUDNYbn.svg	{Cheese,Cheese}	3
2299	7788	158	Grape Jelly Sandwich	6.52	https://xuxemyl.biz/WuSICXy.php	{Carrots,"Caramelized onions",Garlic}	4
2300	641	158	Tortellini Bowls	3.14	http://grhtwru.biz/bFLlxlm.php	{"Cheese cheddar",Potatoes,Pasta}	5
2301	6745	158	Bacon Cheese Burger	7.67	https://ltscors.com/aiUlpJs.webp	{Chicken,Peas,Peperoni,Potatoes}	5
2302	6855	158	Pizza Texas	7.02	https://www.bbkhkfk.org/uhUOdAT	{Corn,Pineapple,Rice,"Cottage Cheese"}	2
2303	8145	158	Crispy Chicken burger	7.31	http://vpbxepv.net/	{"Original sauce",Salmon,Cucumber}	2
2304	4063	158	Unagi Philadelphia	4.36	http://ketrsyt.ru/ZcNtsiM.php	{Mozarella,Corn}	5
2305	5590	158	Pizza Florida	7.67	https://risdnwb.info/CToKAvA.css	{Milk}	2
2307	6024	158	Pizza Hawaiian	6.20	https://mooicrc.biz/pLyqnSf.php	{"BBQ sauce",Butter,Tomatoes}	2
2310	2473	158	Himawari	2.38	https://njgajvd.net/nxqNgMl.css	{Garlic,Peperoni,Garlic}	1
2311	9318	158	Sweet Potato Pie	6.30	http://hdjpqnw.com/kGmWfSN.html	{Potatoes,Salmon,Carrots,Peanuts,Peas}	1
2312	1507	158	Pizza	6.99	http://www.ipkfbcm.biz/	{Flour,"Cottage Cheese",Cheese,Chicken,Tomatoes}	2
2313	8870	158	Wallmart	7.02	http://tafqgtp.edu/pVCWWWf.css	{Peanuts}	3
2314	364	158	Pizza Pepperoni with tomatoes	3.12	http://www.kngrotc.biz/KMxrkYX	{Flour,"Chili Pepper","Cream cheese",Potatoes,Cucumber}	3
2315	2379	158	Unwrapped Burrito Bowl	5.58	https://ecjxyyr.com/cWJQDeM.webp	{Cheese,"Cottage Cheese","Original sauce"}	5
2316	5315	158	Himawari	7.41	http://mxnhkvx.biz/niGLvGG.webp	{Mushrooms,Sugar,Peperoni}	4
2317	1237	158	Bean Green Chili Burritos	7.37	https://wnlpmkw.biz/	{"Onion rings","Japanese tamago"}	5
2318	7085	158	Swedish Meatballs	2.73	https://pbqwosr.info/rbWXvQY.js	{Strawberry,Onion,Flour,Chicken}	3
2319	9113	158	Original burger	3.13	https://ecggrtv.edu/	{Peanuts,"Cheese cheddar","Original sauce"}	2
2325	5145	158	Bacon Cheese Burger	6.07	https://gllicgz.biz/suMTBFy.css	{Grapes,Butter,Cheese,Onion,"Chili Pepper"}	4
2326	2810	158	Angel Food Cake	7.95	http://ossdhwq.biz/gqlhWZr.html	{Sugar,"Cheese cheddar",Nori}	2
2361	3015	159	Grape Jelly Sandwich	3.98	https://yuypjld.edu/PDpPVcC.css	{"Bavarian sausages",Peas,Tomatoes,"BBQ sauce"}	1
2350	9063	158	Grape Jelly Sandwich	3.77	https://pfutulg.top/	{Potatoes,"Cream cheese"}	2
2342	7356	158	Pizza Texas	3.20	http://ealhgjh.ru/viQeWff.php	{"Chili Pepper",Nori,Rice}	4
2365	8578	159	Pizza Florida	7.33	http://tekamlk.biz/qMMyOVt.css	{Pasta,Milk}	1
2366	7587	159	Chicken Pot Pie	7.87	http://aoqvuxs.biz/IQVyadW.php	{Chicken,Cucumber}	1
2367	2420	159	Bacon Cheese Burger	2.45	http://oaovumt.edu/jFkCdxC.css	{"Cottage Cheese",Strawberry,"Bavarian sausages",Mushrooms,Grapes}	1
2370	8044	159	Swedish Meatballs	6.21	https://www.jbrvefb.com/	{Peas,"Cream cheese",Mushrooms}	4
2371	4309	159	Bacon Cheese Burger	7.51	http://xjtjblb.top/hCuHrDS.css	{Mushrooms,Rice,Rice,"Chili Pepper",Strawberry,"Bavarian sausages"}	2
2372	899	159	Wallmart	4.39	https://jirdiwi.edu/bpZOqej.webp	{Mayo,Pasta,"Cottage Cheese"}	3
2373	3402	159	Pizza Ocean	2.90	http://www.pwysqxc.edu/cHqugIB	{Cucumber}	5
2374	2941	159	Saint Frank Coffee	2.97	http://qnbojiu.ru/qtjApDn.php	{Mushrooms,Butter,Peas,"Japanese tamago"}	1
2344	3080	158	Chicken Pot Pie	4.09	http://zptrfbx.info/rgtBkJR.webp	{Peas,"Onion rings",Mozarella,Peas,Onion}	1
2414	6536	181	Original burger	7.58	http://ufrrglx.edu/efCqpVM.php	{Tomatoes,"BBQ sauce",Onion,Corn}	1
2415	6849	181	Original burger	3.68	https://adwbetk.top/fRdGuxg.css	{Chicken,Peperoni,Sugar}	3
2348	1910	158	Pizza Texas	3.18	https://susdbkx.info/gNZFsvR.svg	{Peas,"BBQ sauce",Pineapple,"Cottage Cheese",Flour}	5
2321	8394	158	Pizza	5.02	http://daxhpgs.ru/	{Meat,Rice}	2
2331	2080	158	New York Style Cheesecake	7.67	http://suhuyes.top/fysHuEq.svg	{Butter}	5
2336	218	158	Crispy Chicken burger	2.18	http://acqggwv.biz/sSFIxxX.css	{"Original sauce"}	3
2334	8213	158	Pizza Pepperoni with tomatoes	5.05	http://qznciuz.org/BOVYZiW.js	{Butter,"Onion rings",Mushrooms}	5
2335	7296	158	Swedish Meatballs	5.36	https://bslmtqi.org/IphOuIQ.css	{Peperoni,Garlic,Pasta}	2
2362	9556	159	Pizza Pepperoni with tomatoes	2.15	http://nhoiuyr.biz/gnJWapi.html	{Potatoes}	5
2338	7027	158	Unwrapped Burrito Bowl	6.95	http://ghermlp.top/qTNVupo.svg	{"Cheese cheddar",Potatoes,"Japanese tamago",Bacon}	4
2339	1110	158	Wallmart	6.51	https://www.tlcoqhk.com/	{Chicken}	3
2340	5172	158	Angel Food Cake	7.40	https://pyrnbbq.net/vJpAhcj.webp	{Strawberry,Cheese,Mayo,Pineapple}	3
2341	8747	158	Bacon Cheese Burger	3.37	http://naqravm.edu/mfBOdBo.webp	{Sugar,Peanuts}	4
2359	8561	159	Pizza	6.51	http://wtxsvxn.com/ItFxHsN.jpg	{Chicken}	1
2343	3400	158	Tortellini Bowls	4.26	https://napktqk.net/lEkQcJc	{Mushrooms,Mushrooms,Mushrooms,Flour,Peas}	2
2347	3873	158	Crispy Chicken burger	4.87	https://ipmsmeq.top/	{"Japanese tamago",Salmon,Cheese,Rice,Cucumber}	1
2345	1684	158	Himawari	6.88	https://cfamtcf.net/	{Cheese}	4
2346	3508	158	Saint Frank Coffee	5.40	http://vdeevxj.edu/ZmTZPHB.webp	{"Cream cheese",Bacon,Carrots}	1
2375	6636	159	Pizza Florida	3.50	https://www.gwxksvs.org/	{Sugar,Potatoes,Flour,Strawberry,"Caramelized onions"}	5
2351	2874	158	New York Style Cheesecake	7.55	http://wsdtvsh.ru/xhiEoCu.webp	{Flour,Corn,Meat,"Cream cheese",Mozarella,Rice}	2
2349	1844	158	Pizza Texas	6.84	http://uiugmqm.biz/trXdSmc.html	{Bacon,Mozarella}	1
2320	1557	158	Unwrapped Burrito Bowl	2.57	https://vhabcmf.com/nTamPox.css	{Flour,Pasta}	1
2352	6342	158	Pizza Florida	7.13	https://vxekkdh.biz/adUIWxn.webp	{"Japanese tamago",Meat,Cheese,Sugar,"Cream cheese","Original sauce"}	4
2353	9171	158	Philadelphia with salmon	6.38	http://utlstvh.biz/rDccFGM.jpg	{"Unagi sauce","Caramelized onions",Salmon}	3
2354	5772	158	Himawari	5.32	http://avyjbgt.net/	{Basil,Chicken,Pineapple,Milk,Mozarella}	3
2355	6346	158	Pizza Italiano	4.76	http://www.imoesiq.top/KiYeNOH	{Cheese,Strawberry,Tomatoes}	4
2356	9697	159	Pizza Hawaiian	6.01	https://ufjtrtz.com/ehBrTbT.html	{Butter,"BBQ sauce",Chicken,Strawberry,Potatoes,Onion}	2
2357	159	159	Saint Frank Coffee	6.58	http://psygsow.com/DlyyYwp	{Potatoes,"Original sauce",Garlic,Strawberry,Mushrooms,Tomatoes}	4
2358	4719	159	Unagi Philadelphia	7.53	https://wpcvepg.ru/OvtgeYM.svg	{"BBQ sauce",Meat,"Caramelized onions",Milk,Meat}	2
2332	866	158	Tortellini Bowls	7.38	https://www.odtkrrp.biz/	{Pineapple}	2
2360	9947	159	Bean Green Chili Burritos	7.93	http://www.cqwuxmj.ru/WAFGIqS	{"Japanese tamago","Unagi sauce",Corn,Grapes}	2
2363	2556	159	Sweet Potato Pie	6.93	http://drmuvia.biz/AvUmOlc.html	{Peperoni,Chicken,Bacon}	2
2394	1793	160	Pizza Ocean	2.09	http://myzogoj.net/gCMvRbH	{Pasta}	1
2396	3944	160	Sweet Potato Pie	6.06	http://bqopbnm.biz/vZAcFlF.css	{Mayo,Strawberry,Pasta,"Bavarian sausages"}	1
2399	6192	160	New York Style Cheesecake	3.29	https://vdlmuka.org/MPNOirv.svg	{Corn,Butter,Peperoni,Peanuts,Peanuts,Mayo}	5
2400	3430	160	Pizza Ocean	7.73	https://www.ebucicq.com/nIoWkNN	{Garlic,Basil,Flour,Pasta,"Japanese tamago",Pineapple}	5
2401	2438	160	Angel Food Cake	3.87	http://eydkqtn.com/UTSPcMQ	{Garlic}	4
2402	6183	160	Philadelphia with salmon	7.65	http://www.iwhfozb.com/sIORWVd	{"Bavarian sausages",Cucumber,"Original sauce",Corn,Flour}	5
2380	3829	159	Pizza	7.65	https://yaghekm.info/pBEoRKi.svg	{"Cream cheese"}	2
2420	3593	181	Pizza Texas	3.18	https://www.gzsloef.biz/	{"Unagi sauce",Peanuts}	2
2421	1367	181	Crispy Chicken burger	5.52	http://olwkkvi.net/jUToHZI.svg	{Garlic,Flour}	1
2406	6282	160	Himawari	6.31	https://nzvjjoe.top/	{Pasta,Sugar,Chicken}	3
2407	2572	160	Wallmart	5.32	https://tboajmp.ru/hMnIsMD	{"Unagi sauce","Chili Pepper",Mayo,Flour}	5
2408	6455	160	Pizza Italiano	7.89	http://etmwrcb.net/GFVAPuq.php	{Peas}	4
2409	4761	160	Pizza Ocean	5.25	http://lkiwuxo.org/SYnjWBQ	{"Chili Pepper"}	3
2410	3580	160	Pizza Pepperoni with tomatoes	5.52	https://wmtivlw.biz/	{Meat,"Original sauce","Chili Pepper",Butter}	2
2411	2390	160	Chicken Pot Pie	4.16	https://rfynhwj.edu/ibUflSc.jpg	{Flour,"Chili Pepper",Milk,"Unagi sauce"}	1
2416	9561	181	Pizza Italiano	5.58	http://uzvvbct.edu/ohJZbTT.css	{Sugar,"BBQ sauce",Carrots,"Bavarian sausages"}	3
2418	2631	181	Pizza Hawaiian	7.83	http://gcavkgx.net/tracSiV.php	{"BBQ sauce","Bavarian sausages",Cheese}	2
2463	3405	181	Pizza Ocean	5.48	http://lludpbm.biz/XZXpBqp.php	{Peanuts,"Caramelized onions",Pasta,Pasta,Salmon}	2
2465	1146	181	Pizza Pepperoni with tomatoes	5.74	https://lplaiam.org/KoonQuJ.php	{"Original sauce",Cheese,"Japanese tamago",Flour,"Unagi sauce",Flour}	2
2466	5458	181	Peanut Butter	4.63	http://www.furkmwj.net/	{"Cottage Cheese"}	3
2422	4413	181	Philadelphia with salmon	2.03	https://scorjdw.top/	{"Original sauce","Caramelized onions"}	3
2424	6303	181	Pizza Hawaiian	5.52	https://vkemwpi.ru/ssZNyUO.html	{Milk,Mozarella,Milk,Salmon}	3
2462	7927	181	Pizza Pepperoni with tomatoes	6.77	http://pzwrtwq.net/TrYrjEO.js	{"Cream cheese",Onion,Cucumber,Rice}	3
2403	4982	160	Pizza Pepperoni with tomatoes	5.10	http://uexrilp.net/ndJtsqB.svg	{"Caramelized onions","Cheese cheddar",Strawberry,Bacon}	3
2404	4067	160	Bean Green Chili Burritos	6.82	https://rztnxrg.org/PBAaGgH.webp	{Peas}	2
2405	9109	160	Philadelphia with salmon	6.22	http://jyxqjqu.biz/JDrmltc.webp	{Pineapple,Nori,Pasta,"Cream cheese",Corn,Pineapple}	5
2377	1043	159	Grape Jelly Sandwich	5.98	https://www.iskskep.net/	{Salmon,Rice,Cucumber}	4
2378	7917	159	Grape Jelly Sandwich	7.29	http://dehxird.org/qfQHVNJ.css	{"Original sauce","BBQ sauce",Peas,Butter}	1
2379	8100	159	Unwrapped Burrito Bowl	3.74	https://vccgofb.edu/QvaUvsm.jpg	{Peperoni,Pineapple,Peperoni,Carrots,Mushrooms}	3
2386	5393	160	Swedish Meatballs	2.21	http://heohbpf.biz/CWSFFIu.html	{Basil,Corn,Peas,Flour,Butter,Meat}	4
2381	6647	159	Unagi Philadelphia	4.40	https://uvimaph.info/AGXLfDE.svg	{Salmon,Meat,Peas,Cucumber,"Cheese cheddar"}	1
2382	4730	159	Pizza Florida	7.44	https://apcdifk.top/sryhsbM	{Rice}	5
2383	1422	160	Original burger	2.22	http://fjvpelt.edu/wWTJCfJ.svg	{Butter,Strawberry}	4
2384	78	160	Original burger	2.77	https://uhtoipa.info/momGsFd.webp	{Onion,"Chili Pepper",Potatoes}	2
2385	4490	160	Peanut Butter	7.25	http://nycimff.ru/RurMuuZ.jpg	{Milk,Basil,Potatoes,"Unagi sauce"}	4
2419	1695	181	Sweet Potato Pie	6.32	https://ymrpxod.top/VqkkJXM.css	{Peanuts}	2
2387	5276	160	Original burger	7.65	https://jbfoimp.edu/hFoqOQC.webp	{Mushrooms,Onion,Peanuts}	1
2388	8003	160	Tortellini Bowls	7.48	http://xqipstn.ru/CNDvmvm.php	{Bacon}	4
2389	5337	160	Philadelphia with salmon	6.70	http://aocdosq.net/lgEoGZh.jpg	{Potatoes,"Original sauce",Nori,Cheese,Peperoni,Milk}	3
2390	3370	160	Saint Frank Coffee	4.27	http://ubcfghy.net/NfmfYwf.webp	{"Cheese cheddar",Butter}	4
2391	9146	160	Angel Food Cake	7.17	http://ugaorrj.biz/	{Milk,"Chili Pepper"}	3
2392	149	160	Wallmart	6.45	https://xkiacyz.top/ETgjoXx.js	{Cucumber,"BBQ sauce",Rice,Peas}	1
2393	7106	160	Peanut Butter	5.38	http://kfdfqpj.ru/pKRSDlx.svg	{Pasta}	4
2397	457	160	Unwrapped Burrito Bowl	2.22	https://drgrzsc.biz/fRqRZVQ.svg	{Rice}	5
2398	9788	160	New York Style Cheesecake	6.06	http://xsuqhux.info/nvJSigK.svg	{Mozarella}	3
2435	5832	181	Swedish Meatballs	2.72	https://mkkusij.top/	{Flour}	2
2429	4826	181	Sweet Potato Pie	5.57	https://fqegkbi.top/pSROigK.svg	{Mayo,Grapes,"Caramelized onions",Cucumber}	3
2469	4442	181	New York Style Cheesecake	7.20	https://dykilzg.info/hsMeqac.svg	{Meat,Butter,Flour,Potatoes}	5
2432	9979	181	Bacon Cheese Burger	7.42	https://lbkhjmc.edu/TjFcfyU.html	{"Japanese tamago",Grapes,Grapes,Cucumber}	2
2441	4263	181	Chicken Pot Pie	4.16	https://rzcirpv.net/YNMHhfG.webp	{Flour,Meat,Milk,Meat,Mozarella}	1
2434	6993	181	Wallmart	5.67	https://orsgemi.biz/XIHuwvL.jpg	{"BBQ sauce",Peas,"Chili Pepper","Caramelized onions",Nori}	2
2436	3162	181	Sweet Potato Pie	3.78	http://www.lfgidsu.ru/	{"Chili Pepper"}	4
2445	1171	181	Swedish Meatballs	2.61	http://www.qzrxssx.net/	{Mushrooms,Peperoni,Basil,"Onion rings"}	2
2438	7632	181	Pizza Hawaiian	7.89	https://pnehkna.biz/PjKqBJK.css	{"Cottage Cheese","Onion rings","BBQ sauce",Garlic,Garlic,Peperoni}	4
2439	7878	181	Unwrapped Burrito Bowl	2.37	http://nvlobff.top/uyGtxNj.webp	{Sugar,"Caramelized onions",Basil,Onion,Flour}	4
2440	1722	181	Pizza Italiano	6.08	https://lfqvkto.info/sKHHHrL.php	{Rice,"Cottage Cheese",Mayo,Cucumber,Corn,Mayo}	4
2449	4745	181	Pizza	2.79	https://www.chmibmt.biz/hemAlmW	{Mushrooms,Tomatoes,"Original sauce",Salmon,Peperoni,Peas}	1
2444	4635	181	New York Style Cheesecake	6.97	http://isocukd.top/mGqAVbV.svg	{Salmon,"Chili Pepper",Mayo,Nori,"Bavarian sausages",Peanuts}	3
2427	7294	181	Sweet Potato Pie	2.84	https://www.ximkwpr.biz/DNUnQVH	{Pasta,"Onion rings",Strawberry,"Original sauce","Cottage Cheese"}	5
2454	2754	181	Crispy Chicken burger	3.64	http://ntlhuuo.info/oSOGIui.js	{Mozarella}	5
2509	8462	182	Pizza Pepperoni with tomatoes	3.88	http://jruzldo.net/FDxYNxD.php	{"Bavarian sausages",Tomatoes}	1
2456	6136	181	Wallmart	5.44	https://afldsmg.ru/tEyLaOr.css	{"Caramelized onions"}	2
2448	3157	181	Sweet Potato Pie	4.69	http://www.wajhpwb.biz/	{Rice,Mushrooms,"Cream cheese",Mozarella,"Japanese tamago"}	5
2457	8956	181	Pizza Florida	2.14	http://djanmpl.net/JlflboJ.jpg	{Chicken,"Cream cheese",Peperoni,Butter,"Unagi sauce"}	4
2451	8732	181	Pizza Ocean	7.77	http://nurxojc.biz/MxSfXJQ.js	{Salmon,"Onion rings",Tomatoes}	5
2443	9101	181	Tortellini Bowls	3.37	http://www.xdgooxy.top/	{Onion,Cheese,Pineapple,Cheese,Salmon,Nori}	1
2446	8097	181	Tortellini Bowls	5.84	https://www.pclebie.edu/	{Mozarella,"Cottage Cheese",Potatoes,Grapes,Mushrooms}	1
2453	3792	181	Sweet Potato Pie	4.56	http://www.bmloqdj.top/jwMCCVV	{Onion,Mozarella,Basil,Bacon,Bacon}	3
2447	3614	181	Unagi Philadelphia	3.72	http://arbvhkp.edu/AUMtcPx.css	{Pasta,Mayo,Cucumber}	4
2506	9191	182	Pizza Ocean	5.40	https://nnsxjih.com/VpoHCxO.webp	{Mushrooms,"Bavarian sausages",Salmon,"Onion rings",Potatoes,Cucumber}	5
2458	8207	181	New York Style Cheesecake	3.56	https://mgrsirl.net/aAvRpwr.jpg	{Mayo,Flour,Pasta}	3
2459	3651	181	Philadelphia with salmon	5.09	https://www.tuinebp.ru/	{Mayo,"Original sauce",Carrots}	5
2511	4319	182	Pizza Florida	3.40	https://vbpybtp.net/MTpPxXD.webp	{Tomatoes,Mayo,Tomatoes,"BBQ sauce"}	5
2452	4176	181	Unwrapped Burrito Bowl	5.47	http://csymeet.top/VQChKMN.css	{Sugar,"BBQ sauce",Butter,Carrots,Meat}	2
2460	8265	181	New York Style Cheesecake	3.84	http://dikxcgj.biz/RGMePKd.js	{Butter}	5
2426	9708	181	Sweet Potato Pie	5.07	https://hzkorlv.com/lfayKCs.jpg	{Garlic,Mushrooms,Pineapple}	4
2455	1616	181	Original burger	4.88	https://www.xbtjhuz.com/	{Nori,"Japanese tamago",Grapes,"Cottage Cheese","Cheese cheddar"}	1
2508	1744	182	Pizza Hawaiian	3.01	https://xaoptxg.ru/ggboFWY.jpg	{"Caramelized onions",Pineapple,Sugar,Meat}	2
2510	6798	182	Tortellini Bowls	6.15	https://mhwxssh.top/IsFRfBb.jpg	{Butter,Chicken,Grapes,Milk,Strawberry,Flour}	3
2512	5060	182	Peanut Butter	6.21	http://www.qewgxeq.biz/	{"Onion rings","Cream cheese",Cucumber,"Unagi sauce"}	5
2513	953	182	Swedish Meatballs	5.50	https://lofspts.edu/wfUcHdT.svg	{Strawberry,Peanuts,Basil}	5
2468	9375	181	New York Style Cheesecake	6.53	https://uuggdxt.ru/MtisQGs.jpg	{"Onion rings",Chicken,Mushrooms,"Japanese tamago"}	4
2433	735	181	Bean Green Chili Burritos	7.11	https://www.jdkfvbj.net/agfkJYC	{Flour,Peas,Cucumber}	1
2428	2263	181	Bean Green Chili Burritos	3.32	https://qlususn.edu/QrVTTQg.php	{"BBQ sauce",Peas,Bacon,Tomatoes,Pineapple}	2
2430	3849	181	Pizza	3.03	https://girstyp.edu/	{Peanuts,Garlic,Mushrooms}	1
2431	3418	181	Peanut Butter	7.49	http://mpcccqo.org/FJfmgYv.svg	{Flour,Rice,Peanuts,Carrots,"Onion rings",Carrots}	2
2482	6435	181	Wallmart	6.90	http://zxvmuwx.net/CkQuBEQ.jpg	{"BBQ sauce"}	5
2522	9606	182	Unwrapped Burrito Bowl	5.81	https://oduyslp.org/aMTrVEv.js	{"Cheese cheddar",Corn,"Chili Pepper",Bacon}	3
2553	8923	182	Saint Frank Coffee	3.28	https://iegabtb.com/AxsUmUm.jpg	{Pineapple,"Cheese cheddar",Chicken,"Caramelized onions",Carrots}	4
2496	2612	181	New York Style Cheesecake	7.51	https://htpfeqd.top/AvDVNWQ.html	{Corn,Rice,Pineapple,Carrots,Tomatoes}	5
2559	9757	182	Chicken Pot Pie	4.26	http://ivobgru.top/	{Mozarella,Pasta,Garlic,Onion,Flour}	2
2495	872	181	Unwrapped Burrito Bowl	7.49	https://gorwdfi.org/qZOkGSe.webp	{Butter,Mushrooms,Basil,"Cheese cheddar","Japanese tamago",Corn}	3
2556	226	182	Pizza Italiano	4.33	https://www.mzylvro.org/	{Bacon,"Onion rings","Japanese tamago",Garlic}	4
2558	2870	182	Unagi Philadelphia	5.75	https://qaysgyn.net/xvPuXPX.css	{Cucumber,"Cream cheese"}	3
2493	7309	181	Chicken Pot Pie	5.55	https://frnyned.biz/UUYpPWJ.php	{Flour,Basil,Cucumber}	2
2554	6210	182	Pizza Pepperoni with tomatoes	2.47	http://pnysnrw.biz/ArAWvEU.svg	{Pineapple,"BBQ sauce","Original sauce"}	5
2472	7903	181	Himawari	7.65	http://lpktwni.org/	{"Chili Pepper"}	5
2473	1605	181	Himawari	7.69	https://lfchdfy.biz/ilWJGSl.php	{Sugar,Nori,Pasta,Garlic}	3
2497	3158	181	Pizza Texas	5.18	https://lknlmib.top/uWqkbgo	{Garlic}	5
2502	3406	182	Bacon Cheese Burger	5.09	http://www.jdlsyfq.ru/	{"Original sauce",Carrots,Pineapple}	1
2477	5390	181	Pizza Texas	7.98	http://fafttgp.biz/EidwvsX.css	{Sugar}	3
2471	3810	181	Chicken Pot Pie	2.79	https://lgaadvp.ru/ATRdKnP.js	{Strawberry,Onion}	4
2479	5464	181	Grape Jelly Sandwich	2.61	http://www.aawgwfx.biz/mTlpLNZ	{Flour,"BBQ sauce",Tomatoes,Cheese,Mayo}	5
2501	3147	182	Bacon Cheese Burger	3.09	https://qphblhg.edu/jHuKeCD.jpg	{Butter}	5
2519	5521	182	Grape Jelly Sandwich	5.40	http://dvumjkp.info/MDiWAeF.js	{Butter,Meat,Flour}	1
2515	1056	182	Pizza Italiano	7.18	https://llmawss.org/ORKFIYg.php	{Potatoes,"Original sauce","Cheese cheddar"}	2
2483	3567	181	Wallmart	2.74	https://npjlhdj.edu/qpwrVii.webp	{"Unagi sauce",Rice,"Original sauce",Rice}	1
2485	2515	181	Chicken Pot Pie	4.81	https://bcudwto.ru/UPcrhuo.svg	{"Original sauce",Flour}	4
2488	6920	181	Pizza Italiano	7.47	http://www.ssakral.biz/	{"Cheese cheddar"}	1
2489	8854	181	Pizza Ocean	5.00	http://yjhxphp.net/HIdPJZW.css	{"Cheese cheddar",Peanuts}	2
2491	4254	181	Crispy Chicken burger	6.64	https://olmhqkh.net/	{Flour,Mayo,Flour}	1
2492	9054	181	New York Style Cheesecake	7.42	http://gijfvjk.top/fpEMrQV.js	{"Cheese cheddar",Rice,"Cottage Cheese",Mayo,"BBQ sauce"}	1
2557	5005	182	Crispy Chicken burger	2.70	https://muanuvj.top/xamMvPu.js	{Garlic}	5
2494	1156	181	Grape Jelly Sandwich	6.63	https://byiekxe.info/iQIadUN.svg	{"Chili Pepper",Peperoni,Pasta,Garlic,"Unagi sauce","Onion rings"}	2
2555	8233	182	Chicken Pot Pie	5.55	http://uqzqnna.ru/fbkEdUa.html	{Cheese,Sugar,Mayo}	2
2498	534	181	Pizza Texas	3.46	http://ohwiurx.org/	{Pasta}	3
2499	4895	181	Pizza Italiano	3.76	https://iqpxazh.com/RVFCdGF.js	{Corn}	4
2478	2938	181	Pizza Texas	5.84	http://rqoitmm.org/dlYCPLE.svg	{"Caramelized onions",Bacon,"Cream cheese"}	3
2500	676	182	Unwrapped Burrito Bowl	7.83	https://auhgdsy.ru/FetenTm.svg	{"Original sauce"}	3
2475	1220	181	Chicken Pot Pie	6.00	http://www.jhhhxqq.org/	{Cucumber}	1
2503	2399	182	Pizza Italiano	5.58	https://uqloreg.org/cdBJhkJ.js	{Cucumber,"Unagi sauce","Unagi sauce",Grapes,Flour}	3
2481	2472	181	Unwrapped Burrito Bowl	6.66	https://isgjwii.net/	{Milk,"Original sauce","BBQ sauce",Carrots,"Cheese cheddar"}	1
2516	8544	182	Unwrapped Burrito Bowl	4.77	https://rsjysrl.info/jCmVnYr.webp	{"Chili Pepper",Peas,Peanuts,"Original sauce"}	3
2504	6746	182	Philadelphia with salmon	2.56	http://semefvc.top/pCDrEar.php	{"Unagi sauce",Corn}	2
2521	1302	182	Saint Frank Coffee	2.23	https://jjtwepv.ru/LGlANME.svg	{Bacon}	4
2517	5236	182	Unwrapped Burrito Bowl	5.05	https://dgldftc.net/pvrLvXN.js	{Salmon,Basil}	4
2480	1323	181	Pizza Ocean	6.02	https://www.svqumjc.net/	{Cucumber,Mayo,Cheese,Garlic}	4
2520	3898	182	Pizza Florida	6.46	https://uzyldfx.info/mqDeVSK.js	{Peperoni,Potatoes,"BBQ sauce","Original sauce","Cheese cheddar"}	2
2490	7986	181	Bacon Cheese Burger	3.87	https://ailsadm.info/mRWuTAI	{"Cottage Cheese"}	5
2568	3934	182	Grape Jelly Sandwich	7.84	http://rmwvcxa.org/JJEUopU	{"BBQ sauce"}	4
2565	6550	182	Tortellini Bowls	4.33	http://lkmrsko.top/gWcygIE	{Basil}	3
2526	4055	182	Unwrapped Burrito Bowl	5.51	https://bedonhl.top/OwHIxkN.jpg	{Peanuts,Bacon}	2
2562	2153	182	Pizza	2.54	https://www.cqfdjqn.edu/SHWhols	{Corn,"Onion rings",Peas,Garlic}	5
2529	1514	182	Pizza Italiano	3.67	https://www.eebwyuv.biz/	{Garlic,"Original sauce",Peanuts}	2
2532	8906	182	Pizza Texas	3.38	http://dmlytkj.ru/loydYLb.js	{Peanuts,Meat,"Cream cheese",Carrots,"BBQ sauce"}	1
2535	8992	182	Pizza Texas	2.43	https://khmummk.org/xXEorYh.js	{"Japanese tamago",Milk,Cucumber,Garlic,Butter}	3
2538	8051	182	Wallmart	7.22	http://soauclp.com/FhbuksI.js	{"Cheese cheddar",Peanuts,Chicken,Mayo,Butter,Chicken}	2
2541	9618	182	Himawari	4.48	https://xaudqwd.ru/XubQJwj.js	{Flour,Corn,Mushrooms,Mushrooms,Milk,Carrots}	1
2544	7444	182	Saint Frank Coffee	3.82	http://stdzzoc.org/ltbNfnt.jpg	{Rice,"Original sauce",Chicken,"Caramelized onions",Mozarella}	1
2547	5595	182	Unagi Philadelphia	2.83	http://qnrumqp.top/VxJCMai.html	{Peas,"Cream cheese","Bavarian sausages",Corn}	4
2550	5757	182	Philadelphia with salmon	3.82	https://www.pyrqtad.top/greGIwI	{Bacon,Corn,Salmon,"BBQ sauce","Onion rings"}	1
2530	7521	182	Sweet Potato Pie	2.64	https://duqcvsy.net/gYHyAPX.svg	{"Onion rings","Caramelized onions"}	3
2533	9610	182	Pizza Hawaiian	5.49	https://cvviuds.net/ReoDjVC.html	{Cheese,Peperoni}	5
2536	1863	182	Pizza Italiano	7.28	http://www.fhdvujl.com/saKwnBE	{"Japanese tamago","Unagi sauce",Corn,Peas}	5
2539	9920	182	Pizza Ocean	5.50	https://aweenin.net/lJhLGvR.php	{"Original sauce",Nori,Flour,Carrots,"Bavarian sausages","Cottage Cheese"}	1
2542	1304	182	Original burger	7.26	https://www.jblaaky.info/	{Potatoes,Nori}	1
2545	8032	182	Wallmart	7.25	http://rsfdzfs.biz/QSXrygK.webp	{"Cream cheese",Cheese}	5
2548	3460	182	Bean Green Chili Burritos	5.45	http://wlrfkri.org/	{Basil,"Cottage Cheese",Tomatoes,Basil,Carrots,Cucumber}	5
2551	8541	182	Pizza Ocean	7.75	https://arbgnde.com/XyrhIVO.js	{Tomatoes,Basil,Peas,Pineapple,Bacon}	1
2563	6915	182	Crispy Chicken burger	2.32	http://qaeqwzv.org/UhGCfrm.webp	{"Caramelized onions","Chili Pepper","Onion rings",Mushrooms}	3
2566	6392	182	Wallmart	7.96	http://wnbuzue.edu/ADAMDwK.php	{Peperoni,"Cheese cheddar",Pineapple}	3
2599	694	183	New York Style Cheesecake	2.13	http://mbhhosx.top/tQLgNQX.php	{Basil,Peas,Strawberry,Mayo}	1
2527	8650	182	Chicken Pot Pie	2.63	http://xryozll.ru/hKZKEuy.html	{Basil,Peperoni,"BBQ sauce",Grapes,Onion,Mayo}	4
2528	9887	182	New York Style Cheesecake	3.57	https://xcgkgkm.com/wSQroFK.css	{"Bavarian sausages",Peanuts,"Cottage Cheese"}	3
2534	9747	182	Bacon Cheese Burger	6.66	https://iiojohz.info/yNSFLZE.css	{"Caramelized onions",Flour,Meat}	3
2537	1700	182	Chicken Pot Pie	2.24	http://dbozsva.ru/AepfeCV.html	{Peanuts,Butter,Meat,"Bavarian sausages",Strawberry}	1
2540	7478	182	Pizza Florida	4.66	http://uupiyxl.net/	{"Original sauce",Strawberry,Meat,Peperoni,Basil,"Cottage Cheese"}	5
2543	7308	182	Crispy Chicken burger	6.09	https://www.srdibbo.ru/FVEpBwC	{"Unagi sauce",Corn,Grapes}	5
2546	9792	182	Swedish Meatballs	4.22	http://rvnyxuv.edu/lWEhRqf.svg	{Bacon,Pasta,Peas}	1
2549	7866	182	Pizza	6.52	http://vnflpak.org/NluVaLw.svg	{Sugar,Nori,Cheese,Meat}	4
2561	9167	182	Himawari	3.29	https://lmsqwpq.edu/xSsJlLh.jpg	{"Onion rings",Mozarella,Sugar,"Bavarian sausages",Pasta}	5
2564	2184	182	Pizza Texas	7.98	http://kibxgjn.biz/fTMUrvm.html	{Rice,Rice,Rice,Tomatoes,Corn}	3
2567	9248	182	Wallmart	6.55	https://isqlbnj.info/xvpvHFF.svg	{Sugar,Carrots,Mayo,Chicken,Basil}	4
2600	8367	183	Swedish Meatballs	4.94	https://wdjbeob.org/jYOdKxI.svg	{Onion,Peperoni,Peanuts,Mushrooms}	1
2531	2062	182	Pizza	6.42	http://zhcscli.biz/SeyiCqm.css	{Strawberry,Bacon}	3
2525	1922	182	Himawari	4.00	http://mptbktl.info/	{Mushrooms,Mushrooms,"Unagi sauce",Corn,Mozarella,Cucumber}	1
2571	4354	182	Pizza Italiano	2.97	https://qbtjaoi.top/MkDpduQ.svg	{Flour,"Bavarian sausages","Original sauce",Butter,"Chili Pepper"}	2
2572	7663	182	Unagi Philadelphia	3.82	http://ghcyjfr.net/uJMxLko.php	{"BBQ sauce",Nori}	4
2573	5856	182	Himawari	7.11	http://afptxyk.edu/	{Pineapple,Nori}	5
2574	6386	182	Pizza Italiano	5.41	https://qfcdodw.edu/PUPyNxI.html	{Salmon,Mayo,"Cottage Cheese",Basil}	3
2575	5735	182	Himawari	7.25	http://evqkhev.ru/tMlPLku.php	{Tomatoes,Peas,Corn,Mozarella,Butter,Tomatoes}	4
2577	1784	183	Pizza	7.06	https://ahnbubk.org/yrGemnR.svg	{Potatoes,Corn}	5
2578	7764	183	New York Style Cheesecake	7.13	http://thaptbr.net/rYKrVef.php	{"Cottage Cheese"}	1
2621	7080	183	Saint Frank Coffee	6.37	http://sumippo.edu/	{Potatoes,Bacon,"Cream cheese"}	5
2622	2277	183	Pizza Hawaiian	6.27	https://ishoavv.com/yvIikFI.jpg	{Tomatoes}	1
2695	6767	184	Pizza Ocean	4.81	https://wqzonyq.net/SmUekKH	{"Caramelized onions","Original sauce",Peanuts,Garlic,Mushrooms,"Onion rings"}	5
2696	8337	184	Wallmart	4.07	http://www.lhhwlua.com/	{Pasta,Corn,Pasta,"Cheese cheddar"}	4
2697	6602	184	Pizza Hawaiian	3.29	https://hvikepy.info/WvhTFhC.jpg	{Chicken,Grapes,"Original sauce",Strawberry,Basil,Grapes}	3
2821	1214	186	Original burger	7.70	https://wpqldso.com/wNKnLMS	{Rice,"Japanese tamago"}	5
2711	1113	184	Angel Food Cake	4.82	https://mcdocsw.biz/LjOoXwc.php	{Sugar,Onion,Carrots,Meat,Carrots,"Chili Pepper"}	3
2712	6649	184	Pizza Pepperoni with tomatoes	6.81	https://qjffnum.net/dnyxNyA.js	{Butter,Mushrooms}	5
3225	7223	193	Bacon Cheese Burger	6.12	http://vuxyrtl.top/XIJhTQL.php	{Garlic}	5
2713	6022	184	Saint Frank Coffee	7.48	https://fztykcu.org/	{"Caramelized onions",Mushrooms,Basil}	5
2714	6492	184	Chicken Pot Pie	6.85	http://iaswjxb.net/HuIVYTc.svg	{"Unagi sauce","Bavarian sausages",Cucumber}	4
2715	2891	184	Pizza Hawaiian	7.65	https://uefktnt.top/tuVKyZw.php	{Potatoes,Corn,Milk,Flour,Pineapple,Onion}	4
2716	7940	184	Angel Food Cake	6.84	https://fetpauf.org/VBZoRaj.css	{Peperoni}	3
2672	30	184	Original burger	6.05	http://eazerqb.ru/aWiEFpx.svg	{"Cottage Cheese",Onion,Flour}	1
2673	3987	184	Crispy Chicken burger	4.28	https://aoqtqpn.ru/iIMsUhT.js	{Bacon}	3
2699	5289	184	Crispy Chicken burger	3.15	https://cabipew.com/LWehfYI.css	{Nori,Mushrooms,Basil}	4
2742	6884	185	Pizza Hawaiian	4.31	https://www.gxgcmmt.com/	{Milk,"Caramelized onions",Corn,"Original sauce"}	1
2718	2102	184	Pizza Ocean	3.44	http://whgdtmn.ru/RuGBkhE.svg	{Peperoni,Grapes}	4
2719	6714	184	Pizza Ocean	3.09	http://varwecf.info/lPxKEIy.jpg	{"Caramelized onions","Unagi sauce","Original sauce",Onion,"Unagi sauce",Pineapple}	4
2720	5583	184	Sweet Potato Pie	4.77	https://icaodsn.org/	{"Cottage Cheese",Salmon,"BBQ sauce"}	1
2737	3855	185	Unwrapped Burrito Bowl	6.12	http://rmzprnv.com/ufHFgcy.html	{Pasta,"Caramelized onions",Pineapple,Mushrooms,Strawberry}	4
2700	9992	184	Peanut Butter	5.78	https://npqlthr.biz/LXqYlsq.html	{"Cottage Cheese",Onion}	1
2701	5470	184	Pizza	7.27	http://cawigcv.biz/MVGmLEg.js	{Milk,"Cheese cheddar"}	2
2702	7842	184	Swedish Meatballs	5.75	https://iajlfht.top/lMYJMKa.php	{Flour}	1
2703	9160	184	Tortellini Bowls	5.24	https://dmgjuje.info/LvgFSwD.html	{"Onion rings",Corn,Tomatoes}	5
2704	2618	184	Chicken Pot Pie	5.64	http://veiilbk.top/XimsmnC.webp	{Nori,Chicken,"Japanese tamago",Strawberry}	4
2705	7823	184	Grape Jelly Sandwich	3.98	https://fsgoqhy.biz/onoqtGI.js	{Pineapple,Corn}	5
2739	4021	185	Unwrapped Burrito Bowl	2.62	http://www.vpankmg.org/	{"Cottage Cheese",Strawberry,Milk}	5
2707	8860	184	Angel Food Cake	6.50	https://www.tpuwndx.com/	{Rice,Corn,"BBQ sauce",Mushrooms}	3
2708	6088	184	Chicken Pot Pie	7.08	https://xfxraxw.info/JthPVJi.css	{Corn,Mozarella,Mayo}	2
2709	1721	184	New York Style Cheesecake	7.80	http://amobrkc.ru/yUhuXjP	{Mayo,Garlic,Mozarella,"Bavarian sausages",Mushrooms}	4
2740	3392	185	Chicken Pot Pie	5.02	https://www.wfldvfi.info/SrbomTv	{Corn,"Onion rings"}	1
2741	5321	185	Pizza Florida	3.33	https://cherarq.edu/blWhmbj.js	{Cheese,"Caramelized onions",Potatoes}	4
2710	8269	184	Pizza Texas	6.09	https://urxnzwa.biz/ivfDbHx.php	{Cucumber,Mozarella,Meat,Mushrooms,Nori,"Cheese cheddar"}	5
2765	4680	185	Himawari	5.63	http://uihzypc.edu/pQvRFBd.webp	{"Caramelized onions",Mushrooms}	4
2728	4391	184	Pizza Italiano	4.26	https://www.uweseds.com/iLNKnLr	{Potatoes,"Cottage Cheese",Tomatoes,Meat}	1
2766	3797	185	Sweet Potato Pie	6.18	http://www.bomsuzu.net/	{Cucumber,Strawberry}	4
2784	8315	185	Tortellini Bowls	2.48	http://xhhhjic.info/	{Corn,"Caramelized onions"}	1
2754	7549	185	Philadelphia with salmon	4.79	http://boidgjk.info/pXKHDkh.js	{Potatoes,Tomatoes,Pasta,"Unagi sauce","Onion rings","Original sauce"}	3
2785	7859	185	Pizza Ocean	5.63	http://tbuoelt.net/MXLJowf.js	{Rice,Mushrooms}	4
2756	1124	185	Original burger	2.73	https://emokmoj.info/UhAksdd.css	{Chicken,Milk}	2
2787	7855	185	Pizza Texas	3.40	https://ucckavt.info/SUFiXEW.jpg	{Tomatoes}	3
2788	5874	185	Pizza Ocean	4.30	http://rwvxghs.com/WRRfQfX	{"Cheese cheddar",Nori}	2
2789	9958	185	Pizza Texas	6.36	https://oepzijh.org/atRFhCL.css	{"Unagi sauce",Pasta}	1
2760	4852	185	Bacon Cheese Burger	3.85	http://gnfwojw.info/HGOrZxe.html	{"Japanese tamago",Peperoni}	5
2722	6326	184	Pizza Pepperoni with tomatoes	7.28	https://hmeatpw.top/FGPpOyb.html	{Flour,Salmon,Mozarella,Pasta}	2
2724	1754	184	Peanut Butter	6.69	https://nyfaguj.edu/OXTQemN.jpg	{Cheese,"Bavarian sausages","Chili Pepper",Rice,Peperoni,"Caramelized onions"}	5
2746	62	185	Philadelphia with salmon	3.82	https://gbnprfl.biz/KCJbRRh.jpg	{Butter,Meat}	1
2725	8422	184	Original burger	7.82	http://uwcxhdh.top/qbpxujm.webp	{"Japanese tamago",Cucumber,"Cream cheese",Grapes,Basil,"Caramelized onions"}	4
2726	5936	184	Pizza Florida	6.39	https://www.kkcutyn.ru/qaTkrEi	{"Bavarian sausages",Onion,"Japanese tamago","Caramelized onions","BBQ sauce",Mushrooms}	4
2727	2735	184	Tortellini Bowls	7.64	https://ulfjcoi.edu/	{Mushrooms,"Chili Pepper",Pasta}	3
2769	2181	185	Wallmart	6.14	https://xccugdq.ru/TtjBhDo.webp	{Flour,Flour,Strawberry}	5
2753	2051	185	Pizza Hawaiian	3.42	https://uchwzjd.edu/uciAZvH	{"Original sauce","Cottage Cheese",Grapes,Tomatoes}	4
2730	9409	184	Saint Frank Coffee	2.56	https://ayumzqf.org/	{"Chili Pepper",Mushrooms,Butter,Peperoni,"Onion rings","Onion rings"}	4
2731	762	184	Tortellini Bowls	2.84	http://moerlwl.biz/	{Flour}	5
2732	9793	184	Original burger	3.87	https://qcunygt.com/ePPeRxo.html	{Meat,Onion,"Original sauce","Chili Pepper",Nori,Tomatoes}	3
2733	5825	184	Sweet Potato Pie	3.25	https://hnmqbds.info/	{"Bavarian sausages",Peanuts}	2
2734	4221	184	Pizza	6.22	https://abjeedx.edu/qOrHplA.webp	{Garlic,"Cottage Cheese",Flour}	1
2735	2079	184	Pizza Florida	3.84	http://sjkbohv.edu/ifieEtI.css	{Sugar,Onion,Mayo,Potatoes,Peanuts,Pasta}	1
2744	2948	185	Wallmart	2.08	http://jtyvxvu.ru/bZSrKkM.php	{Mayo}	2
2745	8327	185	Pizza Ocean	6.48	https://edlvtnr.ru/jKPQVNe.php	{Mushrooms}	3
2723	7619	184	Pizza Hawaiian	7.37	https://gagqfhh.ru/wccKKhC	{Cucumber,Grapes,Bacon,"Onion rings",Nori,Grapes}	5
2748	4365	185	Himawari	7.48	https://reobunq.top/lGkajuZ.html	{Basil}	3
2750	1224	185	Unwrapped Burrito Bowl	5.86	https://afryfpz.edu/uhKBybX.svg	{Bacon,Mayo,Pasta}	1
2751	2914	185	New York Style Cheesecake	3.08	http://xbvtrlu.biz/HyhFXgw.js	{"Bavarian sausages","Chili Pepper"}	1
2752	9439	185	New York Style Cheesecake	5.30	https://mttxhnn.ru/vlsXeGi.jpg	{Peanuts}	4
2755	7575	185	Pizza Italiano	3.15	http://www.ogtecqm.biz/pttmkiH	{"BBQ sauce"}	3
2757	6041	185	Swedish Meatballs	7.26	http://www.ehxpwak.edu/	{Pineapple,Basil,Strawberry}	3
2729	8882	184	Angel Food Cake	4.92	http://hbetxxl.net/kMTmKBv.php	{"Caramelized onions","Chili Pepper"}	3
2786	1739	185	Tortellini Bowls	4.67	http://xastpor.net/APsKOKk.php	{"Cream cheese"}	3
2758	3943	185	Bean Green Chili Burritos	7.67	https://vtguljm.biz/	{Milk,"Bavarian sausages",Sugar,Mushrooms,Rice}	5
2759	892	185	Unwrapped Burrito Bowl	2.42	http://jhjdqpc.top/vBAZLLb.css	{Garlic,Sugar,Mushrooms}	5
2761	831	185	Pizza Ocean	5.27	http://www.xtvlfka.info/	{"Cheese cheddar",Strawberry,Cheese,Mozarella,Strawberry}	5
2791	9210	185	Crispy Chicken burger	3.65	http://tgjhknh.net/nYvWmon.jpg	{Peanuts,Flour}	3
2762	9964	185	Angel Food Cake	7.57	http://dqzfydf.edu/MUKtGNL.js	{Mayo,Grapes}	1
2764	1038	185	Bacon Cheese Burger	4.28	http://jmawcvn.ru/TXDWiNo.css	{Pineapple,Cucumber}	1
2767	7397	185	Philadelphia with salmon	4.80	https://fdjnwnz.net/bbMKCeN.js	{Butter,Pasta,"Cream cheese",Flour,Flour,Chicken}	2
2768	9332	185	Grape Jelly Sandwich	5.84	https://nekpyfd.info/MagqfhY.js	{Peanuts}	4
2820	6518	186	Bean Green Chili Burritos	7.18	https://upploqp.net/UEpMJeH.php	{"Cream cheese",Mushrooms,Tomatoes}	2
2831	748	186	Bacon Cheese Burger	7.14	https://nsgtuwi.ru/TQxiNKN.html	{Pineapple,"Chili Pepper",Peas,Pasta}	3
2809	5406	186	Sweet Potato Pie	5.49	http://stafpit.info/kycKWlF.php	{Grapes}	3
2807	98	186	Pizza	4.64	http://cbirtpa.biz/XjUadkT.php	{Strawberry}	4
2836	2775	186	Pizza Pepperoni with tomatoes	3.87	https://svacvkk.top/DaRyhUq.webp	{Mozarella,Chicken,Onion}	3
2837	4010	186	New York Style Cheesecake	2.13	http://rrhmgax.com/sgUTKPx	{Mushrooms,"Cheese cheddar"}	1
2812	4739	186	Pizza Pepperoni with tomatoes	6.11	https://gpyiydx.org/pibrrbf	{Garlic,Strawberry,Pineapple}	5
2772	4174	185	Pizza	2.24	https://zxcqkfe.info/ZDnoLJg	{Milk,Cheese,Milk,Carrots,Tomatoes,Carrots}	4
2773	5846	185	Pizza	6.31	http://nnivvdq.biz/XYguSiV.html	{Chicken}	4
2774	2166	185	Wallmart	6.39	https://sixytfj.top/sRuAvJL.webp	{Butter}	5
2775	6570	185	Original burger	7.95	http://btfiasc.info/OoHwMPQ	{Rice,Pasta}	1
2776	317	185	Peanut Butter	7.83	http://kapiuea.edu/LuqVKxI.php	{"Cream cheese",Nori,Bacon}	2
2777	2099	185	Pizza Hawaiian	4.13	http://xwpikwy.org/UlmFgNM	{"Cheese cheddar","Bavarian sausages",Corn,Flour,Butter,Nori}	3
2778	6922	185	Angel Food Cake	4.61	http://www.qpklcxk.net/IKbOHWs	{"BBQ sauce",Cucumber,Garlic}	1
2779	5010	185	New York Style Cheesecake	2.94	https://www.gbtqcra.ru/	{Rice,"Chili Pepper",Rice,Mayo,Corn,Butter}	2
2780	8147	185	New York Style Cheesecake	7.78	https://rcasylo.org/XQIvQjT.php	{Nori,"BBQ sauce",Mozarella,Salmon,Nori,Pasta}	1
2781	1729	185	Pizza Pepperoni with tomatoes	6.49	http://www.jijhxcc.edu/	{Garlic,"Japanese tamago",Flour,Tomatoes}	2
2793	8903	185	Tortellini Bowls	2.36	https://ylyxgnv.net/gxyyhWW.svg	{Nori,Peperoni,Milk,Mushrooms}	3
2794	4710	185	Bacon Cheese Burger	7.48	https://jrebfpk.org/fQoDCAc.php	{Salmon,Mozarella}	3
2795	5547	185	New York Style Cheesecake	6.40	http://qpkwrtz.net/UXVjSrg.css	{Pineapple,"Cheese cheddar","BBQ sauce",Pasta}	3
2796	8933	185	Philadelphia with salmon	2.44	https://seklhei.net/svGFZtX	{Cheese,Flour,Garlic,"Cottage Cheese",Butter,Nori}	3
2797	5492	185	Pizza Florida	2.73	http://ghgpqwb.org/eghmmhF.php	{Onion,Meat,Cucumber,"Original sauce","Japanese tamago"}	3
2798	382	186	Pizza Hawaiian	3.82	http://wpljqrw.biz/AxoKQOq.jpg	{"Chili Pepper","Chili Pepper",Basil,Sugar,Mayo,"Unagi sauce"}	4
2799	4853	186	Pizza	6.19	https://pbqxbat.org/lsDKjyo.js	{Pasta,"Bavarian sausages",Tomatoes,Nori,Cheese,Carrots}	3
2800	1772	186	Grape Jelly Sandwich	6.78	https://www.btwaybb.edu/	{Grapes,Chicken}	2
2801	8652	186	Pizza Pepperoni with tomatoes	4.36	https://hfsqtxx.com/apWEnon.jpg	{"Unagi sauce"}	3
2803	9623	186	Bean Green Chili Burritos	4.49	http://ddhirhd.org/uJkGhBg	{Flour,Rice,Flour,Butter}	5
2805	1821	186	Unwrapped Burrito Bowl	4.17	https://pjfucya.org/gxgkFIL.css	{"Cream cheese",Pineapple}	1
2806	8076	186	Crispy Chicken burger	5.65	https://xjhekpd.edu/NTFlyfe.html	{"Chili Pepper",Butter,"Cottage Cheese",Mushrooms}	1
2808	5370	186	Crispy Chicken burger	6.92	https://www.ubudfbp.org/PKnvdXw	{"Chili Pepper","Bavarian sausages"}	3
2834	1390	186	Pizza Florida	2.73	https://owiappr.ru/HRAyFgf	{Cucumber,Pineapple,Milk,"Unagi sauce",Milk}	1
2810	7978	186	Pizza	7.21	https://uloiqjx.ru/kMVOtnn.php	{"Unagi sauce","Cottage Cheese",Nori,Potatoes,Flour}	2
2771	9265	185	Peanut Butter	3.98	https://mhfepnr.org/YmHLVMq.php	{"Unagi sauce",Meat,Sugar,Butter}	3
2811	4244	186	Pizza Pepperoni with tomatoes	4.95	http://mpxkasp.edu/cOeLxdi.php	{Mushrooms,Flour}	2
2813	5876	186	Tortellini Bowls	2.33	https://xnlbeko.ru/fnMHyur.html	{"Chili Pepper"}	4
2814	6548	186	Pizza Hawaiian	6.55	http://bvuxydi.org/vBYJtRD.svg	{Mozarella,Cheese,Garlic,Salmon}	1
2815	1191	186	Himawari	7.01	http://xlsjabh.net/nseaOdR.webp	{"Unagi sauce",Flour,Potatoes,Flour,Salmon}	4
2816	4935	186	Pizza Hawaiian	5.68	https://www.jjsjkkv.biz/	{Strawberry,"Cheese cheddar"}	5
2817	7794	186	Chicken Pot Pie	6.84	http://www.aosgrfh.top/	{Pasta,"Original sauce",Mayo,Grapes}	2
2818	816	186	Bacon Cheese Burger	3.74	https://ifqbjgj.net/KFLhDav.html	{"Original sauce",Nori,Corn,Butter,Flour,Chicken}	2
2819	9809	186	Pizza Hawaiian	6.63	https://bfjiyin.top/tDqctgp.html	{Milk,"Bavarian sausages","Unagi sauce"}	5
2832	3032	186	New York Style Cheesecake	2.69	http://whmewyl.org/	{Mayo,Mayo}	4
2833	2668	186	Bean Green Chili Burritos	3.70	https://vdqjmyw.net/AxipmMm.svg	{Tomatoes,"Japanese tamago",Milk}	1
2845	3108	186	New York Style Cheesecake	7.70	https://cftecjj.com/mRdgfmC	{"Chili Pepper",Salmon,"BBQ sauce",Potatoes,Mayo,"Unagi sauce"}	2
2846	5698	186	Saint Frank Coffee	7.83	https://www.xgxgrlo.org/RHhLnTq	{Pasta,Peperoni,Onion,"Cream cheese",Butter,Peperoni}	4
2847	8252	186	Pizza Texas	5.44	https://trxmnnc.com/TBvCwCt.webp	{Bacon,"BBQ sauce",Flour}	4
2856	7509	186	Pizza	6.66	https://xqthjtf.org/DlkArZl	{Milk,"Cream cheese",Cucumber,"Onion rings","BBQ sauce"}	5
2857	8502	186	New York Style Cheesecake	2.67	https://onpebyv.ru/hdFGBZk.css	{Pineapple,Salmon,Mozarella,Corn}	4
2858	4258	186	Crispy Chicken burger	5.83	https://tthfbwy.info/pIwsXTr.svg	{Peanuts,Rice,Potatoes,"Onion rings",Butter}	5
2860	4383	186	Swedish Meatballs	6.40	http://tcpkddu.edu/wyrPWdI.html	{"Bavarian sausages",Tomatoes,Meat,Strawberry}	4
2861	2676	186	Unagi Philadelphia	6.00	https://eujwgap.ru/jeGoiaq.js	{"Original sauce",Rice,Tomatoes,Peas}	3
2862	7780	186	Bean Green Chili Burritos	4.04	http://ybwqmpx.org/OQuflKM.php	{"Cheese cheddar"}	3
2863	3415	186	Sweet Potato Pie	5.50	http://xlceima.net/CVTUwxh.php	{"Onion rings","Caramelized onions"}	1
2865	5309	187	Pizza Ocean	3.88	https://fgzypgv.biz/gsexxhB.webp	{Mayo,Pineapple,Flour,Sugar,Rice,"Japanese tamago"}	2
2867	9340	187	New York Style Cheesecake	3.64	https://rtsmauh.ru/	{Salmon}	5
2823	2926	186	Bacon Cheese Burger	4.37	https://tdrurcy.top/IkBDyIg.css	{Chicken,"BBQ sauce"}	4
2824	7566	186	Wallmart	2.54	http://mabmffi.biz/jGscHsg.php	{"Unagi sauce","Cottage Cheese",Chicken,Strawberry,Mushrooms}	2
2825	9339	186	Pizza Italiano	6.43	http://bebaaot.org/pPGbPPF.html	{Rice,Corn,Rice,Meat,Mozarella}	1
2848	3354	186	Unwrapped Burrito Bowl	2.34	http://yoeixia.edu/BRqvasi.html	{Flour,Grapes,Mozarella,Garlic,Peperoni,Potatoes}	3
2849	923	186	Peanut Butter	5.60	http://keihoip.biz/IsMXKPH.html	{Flour,"BBQ sauce"}	3
2850	7304	186	Peanut Butter	7.28	http://mjpuoxg.net/roStpMw.jpg	{Butter,Sugar}	3
2851	1453	186	Pizza Hawaiian	3.76	http://udihrsc.top/qDfEnZl.js	{Cucumber}	5
2852	889	186	Pizza	7.44	http://xrfcvft.top/eTSGwFD.jpg	{Rice}	2
2826	9338	186	Chicken Pot Pie	2.24	https://npixfls.top/spHlKcL.js	{"Cottage Cheese"}	2
2827	7435	186	Pizza Hawaiian	4.06	http://vbqkgio.info/MsobgRL.html	{Cheese,Grapes}	3
2828	8490	186	Peanut Butter	7.41	https://ppescbu.info/KPlnjZD.php	{Cucumber}	1
2839	1246	186	Peanut Butter	3.17	http://qxetqat.top/AZtYNfW.jpg	{Flour}	4
2841	1345	186	Unwrapped Burrito Bowl	2.48	http://lspbiir.com/tEjvFjX.js	{Pineapple,"BBQ sauce"}	4
2842	7315	186	Crispy Chicken burger	4.29	https://kojvjtr.ru/absqmWU.svg	{"Cream cheese",Mushrooms}	5
2843	1184	186	Tortellini Bowls	6.16	http://zcolaze.edu/GsixrHX	{Carrots,"Japanese tamago"}	1
2853	3433	186	Pizza Hawaiian	5.21	https://www.glmmyzo.org/	{"Caramelized onions",Carrots}	1
2854	8806	186	Unwrapped Burrito Bowl	4.45	https://kljqhpn.info/CFwBmLT.svg	{Salmon,Mayo,Peperoni,Cucumber}	3
2868	8848	187	Original burger	7.79	https://ldqbsaa.net/aivrUJV.jpg	{Basil}	2
2844	1816	186	Wallmart	4.67	https://www.erjgrur.edu/	{Corn,Carrots,Peas,Bacon,Peas,"Cottage Cheese"}	5
2855	3424	186	Swedish Meatballs	2.45	http://irdmdxr.ru/uxEmIXQ.php	{Corn}	3
2873	8066	187	Pizza Italiano	7.82	http://mxxgbyh.ru/bscNpIt.js	{Mayo,"Original sauce",Peas}	2
2874	8034	187	Swedish Meatballs	3.06	http://nltefgc.biz/POZgQcI.css	{Mushrooms,"BBQ sauce","Japanese tamago"}	2
2924	5026	188	Saint Frank Coffee	5.38	https://wpvnuye.biz/tYaSVsc	{Cheese,"Cheese cheddar",Meat,Milk,"Unagi sauce",Bacon}	2
2925	4057	188	Tortellini Bowls	6.15	https://www.rtouozd.org/IscYHaf	{Cheese,Peas}	1
2926	8932	188	Wallmart	2.98	http://www.ncqwoeo.edu/NnCrUQN	{Mushrooms,Pasta,Peas,Sugar,Carrots}	3
2927	4581	188	Philadelphia with salmon	7.85	https://www.yotuzee.com/	{Pasta,"Cheese cheddar"}	5
2928	7452	188	Wallmart	5.74	http://qbqspjr.com/BPxppLN.js	{Butter,"Japanese tamago",Milk,Rice,"Cheese cheddar",Mushrooms}	2
2929	6044	188	Pizza Ocean	5.03	http://qhjsvpo.edu/pPmhCrN.webp	{"Chili Pepper"}	2
2930	5014	188	Philadelphia with salmon	2.73	https://oexvqcw.ru/heoKSkR.webp	{Sugar,Chicken,"Bavarian sausages","Original sauce"}	2
3018	2107	189	Philadelphia with salmon	5.18	https://hmrnntq.net/qkhTXIq	{Milk,"Unagi sauce",Cucumber}	1
3019	43	189	Crispy Chicken burger	4.17	http://www.uoxdiur.info/	{"Onion rings",Mozarella}	1
2964	7702	188	Wallmart	6.17	https://lmqmung.ru/hIYAjgu.css	{"Cheese cheddar","Unagi sauce"}	5
2934	7018	188	Bacon Cheese Burger	3.63	http://oyjlxme.biz/	{Onion,Potatoes,Potatoes,Rice}	3
2935	7131	188	Bacon Cheese Burger	6.05	http://nikwume.org/VUvlFwI.html	{Mayo}	4
2936	1720	188	New York Style Cheesecake	2.43	https://lptcjze.ru/rLXEmrU.jpg	{Mushrooms,Tomatoes,Flour,Mayo,Corn,Peperoni}	2
2937	310	188	Original burger	4.41	https://rwhtdly.com/Bvgvccg.css	{Cheese,Meat,Peperoni,Mozarella,Mushrooms,Mushrooms}	4
2942	7154	188	Pizza Ocean	3.82	http://qaudwmn.top/eyQGeop.css	{Potatoes,Mayo,"Unagi sauce","Cottage Cheese",Mayo,Nori}	3
2939	6700	188	Philadelphia with salmon	3.67	https://wfaxfqx.info/	{"Chili Pepper",Peperoni,Tomatoes,Peas,Bacon,"Onion rings"}	1
2940	8845	188	Pizza Hawaiian	2.01	http://uemmwej.biz/jthlCLy.css	{Mushrooms,"Original sauce","Cream cheese"}	1
2938	8401	188	Swedish Meatballs	6.25	https://xxlrjmq.biz/aBDgUob.php	{Tomatoes,Pineapple,"Chili Pepper","Japanese tamago",Meat}	3
2941	198	188	Bean Green Chili Burritos	3.15	https://jsqfyit.top/nnMtRtH.php	{Sugar,Rice,Rice,Basil,Pasta}	2
2943	8209	188	Unwrapped Burrito Bowl	5.33	https://joxrubw.com/jRLJXkc.js	{Corn}	1
2947	4329	188	Pizza Florida	4.28	http://bayjtyq.biz/fwePTDn	{"Chili Pepper",Peperoni,Carrots,Carrots}	4
2945	626	188	New York Style Cheesecake	4.51	https://kkjijuh.org/kwjEqQQ.css	{Carrots,Tomatoes,Bacon,Carrots,"Caramelized onions"}	5
2946	8309	188	Chicken Pot Pie	6.82	http://hqniopt.edu/fxCMYmO	{Cucumber,"Japanese tamago",Cheese,"Cream cheese",Rice,"BBQ sauce"}	1
2948	7068	188	Chicken Pot Pie	2.26	https://njgdogw.top/	{Butter,Mayo,Strawberry,Grapes}	3
2944	5021	188	Pizza Texas	2.14	http://xxyapti.top/vPSoVWF.jpg	{Butter,Strawberry}	4
2949	5148	188	Pizza Florida	5.39	http://www.wtdwuxy.biz/	{Milk,Rice,Peperoni,"Original sauce"}	2
2950	8058	188	Bacon Cheese Burger	2.54	http://xkmxvqe.edu/ZwaaPvc.css	{Nori,Chicken,Milk,Bacon}	2
2951	6377	188	Swedish Meatballs	6.75	http://www.pcbjpxr.edu/PyIgkAi	{"Unagi sauce",Milk,Onion,"BBQ sauce",Cucumber}	3
2952	4702	188	Pizza Ocean	3.74	https://jqktoyj.org/pRvPeyV.php	{Garlic}	1
2953	344	188	Unwrapped Burrito Bowl	6.31	http://maerjko.net/GFdMWFW	{Pasta,Rice,Mushrooms,Bacon,Mushrooms}	1
2954	6001	188	Unwrapped Burrito Bowl	6.97	https://mjaruij.org/haMTYhQ.html	{Garlic,Grapes,Rice,Potatoes}	3
2955	5282	188	Crispy Chicken burger	7.72	https://pswiwqk.top/FgfTEgT.js	{Basil,Butter,Carrots,"Unagi sauce",Carrots}	4
2958	9568	188	Bacon Cheese Burger	5.67	http://dppfylp.top/UJADOcH	{Corn,Carrots,"Unagi sauce",Nori,Potatoes}	2
2959	9595	188	Himawari	2.45	https://qivtokd.biz/lXosVOL.jpg	{Carrots}	3
2960	2342	188	Unagi Philadelphia	3.08	http://www.dhrrvgo.ru/	{Peperoni,Corn,"Cheese cheddar",Garlic,Milk,Peanuts}	3
2961	3105	188	Saint Frank Coffee	6.83	http://www.mctplrg.info/	{Basil,"Caramelized onions",Salmon,Peanuts,"Bavarian sausages"}	2
2962	1394	188	Sweet Potato Pie	2.76	http://aahftrw.top/cymjnAC.php	{Bacon,Peperoni,"Cream cheese",Mayo}	5
2963	2864	188	Tortellini Bowls	6.90	https://viguxmr.edu/MGXObll.html	{Cheese,"BBQ sauce",Peas}	5
2965	5866	188	Himawari	5.01	https://www.twgumaq.biz/IliiGOC	{Strawberry}	5
2966	5535	188	Tortellini Bowls	3.09	https://www.jmadwmb.biz/OFZwQUu	{"Bavarian sausages",Garlic}	2
2967	2865	188	Grape Jelly Sandwich	3.50	http://umosgtz.org/	{Flour,"Bavarian sausages",Cucumber,"Cheese cheddar",Milk}	5
2969	5303	188	Sweet Potato Pie	7.11	https://rbhkiiv.top/KpMuIqC.css	{Cucumber,Mayo,Peanuts,"Cheese cheddar","Japanese tamago",Sugar}	3
2972	8539	188	Peanut Butter	3.92	https://elslunu.top/NhYRaMy.css	{Cucumber,"Japanese tamago"}	5
2973	8464	188	Crispy Chicken burger	6.95	http://vrlybce.info/jTDpHeu.html	{Butter,Flour,Milk}	1
2974	2120	188	Bacon Cheese Burger	7.12	https://zhpvvuf.ru/rZidPVT.svg	{"Cream cheese",Mayo,"Cream cheese",Butter,"Chili Pepper","Cheese cheddar"}	5
2975	6999	188	Bean Green Chili Burritos	3.16	http://uverugx.net/jEBvAab.php	{Basil,"Cheese cheddar"}	2
2976	4618	188	Original burger	6.67	https://emqsvmj.biz/gbcFvWi	{Pineapple,"Unagi sauce",Pineapple,"Cheese cheddar","BBQ sauce"}	2
3017	2089	189	Chicken Pot Pie	7.50	http://xhbjwkc.biz/AipJDhr.css	{Basil}	3
2933	1915	188	Pizza Texas	7.44	https://eyjtoda.edu/kWWiBcs.svg	{Chicken,Butter,"Cheese cheddar",Sugar,"Caramelized onions"}	2
3011	5180	189	Pizza Pepperoni with tomatoes	7.52	http://nfcsmcy.edu/	{Chicken,Peanuts}	2
2985	6079	189	Pizza	3.79	http://yqpmobz.biz/ENoTsML.php	{"Cheese cheddar",Sugar,Pineapple,Potatoes,"Unagi sauce"}	3
3001	5600	189	Wallmart	6.29	https://qixddmn.com/KQFXfiD	{Corn,Pineapple,Tomatoes,"Caramelized onions"}	3
3020	8889	189	Pizza Pepperoni with tomatoes	4.04	https://niswefs.edu/OSlXicI.webp	{Peperoni,Pineapple}	4
3021	3378	189	Unwrapped Burrito Bowl	5.24	https://rbsdoor.edu/GYNqtwt.webp	{Bacon,Carrots,Cucumber,Meat,Milk,Salmon}	4
3010	7147	189	Pizza Pepperoni with tomatoes	5.51	https://ggqhgks.org/DHbhSKb.php	{Cheese,Milk}	4
3022	6851	189	Chicken Pot Pie	7.15	https://jodfolq.com/YBRCdaC	{"Unagi sauce"}	2
3023	1027	189	Himawari	5.48	https://ciesuso.net/aTRBGYC.svg	{Grapes,Flour,Mozarella}	2
3024	8982	189	Pizza Italiano	7.38	http://qqkbilm.top/ElvZbBL.webp	{Basil,"Original sauce",Peperoni,Pineapple,Peperoni,Peas}	5
3068	68	190	Wallmart	3.73	http://www.myspiut.com/	{"Cream cheese",Mozarella,Strawberry,"Cheese cheddar"}	1
2980	720	188	Bean Green Chili Burritos	4.09	http://nwlntzy.net/hUqpeCJ.php	{Mozarella,Peperoni,"Cheese cheddar",Flour,Mushrooms}	5
3067	2217	190	Pizza	7.64	https://droamdy.biz/mNGwCYe.webp	{Cheese,Milk}	3
3071	6844	190	Pizza Pepperoni with tomatoes	7.13	http://www.qbofsyb.info/iQsKkpO	{Mushrooms,Peanuts,Flour,Grapes,Mushrooms,Nori}	3
3069	7393	190	Original burger	5.05	https://ikinvju.org/IpiphHB.webp	{"Caramelized onions",Flour,Mayo,Chicken,Salmon}	1
3279	1244	194	Bacon Cheese Burger	4.38	http://glreggr.com/bQJVHuH.css	{Potatoes,Flour}	1
2979	261	188	Pizza Hawaiian	4.03	http://jemtgwz.top/oSCPxKF.webp	{Mozarella}	4
2996	5358	189	Swedish Meatballs	6.88	https://gdbbfxa.biz/RuBHOOp.js	{Meat,Mushrooms,Rice,Corn,Pineapple}	2
3066	7921	190	Saint Frank Coffee	4.69	https://gdeicww.info/	{Cucumber,Bacon,"Chili Pepper"}	4
3070	4195	190	Himawari	3.46	http://pimrnba.com/aFTDvfs.jpg	{Butter,"Original sauce","Unagi sauce"}	1
2983	556	188	Saint Frank Coffee	5.27	https://zuvrigw.biz/	{Meat}	2
2981	2417	188	Pizza Hawaiian	4.04	https://www.zbkyliq.ru/rVGpxXF	{Cheese}	4
2993	2978	189	Pizza Ocean	7.89	http://www.txvptmf.com/unwiaCW	{Bacon,"Chili Pepper"}	5
2989	3200	189	Pizza Texas	2.26	http://www.uyqcbfp.org/bPYKUpZ	{Salmon,Corn,Pineapple,Pasta}	3
2984	6961	189	Pizza Florida	5.33	http://www.bvnspbm.net/lbXUxUB	{Basil,"BBQ sauce",Pineapple,Chicken,"Onion rings"}	4
2995	5214	189	Pizza	7.63	http://www.gxokyda.info/	{Rice}	3
2982	6218	188	Saint Frank Coffee	7.55	http://qhgvxky.info/	{Peperoni,Mushrooms,Sugar,Mushrooms}	1
3002	8221	189	Himawari	3.79	http://fscdcza.com/tjKhKIO.jpg	{Peanuts,Butter,"Unagi sauce",Flour,Flour}	2
2999	6439	189	Pizza	5.78	https://twumguc.info/oOSMdYr.jpg	{Corn}	4
2994	883	189	Peanut Butter	4.08	http://www.gclrlvs.org/	{Garlic,Milk,Pasta,Bacon}	2
3004	1382	189	Crispy Chicken burger	2.09	https://tqdsoyp.com/YsHymeH.svg	{"Onion rings",Basil,Flour,Garlic}	1
3003	5649	189	Tortellini Bowls	5.07	https://odopynt.info/KISieKE.html	{Nori,"Cheese cheddar","Cream cheese",Meat,Grapes}	5
2997	7831	189	Pizza Florida	3.86	http://www.mooizcb.com/	{"Caramelized onions",Sugar,Rice,Flour}	1
2998	481	189	Swedish Meatballs	5.06	https://bwbwpqq.net/uYVCKPs.html	{"Japanese tamago"}	1
2992	7705	189	Pizza Italiano	6.96	https://xfgrfba.info/eJcNkvP.jpg	{Basil,Pineapple,Meat,"Onion rings","Bavarian sausages",Mushrooms}	1
2990	9608	189	Bacon Cheese Burger	4.49	https://epaxfqv.ru/kytvmFb.css	{"Cream cheese"}	2
2987	6229	189	Pizza	4.85	https://fnssxpj.info/ZbIvMhJ.css	{Flour,Rice,Salmon,Pineapple}	4
2986	1865	189	Pizza Italiano	2.87	https://xjnjxfu.info/nQVucFM.svg	{Tomatoes,Corn,Garlic}	5
3009	9471	189	Unwrapped Burrito Bowl	6.68	http://htehhgr.edu/cFuTlFt.webp	{"Original sauce",Peanuts,Meat,"BBQ sauce",Pasta}	4
3013	1646	189	Himawari	6.81	https://uqcjihj.info/ranRWNd.js	{Peanuts}	4
3005	567	189	Pizza Florida	4.33	http://www.dlakyok.info/jOGRQOR	{Flour,Basil}	1
3008	8120	189	Philadelphia with salmon	5.39	https://ndcdvke.com/JuDerjB.css	{Chicken,"Unagi sauce"}	3
3007	2057	189	Tortellini Bowls	3.12	http://www.qpavxec.top/	{Mayo}	4
3014	643	189	Pizza	7.00	https://hazylhf.top/fNZfXPa.jpg	{Garlic,Peas}	1
3012	6932	189	Pizza Hawaiian	6.25	http://tdoldlb.top/ufAPrWo.js	{"Cottage Cheese",Potatoes}	1
3006	3745	189	Swedish Meatballs	7.46	https://www.rwuogpa.edu/KIBLTPX	{"Japanese tamago",Meat,Grapes,Grapes,Chicken,Carrots}	4
3111	6978	190	New York Style Cheesecake	2.67	https://nqndnhb.com/wMnmBJg.jpg	{Salmon,Carrots}	4
3054	8306	190	Chicken Pot Pie	4.01	https://jsgbnhe.org/	{Mayo,"Japanese tamago","Cottage Cheese",Carrots,Salmon}	1
3073	8666	190	Angel Food Cake	3.21	https://www.dlkxndt.com/	{"Onion rings",Strawberry,Mushrooms,"Chili Pepper"}	1
3075	9108	190	Peanut Butter	7.60	http://vfzkvad.com/BFukiNI.svg	{Peperoni,Pineapple}	4
3113	2316	190	Saint Frank Coffee	4.07	https://phkyrxo.org/SndONNY.webp	{"Caramelized onions","Japanese tamago",Bacon}	5
3114	478	190	Original burger	4.25	http://velwrxm.com/	{"Cream cheese",Flour}	2
3115	9553	190	Wallmart	3.98	http://gxavvce.biz/	{Strawberry}	2
3112	260	190	Pizza Ocean	4.89	http://tsgacnh.com/SRYWfma.html	{Tomatoes,Salmon,"BBQ sauce",Milk,Mayo}	3
3209	7956	193	Peanut Butter	6.43	https://www.lauyjww.ru/	{Peperoni,"Cream cheese"}	5
3028	9216	189	Pizza Hawaiian	6.84	http://www.ulrecnx.top/ECOTEPq	{Flour,Milk}	5
3061	2416	190	Philadelphia with salmon	6.92	http://deufapl.org/UKJXhiP	{Pineapple,Potatoes,Flour}	2
3116	9206	190	Unwrapped Burrito Bowl	5.89	http://ewmtufl.org/wCkPLMg.webp	{Peas,"Onion rings"}	5
3032	192	190	Pizza Pepperoni with tomatoes	3.06	http://mqpyjlc.net/ORDUQrm.html	{Nori,"Onion rings",Grapes,"BBQ sauce"}	4
3030	7589	189	Wallmart	7.93	http://kfwcqtr.info/cuGsqRU	{Meat,"Unagi sauce","Cream cheese"}	1
3031	9465	189	Angel Food Cake	4.55	http://iabpvdm.com/pasXtEI.html	{Garlic,Cheese,Peanuts,"Onion rings",Cucumber,"Japanese tamago"}	4
3036	353	190	Saint Frank Coffee	7.81	http://mtbtwkd.net/FBQbxkp.jpg	{Potatoes,Salmon,Bacon,Pineapple,Tomatoes,Mushrooms}	4
3034	8486	190	Chicken Pot Pie	2.73	http://gxjadah.info/nCVIGaG	{Carrots,Peas,Cheese,Strawberry}	1
3035	5849	190	New York Style Cheesecake	4.00	https://qjplhqz.info/MSgGutr.js	{Mayo,"Original sauce"}	5
3033	1601	190	Swedish Meatballs	3.84	http://xlqonws.info/hYYUJCP	{"BBQ sauce",Nori}	4
3037	336	190	New York Style Cheesecake	6.59	https://ofuylov.info/gbIsGgN.webp	{Onion}	4
3039	5138	190	Unagi Philadelphia	6.86	http://lsrmomq.ru/htKXVIr.jpg	{"Unagi sauce"}	5
3047	3313	190	Pizza	6.51	http://lmiofvy.biz/ghZskKL.svg	{Flour,Chicken}	2
3040	7347	190	New York Style Cheesecake	5.44	https://fscfaln.top/mYtPPOk.css	{"Caramelized onions",Mayo,Cheese,Chicken}	1
3041	1622	190	Pizza Ocean	5.27	https://wfckbvj.net/nAmKfkm.html	{Chicken}	3
3029	726	189	Pizza Texas	6.28	http://gbzvcqq.info/alEjAcO.jpg	{Peanuts,"Onion rings",Strawberry,Carrots}	5
3042	9134	190	Pizza Florida	5.52	http://cxdlixd.top/SEMDVIr.webp	{Milk,Bacon}	5
3043	1313	190	Tortellini Bowls	4.45	https://siynbfr.org/USIkdOV	{Peanuts,Nori,Bacon,Cucumber}	5
3044	8085	190	Pizza Italiano	4.43	https://gjicetg.com/ouudolw.js	{Salmon,Flour,Pasta}	3
3038	2333	190	Unagi Philadelphia	3.58	http://ohttvfn.ru/SdsPejt.jpg	{Mushrooms,Meat,Rice}	3
3045	2682	190	Pizza Texas	2.98	http://uflxcya.top/hGjZQpF.php	{Grapes,Pasta,Pineapple,Pineapple,"Cream cheese",Carrots}	5
3050	8060	190	Bean Green Chili Burritos	7.13	http://rlngooc.edu/vZFqqkv	{Chicken,"BBQ sauce",Tomatoes,Potatoes}	3
3057	2720	190	Crispy Chicken burger	4.55	http://lrdgcfj.info/BdphXye.jpg	{Flour,"Japanese tamago","Bavarian sausages",Cheese,Tomatoes}	3
3055	5603	190	Pizza	3.89	https://www.flkqevw.org/xwSvIoU	{Peanuts,Chicken}	1
3060	8576	190	Crispy Chicken burger	7.69	https://rjndwnx.biz/uWZnqEQ	{"Caramelized onions"}	1
3056	1946	190	Unwrapped Burrito Bowl	4.30	https://ujwmmcs.com/vRYhZev.css	{Peanuts}	4
3049	635	190	Saint Frank Coffee	2.24	http://pzlsrrm.ru/XvkpUbB.css	{"Caramelized onions","Onion rings",Sugar,"Cottage Cheese",Pineapple}	4
3051	7235	190	New York Style Cheesecake	7.46	https://tmhsnqh.top/uSPqJcR.php	{Basil,Nori,Mushrooms,Salmon,Milk,"BBQ sauce"}	1
3052	7766	190	Pizza Florida	5.08	http://yellikf.org/aFRdmXZ.php	{Nori,Mushrooms,"Caramelized onions"}	1
3059	684	190	Pizza Hawaiian	5.04	https://zjykddb.top/FSQlEZj.css	{Potatoes,Carrots,Onion}	1
3058	6050	190	Peanut Butter	5.64	http://vltmrfu.info/wsUnVNp.html	{Pasta,Tomatoes,"Onion rings"}	2
3074	8549	190	Saint Frank Coffee	2.36	http://www.dxnjlqm.org/PZBAPBo	{Bacon,"Original sauce",Meat,Butter}	4
3063	5652	190	Original burger	6.28	http://www.xeqacgb.top/	{Onion}	5
3076	7289	190	Sweet Potato Pie	6.94	http://www.mbnolzl.ru/GkSSiUv	{"Chili Pepper",Garlic}	2
3062	9181	190	Wallmart	4.13	http://lgxprhf.org/WqeIliq.html	{"Bavarian sausages",Pineapple}	1
3124	74	191	Pizza	6.24	https://didhrkp.com/BSltrDS.jpg	{Mozarella,Tomatoes}	2
3096	7864	190	Pizza Pepperoni with tomatoes	4.73	https://www.omdeaxq.ru/JcTVRkv	{Flour,Mayo,Mushrooms,Flour,"BBQ sauce",Mozarella}	5
3079	7091	190	Pizza Hawaiian	3.09	http://tfindao.com/bEMHOgl.js	{"Original sauce",Milk,"Onion rings",Mozarella,Pasta}	4
3159	9452	192	Pizza Hawaiian	2.83	http://mxgcchf.net/qoAUIZJ	{Bacon}	1
3160	3954	192	Pizza Florida	6.81	http://oipoyre.ru/MXdHoja.html	{Flour,Potatoes}	5
3078	9372	190	Tortellini Bowls	4.59	http://objeawb.org/KwOtGXQ.html	{"Chili Pepper"}	3
3122	9226	190	Angel Food Cake	3.13	https://jemhlmh.edu/gCaxfhG.css	{Cucumber,Peanuts,Onion,"BBQ sauce",Cucumber}	3
3126	5123	191	Pizza Texas	6.98	http://oaqkdxk.info/mOfqhRn.js	{Potatoes}	1
3158	1245	192	Angel Food Cake	5.66	https://sckdjkl.biz/	{Potatoes,Peperoni,Peperoni}	1
3085	5827	190	Pizza Pepperoni with tomatoes	4.24	https://wblckcp.edu/gsfsOZc.js	{Pasta,Mayo,Mayo}	3
3083	6715	190	Bean Green Chili Burritos	7.56	https://cczesdb.net/NRLdGfS.svg	{"Japanese tamago","BBQ sauce",Milk,"Unagi sauce",Mozarella}	3
3084	1883	190	Pizza Italiano	2.96	http://upxqpgh.ru/nWFHMUi.jpg	{Nori,Tomatoes,Salmon,"Original sauce"}	2
3091	2742	190	Pizza	4.74	http://oflrgfa.com/yONlDOK.jpg	{"Original sauce",Bacon,"Cottage Cheese",Cucumber,"Cottage Cheese",Mushrooms}	2
3086	5209	190	Bean Green Chili Burritos	5.85	http://huooipm.org/xoAgqxf.html	{Basil}	3
3087	154	190	Swedish Meatballs	5.18	https://focitby.info/qNYnBtG.jpg	{Meat,Potatoes,Peanuts}	2
3092	5489	190	Unagi Philadelphia	4.78	https://udpkboq.com/PsLThbe	{Cheese,Rice,"Onion rings",Mushrooms}	5
3090	8569	190	Chicken Pot Pie	5.84	https://igoljel.org/UCLfagZ.html	{Rice,"Bavarian sausages",Bacon,Flour}	3
3097	9558	190	Chicken Pot Pie	2.84	https://akdakjb.ru/WJJKWIE.html	{Sugar,Garlic,"BBQ sauce",Onion,Mushrooms,Butter}	5
3098	2693	190	Unwrapped Burrito Bowl	6.55	http://rvktjnv.biz/fxPwuqi	{Meat,"Cream cheese"}	3
3093	4548	190	Pizza Texas	6.40	http://qoflloa.biz/XrtQIxM.webp	{Rice,Rice,Cucumber,Mayo,Peperoni}	3
3088	2578	190	Unagi Philadelphia	4.53	https://pmxmwju.info/ENnnnZA	{Pineapple,Milk,Peperoni,Mushrooms,Salmon,Flour}	5
3094	4328	190	Pizza Florida	6.21	https://dxdjdks.ru/MhJdUWx.php	{Mushrooms}	3
3104	9087	190	Grape Jelly Sandwich	4.34	http://www.znampse.net/	{"Original sauce",Mushrooms,Nori,Mushrooms,Tomatoes}	5
3103	2956	190	Pizza Pepperoni with tomatoes	5.65	http://cqxivwo.biz/sEOwnCF.jpg	{Bacon,"Cream cheese"}	4
3101	8083	190	Philadelphia with salmon	2.53	http://huykkyq.info/VMOQHgs.css	{Cucumber,Nori,"Cream cheese",Salmon,Cucumber}	2
3089	8948	190	Pizza Italiano	5.48	https://xlokfeo.net/lUOqSnj	{Butter,Chicken,Milk,"Caramelized onions",Pasta,Peas}	1
3100	7050	190	Original burger	3.92	https://qfxkaqx.ru/DseBNPi.js	{Meat,Milk,Meat,Tomatoes}	2
3107	4340	190	Pizza Florida	7.30	http://mtulfuj.biz/ZCvuXdw.webp	{Peperoni}	1
3102	406	190	Bacon Cheese Burger	7.46	https://www.knboxhl.top/TEJPioR	{Peperoni}	4
3105	7760	190	Chicken Pot Pie	3.29	http://www.ceigsfa.com/	{"Original sauce",Rice,Pineapple,Butter,"Cream cheese"}	4
3095	4316	190	Saint Frank Coffee	4.81	https://gdzenpu.net/suEOooU	{Peanuts,Nori,Grapes,"Caramelized onions"}	1
3125	4648	191	Himawari	4.03	https://rntqdmt.com/ZbfJYBS.html	{"Cream cheese","Unagi sauce",Grapes}	5
3108	2555	190	Himawari	4.34	http://www.wmmytfb.org/sXBLJZs	{Bacon,Bacon,Garlic,Onion}	2
3099	1640	190	New York Style Cheesecake	7.05	https://www.ylycpbp.biz/CjgACvg	{Tomatoes,Peanuts,"Cottage Cheese",Salmon,Pineapple,Pasta}	4
3120	2746	190	Himawari	2.19	https://www.aqbakrr.info/vPJvbvy	{Nori,Mayo,"Unagi sauce"}	2
3118	743	190	Sweet Potato Pie	7.50	http://www.snvmpso.net/	{"Cheese cheddar"}	4
3121	536	190	Bean Green Chili Burritos	6.46	https://cbldtys.top/qtMVwGS.svg	{Grapes,"Japanese tamago"}	1
3080	9559	190	Swedish Meatballs	5.69	https://nxbqedz.edu/OCZbgvc.css	{Flour,Flour,"Unagi sauce",Meat,Onion}	1
3106	9936	190	Unagi Philadelphia	7.59	http://www.jdlppxw.ru/ZKeNAhA	{"Cream cheese","BBQ sauce","Japanese tamago"}	2
3162	8514	192	Grape Jelly Sandwich	4.52	https://qfnaccq.edu/	{"Cottage Cheese"}	2
3123	9836	190	Pizza Hawaiian	2.05	http://xslsgxb.ru/Crfcsbu.html	{"Onion rings",Mushrooms,Sugar,Carrots}	5
3109	6348	190	Pizza Pepperoni with tomatoes	5.65	http://ncyxacg.top/	{Pineapple}	4
3161	1093	192	Chicken Pot Pie	5.10	https://lmpenpx.biz/uxhGgeJ.html	{"Unagi sauce"}	2
3174	6669	192	Tortellini Bowls	5.96	https://vomuxne.top/rMsyEDL	{Cucumber}	3
3205	9306	193	Wallmart	5.49	https://oppdvrh.edu/uwxkUcI.php	{Grapes}	1
3149	7377	192	Himawari	5.40	http://www.mnedwdm.biz/	{Chicken,Peanuts,Basil}	3
3169	9272	192	Angel Food Cake	4.66	https://www.rmxwupw.org/ZbvfXnx	{Sugar,Flour}	3
3139	4682	192	Angel Food Cake	4.56	http://mffowuo.biz/pFPIFeI.js	{Sugar,Grapes,Mushrooms,Rice,Cheese}	1
3154	1040	192	Pizza Florida	2.30	https://cnqhtpe.info/nyNYHto.php	{"Unagi sauce",Rice,Carrots}	3
3128	9365	191	Pizza Pepperoni with tomatoes	5.03	http://wstkhhu.ru/wLYxjAs.css	{Potatoes,Onion,"BBQ sauce"}	1
3164	3793	192	Original burger	3.23	https://pjwnllj.org/rfDfHKb.svg	{Meat,Mushrooms}	5
3133	9408	191	Pizza Italiano	3.58	http://amioybe.org/vKEVJiy.html	{"Bavarian sausages",Chicken,Flour}	4
3150	4829	192	Wallmart	3.33	https://www.fxnoiba.ru/	{Flour,Butter,Peperoni}	4
3165	2679	192	Himawari	7.40	https://www.mcojjel.org/	{"BBQ sauce",Peas,Basil}	4
3170	321	192	Pizza Hawaiian	3.63	http://ikpitnv.info/mlxybdj.svg	{Strawberry,Flour,Rice}	5
3172	4508	192	Pizza Italiano	2.51	https://zqcymdv.edu/PvJLAmC.css	{"Cheese cheddar",Salmon,Corn,Pineapple,Mozarella,Mushrooms}	4
3175	5101	193	Pizza Texas	6.06	https://cdeatet.ru/qrOIEVE.css	{Peperoni}	4
3206	5433	193	Saint Frank Coffee	6.47	http://uwmrbth.biz/uWwlrHL.js	{Mushrooms,Cheese,Cucumber,Flour,Mayo}	2
3129	835	191	Peanut Butter	2.87	https://bowklbp.edu/pHGAJQu.css	{Nori,Cucumber,"Cream cheese","Japanese tamago"}	3
3173	2524	192	Bean Green Chili Burritos	3.06	https://www.gbphhao.ru/KXjNsLl	{Mushrooms,Grapes,"Cottage Cheese",Flour,Grapes}	2
3207	7282	193	Philadelphia with salmon	4.43	http://exptdil.com/nysZrya.jpg	{Strawberry,Bacon,Flour,"Cheese cheddar"}	4
3134	8557	191	Unagi Philadelphia	5.83	https://leuecrq.ru/xfTSrsD.css	{Strawberry,Cucumber,Cucumber}	3
3135	544	191	Pizza Ocean	6.51	https://infvkmq.org/	{Nori,Cucumber,Garlic,Cucumber,Milk}	1
3140	7961	192	Pizza Hawaiian	6.52	http://www.pcgnnjp.org/	{Mozarella,"Onion rings",Potatoes,Strawberry,"BBQ sauce",Meat}	1
3141	8245	192	Philadelphia with salmon	4.64	http://www.fetdlgy.info/YiOsZLr	{"Cottage Cheese",Strawberry}	5
3147	6147	192	Chicken Pot Pie	6.81	http://tdctmes.ru/bbmbarh.php	{"BBQ sauce","BBQ sauce",Peanuts,Mayo}	3
3151	559	192	Swedish Meatballs	6.46	http://wgaztju.info/oqXoRcn.php	{Peperoni,"BBQ sauce",Garlic}	3
3130	2884	191	Tortellini Bowls	3.68	http://cikgevq.info/PkksCHH.html	{"Japanese tamago",Nori}	5
3152	2323	192	Pizza Pepperoni with tomatoes	5.38	https://hjsdzft.net/vGttGBJ	{Flour,Cheese,Peanuts}	1
3148	6428	192	Angel Food Cake	2.16	https://szvvkva.com/qyKYXjZ.html	{Peanuts,"Caramelized onions",Pasta,Flour}	3
3153	739	192	Philadelphia with salmon	5.93	http://www.difbdcs.org/	{Pineapple}	2
3166	1796	192	Original burger	2.58	https://www.ujscwnf.edu/	{Milk,"Onion rings","Cream cheese",Rice}	5
3202	785	193	Swedish Meatballs	3.36	https://xhmbfjq.edu/XfBpjkc.php	{Grapes,Onion,Potatoes,Meat,Pineapple}	5
3136	8014	191	Pizza Ocean	6.40	http://wuswttn.top/BrPvOFQ.jpg	{Nori,"BBQ sauce",Chicken}	3
3167	3948	192	Sweet Potato Pie	4.81	https://fphaeoa.biz/	{Rice}	2
3203	7738	193	Chicken Pot Pie	2.63	http://tgyjhaa.net/XRQnueT.css	{Strawberry,"Bavarian sausages",Strawberry,Peanuts}	5
3208	6611	193	Himawari	3.10	http://xkyfhjs.net/WninnIq.jpg	{Cheese,Grapes,"Cream cheese","Caramelized onions",Chicken,Garlic}	5
3131	9517	191	Pizza	5.45	https://qqcmisp.ru/scdTDXO.html	{"Japanese tamago"}	3
3138	856	192	New York Style Cheesecake	7.36	http://nrnnbec.net/qlESssb.js	{"Japanese tamago",Onion,Salmon}	5
3204	5467	193	Wallmart	3.36	http://kxzyqwi.biz/	{Sugar,Mayo,"Caramelized onions","Onion rings",Rice,Salmon}	4
3221	3872	193	New York Style Cheesecake	3.79	http://gmihywe.edu/euUGboS.php	{Mozarella}	3
3222	294	193	Swedish Meatballs	4.36	http://xmunfkg.org/ZHOncSu.php	{Mozarella,Garlic,Cheese,Tomatoes,Cucumber}	3
3199	2159	193	Swedish Meatballs	2.67	http://dxmtbnp.info/obeoKjf.jpg	{Cucumber,Cucumber,Mozarella,Sugar,"Cream cheese"}	1
3249	8902	193	Chicken Pot Pie	7.09	https://uflghdw.ru/jTFxTZY.js	{Basil,Peanuts,Corn,Nori,"Cheese cheddar","Japanese tamago"}	1
3250	6994	193	Unwrapped Burrito Bowl	2.13	https://tomsbaf.edu/pNbUjpC.jpg	{Potatoes,"Original sauce"}	1
3251	7281	193	Bean Green Chili Burritos	2.08	http://tgqzstf.org/yRufSIp.html	{"Unagi sauce",Mushrooms,Flour}	2
3252	8940	193	Unwrapped Burrito Bowl	7.17	https://svjijbh.com/hiynfOE.php	{Strawberry,Peanuts}	4
3253	8061	193	Pizza	5.21	http://dcwmfhw.top/blyKDlQ.js	{Milk,"Chili Pepper",Flour}	5
3254	5481	193	Crispy Chicken burger	4.68	https://krjvifd.org/JLPZytE	{Tomatoes,"Onion rings","Unagi sauce",Flour,"Cheese cheddar"}	5
3255	1678	193	Crispy Chicken burger	2.97	https://aexrafy.info/FYIbidF.css	{Pasta,Salmon,Grapes}	3
3812	9825	206	Chicken Pot Pie	6.80	http://www.bqpyhbt.top/	{Butter,Sugar}	4
3177	4643	193	Unwrapped Burrito Bowl	6.70	http://xudinvi.info/SdPDYuo.php	{"Cheese cheddar",Tomatoes,Garlic}	5
3178	1533	193	Original burger	2.58	https://www.fvobdjl.info/oVQkcco	{Mozarella,Mozarella,Mayo}	4
3179	3961	193	Bean Green Chili Burritos	3.80	https://kdxjtil.com/TZIGGVF.css	{Chicken,Mozarella,Corn,Chicken}	2
3180	8587	193	Saint Frank Coffee	4.87	https://qvgifwo.org/MHHfOsE.html	{"Chili Pepper","Caramelized onions",Garlic}	3
3181	4507	193	Bean Green Chili Burritos	3.59	https://cuwrbgt.edu/bhSdZuF.html	{"Chili Pepper",Flour,Corn,"Caramelized onions",Salmon}	4
3182	1879	193	Wallmart	5.18	https://lhyckfr.net/MLmTYsc.js	{"BBQ sauce","Onion rings",Flour}	2
3183	9615	193	Pizza Italiano	2.64	http://zlxjuck.top/EHeYyCn.js	{Peanuts}	3
3185	3892	193	Angel Food Cake	4.16	https://www.wgufghx.edu/	{Potatoes,Salmon,"Cottage Cheese","Caramelized onions"}	2
3186	2702	193	Himawari	7.65	https://nnubmdv.net/JQEaZFk.svg	{"Original sauce",Basil,Nori}	3
3187	7344	193	Himawari	2.89	http://hrjovvg.net/ZUogjcT.svg	{Potatoes,Nori}	2
3188	6077	193	Peanut Butter	6.33	http://vsaongh.info/VSjEbas.css	{Butter,"Cheese cheddar","Chili Pepper",Butter}	5
3189	5479	193	Peanut Butter	3.11	https://mrwufcl.info/fvkhtJs.css	{"Chili Pepper",Rice}	1
3190	965	193	Pizza	4.02	https://jnunmko.biz/	{Cucumber}	2
3191	8966	193	Pizza Italiano	6.67	http://gbevtnd.biz/YOHTYsE.js	{"Cheese cheddar",Mushrooms,Chicken,Sugar}	5
3192	24	193	Pizza Florida	5.07	https://lcyjslv.org/rQUWfTW.html	{"Original sauce",Garlic,Mushrooms}	5
3193	2464	193	Crispy Chicken burger	4.35	http://qlwdkbx.top/IsjKfAM.webp	{Bacon,"Japanese tamago",Garlic,Onion,Cucumber}	3
3194	1033	193	Pizza Ocean	6.67	http://awbagsv.net/	{Chicken,Peanuts,Sugar,Mushrooms}	1
3195	9055	193	Sweet Potato Pie	5.18	http://vilofqf.biz/McZhDsh.html	{"Bavarian sausages"}	3
3196	7923	193	New York Style Cheesecake	7.22	http://xpwgzpt.biz/	{Butter,Peas,Cucumber,Mozarella}	4
3197	4211	193	Pizza Hawaiian	3.75	https://www.joxsxao.biz/	{"Japanese tamago","Bavarian sausages",Butter,"Cream cheese"}	3
3198	7253	193	Chicken Pot Pie	5.66	http://qffmxbr.net/	{"Onion rings","Onion rings",Salmon,"Japanese tamago"}	3
3200	9648	193	Pizza Pepperoni with tomatoes	2.43	https://bfelovc.biz/XaSIxfh.js	{Chicken,Tomatoes,Pineapple}	3
3212	5110	193	Original burger	2.33	http://lwteeri.com/	{Peas,Garlic}	1
3213	1446	193	Himawari	6.43	https://tzobtof.com/KNiufiW.css	{Peas}	4
3214	3058	193	Pizza Pepperoni with tomatoes	4.99	https://qscyvci.org/VtrvfiD	{Flour,Cheese,Nori,Pasta}	2
3215	3825	193	Swedish Meatballs	3.29	https://fjivwzr.com/KTRSiZJ.css	{Chicken,Milk}	2
3216	3355	193	Wallmart	3.98	http://www.mppspuv.org/VGJaKqo	{Garlic,Cheese}	1
3217	8411	193	Peanut Butter	5.16	https://eqninid.net/kEKiPXs.js	{Grapes,"Onion rings"}	3
3218	8288	193	Peanut Butter	2.09	https://wvpsyni.info/ImpaSHr.php	{Mushrooms,Milk,Salmon}	4
3219	504	193	Bean Green Chili Burritos	2.59	http://bkjbfww.biz/vjYmwhO	{Cheese,Basil,Salmon,Milk,Corn,"Cottage Cheese"}	4
3220	9177	193	Saint Frank Coffee	3.86	https://hyolqvo.biz/EjUBLnV.html	{"Caramelized onions",Mushrooms,Nori,Mozarella}	3
3223	5502	193	Philadelphia with salmon	5.98	http://mubswof.edu/LdEPtQk.webp	{"BBQ sauce",Peas}	2
3224	3123	193	Bean Green Chili Burritos	3.05	https://www.geqmeic.info/	{"Cream cheese","Cottage Cheese",Sugar,Carrots,Salmon}	2
3268	3180	194	Pizza Florida	3.26	http://wgbtmdp.biz/VwXhmjL.webp	{Peas}	1
3242	5530	193	Philadelphia with salmon	7.05	https://qrhmsoe.edu/OmIRuGc.html	{Pasta,Salmon,Butter,Sugar,"Onion rings"}	5
3270	3076	194	Chicken Pot Pie	3.82	https://www.tnnmmhk.com/	{Flour}	1
3243	8224	193	Himawari	2.95	https://agoztyv.com/DvZxsRR.jpg	{Chicken}	5
3271	4465	194	Bacon Cheese Burger	5.34	http://www.efkhcsz.info/PcduvkT	{Mozarella,Carrots}	3
3273	7770	194	Original burger	6.52	https://mfeaaqv.com/somQtqt.php	{Chicken,Peas,Flour,Onion,Pasta}	5
3274	4843	194	Himawari	7.82	https://lhiaiqb.info/rTEWpph	{"Onion rings",Mushrooms,Milk,Mushrooms,Flour}	5
3247	5411	193	Chicken Pot Pie	6.17	http://ykijqza.ru/gEDdFmm.jpg	{"Cottage Cheese","Onion rings","Cream cheese",Pasta,Corn,Peperoni}	3
3276	5506	194	Bacon Cheese Burger	7.32	https://skhqxst.biz/dwwlHkm.webp	{Chicken}	3
3303	3276	195	Angel Food Cake	3.09	https://pqlisem.info/KMqSREU.html	{Pineapple}	5
3234	6335	193	Chicken Pot Pie	4.56	https://lozkyqy.ru/RCNswZK.jpg	{Salmon,Sugar,Nori,Mayo,Pineapple}	1
3232	5025	193	Bean Green Chili Burritos	2.47	https://ducwgbc.edu/ZLpkgQh.css	{Flour,"Chili Pepper",Peperoni}	2
3227	2744	193	Swedish Meatballs	4.27	https://www.ssiqcun.edu/jNIJegc	{Basil,Potatoes,"Cottage Cheese",Bacon,Pineapple,Meat}	4
3300	3219	195	Peanut Butter	3.53	https://hatqsox.top/meXFPSs.html	{"Chili Pepper"}	1
3301	4191	195	Pizza Hawaiian	4.22	http://caunlne.org/RRvXSnr.html	{Meat,Mushrooms,Mushrooms}	1
3230	5808	193	Swedish Meatballs	2.91	https://svldhxn.edu/bWGlXON.html	{"Japanese tamago"}	4
3246	7003	193	New York Style Cheesecake	7.23	http://jyxjrgd.net/miTSMgI.jpg	{Meat,Basil,Milk,Flour}	2
3299	4186	195	Bacon Cheese Burger	3.24	https://aaufnft.edu/jeCCMjq.js	{Flour,Mushrooms,Pasta,"Japanese tamago",Flour}	5
3231	6226	193	Pizza Texas	2.11	https://neajeyb.ru/PFAlOSP.css	{Peas,Peanuts,Garlic}	3
3240	9624	193	Tortellini Bowls	6.27	https://pmthccz.ru/KmHxCkG.php	{Bacon,Salmon,Salmon,"Cheese cheddar"}	1
3277	6748	194	Philadelphia with salmon	7.84	http://idvkbmf.org/RdvOdOn.jpg	{"Cheese cheddar"}	4
3241	5081	193	Angel Food Cake	4.84	http://ynwklip.org/Wrvjera.php	{Milk,Meat}	4
3236	7045	193	Unwrapped Burrito Bowl	6.93	https://rarimal.org/WWItdvX.html	{Chicken}	2
3275	6888	194	Sweet Potato Pie	4.89	https://fmjtohx.top/OFCgFqB.html	{Butter,"Chili Pepper",Carrots}	5
3237	1384	193	Bean Green Chili Burritos	3.85	http://jnrwpzt.edu/UZAUtUN.html	{"Chili Pepper"}	2
3259	8226	193	Pizza	2.62	http://rplxrbn.top/rLEubpk.css	{Peas,Corn,Peas,"Bavarian sausages",Milk}	1
3238	2185	193	Sweet Potato Pie	6.84	https://www.onkiiot.ru/mBZHQvI	{Carrots,Potatoes,Rice}	4
3267	4235	193	Sweet Potato Pie	3.06	https://hfngqzn.com/ijJBWUq.jpg	{Flour,"Caramelized onions",Mayo}	1
3261	1577	193	Himawari	6.58	http://zalnsdc.info/	{Chicken,Potatoes,Onion}	3
3258	2002	193	Peanut Butter	2.96	https://pjutjpf.top/UYTQNXL.css	{Mushrooms}	1
3269	8959	194	Chicken Pot Pie	4.40	https://twnawlc.ru/VJGJRlS.js	{Rice,Milk,Mayo,Grapes}	1
3245	4757	193	Pizza Texas	5.09	http://whuuomc.info/YLwuJoo.css	{Cucumber,Cucumber,Potatoes}	4
3262	8676	193	Unagi Philadelphia	5.17	https://asugary.net/sJESpBo.webp	{"Caramelized onions","Onion rings",Nori,Peas,"BBQ sauce"}	4
3298	9153	195	Sweet Potato Pie	3.39	http://anhdybg.top/MShwCWv.js	{Flour,Strawberry,"Cheese cheddar"}	3
3257	8730	193	Pizza Hawaiian	6.01	https://fbplvuf.top/LwVLBJf	{Peanuts,Mushrooms,Chicken}	2
3263	4834	193	Crispy Chicken burger	2.80	http://www.otrgshs.edu/	{Cheese,Meat}	2
3265	5862	193	Wallmart	4.28	http://ogngvbn.net/NMZWhpr.svg	{Carrots,Mushrooms,"Chili Pepper"}	1
3266	9605	193	Angel Food Cake	4.79	https://aakrcro.info/DBMQIXM.webp	{Mayo,Butter,Nori,"Japanese tamago",Grapes}	1
3272	2237	194	Saint Frank Coffee	2.34	https://jwkxevu.ru/HTgtXdk.css	{"Caramelized onions","Onion rings",Mozarella,Mushrooms}	1
3228	7499	193	Pizza Texas	5.58	https://ovstkiu.ru/LhgYKKN.webp	{Peperoni,Salmon,Pasta}	1
3264	636	193	Grape Jelly Sandwich	5.30	http://www.vnlipzg.top/FugQuiS	{"Cottage Cheese",Mushrooms,"Japanese tamago",Mayo,Cucumber}	1
3229	2737	193	New York Style Cheesecake	3.54	http://www.tfvwakh.biz/	{Milk}	2
3278	5216	194	Wallmart	3.42	http://izkpoeo.biz/sNGPJEE.php	{"Cream cheese",Peanuts,Carrots,Rice}	4
3260	7402	193	Philadelphia with salmon	5.51	https://sgigcag.org/RYGMePt.webp	{Tomatoes,"Original sauce",Meat,"Original sauce"}	4
3244	7191	193	Pizza Ocean	6.81	http://jfdwwdg.com/gSUvyqK.js	{Grapes,Strawberry}	3
3329	7006	196	Wallmart	6.47	https://zrvamju.net/nhMfDYW.css	{Garlic,Cucumber,Strawberry,Onion,Rice}	2
3323	2557	196	Unwrapped Burrito Bowl	2.44	https://www.tduiyud.org/	{Butter,Cucumber,Chicken,Peas,"Onion rings","BBQ sauce"}	2
3309	9029	195	Swedish Meatballs	5.12	https://ooahlfs.edu/	{Grapes,"BBQ sauce",Cucumber,Sugar}	3
3327	7472	196	Pizza Ocean	5.44	http://ibyqxcw.ru/YLBlOGu.html	{"Original sauce","Onion rings","Japanese tamago",Strawberry}	5
3320	4532	195	Unwrapped Burrito Bowl	2.44	http://tiqxepl.ru/BfgTeyk.js	{Carrots,"Cottage Cheese","Caramelized onions","Unagi sauce",Bacon,Peperoni}	4
3288	500	194	New York Style Cheesecake	5.62	http://djlftyn.org/gNgVaXM.js	{Corn,Cucumber,Tomatoes,Carrots,Butter}	2
3282	3864	194	Sweet Potato Pie	6.36	http://uadtwvq.top/mPvsVEg.svg	{Pasta,Onion,Basil}	5
3322	562	196	Original burger	2.45	http://tawebar.net/ZDlTMma.svg	{Tomatoes,"Original sauce",Carrots,Chicken,Meat}	4
3344	6454	198	Himawari	4.24	https://www.gylnzcl.info/QGCCKfM	{Corn,Cheese}	4
3293	3275	195	Bacon Cheese Burger	3.98	http://sfaavrx.org/uIiQJtM.jpg	{"Japanese tamago",Milk}	5
3346	7772	198	Pizza Texas	6.42	https://llajowp.edu/jeYQrWu.php	{Pineapple,Carrots,Mushrooms,"Bavarian sausages"}	3
3313	8310	195	Angel Food Cake	2.91	http://hdplixr.ru/oeAlGOK.php	{Corn,Rice}	2
3317	5127	195	Himawari	4.12	http://tnbexmn.net/bvsQFOD.php	{Flour,Sugar,Cheese,Mayo}	5
3348	2635	198	Pizza Florida	3.36	http://hshpawt.ru/ssTJkmQ.css	{Tomatoes,Meat,"Caramelized onions",Salmon,Chicken}	4
3349	9018	198	Angel Food Cake	6.53	http://www.njpyvuc.biz/UislUNn	{"Cottage Cheese",Mushrooms,Mayo,Mushrooms}	1
3310	2707	195	Grape Jelly Sandwich	6.35	https://fhgzgip.org/oHqBQwO	{"Chili Pepper"}	5
3283	5402	194	Pizza Italiano	5.28	https://yqswnsm.ru/qtxtEeO.php	{Butter,Basil}	2
3311	8575	195	Saint Frank Coffee	5.16	https://wsgjjtq.org/vwYESPu.css	{Strawberry,"Unagi sauce",Salmon,Onion,Peperoni,Bacon}	5
3294	8941	195	New York Style Cheesecake	2.49	https://tdtxcaj.edu/	{Tomatoes,Peperoni}	3
3324	1572	196	Bacon Cheese Burger	5.25	https://jhiopto.biz/	{Basil}	4
3286	368	194	Saint Frank Coffee	5.33	https://byamaae.ru/	{"Japanese tamago",Bacon,"Cottage Cheese",Carrots}	4
3287	5420	194	Chicken Pot Pie	7.17	https://rhcmflt.org/GIHpLGL.webp	{Carrots}	1
3290	4183	194	Bean Green Chili Burritos	5.37	https://xkreywa.info/yULIYST.html	{"Bavarian sausages"}	3
3350	8969	198	Pizza Texas	2.53	http://www.hiwounl.com/vFbYmgN	{"Cream cheese",Milk,"Cheese cheddar","Chili Pepper",Onion}	3
3292	9219	194	Pizza Pepperoni with tomatoes	4.68	http://gryfniq.biz/LnhksWo.webp	{"BBQ sauce"}	1
3284	957	194	Pizza Florida	3.15	https://yrbbcxt.top/mAIMFMq	{Tomatoes,"Cottage Cheese",Nori}	3
3305	6407	195	Pizza Florida	3.22	http://npavwie.net/eZtOXUq.svg	{Pasta}	1
3314	9323	195	Saint Frank Coffee	5.44	http://osjubru.info/bBQoHVG.php	{Milk,Peanuts}	2
3306	9780	195	Grape Jelly Sandwich	6.24	https://mllfbme.com/	{"Caramelized onions"}	3
3347	5833	198	Sweet Potato Pie	3.87	https://atnogio.org/jKBPjQy.css	{Milk,"Cheese cheddar",Peas,Corn,Pineapple}	2
3307	4142	195	Pizza Hawaiian	7.49	https://loffpdp.edu/DAuagSv.webp	{Peanuts,Onion,Bacon,Carrots,Sugar}	5
3308	7582	195	Sweet Potato Pie	4.69	http://knmpdcu.top/LqgxJjh.webp	{Mushrooms}	4
3319	2768	195	Pizza Hawaiian	6.18	http://kfsrqzi.biz/XgatseA	{Sugar,"Onion rings"}	4
3330	717	196	Swedish Meatballs	6.68	https://euvwacb.edu/	{Butter,Corn,Mushrooms,Tomatoes}	1
3318	5099	195	Wallmart	7.95	http://loyxvmv.ru/HYZaEZj.css	{Onion}	2
3312	5111	195	Pizza Italiano	5.97	http://fnbqafr.edu/TGWFoau.jpg	{Nori}	3
3302	909	195	Peanut Butter	5.44	https://easugpp.org/nFDkRyL.css	{Garlic,"Japanese tamago"}	4
3285	5455	194	Swedish Meatballs	3.20	http://zqaovte.edu/aMWobEN.jpg	{Rice}	2
3316	8191	195	Wallmart	2.24	http://fkzmtbc.top/bWfhKtA	{Pasta,"Original sauce",Basil}	3
3326	8999	196	Tortellini Bowls	5.91	http://www.vetqrxd.biz/TIcBFII	{Sugar,Tomatoes,Butter}	2
3328	7880	196	Pizza Italiano	4.59	https://osfxnkt.com/aQslOqF.html	{Salmon,"Unagi sauce",Tomatoes,"Onion rings"}	3
3321	5812	195	Pizza Pepperoni with tomatoes	3.91	https://www.dofaypg.edu/	{Grapes,Pineapple}	3
3325	5116	196	Crispy Chicken burger	3.38	http://www.eiompao.biz/tpJFRkl	{Mozarella}	1
3331	6640	196	Unwrapped Burrito Bowl	7.21	https://riqxter.info/	{Peperoni,"Unagi sauce","Onion rings","Original sauce","Cheese cheddar"}	2
3345	6787	198	Pizza Hawaiian	3.13	https://www.tunbaie.org/	{Corn,Mushrooms,Mozarella,Grapes,Pasta}	3
3375	6337	198	Peanut Butter	7.04	http://naebrmk.org/iMKBklZ.js	{Potatoes}	5
3376	4458	198	Grape Jelly Sandwich	5.67	http://ashbwxq.org/CsocQqX	{"Original sauce",Garlic}	3
3377	9347	198	Sweet Potato Pie	2.00	https://exfhydd.net/afOPbDZ.webp	{Salmon,Flour}	4
3371	6227	198	Crispy Chicken burger	5.88	https://blomehh.org/ojnxGxd.html	{"Bavarian sausages",Rice,"Chili Pepper",Chicken,Peas,"Onion rings"}	5
3391	6755	198	Pizza Hawaiian	6.85	http://ruosrxa.com/ivhpFEW.js	{"Cheese cheddar",Bacon,Flour}	5
3384	1136	198	Pizza Texas	5.16	https://ookoazq.com/JoCDjIS.jpg	{Corn,Corn}	3
3339	3329	196	Swedish Meatballs	2.19	https://www.jbdrpms.top/	{Mushrooms,Mozarella,Tomatoes}	4
3396	8633	199	Unwrapped Burrito Bowl	7.02	https://sptdmdc.top/ulWtdER.php	{Milk,Corn,Mayo}	2
3378	2722	198	Wallmart	3.10	http://dvanrbr.info/CwBXesy.php	{Mayo,Meat,Cheese,Peas}	3
3380	4936	198	Pizza Ocean	6.50	http://lnfgkkf.edu/IOmqrLU.js	{"Cottage Cheese",Corn}	5
3333	4603	196	Peanut Butter	5.04	https://bqmqres.info/KwmfClk.php	{Mayo}	4
3392	5608	198	Sweet Potato Pie	5.03	http://ffrafpc.info/vrSMNco.php	{Chicken}	1
3394	4509	199	Philadelphia with salmon	3.41	http://joghrhs.com/rhbRSVn.css	{Cucumber,Peperoni}	3
3382	3339	198	Original burger	5.28	https://uejfmuj.biz/JMFYbNR.php	{Chicken,Onion,"Cream cheese",Bacon,"Cheese cheddar"}	2
3383	8042	198	Unwrapped Burrito Bowl	3.19	https://ufymphn.org/jvNwoKC.svg	{"Cheese cheddar"}	2
3397	4602	199	Unagi Philadelphia	7.03	https://hnjagvn.top/sKXNUsx.webp	{Peas,"Chili Pepper","Cottage Cheese",Milk,Peperoni}	2
3390	3214	198	Pizza Hawaiian	2.32	http://mgybcjf.org/dOQeWmW.html	{Meat,"Cheese cheddar",Peas,Potatoes,Mozarella}	3
3335	3983	196	Angel Food Cake	3.83	https://cgiozcw.top/QWJJKlO	{Salmon,Mushrooms,"Caramelized onions"}	5
3395	1896	199	Angel Food Cake	4.53	https://www.rvrqjqn.edu/DysrxTu	{Grapes}	4
3336	9582	196	Tortellini Bowls	7.84	https://smivlcx.edu/EwXBBgw.php	{Bacon}	3
3360	3142	198	Angel Food Cake	2.88	https://jspiagr.ru/	{Tomatoes,Peperoni,Pineapple,"Chili Pepper","Cottage Cheese"}	5
3338	1848	196	Grape Jelly Sandwich	3.13	http://iklaaru.info/	{Bacon}	1
3356	5227	198	Original burger	2.59	http://uafptfd.top/XVeEKWP.jpg	{Mushrooms,Grapes,Peperoni,Peanuts,Pasta,"Chili Pepper"}	5
3334	6557	196	Pizza Florida	7.30	https://ljntbcj.biz/fkofjFn.svg	{Meat,Pineapple,Sugar,Flour,Flour}	5
3355	7762	198	Chicken Pot Pie	6.70	http://ljbhgyr.net/CpKhHVH.js	{"Chili Pepper","Cheese cheddar"}	2
3337	9236	196	Pizza Texas	4.54	https://tbcnraq.net/lQjunLg.svg	{"Bavarian sausages",Tomatoes,Strawberry,Chicken}	2
3357	4597	198	Philadelphia with salmon	2.71	https://thyjaog.top/ncIuwaY.css	{Mayo}	2
3364	4927	198	Unwrapped Burrito Bowl	5.33	https://cmopacm.biz/nrcQVfw.html	{Peanuts,Peas,Strawberry,Cheese,Pasta}	3
3352	8876	198	Pizza	4.19	https://mghmybn.edu/vgnrnSh.css	{"Cream cheese",Mozarella,Mayo,Bacon}	3
3358	6109	198	Pizza Italiano	7.78	https://ryqvrgq.top/xtDjwgQ.jpg	{Tomatoes,Potatoes,"Chili Pepper"}	3
3361	9052	198	Pizza	7.89	https://ijztdvn.info/wZecqEm.php	{Grapes,Milk,Milk,Sugar,Peas}	3
3366	8984	198	Swedish Meatballs	3.72	http://biiypyv.top/	{"Original sauce",Mozarella,Cheese}	4
3353	5736	198	Original burger	6.05	https://www.wqffqbu.org/UdMuhDS	{"Cheese cheddar",Corn,Pasta,Pasta}	5
3363	2808	198	Bacon Cheese Burger	5.15	http://nkitsrl.ru/UhnrjZq.html	{Pineapple,"Unagi sauce",Mayo,Garlic}	2
3354	985	198	Pizza Italiano	2.22	https://qweuouc.top/gARMJkK.js	{Butter,"Cottage Cheese",Milk,Peperoni,Mozarella,Bacon}	2
3365	8491	198	Swedish Meatballs	6.22	https://nymluyt.edu/RXmaqFG.js	{Peperoni,Pineapple,Sugar,"Cottage Cheese",Basil,"Onion rings"}	2
3367	1641	198	Saint Frank Coffee	6.31	http://vmdbavf.org/gIBogYE.js	{"Original sauce",Garlic}	4
3373	6450	198	Peanut Butter	4.17	https://usjrruh.top/ruwdKZA.webp	{"Unagi sauce","Japanese tamago"}	2
3368	501	198	Bean Green Chili Burritos	7.30	https://bfoziud.org/KevoQPN.jpg	{Bacon,Peperoni}	5
3379	4448	198	Himawari	2.81	https://urtwvmd.com/hvNJdDZ.css	{Garlic}	5
3372	8279	198	Pizza	3.55	http://yshsfyt.biz/	{Onion,Peperoni}	3
3374	1900	198	Himawari	2.70	https://ugvqdoq.net/EYUaBbf.js	{Pasta,Mozarella,Garlic}	1
3393	2313	199	Pizza Ocean	5.19	https://yzlbrlw.top/ejckVaN.html	{"Caramelized onions",Nori,Onion}	4
3362	8552	198	Pizza	5.24	http://jqsvnhm.info/CTvFCQR.php	{Cheese,"Unagi sauce","BBQ sauce","Original sauce",Peperoni}	3
3369	7636	198	New York Style Cheesecake	5.38	https://sxuymag.com/QSDxktL.php	{Rice,"BBQ sauce",Salmon,"Japanese tamago",Onion}	3
3434	2778	199	Pizza Texas	2.48	http://dyikaox.com/THAtwFe.html	{Cucumber,Flour,Chicken}	2
3414	9117	199	Pizza Ocean	7.53	https://www.xdopvio.top/	{"Caramelized onions"}	5
3420	7709	199	Philadelphia with salmon	7.24	http://muwavje.com/UypbIwI.html	{Rice,Basil}	3
3417	275	199	Bacon Cheese Burger	6.78	http://tqjdwgs.com/HYGneiy	{"Cream cheese",Tomatoes,Milk}	1
3421	6512	199	Unwrapped Burrito Bowl	6.68	https://lukjufi.edu/xEZVBdF.svg	{Carrots,Meat,Mushrooms,"Cottage Cheese","BBQ sauce"}	4
3431	291	199	Chicken Pot Pie	3.78	http://www.mnfngoc.biz/wQeWGGi	{"Cream cheese",Bacon}	5
3422	1668	199	Pizza Hawaiian	5.13	http://sldinav.info/BkcZdWW.php	{Flour,Pineapple}	5
3439	2488	199	Sweet Potato Pie	6.09	https://wzlkqis.info/vFklafM	{Salmon,Mushrooms}	5
3441	617	199	Pizza Texas	5.99	https://cixeuli.top/CHwVBDR.jpg	{"Japanese tamago",Salmon,Salmon,"Cheese cheddar",Cucumber}	5
3402	8743	199	Angel Food Cake	7.20	https://iokknqw.biz/vcidbHZ.css	{"Cottage Cheese",Tomatoes}	3
3409	1637	199	Pizza Ocean	2.69	https://lgsfuxd.top/WeaTUOM.svg	{Mushrooms,Peas,"Onion rings",Carrots,Onion}	5
3407	3585	199	Pizza Ocean	4.12	http://fogsklm.org/WGRKUVL.html	{Bacon,"BBQ sauce",Meat,Grapes,Mushrooms,Peperoni}	5
3388	1315	198	Himawari	5.91	https://rpphpwo.net/kgLChKH.webp	{Mayo,"Chili Pepper",Nori}	3
3411	8392	199	Crispy Chicken burger	5.56	http://www.fmtfhnv.top/HmQuQYJ	{Flour}	4
3386	1785	198	Chicken Pot Pie	5.57	http://www.poeeleq.edu/feBeXts	{Chicken,"Japanese tamago"}	5
3423	4756	199	Sweet Potato Pie	4.86	https://jxkbojx.info/ovsuuEf.php	{Flour,"Unagi sauce","Chili Pepper"}	5
3412	6739	199	Grape Jelly Sandwich	7.53	http://zxyjsut.top/lKmKhOS	{Peanuts,Peanuts,Corn,Mayo,Milk,Salmon}	3
3418	7987	199	Unwrapped Burrito Bowl	6.59	http://taraekj.biz/	{Chicken,Milk,"Unagi sauce",Rice}	3
3410	8563	199	Pizza Hawaiian	4.95	http://edybvhh.edu/	{Milk,Pineapple,"Bavarian sausages"}	4
3425	6496	199	Angel Food Cake	3.44	http://lfghzcs.org/gcpTTKE	{"Cheese cheddar","Unagi sauce",Bacon}	4
3428	6940	199	Saint Frank Coffee	3.04	http://esvielr.org/vVlSlaU.jpg	{Butter,Mozarella}	5
3430	706	199	Pizza Ocean	7.05	http://cwdmnqh.edu/PAMgYnM.svg	{Cheese,Mozarella,Rice,"BBQ sauce","Cream cheese",Rice}	4
3483	3298	200	Wallmart	2.33	https://vmepgdm.top/HYnmjNJ.css	{Garlic,Pineapple}	5
3438	6910	199	Pizza Florida	6.05	http://pnrxkrx.info/	{Pasta,Potatoes,"Caramelized onions",Peperoni,Corn,Garlic}	2
3399	1240	199	Grape Jelly Sandwich	4.09	http://vguuaih.ru/	{Flour,Tomatoes,Rice,Potatoes,Flour}	2
3433	4114	199	Peanut Butter	2.39	https://ajdsuzi.net/QQVHCbX	{"Onion rings",Salmon,"Caramelized onions","Bavarian sausages"}	2
3403	4284	199	Grape Jelly Sandwich	2.83	https://sqmmmpb.org/QZXnZRN.css	{Pasta,Flour}	5
3404	6957	199	Bean Green Chili Burritos	7.32	http://fisnpdj.ru/acOeIdy.jpg	{Meat,"Caramelized onions","Bavarian sausages",Tomatoes}	3
3387	1911	198	Himawari	3.28	http://www.xevnchw.ru/yfhEcbr	{"Bavarian sausages",Salmon,"Original sauce",Potatoes}	5
3405	8935	199	Pizza Pepperoni with tomatoes	6.28	http://www.zzbkevg.info/	{Peanuts,Strawberry,Corn,Flour,"Japanese tamago"}	1
3406	244	199	Wallmart	4.54	http://kjnxiqj.top/IFBBoTD.js	{Milk,Garlic,Basil,Basil}	4
3415	262	199	Grape Jelly Sandwich	7.14	https://iwifhsa.org/JXcsEwF.svg	{Mayo,Butter}	5
3419	2640	199	Unagi Philadelphia	7.29	http://tnjifhf.org/FeLqJWo.js	{Onion,Peperoni,Milk}	4
3424	3375	199	Unwrapped Burrito Bowl	4.47	https://www.rwootlo.com/JBcMPJG	{"Unagi sauce","Caramelized onions"}	2
3440	1154	199	Pizza Italiano	4.22	https://kfmojmh.biz/VPkUxdw.svg	{"Cream cheese","Japanese tamago",Grapes,Salmon,Pineapple}	4
3401	2294	199	Tortellini Bowls	7.71	http://awjaeqs.com/BtoaTBX.php	{Strawberry}	5
3408	6444	199	Tortellini Bowls	3.14	http://lnqikkk.edu/UJNxkJo.html	{"Caramelized onions","Cream cheese",Bacon}	2
3413	7983	199	Pizza Florida	2.46	https://ltwrulo.ru/cttTDGB	{Corn,Tomatoes,"Cheese cheddar"}	2
3416	3334	199	Bean Green Chili Burritos	3.68	http://mqpjabi.edu/WdZFNfF.css	{Grapes,Garlic,"Unagi sauce",Nori}	3
3530	8353	201	Unwrapped Burrito Bowl	6.48	http://ohjxbxw.org/	{Rice}	1
3531	6814	201	Bacon Cheese Burger	5.56	http://ppiofhg.info/WUliLNK.js	{Milk,Strawberry,Butter,Flour,"Caramelized onions"}	4
3532	2141	201	Angel Food Cake	2.63	http://cclfmmd.biz/fUEodtg.jpg	{Pasta,Strawberry,Peperoni}	3
3445	4779	199	Peanut Butter	5.98	https://uylixty.ru/ehJCxSY.php	{Peanuts,Cucumber,Peanuts,Mushrooms,Milk,Onion}	2
3484	8098	200	Tortellini Bowls	2.83	http://oanusab.com/hMdfbVJ.php	{"Original sauce",Rice,Nori,Salmon,Potatoes}	2
3485	8993	200	Tortellini Bowls	2.26	http://osklysr.info/kahqNfB	{Peanuts,Grapes}	1
3486	5080	200	Swedish Meatballs	5.01	http://www.ouuyqyy.top/GZYbLWb	{Nori,"Onion rings",Nori,Milk}	1
3487	925	200	Angel Food Cake	3.58	https://rrsgrsu.info/HGYgGob	{Grapes,Pineapple,"Bavarian sausages",Peas}	1
3488	6598	200	Crispy Chicken burger	7.17	http://www.esbbpkg.info/	{Nori,Pasta,Onion,Mushrooms,Strawberry}	1
3528	2370	201	Bean Green Chili Burritos	6.86	https://uttmyms.com/dHasJOF.svg	{Garlic,Mushrooms,Pineapple,"Bavarian sausages"}	2
3529	2529	201	New York Style Cheesecake	7.78	https://www.tukjixh.ru/	{Peas,Milk,Mushrooms}	1
3493	1733	200	Sweet Potato Pie	5.39	http://ppantpw.top/rogCWEl.svg	{Meat,"Japanese tamago",Rice,Salmon}	1
3494	8304	200	Pizza Pepperoni with tomatoes	7.83	http://xxtgomj.ru/oGVYkZt.svg	{"Bavarian sausages",Potatoes}	2
3495	1634	200	Unwrapped Burrito Bowl	4.46	http://www.drxbbvm.edu/YKxgbsZ	{Chicken,"Original sauce"}	5
3496	5922	200	Pizza Hawaiian	3.06	https://fiorkhx.info/AJWZquh.webp	{Pineapple,Rice,Potatoes,Mushrooms,"Chili Pepper"}	1
3576	2729	203	Pizza	2.86	http://sqvfjif.top/OPQWNoc.php	{Mushrooms,Mayo}	5
3497	6166	200	Pizza Texas	7.34	https://www.pevodzy.net/	{Flour,Cucumber,Chicken,Grapes}	2
3498	1081	200	Bacon Cheese Burger	2.86	http://www.ocblqmg.net/	{"Cream cheese",Tomatoes,"Original sauce"}	2
3499	9563	201	Unwrapped Burrito Bowl	5.63	http://ooutxla.org/ZIcKNBR.webp	{Basil,Meat,Cheese,Sugar,Cucumber,Mayo}	2
3577	3154	203	Sweet Potato Pie	5.64	https://fltlura.edu/CSnhaGM.css	{Carrots}	3
3578	8074	203	Saint Frank Coffee	4.46	http://bamnlpj.top/omdCxaX.webp	{Meat,"Unagi sauce","Japanese tamago"}	5
3579	7578	203	Angel Food Cake	7.12	https://dxcotxr.edu/HKuiADv.html	{"Caramelized onions"}	4
3580	2541	203	Crispy Chicken burger	4.74	https://nhvrwwm.net/sKAqWgD.svg	{Salmon,"Bavarian sausages",Flour,Mozarella,Basil}	5
3581	5462	203	New York Style Cheesecake	5.48	http://www.phywhny.net/	{Garlic,Sugar}	1
3582	8733	203	Crispy Chicken burger	4.57	https://axwmuss.org/YbNEhaX	{Grapes,Peperoni}	4
3500	3666	201	Pizza Florida	3.04	https://xhrbkyp.net/ZSRFQxb.jpg	{"Unagi sauce",Peas,"Original sauce","Chili Pepper"}	1
3502	1088	201	Pizza Hawaiian	6.01	http://msqwbfp.edu/gqVPJXC.php	{Cheese}	3
3521	3468	201	Grape Jelly Sandwich	6.64	https://www.swhluez.top/pRWGrhF	{Peanuts}	5
3522	290	201	Pizza Italiano	2.50	http://dqmjlwk.org/	{"Caramelized onions",Chicken}	5
3523	9258	201	Himawari	7.48	http://tvtzibn.edu/iFjDIpK.php	{Flour}	2
3524	9955	201	Swedish Meatballs	4.80	http://exqcksq.net/	{Basil,Meat}	3
3525	2147	201	Unwrapped Burrito Bowl	4.69	https://mubeurd.com/qguOmsN.js	{Cucumber,"Cream cheese"}	2
3533	5929	201	Pizza Hawaiian	7.41	http://www.yrgzjpj.net/	{"Cream cheese",Peperoni}	1
3491	752	200	Pizza Texas	5.13	https://mayqgcb.top/uGlfxdW	{Pasta,Basil}	3
3534	3996	201	Pizza Hawaiian	3.49	https://veptdyl.org/INkUfOD	{Peperoni,Sugar,"Japanese tamago"}	3
3536	3711	201	Original burger	3.16	http://www.xtuoyqv.net/	{"Original sauce",Flour,Peperoni}	2
3538	2738	201	Original burger	6.79	http://jkxteoe.net/vWXWXEx	{Mushrooms,Pineapple,"Japanese tamago",Salmon}	5
3624	3777	203	Unwrapped Burrito Bowl	6.51	https://ypongzk.org/FbVNnZf.svg	{Meat,Flour,"Original sauce",Rice,"Japanese tamago"}	4
3562	4912	203	Unagi Philadelphia	5.47	http://pljoiud.org/psppJwK.webp	{"Original sauce",Rice,Chicken}	3
3625	2055	203	Pizza Ocean	5.65	http://www.sqgnazm.info/ZAevOYr	{Pineapple,Nori}	2
3626	5707	203	Wallmart	4.66	http://agihhss.top/chDWxfc.svg	{Chicken,"Unagi sauce",Basil,Pineapple,"Caramelized onions"}	3
3627	7264	203	Pizza Florida	7.70	https://www.osaksxg.info/	{Nori,Flour,Flour,Peperoni,Flour}	5
3843	3047	207	Wallmart	7.31	http://xhqksbg.info/YvwMrCY.webp	{"Caramelized onions"}	1
3573	628	203	Angel Food Cake	2.76	http://rojlhmu.org/ReLbKoL	{"Original sauce","Chili Pepper","BBQ sauce",Peperoni,Tomatoes}	3
3545	6345	201	Pizza Ocean	3.73	https://vccmxxv.net/opFhqKQ.php	{"Cream cheese"}	2
3547	5140	201	Bean Green Chili Burritos	4.97	http://bmmgxjw.biz/dhIkWZN.svg	{Rice,Tomatoes,Potatoes}	3
3550	4035	202	Pizza Hawaiian	2.27	https://lujrrev.biz/hsGPfWC	{"Cottage Cheese","Cream cheese",Garlic,Bacon}	4
3546	3322	201	Wallmart	4.79	https://www.xeikelc.edu/	{Rice,Pineapple,"Onion rings",Strawberry}	1
3549	2295	202	Bacon Cheese Burger	5.20	http://tpuwqtl.info/TYCHKUL.html	{Strawberry,Tomatoes}	3
3554	5516	202	Crispy Chicken burger	3.53	https://flhfebc.com/	{"Japanese tamago",Peperoni,Flour,"Original sauce","Original sauce"}	4
3551	7942	202	Unagi Philadelphia	6.77	https://gwtcqvq.org/ZpTUYRs.svg	{Bacon,"Bavarian sausages","Chili Pepper","Cream cheese"}	2
3566	5942	203	Crispy Chicken burger	4.04	https://zlsuotj.org/ZatkDUG.html	{Butter,Corn,Rice}	4
3553	5277	202	Angel Food Cake	6.18	http://eqsiuax.biz/xTLtTCI	{"Cream cheese",Peas,Nori}	4
3556	7458	202	Pizza Pepperoni with tomatoes	4.02	http://mlzrlwg.net/HJpCXph.svg	{Flour,Potatoes}	3
3555	8151	202	Pizza Texas	2.20	http://rcxpdmf.top/KjaIqQU.svg	{"Cheese cheddar",Bacon,Potatoes}	4
3557	5206	202	Wallmart	5.90	http://www.nmxlwro.info/WeuGXUu	{"Caramelized onions",Basil,"Cheese cheddar","Bavarian sausages",Salmon,Cheese}	5
3560	4947	203	Swedish Meatballs	4.65	http://foophtk.biz/lTKpCMn.svg	{Pasta,Sugar,Peperoni,Flour,Pineapple}	4
3585	5574	203	Original burger	5.67	http://qylmprb.org/vNeEERZ.js	{Mayo,Cucumber,Onion}	3
3561	2954	203	Himawari	3.01	http://oiydkxo.net/VQBARQH	{Grapes,"Original sauce",Mozarella,"Cream cheese"}	1
3559	9795	203	Chicken Pot Pie	7.20	https://alptkmn.net/lOmkXML.jpg	{Basil}	1
3568	4022	203	Pizza Texas	3.23	http://sbkcqea.top/HcYkfwL	{"Caramelized onions",Chicken,"Japanese tamago","Original sauce",Potatoes,"Original sauce"}	4
3563	1197	203	Swedish Meatballs	6.86	http://buockbh.biz/kZEkVmg.jpg	{Cheese}	2
3569	5865	203	Tortellini Bowls	6.89	http://www.ixscfcb.top/	{Tomatoes,"Cream cheese","BBQ sauce",Onion,"Cheese cheddar",Basil}	4
3565	8382	203	New York Style Cheesecake	6.99	https://www.oezuida.edu/rschRnL	{Flour,Flour,"Original sauce",Tomatoes,Mozarella,Meat}	3
3567	2692	203	Pizza Ocean	7.25	https://hbwplrw.net/	{Onion,Bacon,Tomatoes}	2
3552	6107	202	Pizza Italiano	7.48	http://ukuurut.ru/fNZTobR.svg	{Peperoni}	2
3587	5204	203	Unwrapped Burrito Bowl	4.22	http://mgnpsfj.net/DNNcmhp.svg	{Cheese,Carrots,Flour}	4
3589	360	203	Sweet Potato Pie	6.71	https://www.zpfbuqp.top/	{Cucumber,Bacon}	2
3570	4349	203	Grape Jelly Sandwich	5.69	https://nmbymps.edu/ddIoRal.svg	{Salmon,Mayo,Strawberry,Salmon,Pasta}	3
3571	463	203	Himawari	6.11	https://hfnobza.com/IVaODFX.js	{"Cheese cheddar",Flour,"Japanese tamago","BBQ sauce",Tomatoes,"Unagi sauce"}	5
3572	7841	203	Tortellini Bowls	2.79	http://oadhans.info/YdWviJd.webp	{Corn,Cheese,Bacon,Butter}	4
3588	6038	203	Crispy Chicken burger	5.78	http://rhahjej.net/gVfnomj	{Mushrooms,Garlic,Corn,Onion}	5
3558	4590	202	Bean Green Chili Burritos	6.80	http://taunnzn.com/WrmeRff.svg	{Flour,Pasta,Pasta,Meat,Grapes,Strawberry}	3
3586	6343	203	Angel Food Cake	5.60	https://dsicnxd.top/qjZybVC.svg	{"Chili Pepper",Peanuts,Pineapple}	4
3574	2435	203	Pizza	7.69	https://tnaqlvw.biz/teOulJY	{Butter,"Unagi sauce",Cucumber,"Cottage Cheese","Japanese tamago",Salmon}	3
3564	6037	203	Swedish Meatballs	5.09	https://tkpvszp.top/MLxjZrC.webp	{Cheese,"Chili Pepper","Chili Pepper",Rice,Peanuts}	4
3543	3270	201	Unwrapped Burrito Bowl	3.87	http://vqpqyxm.com/XdXeZrj	{Meat,Pineapple,"Caramelized onions"}	3
3623	7944	203	Pizza Ocean	5.40	https://nkwildv.ru/ftbBaxS.jpg	{Mozarella}	2
3541	4299	201	Chicken Pot Pie	4.20	https://www.fdqhlay.top/	{"BBQ sauce",Cheese}	1
3635	4541	203	Pizza Ocean	3.96	https://uvbfqvy.info/qilHJyr.html	{"Caramelized onions","Japanese tamago"}	3
3619	3806	203	Pizza Texas	2.40	http://lvmjygi.top/xMLjZut	{Mozarella,Grapes}	4
3620	1665	203	Pizza Pepperoni with tomatoes	6.70	https://gxgdedb.ru/ThTaGTs.js	{Flour,"BBQ sauce"}	1
3674	1226	205	Philadelphia with salmon	2.13	https://ifiouat.biz/pvTnNOd.svg	{Mushrooms}	5
3634	1307	203	Wallmart	4.95	http://www.hnebrda.com/	{Sugar,Grapes,"Chili Pepper","Original sauce"}	1
3671	638	205	Grape Jelly Sandwich	4.28	https://aflrrkw.com/vKbLTrI.webp	{"Caramelized onions",Pasta}	1
3672	1934	205	Crispy Chicken burger	6.20	https://mqibqjb.info/eoHfKQB.php	{Peas,Pasta}	4
3673	9732	205	Unwrapped Burrito Bowl	3.51	http://bcrvnwu.net/IRXgyAB.jpg	{"Bavarian sausages",Chicken,Salmon,Chicken,Mushrooms}	2
3675	6892	205	Sweet Potato Pie	4.61	https://www.zneauvu.top/	{"Cottage Cheese",Mushrooms}	4
3640	5586	203	New York Style Cheesecake	6.95	https://bcwzata.org/	{Peas}	1
3598	6155	203	Pizza Hawaiian	2.89	https://www.egjbldb.org/	{Carrots,Tomatoes,Potatoes}	4
3670	851	205	Crispy Chicken burger	4.18	https://txrhivq.biz/pIiErfb.webp	{Milk,Cheese,"Cream cheese",Strawberry,Peperoni,Peas}	1
3592	6032	203	Bacon Cheese Burger	6.66	http://daersns.info/	{Mozarella}	2
3593	9026	203	Unagi Philadelphia	7.14	https://xirompp.info/hrslcmC.jpg	{Mushrooms,Strawberry,"Cottage Cheese",Peas,Peperoni,"Cream cheese"}	2
3594	4673	203	Pizza Texas	4.98	https://tyysvqc.org/mNdRODc.webp	{Mayo,Sugar,Onion}	4
3602	5269	203	Bean Green Chili Burritos	4.48	https://ihnbrwk.net/cFLbCKB	{Butter,Basil,Sugar,Tomatoes,"Cheese cheddar"}	1
3597	4668	203	Unagi Philadelphia	6.69	https://evmctem.net/ejKkBFm.js	{Mozarella,Pasta,"Bavarian sausages",Potatoes,"Chili Pepper",Grapes}	1
3604	8558	203	Pizza Florida	6.47	https://kipgtvh.org/	{Flour,Potatoes,Meat,Corn}	1
3599	4549	203	Grape Jelly Sandwich	6.33	http://girtbqi.info/dtTDcXB	{Bacon,Peas,Pasta,"Chili Pepper",Rice}	1
3591	9335	203	Pizza Italiano	2.62	http://www.sdlcedy.ru/mDpCEaA	{Mushrooms,Mushrooms,"Cheese cheddar"}	5
3600	9723	203	Bacon Cheese Burger	6.31	https://byxnlgf.biz/PhsZcBU.php	{"Chili Pepper",Flour}	4
3609	1391	203	Pizza Italiano	7.66	https://qfozyfq.info/	{Carrots,Peanuts,Flour}	5
3603	1099	203	Unagi Philadelphia	3.08	https://agkoaaj.net/	{"Chili Pepper",Pasta,"Original sauce","BBQ sauce"}	5
3595	2670	203	Grape Jelly Sandwich	3.03	https://ardiwdn.com/DXUWkFQ	{Chicken,Tomatoes,"Onion rings",Butter}	2
3605	5852	203	Swedish Meatballs	7.16	https://xsykisu.info/JiSXIeM.html	{Garlic,Onion,Bacon}	3
3606	4995	203	Pizza Italiano	7.46	http://fkbsoqa.com/iNVhgfw	{Potatoes,Corn,Pasta}	2
3607	6349	203	New York Style Cheesecake	6.40	https://imuzvgi.ru/LeIkTbp.css	{Strawberry,Rice}	4
3610	5826	203	Pizza Italiano	3.94	https://www.cgfsmvj.biz/UdlvKjj	{Tomatoes}	3
3601	4546	203	Peanut Butter	5.36	https://mkufweb.ru/eCgyeNt.jpg	{Peas,Pineapple,Pasta,Rice}	5
3611	5174	203	Pizza	3.72	https://www.ymixfau.org/CKYsjTb	{Pineapple,"BBQ sauce",Mayo,Tomatoes,Basil,"Cheese cheddar"}	2
3612	9072	203	Crispy Chicken burger	2.65	http://www.lvxiijl.com/	{Peperoni,"Bavarian sausages","Original sauce","Onion rings",Cucumber}	4
3613	4290	203	Pizza Hawaiian	2.79	https://gzdyoxn.top/nuGEyuJ.webp	{Pineapple,Flour,"Bavarian sausages","Caramelized onions"}	5
3615	9122	203	Pizza Pepperoni with tomatoes	6.28	http://dyuigtx.org/gEYKPWT.jpg	{Mozarella}	4
3616	7865	203	Pizza Florida	7.87	http://www.tvexwpl.com/	{Corn,Grapes,Peanuts,Peas,Bacon}	3
3617	2615	203	Philadelphia with salmon	7.60	http://xehzsig.info/FpRmmVs.js	{Strawberry,Potatoes,Mozarella}	5
3633	8227	203	Angel Food Cake	4.44	http://www.snssbuj.biz/	{Tomatoes,Mayo,Cucumber,"Cottage Cheese",Pasta}	3
3618	7744	203	Pizza Texas	5.30	http://gqpqjhl.ru/FDcULFf	{Garlic,Flour,Flour,Carrots,Rice,Corn}	2
3630	8815	203	Original burger	6.29	https://uvosvil.org/hbDqvqI.svg	{Tomatoes,"BBQ sauce",Onion}	1
3614	2531	203	Pizza Ocean	3.43	https://lkgvaxx.net/wtkOmcv.css	{Corn,Garlic,"Unagi sauce",Mushrooms,Bacon,Corn}	2
3631	4070	203	Unwrapped Burrito Bowl	3.57	http://ooryuix.org/VjvLcqn.html	{Garlic}	4
3632	8731	203	Tortellini Bowls	6.49	http://arzmnay.ru/FrMHgsg.jpg	{Peas}	1
3641	4622	203	New York Style Cheesecake	3.46	http://sdrbohn.info/	{Potatoes}	4
3636	6137	203	Sweet Potato Pie	7.52	http://mvweshx.edu/WYxnoKh.jpg	{Garlic,Onion}	3
3639	7007	203	Original burger	4.18	https://njrcpbt.top/SeblQuh.jpg	{Corn,Cheese,Flour}	5
3688	3376	205	Pizza Italiano	5.17	https://imhuuwf.ru/JUBoSsP.html	{Corn,Peas,Pasta,"Cottage Cheese",Cheese}	5
3665	1201	204	Original burger	7.31	http://yvnjcsm.biz/	{"Cheese cheddar","Chili Pepper"}	5
3689	5392	205	Grape Jelly Sandwich	7.77	https://jvotddw.info/Dhaywia.svg	{Nori,"Cottage Cheese",Onion,Nori,"Cottage Cheese",Mayo}	4
3691	7862	205	Bean Green Chili Burritos	4.30	http://qatsrot.biz/BFMKHZO.html	{Mayo,"Cheese cheddar","Original sauce",Basil,Cheese,"Cottage Cheese"}	2
3692	5741	205	Sweet Potato Pie	2.15	http://nlhwsbg.org/jnRSnst.svg	{Grapes,Mayo,"Cream cheese",Cucumber,Peperoni,Basil}	3
3648	8642	203	Pizza Italiano	7.43	https://qbhpgae.ru/BnKOuHv.php	{Bacon,Basil,Nori,"Original sauce",Onion,"Original sauce"}	2
3681	3696	205	Swedish Meatballs	3.56	https://aadkiis.org/rsMbryP	{Peanuts,Basil,Peas,"Cream cheese"}	5
3717	4837	205	Pizza Hawaiian	7.31	https://bnagyjp.info/CZLxoHi.html	{Sugar,Peas,Peperoni,Grapes}	1
3718	7287	205	Saint Frank Coffee	4.76	https://gdgpwge.com/yRKjnFo.js	{Mushrooms,"Cheese cheddar",Carrots,Garlic}	4
3720	8648	205	Pizza Florida	3.38	http://qbynsrd.top/MHypGGv.jpg	{Pasta}	1
3650	2238	203	Pizza Ocean	6.57	http://zllgdtc.biz/towIyBs.jpg	{Meat,Pineapple,Mushrooms}	3
3652	6447	203	Unagi Philadelphia	4.92	https://otgblta.ru/CIreWHF.webp	{Flour,Cucumber,"Cheese cheddar",Mushrooms,Basil,"Onion rings"}	3
3655	1901	204	Pizza Italiano	4.15	https://aqhvmja.org/JNpHqPj.webp	{Nori,"BBQ sauce","Cottage Cheese"}	1
3643	8507	203	Peanut Butter	3.51	https://cmkrawu.net/RelCEqS.svg	{Basil,Mayo,Mushrooms,"Caramelized onions"}	3
3645	6033	203	Pizza Ocean	3.03	https://ifipjhb.org/HyrYYHC.php	{Meat,Chicken,Pasta,Butter,Grapes,"Unagi sauce"}	5
3646	2470	203	Pizza Florida	5.53	https://gijgisc.biz/FZwdOIA.jpg	{Basil,Potatoes,Peperoni,Peanuts,"BBQ sauce"}	3
3647	7227	203	Pizza Pepperoni with tomatoes	7.90	https://lltobib.org/tUqvbBF	{Mushrooms,Potatoes,"Cottage Cheese"}	3
3680	3981	205	Original burger	2.48	https://xrvzdaq.top/lEmUsqe.svg	{Garlic,Salmon,"Unagi sauce",Butter,Salmon}	1
3649	7911	203	Tortellini Bowls	7.21	https://ijzydqh.ru/UfZdKVr.php	{Potatoes,Cucumber,Mayo,Mushrooms}	4
3651	4498	203	Pizza	6.20	http://qsycbqi.biz/auHeTwp.svg	{Mushrooms,"Original sauce","Bavarian sausages",Chicken,Potatoes,"Chili Pepper"}	1
3685	2796	205	Swedish Meatballs	2.62	https://tzltsfu.biz/OwrwRMj.jpg	{"Cheese cheddar",Nori}	5
3662	1647	204	Saint Frank Coffee	6.62	https://www.fscgtef.com/	{Pineapple}	5
3653	2792	203	Saint Frank Coffee	6.06	http://wkeibjo.edu/WsipaaF.html	{Mushrooms,Meat,Strawberry,Potatoes,Carrots}	3
3721	7574	205	Peanut Butter	4.52	https://mbkwdvb.ru/YWIKKDG.js	{Corn,Rice,Mozarella,"Original sauce"}	3
3690	8619	205	Sweet Potato Pie	6.59	https://xwvxbji.top/rnAYYiY.jpg	{Grapes,Mushrooms}	1
3657	5660	204	Sweet Potato Pie	6.96	https://dmbcaof.biz/exbtKVm.php	{"Cream cheese"}	1
3658	5915	204	Bean Green Chili Burritos	4.41	https://eplkihf.biz/eMBvCkv.webp	{Mozarella,Mushrooms,"Cheese cheddar"}	3
3682	2542	205	Philadelphia with salmon	3.14	https://wtkminh.biz/OXDCqbL.webp	{"Cheese cheddar"}	5
3661	2391	204	Pizza	7.38	https://ompfghj.ru/PYpgPeN.php	{"Japanese tamago",Strawberry,"Caramelized onions",Butter,Milk,Rice}	4
3659	1719	204	Himawari	5.49	http://ornykin.top/	{"Cream cheese",Corn,"Chili Pepper"}	5
3683	7179	205	Sweet Potato Pie	2.03	https://iemirvw.top/bgBlIKF.css	{Mushrooms}	1
3663	9585	204	New York Style Cheesecake	6.27	https://haiowhv.ru/WlymgfX.php	{Peperoni}	5
3664	4812	204	Pizza Italiano	7.44	https://auecigz.net/vmIDcNH.webp	{Butter}	3
3687	3704	205	Wallmart	5.54	http://www.aryzxuk.ru/DiXFDAD	{Onion}	2
3666	3439	204	Himawari	4.15	https://amitqrb.net/	{Basil,Peanuts}	5
3667	9192	204	Pizza Italiano	5.61	http://xnfysbf.biz/xOxeUGY.js	{Peperoni,Corn}	1
3677	5526	205	Swedish Meatballs	6.50	https://obyvygq.com/hNYOGxw.svg	{Cucumber}	4
3678	1952	205	Bacon Cheese Burger	3.24	https://orhufoq.net/MKPokTJ.webp	{Meat}	5
3656	9501	204	Pizza Florida	6.70	https://pnpueyh.edu/NFEvnwH.svg	{Nori,Corn,Onion}	4
3660	6402	204	Unwrapped Burrito Bowl	4.07	https://qiigxow.ru/frgmOqV.php	{Corn,Pasta,Meat,Meat,Rice,Peperoni}	5
3693	9669	205	Chicken Pot Pie	3.86	https://bfcizsk.biz/ahbTYZJ.php	{"Japanese tamago"}	2
3719	9135	205	Peanut Butter	6.24	http://cqwkhpa.ru/WJvKgxT.css	{Butter,Rice,Flour,Bacon,Butter,Cucumber}	5
3684	8580	205	Unwrapped Burrito Bowl	6.93	https://crnrymg.net/NIMKMCx	{"Cheese cheddar",Mushrooms,Tomatoes}	1
3654	2317	203	Pizza Italiano	2.38	http://ukgczjv.biz/RRWemdA.css	{Flour,Sugar,Potatoes}	2
3763	298	206	Grape Jelly Sandwich	6.69	http://hwyimxr.com/vUOpVJY.webp	{Sugar,Peas,Mushrooms,Strawberry,Meat,Cheese}	3
3764	8800	206	Unwrapped Burrito Bowl	2.95	https://yclwkuk.info/pSFuTmX.jpg	{Potatoes,Salmon,Mushrooms,Mozarella,Mushrooms}	4
3734	8183	205	Himawari	7.87	https://hyczjyq.info/yUvwTZP.jpg	{Bacon,"BBQ sauce",Salmon}	3
3695	5775	205	Unwrapped Burrito Bowl	2.72	http://qpnmjrc.edu/	{Bacon,Peperoni,Nori}	4
3696	1776	205	Saint Frank Coffee	6.86	https://aohicuz.top/EvikmTJ.js	{Carrots,"Unagi sauce",Cucumber,Salmon,Basil,Pineapple}	4
3708	1591	205	Angel Food Cake	7.29	http://srxublv.top/wbMSJFn.html	{Grapes,Cucumber,Peas,Grapes,Basil}	3
3698	649	205	Sweet Potato Pie	6.01	http://lgdwexj.org/yhfEXNY.svg	{Milk,"Onion rings"}	1
3699	1560	205	Pizza Florida	7.09	https://cmubvtx.com/mgOwdgU.html	{"Japanese tamago",Nori,Strawberry}	3
3700	4239	205	Pizza Ocean	3.09	https://qbhqetr.org/QvbcLvH.html	{Garlic,Flour,Garlic,Strawberry}	1
3707	8471	205	Himawari	3.15	https://mqoesbk.net/vgfIIEG.js	{"Chili Pepper",Milk,Tomatoes,"Onion rings"}	5
3697	5791	205	Swedish Meatballs	3.02	http://jeonajw.net/HSkOcGo.webp	{Flour,Mushrooms,Rice,Salmon,Pineapple,Mayo}	2
3704	4189	205	Himawari	7.18	http://lqkgiws.top/QEIjbDC.css	{Mayo,"Japanese tamago",Carrots,Rice}	5
3705	2365	205	Pizza Pepperoni with tomatoes	5.25	http://bzgcaeu.info/QNHOCyY.html	{Sugar,"Unagi sauce",Cheese}	4
3702	9599	205	Bacon Cheese Burger	3.30	http://yvmpbfq.edu/XTsLpsX.html	{Mozarella,Peanuts,Peanuts,Meat,"Onion rings",Corn}	4
3701	7858	205	Pizza Florida	4.38	http://uuonlnw.biz/eOBAqMI.svg	{"Cottage Cheese","Unagi sauce",Peas,"Bavarian sausages","Unagi sauce"}	5
3703	3551	205	Original burger	3.28	http://www.zrcwwde.info/ZItkdkd	{Pineapple,Carrots,Cucumber,Peas}	4
3709	1388	205	Pizza Texas	2.19	http://www.bxajqdg.ru/mOxoMug	{"Cheese cheddar",Flour}	4
3711	8855	205	Original burger	5.49	http://euoabdy.com/vterKCC.svg	{Chicken}	5
3712	1658	205	Wallmart	4.16	http://hqlgdgd.ru/mloyhmf.html	{Pasta,"Caramelized onions",Chicken,Meat,"Unagi sauce"}	2
3730	7928	205	New York Style Cheesecake	6.53	https://aguxmfc.biz/FypeNsZ.css	{Mushrooms,Salmon,Bacon,"Cheese cheddar",Peanuts,Mushrooms}	3
3714	4416	205	Original burger	4.55	http://dzwhgvz.top/eJBhABY	{"Cottage Cheese",Butter,Peanuts,"Original sauce",Mushrooms}	4
3728	8414	205	Original burger	2.65	http://gympple.ru/hWsrHoM.jpg	{"Chili Pepper",Nori,"Caramelized onions"}	4
3724	8796	205	Pizza Ocean	5.56	http://avqaoar.com/fEEbRjO.html	{Corn,Nori}	4
3727	3079	205	Bacon Cheese Burger	5.05	http://www.egmsser.biz/nJAoBNQ	{Peas,Mozarella,Mayo}	5
3713	4382	205	Chicken Pot Pie	3.94	http://awkveet.org/kCxqhIt.jpg	{Garlic,Tomatoes}	4
3729	6815	205	Peanut Butter	5.78	http://xoiauiv.top/KBZqHFE.html	{"Caramelized onions","Caramelized onions",Basil}	2
3723	6924	205	Pizza	5.93	http://yskiqws.edu/OTfRfQh.webp	{Potatoes,"Chili Pepper",Butter,"Onion rings",Salmon,Pineapple}	1
3731	335	205	Pizza Italiano	6.33	https://qcchxyy.org/	{Milk,Cucumber,Grapes,"Original sauce",Milk}	4
3726	7069	205	Unagi Philadelphia	3.08	https://rjivxlu.info/pmJwqfn.php	{Pasta,Tomatoes,Nori,"Cheese cheddar",Peperoni}	1
3732	7326	205	Chicken Pot Pie	2.14	https://iknahqi.ru/hoqjQTx.svg	{Salmon,Strawberry,Mayo,Corn}	1
3733	763	205	Angel Food Cake	3.43	https://wvlcswg.info/sPUiNOr.webp	{Butter}	4
3735	9283	205	Swedish Meatballs	6.59	http://aalaaxl.com/	{Meat,Basil,"Original sauce",Flour}	3
3740	3188	205	Grape Jelly Sandwich	7.54	https://owppnmj.biz/JjyEPnU.php	{Tomatoes,Butter,Grapes,Butter,"Onion rings"}	4
3737	9870	205	Pizza Ocean	2.51	https://pbsrqya.org/bKIPfAi.html	{Tomatoes,Garlic,"Caramelized onions",Basil}	1
3738	4151	205	New York Style Cheesecake	4.69	http://hvpcdub.com/rpEvdGq.webp	{Flour,Strawberry,Garlic,Grapes,Mozarella}	2
3739	7974	205	Philadelphia with salmon	4.07	https://xklhsuo.biz/fisVlHQ.jpg	{Corn,Cheese,Peanuts,Pasta,Mushrooms}	1
3741	1008	205	Pizza Italiano	7.26	https://sitiaum.info/EiZnTEl.jpg	{Mayo,Potatoes,Cucumber,Cucumber}	2
3736	5333	205	Sweet Potato Pie	6.51	https://lpltycq.com/DgRZERH.php	{Pasta,Pineapple,Mushrooms,Flour,Strawberry}	1
3742	4705	205	Philadelphia with salmon	2.33	https://sgwctrb.info/wflmRnN.webp	{Mozarella}	3
3743	9683	205	Philadelphia with salmon	3.51	https://ahjnufe.info/WNdNLHA.webp	{Peanuts,Onion,Chicken,Pasta,"Cream cheese"}	2
3762	2636	206	Chicken Pot Pie	5.28	http://rpqokkx.org/ilCiTJQ.webp	{Rice,Nori}	5
3765	125	206	Wallmart	3.65	http://rmyvkea.org/AnBHelT	{Flour}	1
3752	8868	205	Pizza Florida	4.66	http://www.ddrwdwn.com/	{"Cream cheese","Cottage Cheese",Garlic,Mozarella,"Japanese tamago",Bacon}	3
3805	7620	206	New York Style Cheesecake	3.86	http://bkargqw.top/lIIcNDb.html	{Tomatoes,"Chili Pepper","Onion rings",Pasta,Milk}	3
3756	818	205	Sweet Potato Pie	5.23	https://vyvhevg.top/CeynhPT.css	{Cheese}	5
3778	8379	206	Bacon Cheese Burger	4.23	https://hyzmhgx.com/mDbnbQR.css	{Basil,"Onion rings",Mushrooms,Nori}	2
3810	9904	206	Pizza Florida	5.23	http://www.zuoxyaz.net/giCumBC	{"Cheese cheddar",Peas,"Unagi sauce","Japanese tamago","Cottage Cheese"}	5
3811	5900	206	Swedish Meatballs	6.66	https://www.dsttnsm.info/	{Nori}	4
3745	8929	205	Pizza Texas	3.34	http://fwqwreq.org/Kcjrxdv.php	{"Cream cheese",Garlic,Mushrooms,Mozarella}	1
3746	9588	205	Pizza Pepperoni with tomatoes	5.11	http://cwbsrut.info/CJQawVL.php	{Flour,"Chili Pepper",Mozarella,"Chili Pepper"}	5
3747	2403	205	Saint Frank Coffee	6.94	https://puegpgf.edu/dIiOxvg.html	{Milk,Mushrooms,Peanuts,Grapes,"Cottage Cheese"}	3
3749	5205	205	Pizza Texas	7.56	http://lncwufj.top/	{Butter,"Chili Pepper",Mozarella,"Japanese tamago",Basil,"Bavarian sausages"}	4
3750	9831	205	Chicken Pot Pie	7.79	https://fbgfkgi.edu/QiBqRIi.webp	{Corn,"Cottage Cheese",Chicken,"Caramelized onions"}	3
3790	435	206	Chicken Pot Pie	7.36	https://cymorsu.biz/ljqPCSG.jpg	{Peas,"Cheese cheddar",Cucumber}	4
3774	7670	206	Bean Green Chili Burritos	2.92	http://gqmixth.ru/dAKRbox.css	{Meat,Mayo}	1
3753	1909	205	Pizza Italiano	5.32	https://htdpjvo.top/SYWBDZI.html	{Mayo,Chicken,"Cheese cheddar",Cheese}	5
3754	8720	205	Pizza	3.30	http://qldylyc.org/	{Grapes,Chicken,Flour,Nori,Cucumber,Peanuts}	4
3755	1627	205	Himawari	6.60	https://xxutpvw.ru/iCmKWix.webp	{Cucumber,Sugar,Peanuts}	1
3758	1984	205	Grape Jelly Sandwich	3.74	https://itegavt.edu/mlrelib	{Pineapple,Butter,Peas,Mayo,Tomatoes}	3
3779	3919	206	Pizza Ocean	2.10	http://dctcvkm.top/uLZkewW.css	{Grapes,Pasta}	5
3780	9988	206	Sweet Potato Pie	2.98	https://fhxstzj.com/UyxkhNP.webp	{Cucumber,Pineapple}	2
3781	6244	206	Chicken Pot Pie	2.01	http://gpvmeuf.edu/oWJecBn.js	{Peanuts,Peanuts,Peperoni,"Bavarian sausages"}	1
3759	3637	205	Himawari	4.92	https://tjhiupt.org/OoECGTg.jpg	{Cheese,Chicken,Flour,Flour,"Japanese tamago"}	2
3767	5881	206	Himawari	5.40	http://vbqbzxb.info/Cyqlkvt.jpg	{Peas,Bacon,Meat,Peperoni,"Original sauce"}	2
3768	4814	206	Pizza Italiano	7.51	https://jnrgtsf.info/EYfUHaJ.css	{Cheese,Meat,Grapes,"Cheese cheddar",Chicken}	5
3769	5324	206	Pizza Italiano	4.95	https://bfpavek.ru/JHXaeYP.php	{Flour,"Cheese cheddar","Onion rings",Grapes,"Unagi sauce"}	2
3770	5829	206	Himawari	2.70	https://ntbivtq.net/NLBnZjc.css	{"Cream cheese",Bacon}	5
3772	7608	206	Sweet Potato Pie	5.21	https://xkqfukb.top/	{Flour,Basil,Grapes}	3
3751	6698	205	Unwrapped Burrito Bowl	4.44	http://csinzfs.ru/YxjFQqf.jpg	{Mushrooms,"Onion rings",Chicken,Tomatoes}	4
3791	2452	206	New York Style Cheesecake	4.10	https://iksaapn.com/MgXSVKd.html	{Mayo,Mayo,Peas}	5
3775	3558	206	Pizza Pepperoni with tomatoes	7.45	https://tmztdxa.info/dMnifFp	{Cucumber,Milk,"Cottage Cheese",Rice,Garlic}	5
3777	642	206	Angel Food Cake	7.10	https://www.jugddzt.org/	{Milk,"Unagi sauce",Peas,Cucumber,Peperoni,"Cream cheese"}	4
3807	1328	206	Philadelphia with salmon	5.34	https://kpvqzqi.info/VONxdxM.js	{"Cream cheese",Rice,Meat}	1
3809	904	206	Bean Green Chili Burritos	3.86	http://jqoiskc.ru/XBTIKQD	{Corn,"Bavarian sausages"}	4
3757	4752	205	Pizza Hawaiian	5.83	https://olohmgy.edu/vjHQIaa.jpg	{Meat,Pasta}	5
3782	9043	206	Pizza Texas	7.35	http://www.xlkkjxs.com/WKwahKs	{Nori}	4
3784	6181	206	Pizza Hawaiian	3.06	http://wskomvk.net/	{Peanuts,Pasta}	3
3785	5038	206	Original burger	7.84	https://smyfhtk.edu/etrIBEo.js	{"BBQ sauce"}	5
3786	5548	206	Crispy Chicken burger	3.88	https://www.dcrlajv.top/	{Peperoni,Meat,Basil}	4
3787	4495	206	Pizza Pepperoni with tomatoes	6.39	http://nehefzx.top/	{Nori,Nori,Pasta,"Japanese tamago"}	4
3788	7525	206	Bacon Cheese Burger	3.66	https://nggwdvr.net/iVtSlXx.webp	{Corn,Bacon,Flour}	1
3789	1288	206	Pizza Texas	3.14	http://ohxparl.edu/NatJMLm.svg	{"Cottage Cheese"}	2
3773	3978	206	Pizza Florida	5.15	http://www.vkrxalw.info/	{"Onion rings",Garlic,"Cream cheese","Japanese tamago"}	3
3776	2096	206	Pizza Ocean	4.69	https://vqdeokp.ru/GgYIAHO.js	{Milk,"Japanese tamago","Japanese tamago",Chicken,Strawberry,Bacon}	5
3808	8452	206	Bean Green Chili Burritos	3.36	https://xgzbhtk.ru/AAJKren.php	{Pasta}	1
3816	764	206	Pizza Hawaiian	7.83	http://crvegre.biz/cXfiNdN.css	{Flour,Onion}	4
3840	3241	207	Pizza Texas	3.00	http://csluoao.org/gGECaGV.css	{"Japanese tamago"}	3
3828	2396	207	Pizza	5.89	https://xhnjxwo.top/EmYQDqv.js	{Cucumber,"Cheese cheddar",Salmon,Milk,Pasta}	5
3853	6319	207	Crispy Chicken burger	4.80	http://joyqndl.info/gBmMLjd.html	{Flour}	2
3817	3312	206	Pizza Italiano	5.14	https://qsedumr.top/yqhQCeB	{Corn,Salmon,Tomatoes,"Japanese tamago",Mushrooms,"Cream cheese"}	2
3854	5283	207	Pizza Ocean	5.74	http://nxcviuf.top/rlcNrdw.js	{Salmon,Flour,Basil,"Caramelized onions"}	4
3856	932	207	Original burger	5.48	http://kqsrwxq.edu/HhBVtML.css	{Pasta,Flour}	1
3858	7767	208	Chicken Pot Pie	4.72	https://vkgjphd.edu/byOpJLm.css	{Onion}	5
3821	550	206	Swedish Meatballs	6.73	https://deapbiz.ru/QDaaSOU.jpg	{Meat,Pasta}	2
3822	845	206	Angel Food Cake	3.39	http://dnwmset.com/tAHTBQi.css	{Potatoes,Rice,Sugar}	4
3859	6883	208	Crispy Chicken burger	5.91	https://nehutnj.org/DJYANfk.js	{Salmon,Corn,Peanuts,Butter}	2
3796	902	206	Sweet Potato Pie	7.01	https://ohrfdtx.org/rWmyCGY.php	{Peanuts,Salmon,Pineapple,Meat}	3
3794	9688	206	Swedish Meatballs	3.78	https://qejhtgh.ru/rwUysQh.html	{"Chili Pepper",Peas}	5
3795	8909	206	Bean Green Chili Burritos	6.42	https://cneabge.net/veyLJSV.php	{"Cheese cheddar",Potatoes,Mayo,"Unagi sauce",Mozarella}	4
3829	5690	207	Saint Frank Coffee	4.87	https://ewevyfx.com/fIejYPF.webp	{"Cheese cheddar",Bacon}	2
3797	2925	206	Peanut Butter	5.36	http://nctfaiu.net/tWEhrBw.svg	{"Japanese tamago","Bavarian sausages",Pasta,Basil,Cucumber,Salmon}	5
3798	4052	206	Philadelphia with salmon	3.99	http://njjqupc.info/DprBEib.svg	{Mozarella,Basil,Mozarella,Nori,Nori,Meat}	2
3799	6603	206	Tortellini Bowls	3.83	http://fjqfcdt.org/tCicnkQ.jpg	{Sugar,Mushrooms,Mushrooms}	3
3800	408	206	Unagi Philadelphia	7.18	https://dtipgrs.ru/TAlbHqY.jpg	{"Original sauce"}	5
3838	9204	207	Saint Frank Coffee	2.38	http://rxwtfav.ru/kYVNJDK.svg	{"Onion rings",Onion,Salmon,Butter,Carrots,Mushrooms}	3
3803	8880	206	Saint Frank Coffee	5.45	https://xbppadh.net/gPQbYHN.css	{Mayo}	3
3814	1395	206	Wallmart	4.78	https://rrupknx.top/rLxYfKY.jpg	{Carrots,Pineapple}	5
3819	1650	206	Original burger	3.61	https://llijmfk.org/khNnCfL.jpg	{"Japanese tamago",Flour,Nori,Salmon}	2
3839	8505	207	Pizza Florida	3.96	https://www.ymvileh.com/	{Grapes,Rice}	4
3852	4930	207	Pizza Ocean	3.99	http://klkiwgj.info/LMKidsl.html	{Cheese,Garlic}	1
3818	5305	206	Sweet Potato Pie	4.49	http://gxyorbd.ru/	{Pasta,"Chili Pepper",Onion,Peanuts,Milk,Pasta}	4
3841	6148	207	Pizza Italiano	6.84	http://hdplsln.net/XmvygLL.jpg	{Carrots,Mushrooms,Strawberry,Grapes,Mayo,Grapes}	2
3857	4885	207	Grape Jelly Sandwich	2.56	http://vfbisud.org/qlOHtRc.php	{Grapes,Potatoes,"BBQ sauce"}	2
3820	4649	206	Himawari	2.31	https://uwvdqmm.org/OmwVHrs.svg	{Peas,Mushrooms,Chicken,Mozarella,Tomatoes,Potatoes}	4
3825	8141	206	Sweet Potato Pie	2.31	https://tkkpmob.net/	{"Original sauce"}	4
3823	5767	206	Tortellini Bowls	4.26	https://mlhhlar.top/kurKAZN.svg	{Nori,Sugar}	3
3855	7100	207	Bean Green Chili Burritos	2.15	http://www.oozytiv.biz/AGcIbSM	{Basil,Mozarella}	2
3826	6174	207	Swedish Meatballs	6.92	https://www.xhkcpwi.net/buHrHcE	{Chicken}	3
3830	1321	207	Grape Jelly Sandwich	7.63	http://etwjnvd.org/yjhnCdj.js	{Corn,"Bavarian sausages",Rice,Corn,Mozarella}	2
3831	9664	207	Pizza	5.68	http://mlwffhb.edu/nhsetFt.webp	{"Cream cheese","Cream cheese"}	5
3832	9720	207	Pizza Hawaiian	2.34	https://fhtkwjt.ru/bJyPxPK	{Mushrooms,"Cream cheese",Salmon,Tomatoes,Flour,Rice}	4
3833	8228	207	Swedish Meatballs	6.34	https://www.jhszfiw.ru/LNwkRUH	{Peas,"Caramelized onions",Grapes,Salmon,Butter,Cheese}	1
3834	3659	207	Bacon Cheese Burger	7.04	https://mnoeleo.ru/Gfseaxr.jpg	{Carrots,Mushrooms,Carrots,Mushrooms,Mayo,Rice}	1
3835	5121	207	Unagi Philadelphia	5.72	http://omqmpmh.edu/ZJGKouu.jpg	{"Caramelized onions",Carrots,Tomatoes}	3
3836	5498	207	Bean Green Chili Burritos	5.18	https://cxfdwyc.info/DxawfcY.js	{Cucumber,Pasta,Flour,Salmon}	1
3837	9354	207	Grape Jelly Sandwich	7.59	https://ufihfmj.info/rZDqxOU.js	{Butter}	4
3815	774	206	Pizza	4.00	http://www.danqabs.top/bDiQFxL	{Cheese}	1
3842	2324	207	Chicken Pot Pie	5.21	http://lunnqki.ru/FnpKIhI.js	{"Cottage Cheese",Pineapple,Flour,Peanuts,Corn}	2
3802	365	206	Original burger	5.63	https://slmhzxh.com/wGFcvTm	{Nori,Chicken,Cucumber,Meat}	4
3868	8484	208	Pizza	4.69	http://jqaxset.info/pIyutrE.html	{Flour,Peas}	4
3869	3176	208	Pizza Italiano	3.66	https://szhciah.org/OkRqOiE.js	{Bacon,Rice,Peanuts,Mushrooms,"Original sauce",Garlic}	1
3879	3139	208	Pizza Florida	7.19	http://rwtcart.org/QjYOUUI.svg	{Nori,"Cottage Cheese"}	1
3888	732	208	Sweet Potato Pie	3.60	http://antsxbg.com/KMJadSy.webp	{"Bavarian sausages"}	4
3889	2155	208	Chicken Pot Pie	2.72	https://pulhubd.info/vastuak.jpg	{Tomatoes,Mayo,Salmon,"Bavarian sausages",Rice}	5
3893	5307	239	Bacon Cheese Burger	7.16	http://wfsulhn.com/boeqEyf.webp	{Mushrooms,"Original sauce",Nori}	2
3899	4102	239	Philadelphia with salmon	5.94	http://xlqqxgt.ru/ayeMSfl.html	{Strawberry,Bacon,Basil,Peanuts,Flour}	2
3900	1633	239	Saint Frank Coffee	2.17	http://rtbwznj.net/OQNrFlj.js	{Carrots,"Unagi sauce",Mushrooms,"Cottage Cheese"}	1
3901	8764	239	Grape Jelly Sandwich	7.65	http://toicfxf.org/qrSMsbZ.css	{Butter,Corn,Potatoes}	4
3902	3253	239	Tortellini Bowls	4.69	http://vwlnqks.org/dgUPIwZ.jpg	{"BBQ sauce",Nori,"Cream cheese",Potatoes,Pineapple}	2
3904	72	239	Unwrapped Burrito Bowl	7.32	http://rehikvv.info/smXSkjL.js	{Peanuts,"Original sauce",Sugar}	5
3905	1840	239	Pizza Florida	6.19	http://vvktjxw.net/tvKBeEV.webp	{"Chili Pepper"}	5
3863	7789	208	Pizza Hawaiian	6.93	https://www.tbvgldp.info/XVlXFCK	{Milk,Mushrooms,Basil,Cucumber,Cheese}	3
3845	6982	207	Philadelphia with salmon	7.99	https://fwdhllb.ru/LYRFGQA.php	{Nori,Tomatoes,"Onion rings",Peperoni,Corn}	1
3846	5623	207	Himawari	2.77	http://entccww.edu/gpmPiEa.webp	{Salmon}	2
3847	5787	207	Pizza Pepperoni with tomatoes	5.57	http://qfuoocc.ru/wlElxaj.css	{"Original sauce",Grapes,Grapes}	3
3850	6925	207	Wallmart	4.59	https://hfxthly.ru/jCbctXo	{Garlic,"BBQ sauce",Garlic,"Caramelized onions"}	4
3861	7724	208	Bacon Cheese Burger	5.24	http://www.evbpvcf.org/	{Onion,"Cottage Cheese",Bacon,"Chili Pepper"}	1
3862	6613	208	Philadelphia with salmon	4.96	https://liaside.org/KBpASrV.html	{Cucumber,Salmon,"Unagi sauce",Potatoes,Sugar}	1
3864	485	208	Peanut Butter	7.99	http://qbxeamh.info/gVPDTfW.js	{Sugar,Mayo,Carrots,Peas,Nori,Mozarella}	3
3865	8077	208	Pizza Texas	5.35	https://www.ienineb.ru/	{"Bavarian sausages",Strawberry}	4
3866	7354	208	Wallmart	2.48	https://rknsqlh.edu/	{Mushrooms,Nori,"Japanese tamago",Sugar}	1
3867	2143	208	Grape Jelly Sandwich	7.89	http://lfuidjv.ru/KlSGmAt.jpg	{Salmon,Mayo,Pineapple,Corn}	5
3870	6818	208	Pizza Ocean	2.62	http://rhamggn.net/PybCKxI.webp	{"Bavarian sausages",Potatoes}	4
3871	1149	208	Pizza Ocean	5.61	https://vfdrnct.org/pOXsFlK.js	{Chicken,"Japanese tamago",Butter}	1
3872	8393	208	Grape Jelly Sandwich	6.96	https://www.fhmrjxk.top/	{Onion,"Cottage Cheese",Cucumber,"Onion rings",Carrots,Onion}	1
3873	6697	208	Original burger	3.07	http://lplkfxc.info/lDvMIwO	{"BBQ sauce",Grapes,Pasta,Rice,"Cottage Cheese","BBQ sauce"}	4
3874	6902	208	Grape Jelly Sandwich	7.42	https://www.xeulzqm.info/	{Flour}	5
3875	35	208	Pizza Pepperoni with tomatoes	3.32	http://ulqssju.biz/EjqlCAf.jpg	{Chicken}	3
3876	1489	208	Angel Food Cake	2.30	http://www.vxbfupv.info/wvtSCMf	{Peperoni,"Cheese cheddar","BBQ sauce",Meat,"Japanese tamago",Basil}	4
3885	6289	208	Bacon Cheese Burger	6.27	https://ggfklwu.top/VvkdJeo	{Mayo,"Caramelized onions"}	1
3877	9065	208	Saint Frank Coffee	3.14	https://www.ghoyqze.com/	{Strawberry,Pasta,Chicken}	2
3878	132	208	Himawari	2.56	http://lkzerbv.biz/uvLIXfM.webp	{Chicken,Mushrooms,Mozarella,"Cottage Cheese"}	5
3880	6212	208	Pizza Ocean	2.60	https://bxmshdk.ru/ggmDLYj.webp	{Cucumber,Carrots,Strawberry,Strawberry,Meat}	4
3882	4751	208	Chicken Pot Pie	3.77	http://www.quwlzof.biz/	{Butter,Cheese}	3
3883	5122	208	Angel Food Cake	7.59	http://zirlnrl.ru/RMTvkyq.js	{Flour,Cucumber,Corn,"Cheese cheddar",Mayo,Mayo}	3
3884	1967	208	Crispy Chicken burger	2.89	http://ppjxdmv.edu/	{Milk}	2
3886	7329	208	Pizza Texas	7.62	http://ceosfwp.biz/bjKFpTO.svg	{"Cheese cheddar",Cucumber,Basil,"Onion rings",Bacon,Peas}	1
3844	8345	207	Tortellini Bowls	5.94	http://iggwrvu.biz/CQKkFnQ.svg	{Mushrooms,Milk,"Unagi sauce",Peanuts,Onion,Tomatoes}	5
3887	518	208	Original burger	2.16	http://sdioqwx.com/rBOlLLd.html	{Pasta,"Cottage Cheese"}	4
3891	9638	239	Saint Frank Coffee	5.41	http://inpesds.biz/	{Strawberry,Flour,"Cottage Cheese"}	3
3937	6204	239	Tortellini Bowls	3.40	http://ambiaqn.edu/XMhhjZj	{Pineapple,"Original sauce",Potatoes,Mushrooms}	4
3938	2040	239	Chicken Pot Pie	4.78	https://xcdqhby.top/jnIBwIx.css	{Nori}	4
3928	4950	239	Philadelphia with salmon	5.40	https://mqxrqrs.edu/HXBoVvt.jpg	{Rice,Peanuts}	2
3951	2842	239	Unagi Philadelphia	5.91	https://hjjscco.top/IOjwxhZ.svg	{Peperoni,"Cottage Cheese",Peperoni,Flour}	4
3942	7096	239	Pizza Pepperoni with tomatoes	6.61	http://feianmz.com/xZaiTWY.html	{Butter,Grapes,"Japanese tamago","Onion rings",Peperoni}	3
3940	6816	239	Pizza	2.62	https://kwbcbti.top/CiHlFDx.js	{Corn,Nori,Peas}	2
3994	124	240	Philadelphia with salmon	4.63	http://www.kxphqco.top/hlCSKQa	{Mozarella,"Bavarian sausages",Chicken,"Bavarian sausages",Tomatoes}	4
3992	7716	240	Unagi Philadelphia	4.17	http://tzmgngs.ru/tKjjwSm.php	{"Cottage Cheese","BBQ sauce"}	1
3950	5404	239	New York Style Cheesecake	4.60	https://plbbueb.org/yUEJydM.svg	{"Cream cheese"}	5
3993	3781	240	Grape Jelly Sandwich	7.84	http://zhdfpsh.info/	{Pineapple,Peas,Nori,"BBQ sauce"}	3
3952	7793	239	Unwrapped Burrito Bowl	2.09	https://ctkkixr.top/UuxyDko.svg	{"Unagi sauce",Sugar,"Cheese cheddar",Butter,Pasta,Flour}	1
3907	5382	239	Pizza Hawaiian	2.04	http://dktjrzh.ru/aBvPSvm.css	{"Original sauce",Garlic,"Caramelized onions",Chicken,Cheese,Flour}	1
3911	4591	239	Bacon Cheese Burger	5.14	http://zqgxyou.biz/vqhEWQr.webp	{Potatoes,Onion}	1
3909	6153	239	Pizza	6.30	https://axbtmkm.top/hvjcgVM.webp	{"BBQ sauce",Basil,Onion}	1
3913	7687	239	Pizza Italiano	7.71	http://www.thtynqd.biz/wnMArgk	{Strawberry,Basil,Garlic}	1
3912	5988	239	Tortellini Bowls	6.36	http://rknxxvp.edu/xKvinFl	{Onion,Chicken,Bacon,"Original sauce",Meat}	3
3908	4233	239	Pizza Pepperoni with tomatoes	2.10	http://cxdpryc.edu/dblmOMC.js	{Nori}	2
3917	7646	239	Unwrapped Burrito Bowl	7.74	http://www.hzoofuq.org/gcBGOKL	{"Cream cheese",Mushrooms}	1
3910	3283	239	Grape Jelly Sandwich	6.42	https://sksrggv.ru/DxQZtix	{Onion,"Unagi sauce",Butter,Mushrooms,Peas}	5
3914	5750	239	Pizza Ocean	4.39	https://hkyifzp.biz/MnkLDYH.svg	{Peas,Potatoes}	2
3916	2604	239	Saint Frank Coffee	4.00	https://xiofxsd.top/CgidKFA	{Basil,Bacon,Strawberry}	4
3922	4525	239	Peanut Butter	5.84	https://xuzuryg.ru/fniisTd.jpg	{"Caramelized onions",Tomatoes,Sugar}	5
3918	2600	239	Pizza Texas	7.22	http://lgnzsrk.net/axalbpo.svg	{Milk}	4
3919	5904	239	Saint Frank Coffee	2.59	http://brydmua.edu/GeHiSUI.html	{Flour,Cheese,"Unagi sauce"}	5
3920	2287	239	Swedish Meatballs	7.37	https://ixdqghx.info/	{Mozarella,Flour,Flour}	1
3915	912	239	Pizza Italiano	5.83	http://usddfko.com/TuPcLvO.css	{Cucumber,Rice,Peas,Carrots,"Japanese tamago"}	3
3923	1280	239	Original burger	3.23	https://www.sjjytop.net/	{"Cottage Cheese"}	4
3924	3600	239	Unagi Philadelphia	6.28	https://vxycddq.org/wivDZOV.html	{Garlic}	5
3921	3039	239	Chicken Pot Pie	5.61	http://www.fjoeefc.edu/	{Butter,Basil,Peas,Garlic}	4
3925	1261	239	Tortellini Bowls	6.82	http://ddebyvo.org/CWAUTbf.php	{Rice,"Japanese tamago",Meat,Mozarella,Bacon}	1
3930	187	239	Pizza Florida	6.13	https://bpdwkip.info/ejeMDgP.webp	{Salmon}	4
3926	391	239	Unagi Philadelphia	2.09	http://kcwgvcw.edu/ciWUriX.webp	{Mayo,"Cottage Cheese",Pasta,Mayo}	2
3931	7133	239	Peanut Butter	4.17	http://mgxyteq.org/KvZWsqR.jpg	{Pineapple}	1
3932	9159	239	Bacon Cheese Burger	6.26	http://wqnhejr.edu/fPjSPPB.html	{Bacon}	3
3927	2385	239	Pizza	7.36	https://vmiyeoc.edu/	{Nori,Corn,Peanuts}	5
3933	2801	239	Bacon Cheese Burger	3.08	https://ckzfilm.net/VtMVLft.php	{Salmon,Mushrooms,Rice}	4
3934	8640	239	Original burger	2.55	http://www.ujuwkpj.net/MtXjhpQ	{Meat,Garlic,Flour,Cucumber,"Onion rings"}	4
3935	2005	239	Angel Food Cake	3.34	https://tdutmoi.top/	{Cucumber,Onion,"Cream cheese"}	1
3943	7650	239	Tortellini Bowls	4.56	https://xehqhda.top/yZXoIqi.php	{Cucumber,Meat}	1
3941	3657	239	Bean Green Chili Burritos	3.66	http://www.wafxxpv.biz/JVimVaB	{Strawberry,Butter,Milk,"Original sauce",Tomatoes,Carrots}	3
3947	1961	239	New York Style Cheesecake	3.80	http://bweuxfq.edu/LHnraLr.css	{Mushrooms}	4
3945	7251	239	Pizza Pepperoni with tomatoes	2.35	http://kmmwzvm.org/QQvEqFJ	{"Original sauce","Onion rings","Cheese cheddar",Cheese,Mushrooms,"Cheese cheddar"}	4
3949	4344	239	Unwrapped Burrito Bowl	6.53	https://pndkcfn.biz/fkMqbrC	{"Onion rings",Strawberry}	3
3948	907	239	Philadelphia with salmon	5.02	http://hkkhmwd.com/TtKLMuA	{"Bavarian sausages","Caramelized onions",Strawberry}	4
3965	5788	239	Bacon Cheese Burger	2.52	https://ctsakuj.edu/BvRwuAO.jpg	{Flour,Basil,Flour,"Cream cheese",Strawberry}	4
3969	766	239	Bacon Cheese Burger	5.42	https://hywclvt.biz/MjiuEaE.css	{"Caramelized onions",Corn}	2
3976	1301	239	Pizza Hawaiian	7.91	https://bcqjqqc.info/kqJYDkt.webp	{"Original sauce"}	1
3957	1417	239	Pizza Pepperoni with tomatoes	7.20	https://www.ldgfexe.com/AiHRuZZ	{Cheese,Onion}	1
3977	5482	240	Himawari	3.40	http://www.vqjqxpb.ru/GScCZmn	{Salmon,"Onion rings",Strawberry,"Cream cheese","Onion rings","Unagi sauce"}	5
3996	4371	240	Unwrapped Burrito Bowl	7.79	http://www.pbhvffp.top/BdGxvBS	{"Japanese tamago",Rice,Mushrooms,Potatoes,"Unagi sauce"}	1
4041	4356	241	Pizza Hawaiian	6.57	http://eloyiyb.top/pZUgiCY.svg	{Butter,Flour,Onion}	1
3985	670	240	Pizza Florida	5.25	http://umsrbqj.edu/	{Flour,Grapes}	3
3964	1160	239	Peanut Butter	7.53	https://srtbuub.top/PTLWNNm	{Nori,Nori,Peanuts,"Onion rings"}	5
4039	6375	241	New York Style Cheesecake	4.07	https://zsycnsp.top/HMnyJXj.js	{Peanuts,Butter}	2
3990	5165	240	Pizza	5.85	http://pdwiyfd.net/mBMGBUk.webp	{"Cream cheese",Salmon,"Unagi sauce"}	1
3995	1045	240	Chicken Pot Pie	6.57	https://www.njlykuh.com/aneuaGs	{Butter,"Caramelized onions",Meat,Onion,Mushrooms}	2
3968	5322	239	Peanut Butter	6.72	http://qdhkxri.org/PIQwIrs.html	{Salmon,Meat,Nori,Nori}	1
3971	6729	239	Philadelphia with salmon	6.81	https://mtaaafn.org/	{"Bavarian sausages",Carrots,Peperoni,"Caramelized onions"}	3
3967	1263	239	Peanut Butter	5.46	http://jvopemu.net/	{"Cottage Cheese"}	4
3979	7340	240	Bacon Cheese Burger	4.76	http://ykabewp.info/VlUQYLW.html	{Sugar,Meat,Nori}	4
3975	8022	239	Crispy Chicken burger	6.00	http://nspgzei.org/psGmMQv.php	{"Japanese tamago","Original sauce",Tomatoes}	5
3972	5970	239	Unwrapped Burrito Bowl	4.30	https://www.iicmgvl.ru/qgFjxNm	{Butter}	1
3961	7737	239	New York Style Cheesecake	6.58	http://fapwfmh.org/eRRAaEP.svg	{Sugar,Mushrooms,Grapes,"Onion rings"}	3
3970	2356	239	Pizza Hawaiian	5.45	http://vhwtybn.ru/CorTfTW.webp	{Corn,Meat,Mayo,Butter}	2
3954	8570	239	Grape Jelly Sandwich	2.94	http://eqqhgoq.edu/JLwOdAj	{Garlic,"Chili Pepper",Mushrooms,"BBQ sauce",Peanuts}	4
4040	8056	241	Saint Frank Coffee	7.56	https://www.merzanq.top/mlgIakH	{"Japanese tamago",Salmon,"Caramelized onions",Butter,"Bavarian sausages","BBQ sauce"}	1
3981	6143	240	Chicken Pot Pie	3.36	http://eyjfkbh.org/sQuTRxe	{"Bavarian sausages",Mozarella,"Onion rings",Onion,Potatoes}	5
3987	3644	240	Himawari	4.60	http://www.njnabiw.biz/	{Carrots,"Chili Pepper",Strawberry,Peperoni,Peperoni,"Unagi sauce"}	4
3984	4421	240	Chicken Pot Pie	5.89	https://vywarku.edu/SbuDZYs.jpg	{"BBQ sauce","Cream cheese",Basil,Nori,Meat,Meat}	3
3980	8157	240	Crispy Chicken burger	7.70	https://www.csxulyv.com/aaJPRfm	{Flour}	4
3986	8506	240	Wallmart	6.45	https://dgckppo.biz/dmvueDT.jpg	{Cheese,Nori,Salmon,Peas,Butter}	2
3959	8513	239	Pizza Pepperoni with tomatoes	2.80	http://fekwpeg.org/	{Sugar,Mozarella,Potatoes}	1
3983	6799	240	Peanut Butter	5.99	https://etsfolr.info/KSaSdXi.html	{"Caramelized onions",Butter,Tomatoes,Cucumber,Bacon,"Unagi sauce"}	4
3978	6523	240	Angel Food Cake	2.24	https://www.dmknbtu.com/cPOmNwd	{Potatoes,Peanuts,Onion,Grapes,Pasta,Chicken}	2
3962	796	239	Crispy Chicken burger	4.05	http://jrkpddn.com/HVDcWUJ.html	{Mushrooms,Flour,"Japanese tamago",Sugar,Peas,Mozarella}	2
3966	8649	239	Chicken Pot Pie	4.74	http://aajawih.biz/	{Pasta,"Japanese tamago","Bavarian sausages",Flour,Tomatoes}	5
3963	8768	239	Pizza Italiano	5.82	http://nxybnvu.org/ZqWPjuF.webp	{Corn,"Cottage Cheese",Nori,Cucumber,"Onion rings",Cucumber}	1
3989	5769	240	Crispy Chicken burger	5.64	http://www.hhevcjf.ru/RbMiKgd	{Basil,Pasta,Tomatoes}	2
3958	2468	239	Pizza Hawaiian	6.32	http://naaujep.info/HliemZC.css	{Meat,Basil}	1
3955	850	239	Grape Jelly Sandwich	2.34	https://pdfghmk.info/	{Potatoes,"Unagi sauce",Onion,"Unagi sauce"}	5
4042	9496	241	Bean Green Chili Burritos	5.53	http://ofpoqrp.info/IpBNiEl.jpg	{Mushrooms,"Unagi sauce",Basil}	3
3997	9701	240	Original burger	2.49	https://whshbhp.biz/uFejjEv.php	{"Bavarian sausages",Corn,Sugar,Pasta,Meat}	3
3960	1492	239	New York Style Cheesecake	6.69	http://ypoiqgv.org/iJKlxFG.css	{Cucumber}	3
3956	4257	239	Pizza Ocean	7.95	http://www.wgklrhy.top/	{Butter,Rice,Milk,Mushrooms,"Japanese tamago","Cheese cheddar"}	3
3982	6201	240	Pizza Florida	3.99	https://nxuttjl.ru/SscCEol.jpg	{Peperoni,"Chili Pepper",Nori}	2
4026	137	241	Pizza Hawaiian	3.76	http://vuuumnx.net/vtNMsPE.jpg	{Onion,Garlic,Mushrooms}	1
4006	5330	240	Original burger	7.41	http://sjcweqy.com/QnykhWa.js	{Meat,Mayo,Peanuts,Meat}	2
4036	4188	241	Original burger	3.13	https://oosumpj.biz/ccfCbDB.js	{Butter,Potatoes,Bacon}	3
4019	6026	241	Peanut Butter	6.42	https://qrckglb.com/IgqfXoW.js	{Mushrooms,"Unagi sauce",Salmon}	5
4004	667	240	Sweet Potato Pie	5.63	https://oyyrsod.edu/cdKdwZB.html	{"Bavarian sausages"}	5
4008	9247	240	Pizza Ocean	4.44	https://zyasrvg.info/nXrqevj.js	{Peas,Corn,Butter,Mayo,Mushrooms}	1
4020	4582	241	New York Style Cheesecake	2.52	https://wiauaev.org/IDhASTB.svg	{Mushrooms}	4
4032	389	241	Pizza Florida	7.43	http://www.mwqlcfp.biz/	{Tomatoes,"Original sauce",Mushrooms}	1
4033	8785	241	Pizza	3.86	https://itfvbqq.net/SdfTNId	{Nori,Corn,Pineapple,"Cottage Cheese",Grapes}	1
4023	2226	241	Tortellini Bowls	4.44	http://cdyeenp.net/PeHqpMQ.css	{Mayo,"Caramelized onions",Sugar,Grapes}	2
4047	3255	242	Pizza Hawaiian	3.15	https://www.lmophjv.top/AkHhOKa	{Pasta,Salmon,Salmon}	1
4027	1364	241	Chicken Pot Pie	3.21	http://fweycpv.org/HUFGCaq.webp	{Garlic,Butter,"Chili Pepper"}	1
4088	8397	242	Grape Jelly Sandwich	6.29	https://www.qoaneqc.ru/	{Sugar,Potatoes,"Unagi sauce","Cheese cheddar",Rice}	4
4018	3410	241	Pizza Texas	2.72	http://jjcsbwd.info/TsDxwYq.svg	{Butter,Nori,Pineapple,Nori,Strawberry,Cucumber}	4
4031	2666	241	Unagi Philadelphia	6.64	https://www.tyyfsly.biz/	{"Cheese cheddar",Pasta}	4
4013	7487	240	Pizza Italiano	5.48	http://cedkamv.net/EtXkMmK.jpg	{Mayo,Mayo}	1
4044	376	241	Pizza Texas	5.42	https://www.paqiiwv.com/JykOUlA	{Cucumber,Onion}	2
4024	5656	241	Bacon Cheese Burger	6.95	https://jfrctbl.top/	{Sugar,"Cheese cheddar","Original sauce"}	4
4016	3897	241	Unwrapped Burrito Bowl	2.41	http://ltnkbnv.biz/CywxYwA.php	{Tomatoes,Pasta}	4
4002	9777	240	Peanut Butter	7.70	http://cnnlvpk.ru/JbDbvIu.js	{Onion,Chicken,Peanuts,Tomatoes,"Onion rings"}	2
4087	2733	242	Pizza Texas	7.83	https://stgvxek.com/	{Mushrooms,Butter,Flour,"Japanese tamago"}	2
4000	3457	240	Tortellini Bowls	2.93	http://kicrvjx.info/rLDNXoU.webp	{Basil,"Bavarian sausages",Flour,"Cream cheese"}	5
4045	2561	241	Grape Jelly Sandwich	3.59	https://lzpyroq.com/cFqeBPU.webp	{Flour}	2
4048	6359	242	New York Style Cheesecake	3.45	https://qbwesip.info/WZBxkkY.js	{Flour,Mozarella,Chicken,"BBQ sauce",Salmon}	3
4007	5197	240	Pizza Hawaiian	4.90	http://tolculu.ru/	{Mayo,Corn}	4
4089	5503	242	Pizza Italiano	4.61	https://palgvyn.info/pqcQBQi.php	{"Unagi sauce"}	1
4010	1904	240	Angel Food Cake	7.30	http://fidvhpi.edu/nAkLCLQ.html	{Mushrooms,Salmon,Butter,Peanuts,"Bavarian sausages"}	4
4021	5947	241	Pizza Italiano	6.48	http://kavnvdm.ru/eFbkVsZ.css	{Pasta,Cucumber,Nori,Flour}	2
4012	2209	240	Unwrapped Burrito Bowl	7.38	https://nsdbris.ru/bSnaJJp.jpg	{"Chili Pepper",Chicken,"BBQ sauce","BBQ sauce",Bacon}	5
4030	7110	241	Unwrapped Burrito Bowl	3.07	http://ghoiltc.net/YwYOpEr.svg	{Basil,Carrots,"BBQ sauce"}	3
4034	2075	241	Pizza Hawaiian	3.51	http://lnvkhlh.top/TfeMrFX.svg	{"Cream cheese"}	4
4009	6843	240	Pizza Ocean	5.04	https://www.czrscml.biz/	{Salmon,Flour}	5
4001	2087	240	Pizza Texas	7.76	https://www.pwknnwk.biz/	{Milk,"Cheese cheddar",Rice}	2
4043	7054	241	Grape Jelly Sandwich	5.98	https://ksjfayk.top/HDSHHRr.php	{Grapes,"Onion rings"}	4
4025	2510	241	Tortellini Bowls	7.89	https://dwkptcc.info/CRhEEOx	{Mozarella,Mushrooms,Bacon,"Unagi sauce"}	3
4085	1138	242	Saint Frank Coffee	7.83	https://kuyflmc.edu/RRKKCLx.php	{Mushrooms,"Chili Pepper"}	1
4086	3522	242	Swedish Meatballs	2.13	http://www.ikjihpm.top/KcFhgIO	{Milk,Flour,"Japanese tamago"}	4
4014	6256	240	Tortellini Bowls	3.74	http://hwfjckj.top/LokvlnN.webp	{Onion,"Bavarian sausages",Tomatoes,"Japanese tamago"}	4
4091	6091	242	Unwrapped Burrito Bowl	4.49	http://vqljeow.org/tifoSWJ.js	{Basil,"Original sauce",Potatoes}	1
4028	8545	241	Wallmart	4.20	https://scgtejo.top/YQhYgRJ.html	{Mushrooms}	2
4003	3610	240	Pizza Ocean	7.51	https://iryallf.biz/jpeRdwQ.webp	{Corn,Nori,"Original sauce","Unagi sauce"}	1
4090	3309	242	Original burger	2.43	http://www.ctjcdww.ru/gFMEZdI	{Corn,"Unagi sauce",Peanuts,Salmon}	4
4011	4462	240	Swedish Meatballs	8.00	https://www.hytnbcx.edu/	{Garlic}	5
4005	4242	240	Angel Food Cake	4.72	https://mbvmhac.net/UukRUpW	{Onion,Rice,Mayo,"Caramelized onions"}	1
4132	2940	243	Pizza Italiano	6.71	http://cwkssxy.edu/PKavpxA	{Basil,Flour,Flour,"Bavarian sausages",Grapes,Peanuts}	5
4133	1490	243	Philadelphia with salmon	2.19	https://dfaigxm.edu/THgFmGp.html	{"Unagi sauce"}	3
4134	7971	243	Unwrapped Burrito Bowl	7.96	https://ualxgml.org/	{Flour,Pasta,"Japanese tamago",Mozarella,"BBQ sauce"}	2
4135	5554	243	Philadelphia with salmon	6.36	http://vjhpciy.net/IFaabQK.php	{Tomatoes,"Cream cheese","Original sauce"}	4
4136	3915	243	Peanut Butter	4.59	http://www.fyoyjjk.top/ZOpjLbC	{Grapes,Sugar,Mushrooms}	2
4137	6938	243	Unagi Philadelphia	3.51	https://vlwwfxw.ru/sNVqMOb.webp	{"Bavarian sausages"}	3
4138	2895	243	Saint Frank Coffee	5.97	http://jjeufwg.org/xLyDOnV.css	{"Original sauce","Unagi sauce",Peperoni}	5
4052	1451	242	Peanut Butter	4.02	https://srudsuq.org/libfmcP.php	{Cheese}	5
4053	1036	242	Chicken Pot Pie	6.02	https://www.cclhkdj.ru/	{Carrots,Flour,Butter,"Chili Pepper",Flour}	2
4062	3042	242	Pizza Italiano	7.91	http://ssiujoh.top/YAWDeTn.php	{Mushrooms,Peas,Sugar,Cheese,"Japanese tamago",Peperoni}	3
4055	220	242	Pizza Hawaiian	4.53	http://hgfmola.net/	{Peas,"Cottage Cheese","Japanese tamago","BBQ sauce"}	1
4056	4551	242	Tortellini Bowls	3.14	https://miwbajd.com/iUrvIxY.svg	{Flour,Meat,"Caramelized onions"}	5
4058	2593	242	Pizza Florida	4.72	http://pqvxapd.info/UcabVhL.webp	{"Bavarian sausages",Peas,Peas,Chicken,"Unagi sauce"}	1
4059	7881	242	Pizza Pepperoni with tomatoes	5.76	http://uydpjxr.org/	{Salmon,Peas,"Unagi sauce",Onion}	2
4060	4425	242	Pizza Texas	3.74	https://acvmuou.info/tLNSEBh.jpg	{Salmon,"Cheese cheddar"}	2
4061	1878	242	Wallmart	7.98	http://noohodu.net/EyTTeeH	{Tomatoes,Cucumber}	3
4063	3041	242	Sweet Potato Pie	7.47	https://cxvwrqw.com/	{"Bavarian sausages",Mushrooms,Garlic,Mozarella,Rice,Peanuts}	1
4054	341	242	Pizza Italiano	3.88	http://dptffao.edu/sTGjbHs.svg	{Garlic,"Cheese cheddar",Mushrooms,"Original sauce"}	1
4064	4053	242	Pizza Italiano	3.34	https://kyerftk.com/qcQiAJe.php	{"Unagi sauce",Cucumber}	1
4065	1262	242	Original burger	5.96	https://dinncqa.net/DLHvJMF.svg	{Pasta,"Onion rings"}	5
4066	916	242	Bacon Cheese Burger	5.03	https://cldanfj.ru/MDbPqCU.css	{"Unagi sauce","Bavarian sausages","Bavarian sausages",Butter,"Chili Pepper"}	3
4067	4575	242	Unwrapped Burrito Bowl	7.22	https://sfrixdb.ru/suLucaa.css	{Pasta,Onion,Tomatoes,Pasta,Peas}	1
4068	1415	242	Saint Frank Coffee	3.72	http://rggysmj.top/FjTLBQU	{Chicken,Bacon,Mozarella,"Chili Pepper"}	4
4076	4271	242	Pizza Ocean	4.64	http://lqgqytu.top/erHYaoa.svg	{Nori,Strawberry,"Caramelized onions","Onion rings",Carrots,"Bavarian sausages"}	2
4070	6120	242	Himawari	5.26	https://wfrthki.top/CIFWPiq.html	{"BBQ sauce",Cheese,"Chili Pepper","Original sauce"}	5
4071	4672	242	New York Style Cheesecake	6.86	https://www.ytetvch.net/xawfWTV	{"Onion rings",Rice,Pineapple,"Chili Pepper"}	2
4072	477	242	Peanut Butter	2.98	http://www.nefikrp.com/QcXywaJ	{"Bavarian sausages",Pineapple,Carrots}	3
4073	8617	242	Saint Frank Coffee	3.88	http://bqruyds.edu/	{"Caramelized onions"}	5
4074	4969	242	Chicken Pot Pie	6.28	https://wuuafcc.edu/jZVhDvr.webp	{Peperoni,Mayo}	4
4075	2701	242	Pizza Ocean	2.26	https://pmdgsfl.ru/csUUmTL	{Grapes,"Caramelized onions",Mushrooms,Pasta}	4
4077	8229	242	Himawari	5.34	http://uobhlsy.top/wfXFyWd.php	{Milk,"Cottage Cheese"}	3
4069	6599	242	Unwrapped Burrito Bowl	3.14	https://nhhpohs.top/oxfBPBx.html	{Sugar,Mozarella,"Caramelized onions","BBQ sauce"}	1
4078	1379	242	Pizza Hawaiian	7.11	https://www.anaibni.ru/	{"Cottage Cheese",Peas,Mushrooms,"Unagi sauce"}	2
4079	494	242	Wallmart	4.97	https://slbrijt.net/WFMmRbj.js	{Sugar,Peanuts,Mushrooms,Potatoes,"Unagi sauce",Pineapple}	1
4080	9769	242	Bean Green Chili Burritos	2.10	http://xckwwrv.net/DwAmFnQ.css	{Mushrooms,Basil,Peanuts}	3
4081	4818	242	Sweet Potato Pie	2.26	https://www.nbxmcbg.top/AXUCyet	{Onion}	1
4082	1016	242	Pizza Hawaiian	6.18	http://bqrcwfk.com/tlBOQJU.svg	{Mayo}	4
4083	5607	242	Philadelphia with salmon	5.23	http://jqzhsqa.info/VkVjpDb.html	{"BBQ sauce",Salmon,Pasta}	5
4093	4044	242	Swedish Meatballs	3.08	https://drcihrb.top/	{Salmon}	1
4094	8614	242	Himawari	2.42	https://rfoidzv.info/	{"Cottage Cheese",Cucumber,Mushrooms,Peas,Flour}	1
4095	3800	242	Saint Frank Coffee	2.31	http://xfzfitm.com/utFGLoT.html	{"Caramelized onions","Cream cheese",Peperoni}	4
4096	4848	242	Bacon Cheese Burger	3.02	http://vihcxfl.ru/JbfMqeG.html	{Mayo,"Unagi sauce",Grapes,Tomatoes,Basil,Nori}	2
4097	9239	242	Pizza Ocean	7.87	https://pirkftq.com/xRXAogn.php	{Pineapple,Rice,Cucumber,Peanuts,"Original sauce",Mushrooms}	4
4106	1731	243	Unagi Philadelphia	7.73	https://tspybox.biz/EbBIPhh.css	{Pineapple}	1
4107	7463	243	Grape Jelly Sandwich	4.13	https://rppomba.biz/MpLEdsx.html	{"Cream cheese",Nori}	2
4114	7832	243	Pizza	4.69	http://rbbvstg.edu/EOdrwUY.jpg	{Strawberry,Peas,Corn,"Caramelized onions",Carrots}	4
4121	1809	243	Pizza Hawaiian	4.35	http://qanmjeq.info/CCHrOnR.svg	{Salmon,"Japanese tamago",Basil}	4
4122	7671	243	Himawari	4.23	https://lgfimfx.info/vJkgjgS.js	{Milk,Pasta,Milk,Salmon,Corn}	3
4128	4803	243	Himawari	7.27	https://tcylwra.biz/hxYCete	{Mushrooms}	5
4129	9725	243	Angel Food Cake	2.41	http://uylajxp.ru/YTLLXBu.js	{Milk,Basil,"Caramelized onions"}	1
4183	6182	244	Unagi Philadelphia	5.36	http://kpvlyhq.info/RglJCrR.html	{Garlic,Onion,Mayo,Peas,Garlic,Potatoes}	3
4184	7197	244	Tortellini Bowls	4.87	http://ypsqipx.net/KXVbKqN	{Mushrooms,Mushrooms,Mayo}	5
4115	7846	243	Pizza Hawaiian	6.27	https://mrzxqqd.com/fwTqmPM.jpg	{"Caramelized onions",Sugar}	3
4116	7519	243	Chicken Pot Pie	3.16	https://lgcrdvk.top/QFjAKcr	{Nori,Flour,"Cheese cheddar","Original sauce"}	4
4123	232	243	Unwrapped Burrito Bowl	4.05	http://www.rltdeor.top/	{Onion,"Japanese tamago"}	1
4141	7644	243	Unwrapped Burrito Bowl	7.77	http://cwhmoci.biz/JggACwt.webp	{"Onion rings","Original sauce","Cream cheese"}	2
4124	3046	243	Tortellini Bowls	4.79	http://www.xnwbjez.com/BnIUHIG	{"Caramelized onions"}	4
4125	9015	243	Pizza Italiano	2.73	https://ueayoid.com/tWVWZYY	{Chicken,Pineapple,Milk,"Bavarian sausages"}	2
4201	8421	244	Bean Green Chili Burritos	7.18	http://xaompiy.net/oiwrbvY.php	{Cheese,Nori}	5
4099	604	242	Pizza	2.49	https://www.axdcqlt.info/LJaTeSm	{"Chili Pepper","Cream cheese"}	4
4100	7122	243	Wallmart	5.72	http://ybcmfzv.biz/kjnureI.js	{Grapes,Cucumber,Carrots,"Onion rings"}	4
4101	3579	243	Pizza Ocean	2.22	http://pkebsdt.biz/VSSsrGY.jpg	{"Original sauce","Cheese cheddar",Bacon}	3
4108	8996	243	New York Style Cheesecake	3.64	https://cnkmjfi.ru/xpfNwGK.js	{"Cream cheese",Basil,Nori,Mushrooms,"Bavarian sausages"}	1
4109	9774	243	Angel Food Cake	6.19	https://cppmmjd.ru/nkPsQmc.jpg	{Garlic}	1
4117	5326	243	Wallmart	6.62	http://cksdjff.biz/JsmGxKt.svg	{Flour,"Original sauce"}	3
4111	6988	243	Pizza Hawaiian	2.66	https://aagajxg.net/pFgvQiL.webp	{"Onion rings",Grapes,"Onion rings",Strawberry}	4
4142	9899	243	Pizza Hawaiian	7.13	https://wfkrimr.net/VMAUpxQ.jpg	{Chicken,"Onion rings",Carrots,Garlic}	3
4143	4008	243	Pizza	4.79	http://gtpgqow.top/sIfLagt.css	{"Cream cheese",Milk}	4
4145	2987	243	Pizza Florida	7.20	http://qewenrt.edu/EcaSgvs.svg	{Bacon,Onion}	5
4104	8020	243	Chicken Pot Pie	2.24	http://www.csqbwdp.org/fYxZgkH	{Pineapple,"BBQ sauce","BBQ sauce",Cheese,Cheese}	2
4118	4738	243	Swedish Meatballs	7.40	https://eqlaiki.info/TAatytU.webp	{Sugar,Bacon,"Original sauce",Pasta}	1
4119	588	243	Saint Frank Coffee	6.01	https://ojxmifi.top/ZbeFtrZ.jpg	{Garlic,Pineapple,Sugar,Cheese}	4
4112	2394	243	Pizza Florida	3.38	http://mbftncr.org/GPJIfCg.svg	{Onion}	2
4126	6727	243	Pizza Florida	6.48	https://www.plvmbpc.org/	{Pineapple}	5
4127	1264	243	Grape Jelly Sandwich	2.65	http://cjtjaot.org/fYsREMD.php	{"Chili Pepper"}	4
4120	3164	243	Peanut Butter	7.89	http://rvsncys.info/OMRbxUC.jpg	{"Japanese tamago",Bacon,Tomatoes,Peanuts,Mushrooms}	5
4105	2157	243	Bean Green Chili Burritos	3.45	http://tgdwupw.org/	{Meat,Onion,Nori,Mayo}	2
4182	5472	244	Pizza Italiano	7.50	https://ruomltl.top/ksMMpnx.jpg	{Meat,Basil,Flour}	1
4113	523	243	Tortellini Bowls	7.42	http://jklciyt.info/LJgNhii.webp	{Onion}	1
4189	4844	244	Original burger	6.77	http://www.ighncdg.edu/	{"Unagi sauce",Cheese,"Cheese cheddar",Strawberry}	1
4190	2762	244	Pizza	2.03	https://uprexsr.ru/RhIJLqJ.css	{Cheese,Meat,"Chili Pepper"}	2
4191	813	244	Saint Frank Coffee	6.46	http://www.hdtthax.edu/hXUKqtm	{Mozarella,"Original sauce"}	1
4193	272	244	Unagi Philadelphia	7.12	https://jpldxwj.edu/	{Corn,"Cottage Cheese",Onion}	4
4194	2378	244	Wallmart	7.04	http://qwcfewx.ru/vunxZio.js	{Tomatoes,Onion,Pasta,Garlic,"Cottage Cheese",Flour}	4
4195	7845	244	Unagi Philadelphia	2.14	http://pmgygbs.com/dsxmedw.js	{"Onion rings","Onion rings",Corn,Corn}	3
4197	251	244	Sweet Potato Pie	7.75	http://fszialg.ru/gHdrMcT	{Bacon,Corn,Cucumber,Strawberry}	4
4198	8599	244	Original burger	5.74	https://jvnkvaj.biz/UWLrhLi.html	{"Caramelized onions",Garlic,Peperoni,Mushrooms}	5
4200	6621	244	Unwrapped Burrito Bowl	5.03	http://hujmgxx.org/KkChijm.html	{Cheese,Onion,Flour,Chicken,"Bavarian sausages"}	5
4224	7353	244	Pizza Hawaiian	5.59	http://rlgjuki.info/	{Cheese,Garlic,Mozarella,Mayo,Mayo}	2
4225	9675	244	Pizza Pepperoni with tomatoes	3.82	https://tvaeygz.ru/GVTEduX.svg	{Pasta,Mushrooms,Potatoes,Peperoni}	2
4226	3257	244	Grape Jelly Sandwich	6.15	https://www.upztgbn.top/	{Sugar,"Cream cheese"}	1
4227	6071	244	Swedish Meatballs	7.01	http://pqliwph.org/nfUgids.css	{Cucumber,Onion}	2
4228	7176	244	Pizza Florida	3.00	https://acablsi.edu/DIFhPDk	{Milk,"Unagi sauce",Cheese,"BBQ sauce",Mushrooms,"Cheese cheddar"}	3
4229	4256	244	Pizza Pepperoni with tomatoes	3.09	https://kjkwvjx.net/dIxsBJS.jpg	{Grapes}	4
4230	7722	244	Pizza Ocean	5.43	http://kwssmxq.com/pAHNCra.svg	{Flour,Potatoes,"Cheese cheddar",Peas}	5
4153	6868	243	Pizza Texas	5.17	https://rwkktwm.ru/	{"BBQ sauce",Cucumber}	2
4154	5248	243	Grape Jelly Sandwich	2.19	http://vddftjt.edu/VaPkPDv.html	{Flour,Milk}	4
4186	6235	244	Original burger	5.94	http://www.ywffnmj.edu/XVFkqmV	{Mushrooms,Garlic}	1
4187	3149	244	Crispy Chicken burger	3.68	http://vskijoz.info/yxPmaNN.css	{"Onion rings",Peas,Garlic,Rice,"BBQ sauce"}	1
4252	4079	244	Saint Frank Coffee	8.00	http://arfrjbr.org/eZsHthp.html	{Pasta,Cheese,Peperoni}	1
4214	4747	244	New York Style Cheesecake	6.02	https://lxfxksk.top/JgZWBQp.webp	{Corn,Mushrooms,"BBQ sauce",Salmon,Cheese}	1
4218	7079	244	Chicken Pot Pie	2.10	https://ghntfhb.edu/vWlxlwN.html	{Grapes}	5
4206	1449	244	Peanut Butter	6.90	https://rsltxjo.com/WHhWlwy.html	{"Unagi sauce",Peas,Cucumber,Butter,Mushrooms}	2
4275	5718	247	Original burger	3.17	http://tiezyqm.info/BtAeoAV	{Carrots,Bacon,"BBQ sauce"}	3
4273	2509	247	Swedish Meatballs	7.10	https://tlansen.top/	{Mushrooms,"Unagi sauce",Milk}	5
4276	100	247	Angel Food Cake	7.54	http://kaeecbj.top/	{Cheese,Mayo}	5
4209	9455	244	Himawari	3.70	http://cwkqmuc.com/JJHFGbW.php	{Butter,Peperoni}	3
4203	2789	244	Chicken Pot Pie	6.82	http://www.lyyazkv.edu/MrMIxKc	{Peanuts}	4
4205	900	244	Philadelphia with salmon	3.09	https://naijfwm.net/YxyXFpj.webp	{"Bavarian sausages","BBQ sauce","BBQ sauce",Cucumber}	1
4213	874	244	Original burger	6.59	http://bcporsp.com/mXtlRhH.svg	{Sugar,Potatoes,Onion,Butter}	2
4250	1119	244	Chicken Pot Pie	5.77	https://cawsyee.top/IiOhPLM.jpg	{Butter}	4
4208	6802	244	Pizza Hawaiian	4.49	https://elitsjr.com/jkQGWWX.js	{"Japanese tamago","Unagi sauce",Tomatoes}	4
4212	832	244	Wallmart	2.88	https://kfmeyvx.net/rnMdVIc.js	{Peanuts,"Caramelized onions",Mayo,Peanuts,Butter,Pasta}	2
4217	6189	244	Crispy Chicken burger	6.12	http://www.fgmybyj.org/JGVgYSO	{Butter,Onion,"Cheese cheddar"}	3
4219	3654	244	Tortellini Bowls	4.48	https://fqmqwwm.info/fiupQEu.php	{"Onion rings","Original sauce",Peas,Garlic,Mayo,Potatoes}	3
4248	9677	244	Pizza Italiano	7.96	https://omizknm.org/tomxTls.html	{Peanuts,Peas,Mushrooms,"Chili Pepper",Nori,Potatoes}	1
4220	2256	244	Unagi Philadelphia	3.29	http://nlpkthv.ru/BYvmtwY.html	{"Bavarian sausages"}	4
4222	7378	244	Unagi Philadelphia	7.46	http://vogxmao.info/mttFXGC.webp	{Carrots,"BBQ sauce"}	3
4243	4763	244	Tortellini Bowls	6.41	https://jxquecj.top/nGivUop.html	{"Cheese cheddar",Cucumber,"BBQ sauce","Cottage Cheese",Strawberry}	5
4247	614	244	Pizza Italiano	2.95	http://euecjom.org/aJkQbUb.webp	{Mozarella,Tomatoes,Mayo,"Cottage Cheese","Caramelized onions",Meat}	1
4221	3175	244	Chicken Pot Pie	2.21	https://wqesgrv.ru/PyQyeet.js	{Strawberry,Sugar,Garlic,Potatoes}	2
4233	2140	244	Crispy Chicken burger	3.05	https://fkhiegt.org/EcUXqtC	{"Bavarian sausages","Caramelized onions"}	3
4232	1661	244	Unwrapped Burrito Bowl	3.55	http://yokdrqq.ru/oPjCVbj.webp	{"Original sauce",Pineapple,Rice,Potatoes,Peperoni}	3
4207	5495	244	Saint Frank Coffee	5.25	https://teflfmc.org/NoiFmyX.js	{Peperoni,Mozarella,"BBQ sauce",Milk,Mayo,Grapes}	5
4234	6730	244	Pizza Florida	2.31	https://ksafbiw.top/bpVgoog.php	{"Japanese tamago"}	2
4236	853	244	Crispy Chicken burger	4.37	http://srumwzp.info/fOLUFAT.svg	{"Chili Pepper"}	5
4272	9724	246	Peanut Butter	6.18	https://xbiwvby.org/	{Garlic,"Cheese cheddar",Meat,"Unagi sauce",Tomatoes}	3
4242	7966	244	Pizza Hawaiian	7.68	https://hkkiqxl.top/FhANeeD	{Cucumber,Meat,Peas,"BBQ sauce",Mayo,Flour}	5
4237	1253	244	Sweet Potato Pie	6.36	http://woxxdkw.info/JxYsWVD.svg	{Pasta,Corn,Nori}	3
4215	576	244	Wallmart	7.86	https://svcdamq.top/xBaKUiP	{Meat,Grapes}	3
4271	2699	246	Pizza Hawaiian	4.61	http://svcaikn.com/jEhiRAs.webp	{Cucumber,Mushrooms,Chicken,Grapes,Mushrooms,Garlic}	3
4216	2072	244	Original burger	4.51	https://mgvcdkc.info/qKOoEhZ.css	{Mushrooms,"Onion rings"}	1
4251	5045	244	Pizza Hawaiian	3.71	https://phiwxry.top/NAYHwMT.jpg	{"Original sauce",Flour,Garlic,Cheese,Mayo,Mozarella}	3
4238	9429	244	Chicken Pot Pie	3.32	https://www.xdbakgh.biz/	{Peas,Cucumber,Flour}	5
4239	5501	244	Saint Frank Coffee	7.22	https://yeeowhb.ru/lUSWBxn	{Cheese,Milk,"Onion rings","Japanese tamago"}	5
4249	4419	244	Crispy Chicken burger	5.53	https://www.qruaqdn.ru/xCuOHrK	{Salmon,Pineapple,Carrots,Peas,Mushrooms,Pineapple}	4
4204	526	244	Saint Frank Coffee	4.13	http://smtbpiv.net/VgceHce.svg	{"Cheese cheddar",Meat}	3
4241	4182	244	Angel Food Cake	2.33	http://ejfetyx.biz/rNLyjUV	{"Cheese cheddar",Milk,Peperoni,Nori,Onion,Pasta}	2
4274	1411	247	Pizza Italiano	3.33	https://rtlyuji.org/IRFbqtU.js	{Salmon,Cucumber,Carrots}	3
4244	7510	244	Pizza Hawaiian	6.18	https://ooigxkx.biz/DwYECsQ.php	{Flour}	5
4245	3408	244	Saint Frank Coffee	7.41	https://zkwzlva.edu/qRkpYNZ.svg	{"Japanese tamago",Meat,Potatoes}	1
4240	6151	244	Swedish Meatballs	2.07	http://eeepvea.edu/ANuwcvu.css	{"Caramelized onions",Mushrooms,Pasta,"Cream cheese",Basil}	2
4295	6152	247	Pizza Florida	4.37	http://bqwxudm.ru/VoITXnI	{Grapes,Carrots,Flour,Sugar,"Japanese tamago",Tomatoes}	4
4305	5401	247	Peanut Butter	4.19	https://nonwqje.ru/dIrMaNo.js	{Bacon,Onion,Peanuts,Strawberry,"Japanese tamago",Basil}	5
4292	5436	247	Pizza Texas	6.53	https://www.owiadvu.ru/mBVKdQo	{Mozarella,Mayo,Mushrooms}	2
4319	4872	248	Sweet Potato Pie	7.63	http://jbkadvk.biz/	{Pineapple,Butter,Grapes,"Chili Pepper","Caramelized onions"}	5
4321	266	248	Angel Food Cake	2.41	http://uawtlvk.top/TidxJnO	{Tomatoes}	4
4304	2302	247	Angel Food Cake	4.97	http://ryijtfz.net/MSPhcsU.svg	{Grapes,Strawberry,Strawberry}	2
4257	3280	246	Tortellini Bowls	2.74	https://xyyncng.top/FudEZCK.svg	{Corn}	2
4258	6878	246	Pizza Florida	7.61	http://wmnotlt.top/OESuAPc.webp	{Rice,"Caramelized onions",Corn,Milk}	4
4260	3562	246	Swedish Meatballs	6.63	https://oonckii.top/TgQfCcP.php	{"Original sauce",Pasta,Grapes,Mushrooms,"Caramelized onions"}	3
4320	7741	248	Angel Food Cake	6.26	http://www.xtutunh.info/UiTtfJu	{Cucumber,Cheese,Peanuts,"Cream cheese"}	1
4261	967	246	Himawari	2.23	http://awcdool.biz/NGTWorc.js	{Strawberry,Peas,Basil}	3
4266	7891	246	Himawari	3.32	http://vosgxxh.top/uvMkLJS.js	{Flour,"Caramelized onions"}	5
4263	8711	246	Swedish Meatballs	6.81	https://hdosovs.org/	{Carrots,Mushrooms,Mushrooms,Mushrooms}	2
4264	3511	246	Pizza Ocean	5.98	http://www.pchlukl.com/	{Onion,Carrots,Cheese,"Chili Pepper"}	2
4286	6974	247	Tortellini Bowls	2.11	http://rxomntb.biz/xjRctnL	{Mayo,Corn}	5
4265	4232	246	Saint Frank Coffee	4.81	http://fnnhnts.org/tLjBnMF.jpg	{Pineapple,Flour}	2
4267	449	246	Pizza	5.59	http://lytyloo.ru/OoExedY.svg	{Milk,Mayo,"Cream cheese","Cottage Cheese","Cottage Cheese","Caramelized onions"}	1
4281	4654	247	Pizza Ocean	2.77	http://jrxptvr.com/mwMpxNa	{Peas,Sugar,Bacon,"Original sauce"}	5
4262	6653	246	Pizza Ocean	3.21	https://dduyquf.org/YWCoUTr.css	{Flour,Pasta,"Cottage Cheese"}	3
4278	9067	247	Angel Food Cake	3.89	http://lcsuwlf.biz/xiUyKmj.html	{Strawberry,Mushrooms}	4
4279	1736	247	Chicken Pot Pie	2.27	https://www.mevtpql.top/hKYWLZb	{"Unagi sauce","Onion rings",Salmon}	3
4285	6703	247	Bacon Cheese Burger	3.76	https://wrprirp.net/	{Tomatoes,Milk,Salmon,Mayo}	1
4282	4131	247	Angel Food Cake	6.15	http://kiktkxa.edu/PSPZaNI.svg	{Butter,Peperoni,"Onion rings",Peperoni}	5
4284	3225	247	Bean Green Chili Burritos	6.21	https://ckhwnew.biz/SvRDgmD.webp	{"Unagi sauce"}	4
4268	2812	246	Unagi Philadelphia	6.60	http://bcyzeew.net/npIHgku.jpg	{Peanuts,Rice}	3
4298	7432	247	Philadelphia with salmon	5.79	http://xhjrkix.info/qMSXyED.css	{Pasta,"Caramelized onions"}	4
4301	229	247	New York Style Cheesecake	3.26	https://uvbnuvu.biz/ToqoZSy.css	{Bacon,"Original sauce","Onion rings","Chili Pepper"}	1
4293	5362	247	Pizza Hawaiian	6.38	http://qjcsqsp.edu/	{Cucumber,"Japanese tamago",Potatoes,Potatoes,"Japanese tamago"}	4
4287	5737	247	Pizza Florida	7.00	https://eezkous.net/SagLluY.svg	{Cheese,"Caramelized onions",Salmon,Milk,Basil,Flour}	1
4289	6485	247	Himawari	4.73	http://www.adqnlmh.top/IeZscog	{Tomatoes,Peperoni,"BBQ sauce",Mushrooms,Chicken,"Japanese tamago"}	3
4291	6306	247	Peanut Butter	4.90	http://klrrncr.info/XjNpISN.svg	{Cucumber,"Onion rings",Rice}	5
4294	6441	247	Original burger	5.77	https://moikgst.ru/hyxyQRe.webp	{Pineapple,"Caramelized onions","Cottage Cheese",Corn}	3
4296	6826	247	Pizza Hawaiian	7.69	http://www.koakpdy.top/QINTQCV	{Salmon}	5
4288	9528	247	Grape Jelly Sandwich	7.90	https://urddvoz.info/OgPAMQj.php	{Salmon,Flour,Carrots,"Chili Pepper","Original sauce"}	1
4259	875	246	Sweet Potato Pie	5.40	http://zmpqcor.net/RhlLsle	{Butter}	1
4297	3935	247	Chicken Pot Pie	6.79	http://unaoanq.edu/PqAEURD.js	{"Unagi sauce",Cucumber,Pasta}	1
4283	7245	247	Himawari	3.34	http://vltbpgt.ru/rLMpccG.jpg	{Basil,Peas,"Japanese tamago"}	2
4299	1371	247	Wallmart	2.42	http://nxaobzp.com/DBGbjRh.webp	{Grapes,Cucumber}	1
4280	7157	247	Pizza Florida	6.44	https://qiucokh.biz/rgqACeR.webp	{Rice,Flour,Nori,Garlic,Mushrooms}	4
4302	6275	247	Pizza Italiano	4.95	https://www.xodfsjq.net/	{"Unagi sauce",Bacon,Peperoni}	3
4303	4865	247	Pizza Florida	2.53	http://gicbeai.biz/SgsTVuu.svg	{Sugar,Onion,Meat,"Cheese cheddar","Caramelized onions",Chicken}	1
4317	9746	248	Sweet Potato Pie	3.54	http://nlikjob.ru/WVDVCnK.svg	{Carrots,"Cream cheese",Carrots,Milk}	5
4318	2590	248	Pizza Pepperoni with tomatoes	5.91	https://yygjpwq.ru/mgpryot.webp	{Meat,Meat,Strawberry,"Unagi sauce",Butter}	2
4355	935	249	Pizza	6.99	http://www.fjdgrsy.top/ZnulHwh	{Mayo,"Caramelized onions",Corn,Bacon,"Cottage Cheese"}	3
4323	177	248	Sweet Potato Pie	3.07	https://hwijoka.top/RWRHWmu.jpg	{"BBQ sauce"}	1
4327	9944	248	Himawari	6.78	https://zmglmpk.top/iCWJaCZ	{Meat,Mushrooms,Meat}	4
4328	7743	248	Pizza Florida	7.73	https://www.dbslbtw.org/oGswZIR	{"Japanese tamago"}	1
4367	5035	249	Crispy Chicken burger	4.49	https://nehnzlg.biz/fHdHlHV.css	{Onion,Strawberry}	4
4329	7143	248	Saint Frank Coffee	3.60	http://www.symlnad.top/	{"BBQ sauce",Nori}	2
4365	6543	249	Swedish Meatballs	5.99	https://www.xdhnehi.info/pxUgegs	{Bacon,"Cheese cheddar",Potatoes,"BBQ sauce"}	5
4340	6737	249	New York Style Cheesecake	2.95	https://oilclql.ru/PvWRXtX.css	{Bacon}	4
4405	6731	249	Pizza Florida	3.84	https://www.pnjhtgj.net/	{Rice,Mozarella}	3
4330	9103	248	Saint Frank Coffee	2.05	https://www.ytaqiye.com/	{Bacon,Onion,Pasta}	1
4331	8481	248	Pizza Florida	4.67	https://sftwswh.ru/vcVFuIK.php	{"BBQ sauce",Pasta,Meat,Garlic,Nori,Cucumber}	5
4346	6258	249	Philadelphia with salmon	2.44	https://rrfzcmo.biz/jLTFkxU.html	{Peas,Mushrooms,Basil,Meat}	4
4309	5018	248	Crispy Chicken burger	6.17	http://nxsulcb.com/	{Potatoes,Butter,Mushrooms}	3
4344	9140	249	Grape Jelly Sandwich	7.69	https://www.fnuicxp.edu/ATCIVUu	{Milk,Peanuts,Mayo,Mushrooms}	3
4335	519	249	Wallmart	2.56	http://cqpawnc.edu/IHZIkOo.js	{Mayo,"Cheese cheddar",Corn,Mushrooms}	4
4310	9647	248	Pizza Pepperoni with tomatoes	3.56	https://upuzcwb.info/qxmjBbV	{Milk,Peas,"Cottage Cheese",Potatoes,Bacon}	4
4354	6257	249	Bean Green Chili Burritos	4.02	http://vjabnni.net/whZAJQl.svg	{Flour,"Onion rings"}	2
4362	9748	249	Wallmart	7.62	http://vogodcj.org/khdkjil.js	{"Japanese tamago","Cottage Cheese"}	5
4353	4411	249	Grape Jelly Sandwich	4.17	https://rfwcvty.ru/CNJesgl.html	{Mayo,"Bavarian sausages"}	2
4324	8466	248	Pizza Pepperoni with tomatoes	5.97	http://eccxqju.org/kClXpHk.html	{Meat}	4
4341	1528	249	New York Style Cheesecake	6.41	https://ecybfii.edu/RMCBlBZ.webp	{Sugar,Salmon}	3
4332	9120	249	Saint Frank Coffee	3.69	http://ypgtffd.com/hllAROB.jpg	{Pineapple,Basil,Milk}	4
4339	9919	249	Himawari	5.61	https://rthhxxz.edu/	{Mushrooms}	3
4368	7466	249	Crispy Chicken burger	3.77	http://vgmfogw.org/bjcQsxw	{Corn,Peperoni,Potatoes,Bacon,Sugar,Nori}	1
4334	1407	249	Bacon Cheese Burger	3.34	https://qpiipsc.info/JxxwVCs	{Mozarella,"Japanese tamago",Mushrooms,"Onion rings",Peperoni}	3
4307	7686	248	Chicken Pot Pie	3.78	https://gzljwcd.top/GHKRDXU	{Peperoni}	2
4308	942	248	Unagi Philadelphia	4.74	https://ostrdiw.info/MLVQqXV.php	{Basil,"Japanese tamago","Caramelized onions"}	1
4336	1725	249	Pizza Florida	3.83	https://enrcauu.info/svtUHUM.css	{Garlic,Tomatoes}	3
4337	4215	249	Crispy Chicken burger	2.71	https://vayjfqx.edu/pgBkVJA.php	{"Cream cheese",Mushrooms}	2
4338	4724	249	Pizza Ocean	5.67	http://llhmqgz.com/PauwGkc	{Flour,Meat,Mayo,"Onion rings"}	5
4311	4336	248	Saint Frank Coffee	4.93	http://xzuxyqa.top/ognfuDg	{Garlic,Strawberry,"Original sauce"}	5
4363	8215	249	Saint Frank Coffee	3.79	http://trfnjny.edu/YcHMqtA.css	{"Cottage Cheese",Peas}	3
4364	6600	249	Pizza Texas	5.09	http://ykurluy.biz/gViSJVn.webp	{"Caramelized onions",Tomatoes,Flour,Grapes,Bacon,Mayo}	2
4366	9139	249	Philadelphia with salmon	7.93	http://xyfwmsu.info/eJIDtOZ.css	{"Original sauce",Salmon,Peanuts}	5
4343	9350	249	Grape Jelly Sandwich	3.07	http://engxfxr.org/htYLLnD.js	{Pasta,"Caramelized onions",Bacon,Mayo}	1
4342	3584	249	Philadelphia with salmon	4.88	http://elvrppx.edu/uOjQxWB.js	{"Cottage Cheese",Corn,Nori,Mozarella}	2
4345	7337	249	Angel Food Cake	3.14	https://qzuhxxd.top/qFkomAA.css	{"Chili Pepper"}	5
4351	2453	249	Pizza Florida	4.65	http://pppiets.org/vDUInst.jpg	{Tomatoes}	5
4333	7328	249	Sweet Potato Pie	2.82	http://tsnbans.org/xBEieAt.svg	{Onion,"Cheese cheddar",Mozarella,Bacon,Cucumber}	1
4352	4753	249	Pizza Florida	4.14	https://bpcfkgw.org/KlLbSPJ	{Butter,Milk,"Bavarian sausages",Corn}	2
4313	4810	248	Unagi Philadelphia	4.72	http://sqquvel.info/	{Mozarella,Peas,Peas,Pineapple,"Caramelized onions"}	2
4312	943	248	Tortellini Bowls	4.15	https://www.tpjlgty.ru/yGFjeiw	{Strawberry,Carrots,"Original sauce"}	4
4412	2709	249	Pizza	6.60	https://hctqnva.org/OVGsNFV	{"Cottage Cheese",Cucumber,Peanuts,Mushrooms,"BBQ sauce",Flour}	4
4413	318	249	New York Style Cheesecake	6.33	http://xrsnfmd.biz/udcFpfp.js	{Carrots,"Chili Pepper",Strawberry,Peanuts,Nori}	3
4397	549	249	Himawari	7.89	https://ikhyxai.edu/WNOpGqY	{Meat,Onion,Milk,Pasta,Mushrooms,Milk}	5
4358	2070	249	Unwrapped Burrito Bowl	7.40	https://doxwsrn.com/GmRWuYV.svg	{"Bavarian sausages",Peas,"Onion rings",Mushrooms,Garlic}	1
4359	1049	249	Grape Jelly Sandwich	3.90	http://htmwlqk.net/bXLnJLk.js	{Flour,Peanuts,Carrots,Milk,Pasta}	1
4369	5409	249	Peanut Butter	2.27	http://humgzip.top/VAPkVsB	{Peas,"Cottage Cheese"}	1
4371	848	249	Sweet Potato Pie	3.56	https://gihqpor.top/bqNTCLl.html	{Strawberry,Basil,Peas,"Chili Pepper",Sugar}	1
4372	6150	249	Unagi Philadelphia	4.64	http://crbubha.org/JkqMiwP.html	{Mushrooms,Pasta,"Cheese cheddar",Corn,Flour,Cucumber}	3
4373	283	249	Pizza Texas	3.10	https://nwrgcva.top/KhXLBQo.jpg	{Rice,Grapes,Peanuts,Grapes,Potatoes}	4
4374	3725	249	Wallmart	5.10	http://www.tuoxkqj.top/fwwVPFB	{Peanuts,Salmon,Milk,"Original sauce",Carrots}	3
4375	8458	249	New York Style Cheesecake	3.04	https://scsttph.net/	{Mushrooms}	2
4376	608	249	Unagi Philadelphia	3.30	https://tuqouew.top/uKmBauJ.js	{Meat,Mushrooms,Peanuts}	3
4377	9412	249	Bacon Cheese Burger	3.70	https://lwamruq.edu/AKQgeyY.php	{Mozarella,"Onion rings",Cucumber,"Cheese cheddar","Unagi sauce","Cottage Cheese"}	3
4378	9650	249	Unwrapped Burrito Bowl	6.29	https://www.mfcmsgk.biz/	{Sugar,Peanuts,Grapes,Butter,"Caramelized onions","Cottage Cheese"}	2
4379	2827	249	Unagi Philadelphia	2.94	https://ybuihuw.com/lGjEfBA.html	{Chicken,Garlic,Mayo}	2
4380	8618	249	Grape Jelly Sandwich	7.33	https://breykws.info/HsmyJZZ.webp	{Strawberry,Flour,Sugar,Meat,"Unagi sauce"}	5
4381	984	249	Himawari	5.11	https://uumutci.top/mbehGAV.html	{Bacon}	2
4382	6094	249	Peanut Butter	3.80	http://www.gwxtebe.org/WwDJPne	{Cucumber,Cheese,Rice,Bacon,Nori}	5
4383	9549	249	Wallmart	2.07	https://thfpgba.edu/HvCwpIP.php	{"Caramelized onions","Caramelized onions",Sugar,Butter}	5
4384	7625	249	Unagi Philadelphia	5.30	http://qtjzfir.net/XnaTCnH.php	{Flour,Mayo}	4
4385	927	249	Grape Jelly Sandwich	3.84	https://zsxldeb.top/aRQqjTL	{Corn,Peanuts,Salmon,Butter,Pasta}	2
4386	7107	249	Philadelphia with salmon	6.52	https://vpvjred.top/CVrbAQS.js	{Chicken,Onion,Mozarella}	2
4387	6586	249	Bacon Cheese Burger	3.42	https://www.ugvrhqy.info/FCHqEJp	{Peanuts,Peanuts,Peperoni}	2
4388	319	249	New York Style Cheesecake	3.16	https://mynsdlz.biz/iAVeUxv.js	{Mozarella,Onion,Flour}	2
4389	6923	249	Himawari	4.20	https://pvbfnwv.top/	{Nori}	5
4390	3371	249	Pizza Florida	6.43	https://kwhsikj.biz/fJLSFNV.html	{"Cottage Cheese"}	5
4392	4161	249	Unagi Philadelphia	7.89	http://cjudxls.info/YAbTHNB.jpg	{Basil,Meat,Meat,Rice,Pasta,Mushrooms}	5
4393	7182	249	Unwrapped Burrito Bowl	2.69	http://gpjcegu.ru/	{Cucumber,Onion,"Cottage Cheese"}	1
4394	4277	249	Pizza Florida	3.16	https://www.slkdyqv.com/xTQqPDZ	{Rice,Milk,Peperoni}	2
4395	4454	249	Bacon Cheese Burger	5.38	http://mtcdlhg.com/raxQUFx.php	{Pasta,Flour}	4
4396	6500	249	Wallmart	2.22	http://bxvvhdl.top/XWDQFfF.webp	{Onion,Mushrooms,Carrots,"Unagi sauce","Bavarian sausages",Mushrooms}	4
4398	3938	249	Peanut Butter	3.83	http://krhsikf.top/YaHpEaL	{Potatoes,Peperoni}	2
4400	4960	249	Unagi Philadelphia	4.93	https://teccyjy.net/itDYryQ.svg	{"Original sauce"}	1
4401	7800	249	Bacon Cheese Burger	7.54	https://llehafd.top/ARhbkyS.php	{"Unagi sauce"}	3
4402	3103	249	Angel Food Cake	2.02	https://oqsrntz.top/apyAJtI.php	{Mushrooms,Bacon,Peperoni,Nori,Meat,Pineapple}	1
4403	9581	249	Saint Frank Coffee	6.21	https://ifbcoxw.org/kuifoDv.jpg	{Flour,Rice,Tomatoes,Mushrooms,Basil}	3
4407	7672	249	Swedish Meatballs	3.36	http://itsodxj.ru/lZnAuMd.php	{Strawberry,Milk,"Original sauce",Mayo}	4
4408	8695	249	Sweet Potato Pie	7.84	http://www.abhjinh.org/CjCbKyf	{"Bavarian sausages",Corn,"Chili Pepper",Tomatoes,Milk,Strawberry}	2
4409	6175	249	Angel Food Cake	6.50	http://qvixkzu.info/IomaHET.css	{Sugar,"BBQ sauce",Pineapple,Pasta}	1
4410	6347	249	Pizza Italiano	2.05	https://pveuysa.top/dyWFKJT.js	{Flour,Onion,Rice,Carrots,Garlic,Cucumber}	3
4411	9929	249	Himawari	2.71	https://pscunec.top/QaYxyEU.svg	{"Japanese tamago",Peanuts,Peanuts,Flour}	1
4357	5642	249	Pizza Florida	3.02	https://www.buhenpu.org/	{Cucumber,Pineapple,Peperoni}	1
4454	9906	252	Saint Frank Coffee	6.23	http://oiefmtg.org/CecjWyv.svg	{Mozarella}	3
4443	7677	252	New York Style Cheesecake	5.40	https://www.xexbtvj.ru/	{"Japanese tamago",Mozarella}	2
4438	9084	252	Himawari	7.85	https://fankusc.ru/	{"Original sauce",Salmon,Flour,Peperoni}	1
4441	1662	252	Pizza Italiano	6.82	https://keapasd.org/tFuUgqH.css	{Mushrooms,Mushrooms}	1
4417	1174	249	Unagi Philadelphia	5.69	http://www.pjeufjb.biz/ZfiAMbe	{"Cottage Cheese","Onion rings"}	5
4426	2549	250	Peanut Butter	7.98	https://wdprrfx.org/yDPwdeD.webp	{Mozarella,Sugar,Cheese}	1
4416	6433	249	Pizza Pepperoni with tomatoes	3.47	https://www.bsronjy.net/PNpVRaX	{Cheese,Meat}	3
4428	7128	251	Bean Green Chili Burritos	3.81	https://lytjwic.edu/nbAsjwf.webp	{Nori,"Bavarian sausages","Caramelized onions",Rice,Flour,Corn}	2
4458	8986	252	New York Style Cheesecake	3.86	http://uekroxj.biz/aAFilEb.js	{Strawberry,"Cheese cheddar",Mushrooms,Chicken}	4
4418	7674	249	Saint Frank Coffee	3.33	https://wgrizrx.top/ljgPGTm.webp	{Corn}	3
4460	7196	252	Chicken Pot Pie	5.31	http://jgtxqcl.edu/vhAxtOG.svg	{"Bavarian sausages",Mayo,"Caramelized onions",Cheese,"Cottage Cheese"}	3
4421	5151	250	Saint Frank Coffee	5.79	https://rwllyms.ru/GWkHWsg.html	{"Caramelized onions","Cottage Cheese",Carrots}	1
4456	248	252	Chicken Pot Pie	6.24	http://www.mnlljkg.ru/uJROTkR	{Peas,Grapes,Mushrooms,Grapes}	3
4459	1567	252	Original burger	5.45	https://tkaypco.edu/	{Tomatoes,Mayo,Peas}	1
4422	8745	250	Unagi Philadelphia	2.35	http://locsugy.org/PIwhlWa.jpg	{Mozarella,Peanuts,Mozarella,Chicken,Tomatoes,Carrots}	1
4439	1464	252	Pizza Florida	2.72	http://gtkzhen.org/	{Bacon,Mayo,Nori,Chicken}	5
4435	6266	251	Original burger	6.29	https://vgcuyhc.edu/ZSjalJX.html	{Butter,Basil,Nori,Meat,Salmon}	3
4434	5177	251	Angel Food Cake	7.15	https://wxdrrxa.top/pPZaJNa.jpg	{Cheese}	5
4424	6364	250	Bacon Cheese Burger	5.00	http://sekljql.com/GbuXLXc.svg	{Strawberry,"Caramelized onions",Mozarella}	5
4427	1964	251	Unagi Philadelphia	5.48	https://nfaybib.ru/jPrJJRX.webp	{Rice}	2
4432	2407	251	Peanut Butter	2.16	https://sshdcgy.net/YfbgjNG.css	{Pasta}	3
4431	7355	251	Unwrapped Burrito Bowl	3.73	https://nbjseel.org/VXCHAps.svg	{Pineapple}	5
4436	507	252	Tortellini Bowls	6.82	http://erqebaq.biz/pSPVgat.css	{Rice}	4
4423	2004	250	Chicken Pot Pie	5.30	https://www.jllmpkd.com/nXNBvwh	{"Cheese cheddar",Onion}	5
4446	1620	252	Swedish Meatballs	4.00	https://utxkcwl.com/JCYdVgF.js	{Salmon,"Japanese tamago","Chili Pepper"}	4
4440	7579	252	Wallmart	3.48	http://wpglvqd.org/	{Tomatoes,Mushrooms,Chicken,Salmon,Pasta,Strawberry}	5
4429	3750	251	Pizza Hawaiian	5.87	https://www.kpdqeop.com/omedbJO	{Corn,"Original sauce"}	3
4445	440	252	Pizza Florida	4.74	https://lnwhhjo.net/qJMtmyO.webp	{Potatoes,Tomatoes,"Onion rings"}	5
4442	9828	252	Swedish Meatballs	7.86	https://ihujgpn.top/pjfHRHn.php	{Chicken,Flour,Flour,Meat,Garlic,Mushrooms}	4
4425	4918	250	Chicken Pot Pie	7.33	https://putojnj.com/	{Milk,Mushrooms,"Japanese tamago","Japanese tamago"}	1
4437	5311	252	Swedish Meatballs	7.04	https://dskqnzw.info/ZLpGZgf.css	{Corn,"Original sauce",Potatoes,Basil,Tomatoes}	3
4447	4014	252	Pizza	2.99	http://oixqlgs.biz/gAndTAB	{Rice}	3
4444	2231	252	Tortellini Bowls	4.31	http://www.kpaqjkn.org/hCUJwpc	{Sugar,Milk,Grapes,Milk,Mayo}	4
4430	5977	251	Sweet Potato Pie	7.41	http://lmeqrbn.info/	{Cheese,Sugar,"Cheese cheddar",Pasta,Mozarella,Tomatoes}	3
4450	6514	252	Pizza Pepperoni with tomatoes	2.94	https://inxhrcb.biz/iGGwnhj.svg	{Rice}	3
4453	8518	252	Bean Green Chili Burritos	3.12	http://qibzzpg.top/XQPPcGA.js	{"Original sauce"}	3
4448	1794	252	Pizza Texas	2.37	https://zbdgavc.edu/IMcMpDx.css	{Milk,Bacon,Milk,Chicken,"Cottage Cheese",Strawberry}	3
4457	6054	252	Tortellini Bowls	4.55	https://www.vpkspdp.info/JPrMqVx	{"Cottage Cheese","Chili Pepper",Rice,Milk,"Unagi sauce","Cheese cheddar"}	3
4449	834	252	Grape Jelly Sandwich	5.60	http://lddoaez.info/rhvFeju.css	{Pasta,Peas,Salmon,Cucumber,Cucumber}	2
4451	2930	252	Pizza Texas	2.64	https://omwdvgg.ru/CeCyqgD.js	{Onion}	1
4419	5565	250	Unwrapped Burrito Bowl	2.14	https://qwhctux.org/lHtXCbd.php	{Rice,Bacon,"Onion rings"}	1
4501	9687	253	Swedish Meatballs	7.62	http://lxfundj.biz/jHXsbYn.webp	{Chicken,Cheese,"Bavarian sausages","Cream cheese","Onion rings"}	1
4484	6563	253	Pizza Ocean	6.05	https://www.awwpkbx.ru/	{Strawberry,Tomatoes,Strawberry}	1
4465	8752	252	Pizza	3.29	http://qtrklag.info/SHOpxhl.jpg	{Butter,Basil,Nori}	3
4485	6706	253	Pizza Ocean	4.88	https://ekjqnio.biz/WKYRdhG.js	{Peperoni,Sugar}	2
4486	76	253	Bacon Cheese Burger	7.09	http://dmvlvct.biz/KXDTHlR.svg	{Mozarella,Corn}	4
4466	5381	252	Bean Green Chili Burritos	4.14	https://pvdehka.biz/OtuaRnf	{Milk,Mayo,Bacon,Garlic,Grapes,"Unagi sauce"}	3
4467	9579	252	Pizza Ocean	7.04	http://flcasti.org/RXWUmtB	{Grapes,Salmon,Tomatoes,Mushrooms}	5
4551	4540	254	Swedish Meatballs	4.78	https://babfkuy.org/iQthTwO.php	{Mozarella,"Unagi sauce",Pasta}	4
4468	2657	252	Original burger	3.58	https://www.xfuyoks.edu/	{Flour,"Chili Pepper",Salmon,Grapes}	3
4469	5659	252	Bacon Cheese Burger	5.48	http://fxibxls.org/jsVhsbu.css	{Tomatoes,Rice,"Chili Pepper","Onion rings"}	4
4552	307	254	Original burger	5.86	https://limydsc.org/	{Garlic,Peas,Rice,"Cottage Cheese",Flour}	1
4600	4721	254	Saint Frank Coffee	6.51	http://www.ikcqeuu.com/	{Pasta,Strawberry,Cheese}	4
4470	1562	252	Pizza Pepperoni with tomatoes	4.60	https://ruxdolo.info/BiLhjNt.php	{Salmon,Sugar,"Cheese cheddar","Bavarian sausages"}	3
4472	7791	253	New York Style Cheesecake	5.50	https://gmebfgr.net/LSAymfO.css	{Potatoes,"Cottage Cheese",Mayo,Cheese,Butter}	1
4473	5499	253	Saint Frank Coffee	7.49	https://crrqjrd.top/rxiNMsU.css	{Basil,Peperoni,Cheese,"Cream cheese"}	3
4474	8831	253	New York Style Cheesecake	5.45	http://unnzyax.top/RPEipsM.jpg	{Peperoni}	3
4475	1506	253	Pizza Italiano	2.98	http://rkabwoo.edu/eimnfMS.js	{Butter}	1
4476	9770	253	Philadelphia with salmon	5.49	http://jnyjagr.info/bjNHrak.svg	{"Onion rings"}	3
4477	6785	253	Unwrapped Burrito Bowl	3.04	http://nlaevqy.com/XTdKDOw.html	{Meat}	1
4478	3899	253	Original burger	3.69	https://vogrnqe.edu/nOZBUPR.html	{Cucumber,Pineapple,Mayo}	2
4479	9430	253	Philadelphia with salmon	5.44	https://kaxrccr.net/oVbAsoa.jpg	{Basil,Nori,Potatoes,Mushrooms,Carrots}	2
4480	9424	253	Himawari	4.05	http://vbeyhry.com/	{"Bavarian sausages",Flour}	5
4481	2581	253	Bacon Cheese Burger	6.82	http://kweytlq.top/IhDfIAT.css	{Nori,Bacon}	4
4463	884	252	Peanut Butter	5.49	http://dblpmjc.net/BiTmltj.css	{Cheese,Carrots,"Cream cheese"}	3
4483	8837	253	Sweet Potato Pie	6.31	https://vwdkvgt.ru/cYlhQZv.webp	{Potatoes,Butter,Bacon,Onion}	5
4464	7799	252	Sweet Potato Pie	7.22	https://eytdvwm.info/AIVIWEV	{Flour,"Cheese cheddar",Peas}	1
4593	2955	254	Original burger	7.14	https://mfvcwob.ru/MKAgGEF.html	{"Original sauce",Potatoes,Garlic,Flour,"Unagi sauce",Meat}	2
4594	5803	254	Himawari	3.24	https://jlncfkk.com/	{"BBQ sauce",Peperoni,Carrots,Cucumber}	1
4595	3416	254	Tortellini Bowls	6.18	http://www.jhkbdcl.org/FHVmQdB	{Flour,"Unagi sauce",Pasta,Tomatoes,Peanuts,Salmon}	2
4596	8086	254	Unwrapped Burrito Bowl	3.14	http://gtwgrwo.biz/TCuBgxu	{Mayo,Peperoni,Cucumber}	1
4597	5119	254	Himawari	5.52	http://www.opokzkc.biz/HUDKPUR	{Pineapple,"Cheese cheddar",Mayo,Butter,Onion}	5
4598	8662	254	Tortellini Bowls	3.48	https://yyevbrj.edu/WhCyiqu.svg	{Milk,Mayo,Pineapple}	4
4599	5298	254	Pizza Ocean	2.68	http://wawgnbf.top/kETCGsC	{Flour,"Onion rings",Flour,Peanuts}	1
4509	1137	253	Chicken Pot Pie	5.53	http://oowigyf.ru/ZkOqbQa	{Chicken,"Cottage Cheese"}	4
4510	2020	253	Grape Jelly Sandwich	6.36	https://onusfoc.top/xtZttse.php	{Meat,Potatoes,Milk,Cheese,Flour}	1
4554	3901	254	Pizza Florida	6.36	http://xommdsb.biz/HkgpLie.svg	{"Bavarian sausages",Mushrooms,"Bavarian sausages",Sugar}	3
4555	1676	254	Bacon Cheese Burger	4.84	http://rutvjdl.info/jSgrctp.html	{"Cream cheese",Mushrooms}	5
4592	6972	254	Grape Jelly Sandwich	5.50	https://rpvukeb.com/dJHCMDS.php	{"Chili Pepper",Basil,"Cream cheese",Mayo}	2
4557	7494	254	Original burger	5.88	http://lsjdiqs.top/oXqeldZ.css	{Flour,Mushrooms,Carrots,Peanuts,Carrots,Peanuts}	1
4640	3586	255	Bean Green Chili Burritos	3.09	http://lefdwvb.biz/PyGtTDS.css	{"Cheese cheddar",Cheese,"BBQ sauce"}	3
4641	5714	255	Tortellini Bowls	4.19	http://zrthguu.info/wxZQkYO.jpg	{Mushrooms,Carrots}	3
4642	5287	255	Unagi Philadelphia	2.99	http://fvatyyf.edu/dpkqTAR	{"Onion rings",Potatoes,"Cottage Cheese"}	1
4644	9166	255	Pizza Ocean	5.93	https://www.nwewrze.org/XxJIuSO	{Peperoni,"Cream cheese","Unagi sauce",Pineapple}	1
4645	161	255	Pizza Texas	3.81	http://saibgzf.edu/FwOJinV.php	{Cucumber,"Cream cheese",Cucumber}	3
4686	4961	255	Unagi Philadelphia	3.71	http://lbptwxv.info/OoFAXoN.jpg	{Bacon,Strawberry}	5
4620	9613	254	Crispy Chicken burger	5.88	https://vqtlgpm.org/BCdEEWu.js	{"Unagi sauce",Cheese,Mayo}	4
4648	6682	255	Tortellini Bowls	5.53	http://kogrfpo.edu/sEvaucY.php	{Peperoni,Rice,"Cheese cheddar","Bavarian sausages"}	3
4647	955	255	Bacon Cheese Burger	5.54	https://ynwhxvr.net/RpIbleA.css	{Grapes,Peas}	5
4690	2647	255	Unwrapped Burrito Bowl	7.42	http://vndspki.net/AMGjoUJ.webp	{"Japanese tamago",Cheese,Mushrooms,"Original sauce",Strawberry,Nori}	5
4691	7714	255	Peanut Butter	6.90	https://www.agseiwh.com/WrWdmlj	{Strawberry,Cheese,Chicken}	4
4650	6631	255	Pizza	6.84	https://myuknpm.info/EZtEqGU.php	{Nori,"Cottage Cheese"}	4
4614	4609	254	New York Style Cheesecake	5.86	http://htdbslb.org/McYZrNY.webp	{"Caramelized onions"}	4
4615	6431	254	Saint Frank Coffee	4.93	https://www.anibiss.top/MohXfmI	{Cucumber,Mozarella,Milk,"Unagi sauce",Bacon,Peanuts}	5
4617	4435	254	Pizza Florida	5.02	http://dvnmxch.biz/DlPURkX.php	{Garlic,Potatoes,Corn,Salmon,"Chili Pepper","Onion rings"}	1
4631	8849	255	Saint Frank Coffee	5.71	https://uijslxr.ru/WbItmyU.svg	{Cucumber,Milk}	2
4657	9362	255	Crispy Chicken burger	4.04	https://xvvfjcb.net/ximEEAU.js	{Peas}	5
4619	373	254	Himawari	6.63	http://rfjbkfw.biz/xaHPOZx.html	{Milk,Onion,Basil,Bacon,"Japanese tamago"}	5
4685	7933	255	Himawari	4.57	http://fsivnlk.org/YOFxMjK.js	{Milk,Mushrooms,Milk}	1
4621	9736	254	Tortellini Bowls	2.50	http://vlxfdra.info/yLxQFWl.html	{"Cream cheese","BBQ sauce",Mushrooms,Tomatoes,Mushrooms}	5
4622	2086	254	Bean Green Chili Burritos	5.96	http://jwcjtjn.biz/TKQsDdJ.php	{"Bavarian sausages"}	1
4623	5964	254	Crispy Chicken burger	7.27	http://xkyrxzo.edu/LiqxELa.webp	{"Chili Pepper",Peanuts,Cheese,Strawberry,Meat}	5
4624	2423	254	Pizza Italiano	2.76	https://wfdjvcq.info/bvpfWoW.jpg	{Peanuts,"Caramelized onions",Flour,Mushrooms}	5
4625	5993	254	Tortellini Bowls	3.87	https://gqlwuwp.info/HIImolp.svg	{Potatoes,Salmon,Mushrooms,Peanuts,Strawberry,Sugar}	5
4626	2476	254	Pizza Florida	5.17	http://www.nizospf.info/gQICUUi	{Peas}	2
4628	7852	255	Bacon Cheese Burger	5.25	http://yqlbkju.com/hblbkUF.css	{Mayo}	4
4629	2474	255	Grape Jelly Sandwich	7.82	https://ixhrlpe.ru/xUbHgiN	{"BBQ sauce",Mushrooms,Carrots,"Cheese cheddar",Grapes}	5
4630	5215	255	Unagi Philadelphia	2.10	http://ajchqew.edu/WQFaMeA	{Salmon,"Onion rings",Meat}	4
4654	4989	255	Grape Jelly Sandwich	6.29	https://edtqknb.info/mvfAyDc.svg	{Butter,"Japanese tamago"}	2
4616	5953	254	Pizza Hawaiian	2.69	https://sjkhabj.com/LhUtwaW.svg	{"Caramelized onions",Bacon,"Japanese tamago"}	5
4632	348	255	Angel Food Cake	2.82	https://www.xmaapqh.org/lmYQeGs	{Onion,Rice,Mayo}	5
4633	9175	255	Chicken Pot Pie	4.44	https://feubayz.top/OaDgMqw	{"Original sauce",Peas,Cheese,Butter,Basil}	4
4634	8460	255	Angel Food Cake	4.92	https://mrfcfns.net/rPPhsGp	{"Original sauce",Salmon,Carrots}	1
4635	5629	255	Pizza Pepperoni with tomatoes	2.83	https://vjywhjt.ru/GOygxwn.html	{Mushrooms,"Cheese cheddar","Cream cheese"}	3
4636	3227	255	Tortellini Bowls	2.27	http://ertobak.com/thFPnqJ	{"Cream cheese",Flour,"BBQ sauce"}	5
4637	3022	255	New York Style Cheesecake	7.89	http://www.akymkqz.net/ccMZPMs	{Strawberry}	1
4689	2787	255	Himawari	7.05	https://ggspbbv.net/EYycvkc.jpg	{Potatoes,Milk}	2
4649	4998	255	Grape Jelly Sandwich	5.11	http://abftyid.top/JyDwCbR.jpg	{Bacon}	4
4627	4966	255	Peanut Butter	3.66	https://mqatytd.org/	{Pineapple,"Caramelized onions",Garlic,"Chili Pepper"}	5
4651	8275	255	Unagi Philadelphia	5.73	https://rmoswxp.edu/bsBAPCV.php	{Meat,"Japanese tamago","BBQ sauce"}	2
4613	2421	254	Unwrapped Burrito Bowl	4.69	http://www.gwmagtx.net/LkPrJlB	{Flour,"Original sauce"}	1
4652	7433	255	Swedish Meatballs	3.20	https://sgbqepr.org/TVpinbM.js	{Pineapple,"BBQ sauce",Milk}	5
4655	7660	255	Unagi Philadelphia	7.76	http://nhiaeyc.com/OXpIlBt.html	{"Cheese cheddar",Cucumber,Flour,"Cheese cheddar",Rice}	2
4656	3130	255	Tortellini Bowls	5.12	https://cwsmwha.org/jtEnOZa.html	{"Onion rings",Flour,"Cottage Cheese",Carrots}	5
4659	3228	255	Angel Food Cake	3.18	https://xnvecgk.net/XlIxocL.svg	{Rice,"BBQ sauce",Onion,"Cheese cheddar"}	5
4618	7665	254	New York Style Cheesecake	4.46	http://cjvtrie.ru/UjPTeEI.js	{"Bavarian sausages",Rice,"Japanese tamago",Carrots,Pasta}	2
4687	7123	255	Crispy Chicken burger	3.77	http://www.hanqckh.ru/FiDXduY	{Flour}	2
4688	1830	255	Angel Food Cake	3.58	https://divjpxm.org/mJnogtn.webp	{Meat,Strawberry}	1
4708	8504	255	Tortellini Bowls	2.13	https://gweqihw.ru/ZDjNFlu	{Mozarella}	4
4733	5824	256	Peanut Butter	3.41	http://ukbsqsa.ru/qEDmiCO.css	{Meat,Basil,Milk,Corn,Pasta}	3
4700	4626	255	Pizza Florida	4.78	http://orhsuhg.ru/ILgkkJb.css	{"BBQ sauce"}	2
4710	7221	255	Original burger	6.46	http://lpqwrpl.info/	{Cheese,Bacon,Grapes,"Chili Pepper"}	3
4738	1305	256	Original burger	6.22	http://ealmoll.org/DvtgcnM.svg	{Onion,Mushrooms,"Chili Pepper",Peperoni,Basil}	3
4732	7278	256	Bacon Cheese Burger	4.37	http://www.wyxpsep.net/	{Flour,Flour,"Cottage Cheese"}	1
4734	6389	256	Unagi Philadelphia	7.60	https://cbasyrk.info/fGBEdMV.html	{Butter,Mushrooms,Pasta,Chicken,Mushrooms}	2
4735	9303	256	Pizza Italiano	6.37	http://zjsdrtg.biz/BASMruV	{"Caramelized onions"}	2
4709	4152	255	Pizza	7.26	https://fgnlsou.ru/	{"Cream cheese",Pineapple,Flour,Tomatoes}	5
4736	2032	256	Himawari	4.47	https://sienjnn.ru/VribXDV.js	{"Cream cheese",Corn,Strawberry}	3
4661	4477	255	Wallmart	3.17	https://www.bpoestk.biz/	{Tomatoes,Flour,Basil}	3
4705	516	255	Saint Frank Coffee	2.84	http://nvaaood.ru/ZvFsbHa	{Mushrooms,Milk,Pineapple,Corn}	1
4662	5918	255	Pizza Florida	4.51	https://fkqzbve.info/gQvJfdY.html	{Pasta,Sugar,Corn}	1
4663	6926	255	Bacon Cheese Burger	6.42	https://wsgyeja.com/vkuNdnj.php	{Basil,Strawberry}	5
4664	1057	255	Pizza Pepperoni with tomatoes	5.31	https://hrovbom.info/WUrqfhV.js	{Salmon}	1
4666	164	255	Pizza Florida	2.94	https://tfkqeia.ru/xSCnylv.html	{Carrots}	4
4669	7417	255	Chicken Pot Pie	3.98	http://xabtlcl.biz/gNQvTmu.webp	{"Cottage Cheese","Onion rings",Sugar}	1
4670	5786	255	Unwrapped Burrito Bowl	5.49	https://rvvrbwi.info/AqGUgjP.svg	{Sugar,Basil,Flour,Mushrooms,"Cheese cheddar"}	3
4671	8267	255	Unwrapped Burrito Bowl	7.50	https://vshntzm.ru/yQvZcCm.css	{Salmon,Peperoni,"Caramelized onions"}	5
4672	6953	255	Pizza Italiano	6.20	https://jwmwojj.biz/NUbDude.svg	{Meat,Flour,"Cheese cheddar",Chicken,Mozarella}	3
4679	205	255	Sweet Potato Pie	4.06	http://www.sbauttp.ru/HbNymBC	{Mushrooms,Peperoni,Cheese,Bacon,Sugar}	4
4673	3156	255	Pizza Ocean	5.22	http://pkjcgqc.net/XbehOfm.html	{"Onion rings","Chili Pepper",Bacon,Flour,Carrots,"Bavarian sausages"}	1
4675	7105	255	Crispy Chicken burger	2.90	http://ebeiuvw.biz/jwlRRAx.webp	{Butter,Peanuts}	3
4676	1631	255	Peanut Butter	7.11	https://bbbftdq.edu/	{"Cottage Cheese",Corn,Mozarella,"Cottage Cheese",Pasta,Strawberry}	5
4677	7165	255	Swedish Meatballs	7.36	https://www.eevkwsl.top/	{"Cream cheese","Original sauce"}	4
4678	2149	255	Pizza Ocean	3.70	http://www.ioelvph.top/ynIEKLp	{"Original sauce",Rice,Peas,Meat,Peperoni,"BBQ sauce"}	1
4680	5513	255	Original burger	2.93	http://lwravfv.com/RgabPAl	{Peas}	2
4681	5650	255	Pizza Ocean	6.92	http://iqjrinr.edu/VtHHhAD.svg	{Potatoes,Tomatoes,Pineapple,"Bavarian sausages",Mayo,"Onion rings"}	4
4674	1212	255	Saint Frank Coffee	2.95	http://mbjcvbb.biz/JxMpwZj	{Bacon,Peanuts}	5
4682	3974	255	Sweet Potato Pie	5.88	http://www.vnoktgj.com/UyTqDir	{Cheese,"BBQ sauce","Bavarian sausages",Bacon}	2
4683	3980	255	Wallmart	6.13	https://www.ekzyrws.org/LVcDuYT	{"Chili Pepper","Original sauce",Flour}	1
4693	2315	255	Pizza Ocean	4.93	http://ggrpfgr.biz/gwFvKaP.html	{"Cheese cheddar"}	2
4694	7811	255	Philadelphia with salmon	6.40	https://tndkbay.info/nBJLPLF.jpg	{Mushrooms}	5
4696	3718	255	Unwrapped Burrito Bowl	4.72	https://dbhckkv.net/tSbYcxa.jpg	{"Chili Pepper",Butter}	1
4697	450	255	Pizza	6.93	https://sixpfcb.biz/sHqPfZB.html	{Mozarella,"BBQ sauce",Mushrooms,Meat,Peanuts}	2
4698	6191	255	Unagi Philadelphia	4.35	http://dbgqliy.top/	{"Unagi sauce"}	4
4711	9289	255	Crispy Chicken burger	6.34	http://gpunuxb.edu/StNkJuy.svg	{Carrots,Mushrooms,"Cheese cheddar",Milk,"Onion rings"}	2
4699	8442	255	Peanut Butter	7.28	http://cxapphq.org/leARWwy.html	{Peanuts,Peperoni,"Unagi sauce",Grapes,Mushrooms}	2
4707	1229	255	Sweet Potato Pie	2.26	https://zxjbqux.net/qfBPERC.php	{Strawberry,"Cheese cheddar",Pasta}	5
4701	5484	255	Crispy Chicken burger	4.15	http://neomigj.biz/dOSbowo.webp	{Chicken,Cheese}	5
4703	5367	255	Unagi Philadelphia	4.41	https://aggkawk.ru/DZkDeHR.css	{Grapes,Mushrooms,Meat,Corn,Sugar}	3
4704	8829	255	Grape Jelly Sandwich	2.29	http://afmedpw.com/uMGjldE.php	{Mushrooms,Milk,Bacon,Onion,Butter}	3
4706	6554	255	Original burger	7.14	https://gfuiptk.edu/xMqmXOY.html	{Flour,Peanuts,Peas}	3
4702	1864	255	Pizza Pepperoni with tomatoes	4.67	https://wpgfrol.edu/AoKDala.jpg	{Butter,Basil,Flour,"BBQ sauce","BBQ sauce",Chicken}	4
4758	150	256	Original burger	5.23	https://unjsgjd.info/aGCYnCH.js	{Mayo,Sugar,Flour,"Bavarian sausages"}	1
4760	4633	256	Swedish Meatballs	5.51	https://www.djgthkr.com/JQbWxSE	{Peanuts}	5
4746	9874	256	New York Style Cheesecake	7.88	https://glysohr.com/LtWFEdM.css	{Mushrooms,Pasta,Butter}	5
4779	2876	256	Sweet Potato Pie	3.55	http://njskqpi.top/VuhPNHb.html	{"Original sauce",Sugar,"BBQ sauce",Cheese}	2
4761	5067	256	Crispy Chicken burger	5.29	https://nvnxeui.ru/	{"Bavarian sausages",Carrots,Mozarella,Nori}	2
4759	2236	256	Swedish Meatballs	6.30	https://csttpwq.biz/MEyxVjB	{Garlic,"Chili Pepper",Bacon}	4
4762	162	256	Sweet Potato Pie	2.01	http://kvvhidm.edu/tBLmDDi.jpg	{Onion,Mozarella}	2
4782	719	256	Bean Green Chili Burritos	6.53	http://cionumh.net/yyWfgIc.jpg	{Salmon,Cheese}	2
4778	8864	256	Angel Food Cake	6.41	http://enargdm.ru/	{Pasta,"Caramelized onions"}	3
4783	8243	256	Himawari	5.47	https://uwmvphf.edu/VPDCxZG.svg	{Chicken,Peanuts,Corn,Milk,Milk}	5
4781	699	256	Himawari	7.23	http://nlkwyfx.com/JxcPPUM.html	{Salmon}	5
4784	2198	256	Pizza Pepperoni with tomatoes	2.35	https://xneiabh.net/	{Peas,Mushrooms}	5
4713	9319	255	Sweet Potato Pie	2.78	https://fwtvtmx.edu/aOGhCEA	{Cucumber,Peperoni}	1
4717	3917	256	Pizza Pepperoni with tomatoes	4.54	https://kfvywrz.info/jDEksJW	{Flour,Cheese,"Cottage Cheese",Mushrooms,"Original sauce"}	4
4785	8681	256	Crispy Chicken burger	3.81	http://awtzxfm.biz/uTKRZZo.php	{Grapes,Milk}	5
4715	691	255	Angel Food Cake	3.38	https://qgaafvn.info/PqTiJVE	{Mushrooms,"Original sauce"}	2
4718	4892	256	Bean Green Chili Burritos	7.92	http://omctham.edu/LlDTwdc.svg	{Cucumber,Peas,"Cream cheese",Corn,Carrots}	4
4719	5491	256	Swedish Meatballs	6.58	http://fuhymce.top/DBOpXvo	{Nori,Grapes,"Bavarian sausages",Salmon,Cucumber,Tomatoes}	2
4720	7643	256	Crispy Chicken burger	4.39	https://qiwbmgb.com/	{"Caramelized onions",Meat,"Original sauce",Carrots}	3
4721	6547	256	Pizza Italiano	7.08	http://ouvwign.biz/BYTKogF.css	{Mozarella,Peas,Tomatoes,Flour,Tomatoes}	4
4722	696	256	Unwrapped Burrito Bowl	6.51	https://nkpfvkk.biz/gQroeBT.svg	{Milk,"Original sauce"}	3
4723	3652	256	Swedish Meatballs	3.17	https://epgikbu.biz/byQvMjH.jpg	{"Bavarian sausages",Strawberry}	3
4724	5730	256	Bacon Cheese Burger	2.33	https://djgodla.ru/kplfXmd	{"Bavarian sausages",Cucumber,"BBQ sauce"}	5
4725	908	256	Pizza Florida	2.99	https://wcfvqjc.net/LQNeDSF	{Nori}	1
4726	7302	256	Wallmart	7.41	http://toagaod.info/xXILrIE.svg	{Sugar,Peperoni,Pasta}	4
4727	1607	256	Bean Green Chili Burritos	6.68	https://www.ucutjpe.net/yeDrllq	{Corn,Rice}	1
4728	8687	256	Original burger	2.03	https://sebcqww.biz/llqoAaC.svg	{Peperoni,"Onion rings","Cream cheese"}	1
4729	3244	256	Swedish Meatballs	2.16	http://ljgvvyi.com/gIoSFcL.svg	{"Chili Pepper",Strawberry,Bacon,"Cottage Cheese",Flour}	4
4741	6400	256	Pizza	6.66	http://delhzat.com/pUjrysv.svg	{Mayo}	5
4742	8048	256	Bacon Cheese Burger	7.64	http://www.dylfmis.org/SLYomDT	{Corn,"Japanese tamago",Grapes,"Cream cheese",Butter}	3
4744	2947	256	Himawari	7.50	http://aglrhol.info/LYMfAsV.html	{Corn,Peanuts,Grapes,Mushrooms,Strawberry}	2
4740	323	256	Pizza Pepperoni with tomatoes	3.10	http://www.sxgmkar.net/	{Bacon,Salmon,Garlic,"Onion rings",Butter}	4
4743	305	256	Bacon Cheese Burger	7.07	https://gvvbdvg.net/HNqkhex.html	{Grapes,Cucumber,Peperoni}	2
4745	1834	256	Bacon Cheese Burger	5.52	https://nxuaguk.top/eiNXZJK.php	{Pasta,Rice,Salmon}	1
4747	3388	256	Wallmart	2.64	http://kbrufqr.ru/aftLvOg	{"Cheese cheddar",Rice,"BBQ sauce",Chicken,Milk,"Cream cheese"}	1
4748	7071	256	Pizza Ocean	7.63	https://www.edhkiiq.info/	{Meat,"BBQ sauce",Garlic}	5
4749	9305	256	Original burger	6.92	https://www.tlbbhhn.ru/FbFriGn	{Cheese,Cheese,Strawberry}	5
4750	5156	256	Bean Green Chili Burritos	5.99	https://avwexty.net/IngdBMW.webp	{Flour}	3
4751	5882	256	Pizza Pepperoni with tomatoes	4.25	https://qquezts.edu/WjtIIbS.php	{"BBQ sauce",Mayo,Sugar}	5
4752	3679	256	Unwrapped Burrito Bowl	3.65	https://zziskve.biz/jplcJjT.svg	{Meat,"BBQ sauce","Bavarian sausages"}	2
4753	9550	256	Saint Frank Coffee	5.88	https://cspttii.com/	{Milk,Pineapple,Meat}	4
4754	1175	256	Wallmart	6.04	http://svyykqu.net/detJLfH.php	{"Chili Pepper"}	4
4755	7896	256	Pizza Hawaiian	5.57	http://fbphvyf.edu/SIKmmfa	{Carrots,Mushrooms}	2
4757	128	256	New York Style Cheesecake	3.14	https://dcscxyg.edu/eiPXBVt.jpg	{Flour,Milk}	2
4794	7717	257	Tortellini Bowls	5.11	http://xuswryd.info/FEhdtSE.html	{Chicken,"Cheese cheddar",Pasta,Onion}	1
4827	9942	257	Bean Green Chili Burritos	4.50	https://ttgtluh.info/tYIVqEt.jpg	{Butter,"Cream cheese",Peperoni}	4
4771	5858	256	Peanut Butter	3.91	http://clhuawg.ru/kEYLkQR.php	{Flour,Flour,Flour}	4
4831	6618	257	Tortellini Bowls	3.20	http://corezxd.edu/	{Onion,Flour,Rice,Peperoni,"Japanese tamago"}	4
4789	4576	256	Unwrapped Burrito Bowl	4.15	http://yxlqtmr.ru/IBCJtUq.css	{Meat,Cheese,"Cream cheese"}	2
4832	9700	257	New York Style Cheesecake	6.01	https://www.feqidsh.org/RawDbqb	{Milk,Butter,"Unagi sauce"}	5
4764	3902	256	Saint Frank Coffee	2.18	https://cqxqwdc.ru/fsKlsoE.css	{Tomatoes,Flour,Meat,Sugar,"Chili Pepper","Cheese cheddar"}	2
4765	2501	256	Unwrapped Burrito Bowl	3.86	http://fgdxbwv.ru/nkCFcFi	{Flour,Mushrooms,Mayo,Bacon,"Japanese tamago","Unagi sauce"}	2
4766	221	256	Pizza Pepperoni with tomatoes	2.53	https://qffjfip.ru/	{Potatoes,"Cream cheese",Basil,"Original sauce","Caramelized onions",Peas}	2
4767	6976	256	Pizza Ocean	6.55	https://yfqhkpc.info/dCLuLtQ	{Mushrooms,Chicken,"Onion rings",Mozarella}	1
4768	6908	256	Unwrapped Burrito Bowl	2.93	https://pcasxbn.info/ybVXeMx.html	{"Cottage Cheese",Flour}	5
4769	6232	256	Grape Jelly Sandwich	4.67	http://wvppjcj.org/TZBkFgg.jpg	{"Original sauce","BBQ sauce"}	5
4770	5267	256	Pizza Florida	2.10	http://www.bpflsdp.edu/	{Sugar}	1
4772	1353	256	Sweet Potato Pie	6.99	http://nwqxtxh.ru/QwlIhHd.webp	{Strawberry,Salmon,"Cream cheese","Onion rings",Butter,Chicken}	4
4803	4281	257	Pizza Hawaiian	4.67	https://www.tvyowsj.ru/	{Flour,Onion,Sugar,"Original sauce","Original sauce"}	1
4773	1381	256	Pizza Texas	3.65	https://www.xoarqod.edu/lOoahiJ	{Peperoni,Garlic,"Caramelized onions",Rice,Mayo,"Cheese cheddar"}	2
4775	3427	256	Pizza Italiano	4.10	https://www.canxqrd.org/	{Mushrooms}	1
4806	6558	257	Pizza Ocean	2.80	http://swygyzu.biz/TNWDoeL.svg	{Meat,Milk,Chicken,Tomatoes,Potatoes}	1
4776	5727	256	Pizza Pepperoni with tomatoes	3.04	http://qajmcnc.top/OURIscv.html	{"Unagi sauce","Onion rings"}	1
4788	6996	256	Grape Jelly Sandwich	4.49	https://hrxhewx.com/AbeisBO.js	{Onion,Basil,Meat}	5
4830	4754	257	Pizza Florida	3.19	https://uujzhny.edu/BPISlNB.svg	{Butter,Grapes,Flour,Milk}	4
4790	1400	256	Pizza Florida	4.22	https://sdleqnm.biz/OqwakNq.css	{"Cottage Cheese","Caramelized onions",Mayo}	2
4791	393	256	Wallmart	3.74	https://www.rfrgeog.net/	{Pineapple}	5
4792	1559	257	Pizza	4.23	https://www.kafcmpi.edu/	{"Japanese tamago"}	3
4795	7290	257	Bean Green Chili Burritos	7.85	http://www.jnviwdt.biz/siMxIXt	{"Cream cheese","Original sauce",Carrots,Butter}	3
4814	5903	257	Sweet Potato Pie	6.70	https://lmwiojo.biz/UtJyAxc	{"Cream cheese",Meat}	4
4796	1986	257	Pizza Pepperoni with tomatoes	6.47	http://bpglqnx.top/nWcokFV.js	{Chicken,"Cottage Cheese",Carrots}	4
4797	2623	257	Pizza Texas	5.76	http://www.yylmptj.info/	{Potatoes,"Caramelized onions",Mushrooms,"BBQ sauce"}	3
4799	5135	257	Pizza Italiano	3.39	http://nlociqa.com/dTKEFwb.html	{"Cheese cheddar",Peas,Strawberry,Tomatoes,"Caramelized onions"}	2
4800	219	257	Unagi Philadelphia	3.79	https://www.huclutf.net/UirZkKc	{Pasta,"Chili Pepper"}	5
4801	8094	257	Pizza Ocean	5.68	http://vvlymyp.info/ytySgoB.php	{Butter,Mayo,Carrots,"Original sauce"}	1
4804	1012	257	Pizza Texas	3.92	http://tjejojx.info/RKWRVuA.js	{Potatoes,Nori,Mushrooms,"Unagi sauce",Carrots}	1
4805	5749	257	Pizza Ocean	2.47	https://bobungl.com/sAbvbYF.html	{Rice,Butter,Bacon,"Bavarian sausages",Nori}	3
4774	1569	256	Angel Food Cake	2.12	http://vqtrffj.net/	{Onion,Chicken}	3
4807	5971	257	Grape Jelly Sandwich	4.71	http://www.giflhil.org/	{Peperoni}	4
4808	592	257	Chicken Pot Pie	3.86	https://qotxiiq.biz/FfUrlVt.js	{Tomatoes,Peas,Chicken,Cheese,Peas,Meat}	4
4809	1469	257	Wallmart	5.04	http://kjracbl.net/FsWEfNC.jpg	{Pineapple,Mayo,"Unagi sauce"}	5
4810	2484	257	New York Style Cheesecake	7.13	http://yemgaoy.org/lmQIMNV.webp	{Mozarella,Garlic,"Onion rings",Salmon,"Onion rings","Cottage Cheese"}	5
4811	6394	257	Philadelphia with salmon	4.62	http://hapkdyg.net/RrmsufH.svg	{Bacon,Mayo,Salmon}	4
4812	3949	257	Saint Frank Coffee	6.34	https://xvyxcdr.org/MkDoOXC.webp	{Mayo}	2
4813	8011	257	Pizza Texas	3.93	http://rsddbll.net/AqywhUY.jpg	{Onion,Mushrooms}	3
4828	8934	257	Pizza Hawaiian	2.65	http://www.eomhjrs.info/	{"Chili Pepper",Peperoni,"Cottage Cheese",Peas,Garlic,"BBQ sauce"}	2
4829	7664	257	Saint Frank Coffee	4.55	https://www.miqkmym.ru/	{"Original sauce"}	3
4865	1071	257	Grape Jelly Sandwich	2.80	http://yhzffnz.ru/DrTDhWk.php	{"Chili Pepper",Meat,Flour,"Bavarian sausages",Garlic}	2
4852	4034	257	Angel Food Cake	3.76	http://gdcpvaw.edu/hvkkCmJ.css	{"Cheese cheddar"}	4
4874	4318	258	Crispy Chicken burger	3.41	https://hurmhqn.top/hcESjuS	{Rice}	5
4877	5442	258	Bean Green Chili Burritos	3.49	http://dbzrryw.org/YnBGjVG.svg	{Grapes,Butter}	4
4878	2443	258	Peanut Butter	4.12	https://ujotatl.net/UJQyTri.svg	{"BBQ sauce"}	2
4879	206	258	Original burger	3.44	https://www.poqxmvw.info/ZQujsGk	{Salmon,Salmon,Grapes,"Caramelized onions"}	4
4821	3656	257	Philadelphia with salmon	4.79	http://www.obxaoga.net/	{Garlic,"Original sauce",Flour,Bacon,"Original sauce","Japanese tamago"}	1
4816	1002	257	Pizza	2.54	https://kmipoly.top/qHNNYhw.php	{Peanuts,"Cottage Cheese"}	3
4817	6092	257	Pizza Hawaiian	5.86	https://jjwuppn.edu/AtIJQrh.svg	{Rice,"Caramelized onions",Rice,Mozarella,Bacon,Chicken}	3
4818	7732	257	Sweet Potato Pie	5.87	http://zcdzmus.biz/	{Mayo,Flour,"Chili Pepper","Original sauce"}	5
4819	843	257	Pizza Italiano	3.56	https://cqzxpdh.ru/dgKFmUe.jpg	{Corn,Basil,Carrots}	2
4820	490	257	Saint Frank Coffee	7.53	https://rhxhgxc.biz/pqBusmy.css	{Peanuts,Potatoes,Sugar,"Onion rings","Bavarian sausages"}	2
4822	8684	257	New York Style Cheesecake	7.15	https://www.dmidgas.com/	{"Original sauce",Bacon,"BBQ sauce",Cheese,Nori}	1
4823	3323	257	Chicken Pot Pie	7.88	http://vykrmhr.edu/KapacVi.php	{Corn,Salmon,"Cream cheese","Original sauce"}	1
4824	4297	257	Pizza Italiano	5.98	https://nuhicti.com/WByDwUe.webp	{Peperoni,Onion,"Unagi sauce",Rice,Corn}	5
4834	7445	257	Swedish Meatballs	2.68	http://jbtkiej.ru/LeWpAjL.svg	{Pasta,Sugar,Grapes}	2
4836	5034	257	Unagi Philadelphia	5.17	https://mhpundl.biz/SsZlpEJ	{Strawberry,Rice}	1
4837	8624	257	Philadelphia with salmon	5.95	https://frykohh.net/	{"Bavarian sausages",Cucumber,Grapes}	4
4838	3393	257	Peanut Butter	6.47	https://www.lkdvfyo.org/	{Cucumber,Grapes}	4
4846	6853	257	Pizza Italiano	2.41	http://jlxmrwq.net/sGdTZJy.jpg	{Mozarella}	4
4840	2126	257	Sweet Potato Pie	6.47	https://snxlpfl.edu/	{Mushrooms,Cucumber,Bacon,Nori,"Unagi sauce"}	2
4842	5524	257	Angel Food Cake	5.42	http://omhqwdp.top/VobMeFD.jpg	{Mushrooms,Onion,Flour,Mushrooms,Peanuts,Peanuts}	4
4843	3206	257	Pizza Texas	7.51	http://www.rdzdilf.top/	{Pineapple,Butter,Chicken,"BBQ sauce"}	2
4850	3413	257	Pizza Texas	3.63	http://www.qfctaps.ru/TrhfTTl	{Milk,Corn,Mushrooms,"Cream cheese","Cottage Cheese"}	2
4845	7922	257	Bacon Cheese Burger	4.67	https://sblhhyb.top/AcccLYb.js	{Pineapple}	4
4847	1787	257	Chicken Pot Pie	2.49	https://nylorvd.edu/jvOhdHV.jpg	{Mayo,Mushrooms,"Japanese tamago",Sugar}	1
4839	1513	257	Unagi Philadelphia	6.06	http://iwjaflq.ru/OWoWvGV	{Grapes,"BBQ sauce"}	4
4848	6776	257	Bacon Cheese Burger	2.31	http://bqudiuc.biz/VDwPZLo.svg	{Peperoni,Grapes,Grapes,Basil,Mayo,Salmon}	5
4857	6121	257	Grape Jelly Sandwich	6.47	https://bmjmpyq.biz/hSqJaqg.css	{Corn,Mushrooms,Cheese,Chicken}	5
4851	7016	257	Swedish Meatballs	3.76	https://ksltkgo.net/iJVZgKA.css	{Grapes,Peas,Sugar}	4
4844	2103	257	Pizza Ocean	4.33	https://qgbdwvt.edu/kSEaTwj.html	{Onion,"Original sauce",Strawberry,Pineapple,"Cream cheese"}	3
4855	5183	257	Tortellini Bowls	3.31	http://muinuxc.info/eEZlGTn.php	{Cheese,Strawberry,"Cheese cheddar","Chili Pepper"}	2
4856	3638	257	Unagi Philadelphia	6.22	http://rmodlhd.net/oAeYVnB.html	{Salmon,"Caramelized onions",Garlic,"Cream cheese",Potatoes}	5
4858	1252	257	Bacon Cheese Burger	4.78	http://kfjbpja.net/GDmxvGI	{"Japanese tamago"}	1
4849	5405	257	Pizza Ocean	5.31	https://nmajrlb.top/	{"Cheese cheddar",Peperoni,Flour,Butter}	5
4859	1166	257	Original burger	4.45	http://www.gsdqmgz.top/	{Flour,Corn,Nori,Grapes}	2
4860	9470	257	Angel Food Cake	6.94	http://pkxompc.edu/mmifUEK.webp	{Bacon}	3
4861	9530	257	Pizza Italiano	7.78	https://www.swheqjn.top/	{Meat,Potatoes,Bacon}	3
4862	5019	257	Pizza Pepperoni with tomatoes	6.70	http://zlvpzou.net/oPrEwhH	{Peperoni}	5
4863	6956	257	Grape Jelly Sandwich	4.60	http://gmumfup.com/YAyAdmr.svg	{Nori,Cheese,Mushrooms,Potatoes,"Cheese cheddar",Rice}	3
4864	5753	257	Grape Jelly Sandwich	5.81	https://ffhycvn.com/NuiZHii.js	{Garlic,Cheese,Flour,"Cottage Cheese"}	1
4875	6585	258	Philadelphia with salmon	7.39	https://qtstdqz.info/redmXHf.svg	{Pasta,"Onion rings","Japanese tamago",Chicken}	4
4876	5945	258	Pizza Florida	5.00	https://www.byyccxn.ru/IbEYClC	{Peanuts,Bacon,Flour,Chicken}	5
4910	5983	258	Pizza Ocean	3.52	https://ymjcdpz.top/ErVJBEI.jpg	{Corn}	2
4912	3044	258	Angel Food Cake	7.09	http://ctlznma.edu/	{Garlic,"Japanese tamago"}	2
4897	1047	258	Himawari	6.74	https://xnwvyoc.info/jEhuiYd.js	{Bacon,Pineapple,"Caramelized onions"}	1
4913	8888	258	Unwrapped Burrito Bowl	4.68	https://dsxrfrx.org/GueMmLo.js	{"Onion rings",Peas,Corn,"Onion rings",Bacon,"Cottage Cheese"}	3
4914	7854	258	Pizza Florida	3.03	http://wqpnnff.org/EEdrWQA.svg	{"Cottage Cheese","Cheese cheddar",Pasta,Tomatoes,Peperoni,Salmon}	3
4915	9257	258	Unwrapped Burrito Bowl	4.81	https://cowwnba.biz/cHwVwko.php	{"Cheese cheddar",Sugar,Basil,"Japanese tamago"}	2
4916	5124	258	New York Style Cheesecake	2.27	https://aymrwkc.org/SQRJqNe.php	{Pineapple,Mushrooms,Potatoes,Potatoes}	4
4917	3619	258	Angel Food Cake	2.86	http://duxpvzf.biz/lOTadgU.jpg	{Milk,Salmon,Mushrooms,Onion,Cheese}	1
4918	7298	258	Wallmart	5.44	https://jyamqlm.info/vbfLTZj.html	{Peas,Bacon}	2
4921	6239	258	Saint Frank Coffee	3.03	https://zcsbypa.biz/NwmcYNT.js	{"Original sauce","Bavarian sausages"}	4
4922	2597	258	Unagi Philadelphia	6.02	http://smluwrt.net/PjQJsdq.jpg	{"Cheese cheddar",Grapes,"Original sauce",Peas,Pineapple}	4
4923	2048	258	Pizza Italiano	7.91	http://xtvxcxv.net/CIkgrXw	{Cucumber,Grapes,Strawberry}	4
4924	6984	258	Chicken Pot Pie	6.85	http://hxjpfxc.net/fLrrMLd.css	{"Cheese cheddar",Mushrooms,"Japanese tamago",Meat}	1
4925	1409	258	Pizza Florida	6.26	https://uwgmwdj.edu/	{"Japanese tamago",Salmon}	2
4926	333	258	Pizza Florida	4.27	http://www.vnpknta.edu/ZQOSNSV	{Basil,Grapes}	1
4927	2920	258	Himawari	6.67	https://eswtqhv.org/dgMBJlH.svg	{"Caramelized onions",Salmon,Peas,Onion}	2
4867	5686	257	Angel Food Cake	3.84	http://ejxjmww.edu/lyAGbYe.html	{Carrots,Mushrooms,Rice,"Cottage Cheese"}	4
4868	4025	257	Philadelphia with salmon	3.50	https://hfcheki.top/	{"Cream cheese"}	5
4870	6339	258	Sweet Potato Pie	6.76	http://www.dpjsqot.net/	{"Japanese tamago",Nori}	5
4871	6093	258	Pizza Pepperoni with tomatoes	3.91	http://uepanwa.net/sbydHVh.webp	{Onion,"Japanese tamago"}	5
4881	9250	258	Pizza Texas	5.27	https://kqpnrpq.net/QrhOMPK.html	{Meat,Peas}	5
4884	7611	258	New York Style Cheesecake	3.57	https://vejbbec.ru/tDMsHgR	{Nori,Salmon}	5
4887	8131	258	Chicken Pot Pie	4.83	https://lvljipj.top/ytxBgHT	{Cheese,Peanuts,Peas}	5
4885	6452	258	Angel Food Cake	4.62	https://nqmpeyg.ru/IqbtteP.php	{Bacon}	5
4883	9436	258	Original burger	2.01	https://kkxirap.ru/	{"Cottage Cheese",Carrots}	4
4888	573	258	Crispy Chicken burger	6.56	http://www.nrbgecc.org/CwQbhmk	{Corn,Milk,Garlic,"BBQ sauce",Onion}	1
4889	4955	258	Wallmart	4.10	http://khdbruo.edu/yXjmyoY.js	{"BBQ sauce",Basil,Flour,Nori,Flour}	2
4890	3137	258	Unagi Philadelphia	2.77	http://xuaadrk.edu/	{Corn,Pineapple,"Japanese tamago",Strawberry,Potatoes,Bacon}	1
4891	7137	258	Pizza	4.12	http://nwvaoey.org/FjmrTeW.jpg	{Meat,Milk,"Onion rings"}	5
4892	8670	258	Unagi Philadelphia	4.31	http://lsfdnkh.ru/XaZACgD.js	{Basil,Salmon,"Onion rings",Potatoes,Cucumber}	2
4893	8485	258	Chicken Pot Pie	2.17	https://xropmmp.ru/IuTKfkE.webp	{"BBQ sauce"}	2
4894	9622	258	Pizza	3.88	http://wfdpkld.top/lJLDWyg	{Mushrooms,Chicken,Potatoes,"Original sauce",Mayo}	3
4895	4262	258	Peanut Butter	3.98	http://jufwmxi.com/JlpfJdW.js	{"Cottage Cheese",Basil,Carrots}	1
4899	4715	258	Crispy Chicken burger	7.46	https://aoomryh.edu/	{Mayo,Corn,"Unagi sauce","Japanese tamago",Pasta}	4
4898	4531	258	Saint Frank Coffee	3.75	http://www.xkwsyxb.org/fxiZVXp	{"Onion rings"}	1
4896	5674	258	Tortellini Bowls	5.55	http://iwrxgkv.info/aQZmncA	{Peas,Flour}	4
4901	9474	258	Original burger	7.86	http://www.icijxjv.info/leFkWGJ	{"Bavarian sausages",Tomatoes}	5
4902	8523	258	Original burger	5.51	http://www.ecjaysg.info/	{Peperoni,Mushrooms,"Caramelized onions"}	3
4904	3784	258	Philadelphia with salmon	2.70	http://klwomlg.org/	{"BBQ sauce","Cream cheese"}	3
4906	1545	258	Pizza Texas	3.32	http://www.gvfzgge.edu/nKGZYMd	{Milk,Grapes}	4
4905	5365	258	Original burger	3.08	http://vhoggxy.com/sBdgHfm.css	{Pasta,Mayo,Rice}	3
4903	4921	258	New York Style Cheesecake	7.57	http://igdytpd.ru/EDnBhcO.js	{Carrots}	3
4907	9808	258	Bacon Cheese Burger	4.96	http://ryyqwnc.info/xtNhjhp.js	{Carrots}	2
4911	7820	258	New York Style Cheesecake	6.82	http://gluuxdy.net/sAraAlH.js	{Mozarella,"Japanese tamago","BBQ sauce",Carrots,Corn,Rice}	4
4909	8668	258	Pizza	4.29	https://vldnvig.net/uJGQDxm.css	{"Caramelized onions"}	1
4965	4452	259	Wallmart	2.25	https://www.olugnpy.com/feRGfXo	{Nori,Flour}	4
4968	8030	259	Swedish Meatballs	6.45	https://bejlsfm.edu/WfqwZkK.js	{"Caramelized onions",Pineapple,"Unagi sauce",Grapes,Butter}	2
4952	5784	258	Unwrapped Burrito Bowl	2.44	https://fvaibxs.top/BWKYSrR.svg	{"Chili Pepper",Garlic,Tomatoes,Meat,Grapes}	2
4971	1272	259	Philadelphia with salmon	6.80	https://dbyjbpg.ru/oThLtbS	{Pineapple,"Cream cheese",Carrots,Mushrooms}	2
4972	6020	259	Philadelphia with salmon	6.48	https://kefcqfo.info/KrqTZSm.js	{Mozarella,"Caramelized onions",Mushrooms,"Cream cheese"}	2
4973	6281	259	Original burger	4.89	https://nxzujaq.org/XGdjibV.js	{Chicken,"Original sauce",Corn,Sugar}	1
5013	1308	259	Original burger	5.56	https://mzycgwf.ru/DUDgGRQ.webp	{"BBQ sauce",Grapes}	4
5014	2372	259	Crispy Chicken burger	6.91	http://hqovgoa.com/	{Flour,Pineapple}	3
5015	4659	259	Pizza Italiano	4.87	http://haejbjv.info/LcGmidx.html	{Milk}	3
5016	5728	259	Unagi Philadelphia	2.26	http://glcjdzo.ru/vUnGKZn.webp	{"Cream cheese"}	1
5017	5831	259	Chicken Pot Pie	7.26	https://dgrycsm.org/	{Pineapple,"Onion rings"}	2
4930	8895	258	Original burger	2.86	http://lqafzjk.com/gikjAQG.jpg	{Bacon,"Cottage Cheese",Butter,Grapes,"BBQ sauce"}	3
4931	5546	258	Grape Jelly Sandwich	3.96	https://xkdptne.biz/UKwKFAw	{"Japanese tamago"}	1
4932	4931	258	Bean Green Chili Burritos	5.61	https://mzpiahl.net/uInvBli.webp	{Salmon,"Chili Pepper","Japanese tamago"}	2
4933	7682	258	Saint Frank Coffee	6.21	https://cnxhbmw.org/dKdJPFf	{Cucumber,Pasta}	5
4934	8115	258	Original burger	3.40	http://aittshk.com/GWpHEwl.svg	{Mozarella}	3
4935	3582	258	Pizza Florida	7.35	https://xputbgd.ru/qBAjNuU	{Pasta,Mozarella,Potatoes}	3
4936	9498	258	Swedish Meatballs	5.44	https://lqkvaqs.top/gimJmDG	{"Original sauce",Mozarella,"Japanese tamago"}	5
4937	1524	258	Sweet Potato Pie	3.54	https://fpqyhvj.org/jVTIZvE.jpg	{Peanuts,"Original sauce",Cucumber,Rice,Onion,Meat}	5
4938	2736	258	Wallmart	4.38	https://www.gwlllmo.top/	{Sugar,"Cream cheese","Cream cheese",Grapes}	1
4962	3192	259	Pizza Italiano	2.44	https://www.qoybgeb.info/HaBreZn	{Carrots}	4
4940	8603	258	Peanut Butter	5.22	http://obsaggh.com/MieQWPW.php	{Mushrooms,Pineapple,Carrots,Peperoni,Flour}	5
4941	9360	258	Himawari	7.07	https://ardhepy.top/MPBNSPi	{Flour,Potatoes,Corn,Peas,"Japanese tamago"}	5
4942	9952	258	Saint Frank Coffee	6.75	http://ykpduzf.org/OvjFklR.js	{Garlic,Basil,"Cottage Cheese",Tomatoes,Peanuts}	5
4943	1728	258	Pizza Texas	4.56	http://rlxcosp.com/EZjnReE.html	{"Chili Pepper","Chili Pepper",Pasta}	5
4944	5231	258	Tortellini Bowls	7.17	https://mhceety.edu/cVkECpA.html	{Mozarella,Flour,Peperoni,Peperoni}	5
4945	8917	258	Sweet Potato Pie	5.98	http://tjkqxtn.edu/PNVlowy.css	{"Chili Pepper",Sugar,Mozarella,Pasta,Corn}	2
4946	5520	258	New York Style Cheesecake	6.82	http://khsvqlr.net/jEfZSkq.webp	{"Cheese cheddar",Potatoes}	2
4947	5748	258	Pizza Pepperoni with tomatoes	4.70	http://www.xfvrwgj.net/hRmKAwJ	{Grapes}	5
4948	7586	258	Himawari	3.21	http://wjlghdv.org/lkDjKSK.css	{Grapes,"Bavarian sausages",Pasta}	5
4949	6592	258	Bacon Cheese Burger	4.19	https://fayapkm.org/EyTyPtQ.webp	{Grapes}	3
4950	3401	258	Unwrapped Burrito Bowl	6.27	http://iootdpe.info/	{Milk,"BBQ sauce",Chicken,Nori,Potatoes}	4
4953	1105	258	Philadelphia with salmon	7.95	https://www.rkkymay.biz/GIDpUSE	{Peas,Strawberry,Chicken,Meat}	3
4954	4394	258	Himawari	3.53	http://ikzfkdq.net/	{Corn,Cucumber}	4
4956	3432	259	Pizza Florida	4.09	http://tplhibf.net/soSljoY.css	{Pasta,Mayo,Strawberry,Peas}	3
4958	7970	259	Swedish Meatballs	5.33	https://sphvjub.edu/qxaLgXW.html	{Corn,Pasta}	2
4959	503	259	Angel Food Cake	3.22	http://grlvnrb.com/	{"Chili Pepper"}	1
4960	2406	259	Pizza	5.77	http://ygrkaic.edu/VHvwYkT.html	{"Caramelized onions",Peas,"Unagi sauce","Bavarian sausages","BBQ sauce","Unagi sauce"}	5
4961	5004	259	Unwrapped Burrito Bowl	4.02	https://bcdlphx.com/cXuOUSI.css	{Cheese,Basil,Bacon}	4
4963	9254	259	Original burger	7.85	https://yredzvn.info/YRKxKcg.jpg	{"Cheese cheddar",Mushrooms,"Chili Pepper",Pasta,Flour}	2
4939	5200	258	Unwrapped Burrito Bowl	5.52	http://wtiylqh.org/	{Carrots,Chicken,Mushrooms}	4
4964	4842	259	Crispy Chicken burger	5.17	http://fyuevof.org/ewXBmms.svg	{Butter,"Cottage Cheese",Rice,Strawberry}	1
4969	9968	259	Bean Green Chili Burritos	5.46	https://pqsbghq.top/dxicAIm.php	{"BBQ sauce"}	1
4970	7171	259	New York Style Cheesecake	2.80	http://hravyqh.edu/sNFbxWH.svg	{Mozarella,Mayo,Mayo}	2
5064	2665	260	Pizza Italiano	7.37	https://wmmzfwr.net/IkaBrDP.jpg	{Salmon}	2
4982	7989	259	Peanut Butter	6.55	https://fnqiwje.biz/	{"Cream cheese",Pineapple}	4
5008	1294	259	Saint Frank Coffee	5.39	https://idbrndj.top/	{"Bavarian sausages",Mozarella,"Original sauce",Mushrooms,Sugar}	3
4986	5394	259	Pizza Texas	7.71	https://gwiislf.net/	{"Original sauce","Chili Pepper",Carrots,Carrots,"Japanese tamago"}	1
5061	9504	260	Pizza	2.92	https://www.dikktzk.ru/	{Rice}	4
4979	2986	259	Pizza	5.72	https://abghkjj.ru/ZnvMRUo.js	{Carrots,Nori,Potatoes,"Japanese tamago"}	5
4981	1645	259	Tortellini Bowls	5.38	http://kutydno.info/xIrOQjw.php	{Grapes}	4
4990	3975	259	Pizza	5.98	https://hsrnccg.org/FJEMkaF.css	{"Cottage Cheese"}	5
5065	842	260	Bacon Cheese Burger	2.28	https://auembpu.ru/ZAFolUj.css	{"BBQ sauce","Onion rings","Cottage Cheese",Meat}	3
4985	3466	259	Saint Frank Coffee	4.27	http://yjekjxm.biz/OIfQkVW.svg	{Mushrooms,Flour,Sugar}	4
4994	4977	259	Peanut Butter	4.80	https://wbepwyf.edu/awoSPfj.html	{Peanuts,"Japanese tamago"}	5
4978	5070	259	Pizza Texas	5.30	https://fksucjb.edu/aAvBUBr.webp	{Mushrooms,Butter,Onion,"Cheese cheddar"}	5
4988	4150	259	Crispy Chicken burger	5.45	http://lbnpemr.net/JXdiJkH.webp	{Meat,Peperoni,"Japanese tamago",Flour,Nori,Grapes}	5
4989	2186	259	Crispy Chicken burger	3.39	http://kmdccha.edu/	{Sugar,Pineapple,Flour,Nori}	3
4998	9377	259	Tortellini Bowls	7.04	http://betiwua.ru/jsSgAUj.css	{Mushrooms,Mushrooms,Flour,"Onion rings",Milk,Peanuts}	1
4983	9565	259	Peanut Butter	3.13	http://www.ytiprtd.info/JbPdrOP	{"Japanese tamago",Flour,Mayo,Mushrooms}	4
5000	6270	259	Original burger	2.19	https://www.gpavfgn.org/heNMSOl	{"Onion rings",Butter}	3
4995	9785	259	New York Style Cheesecake	3.97	http://lvcdxad.ru/WOBcdPN.svg	{"Cream cheese",Carrots,Basil,Butter,"Japanese tamago"}	3
4987	8465	259	Pizza Ocean	2.41	https://www.vxpksww.com/JYhkpWA	{"Original sauce",Peanuts,Butter,"BBQ sauce"}	4
4996	792	259	Swedish Meatballs	3.29	https://www.yosbugm.org/	{Cheese,Peas}	1
4997	9111	259	Pizza Pepperoni with tomatoes	7.79	http://ailaatr.info/MSJIcFV.html	{Potatoes,Mozarella}	4
4999	1222	259	Swedish Meatballs	4.91	http://xbmphtx.top/	{"Chili Pepper",Pineapple,Mayo,Mozarella}	5
4991	412	259	Pizza Hawaiian	4.23	https://xkmfzve.ru/	{Mushrooms,Peas,Peas,Flour}	3
5001	9891	259	Grape Jelly Sandwich	5.25	http://uvwrpck.com/QBqHFrl.webp	{Bacon,"BBQ sauce",Bacon,Tomatoes}	3
4992	4085	259	Philadelphia with salmon	4.52	http://lqmdihd.com/IrqZjbI.html	{Mushrooms}	3
5009	3423	259	Pizza Ocean	3.97	https://hpxgsxd.net/OnBjqye.css	{Sugar,"BBQ sauce",Cheese,Mushrooms,Onion,Nori}	4
5003	9630	259	Wallmart	3.07	http://www.pdbjund.com/VCJroSv	{"Cheese cheddar","Japanese tamago",Mozarella,Strawberry,"Onion rings",Mushrooms}	2
5004	7476	259	Unagi Philadelphia	7.11	https://accjfai.org/hqjgiJi.js	{Strawberry,"Japanese tamago","Onion rings",Bacon,Cheese,Potatoes}	4
5005	1832	259	Crispy Chicken burger	2.53	http://xmdwzgx.biz/CZAPEDy	{"Onion rings",Cucumber,Butter,Butter,"Cream cheese",Sugar}	1
5006	2937	259	Wallmart	5.73	http://nmsjgmj.edu/bkvTtgk.js	{Sugar}	5
5007	1498	259	Grape Jelly Sandwich	7.59	https://www.jgjrcak.org/	{Flour,"Original sauce","Cream cheese",Basil,Strawberry}	2
5010	2436	259	Pizza Hawaiian	4.81	https://lpfbvjp.ru/qQEHPOH.html	{"Caramelized onions",Cucumber,Mushrooms,Bacon,Grapes,Pasta}	1
5002	8326	259	Pizza Ocean	6.70	https://www.htxdsvv.net/	{Cheese,Peas,"Cheese cheddar",Salmon,"Bavarian sausages","Cheese cheddar"}	4
5011	2703	259	Unagi Philadelphia	3.37	https://www.kfrrawx.edu/	{Flour,Cucumber,"Onion rings",Flour,Mozarella,Flour}	1
5020	236	259	Unagi Philadelphia	5.18	https://www.nicqrwq.info/lmRoMkG	{"Onion rings","Cheese cheddar",Chicken,Tomatoes,Mozarella}	5
5021	7713	259	Saint Frank Coffee	7.58	https://bunvcvc.top/puqdOqs.html	{Carrots,Cucumber,Onion}	2
5059	798	260	Tortellini Bowls	7.53	http://ojcbppg.edu/	{Corn,Flour,Corn,"Unagi sauce",Cheese}	1
5060	404	260	Bean Green Chili Burritos	3.54	https://veizjdu.top/TZLSwJM.jpg	{Garlic,"Chili Pepper",Mushrooms,Salmon,Nori}	3
4977	7997	259	Himawari	6.75	https://hoanfgv.org/peCIKFI.php	{"Cream cheese",Chicken,Milk,Garlic,"Onion rings"}	4
5062	6525	260	Crispy Chicken burger	6.27	https://ahexsbo.org/hfTGXWD	{Mushrooms,Salmon,Potatoes,Butter}	4
5063	92	260	Crispy Chicken burger	5.07	https://eljpfdr.biz/eQsYrtb.html	{Mozarella,Cucumber,Corn,Flour}	5
4976	6795	259	Sweet Potato Pie	5.64	http://www.whkmaja.com/lRLoJcQ	{Peas,Peas,Rice,"BBQ sauce",Mozarella}	5
5109	2620	261	Bacon Cheese Burger	4.45	https://akcjbxp.net/tvuccYQ.js	{Strawberry,"Caramelized onions","Cream cheese",Corn,Meat}	4
5045	976	259	Pizza Hawaiian	2.31	http://pajwhvz.org/ihNvmkc	{"Unagi sauce",Onion,Flour}	5
5049	9987	260	Original burger	2.29	http://apacrjb.biz/	{"Cheese cheddar",Corn}	3
5108	860	261	Crispy Chicken burger	6.67	https://pwwbvid.edu/eLPcktG.js	{"Chili Pepper",Strawberry,Flour}	5
5051	4681	260	Himawari	5.69	https://ohjgeld.net/	{Meat,Potatoes}	2
5053	5213	260	Crispy Chicken burger	5.32	http://xtanxkx.net/ljoTusa.php	{Milk,Mushrooms}	2
5034	664	259	Wallmart	6.19	https://tndnllq.edu/ZJZOkYA.jpg	{Bacon,Mayo,Cheese,Nori,Pineapple,Mozarella}	3
5056	6283	260	Pizza Pepperoni with tomatoes	7.85	http://www.eajcojo.ru/PEFHsUN	{Nori,"Japanese tamago"}	1
5068	9784	260	Crispy Chicken burger	3.79	http://fjfpdrg.edu/WtEpEDa.jpg	{Corn}	1
5024	4091	259	Pizza Ocean	6.03	http://hnnrffy.net/mRZmTBi.webp	{Peperoni,Flour,"Japanese tamago",Mushrooms,Flour,Chicken}	5
5071	2269	260	Pizza	6.31	https://dfrggaj.org/Gejyoya.php	{Pineapple,Peanuts,Meat,Flour}	3
5072	2718	260	New York Style Cheesecake	7.28	http://www.knhauin.edu/UGosevJ	{Salmon}	2
5073	8294	260	Pizza Pepperoni with tomatoes	5.13	http://www.mwbbhcl.ru/uhAjUsx	{Pineapple}	1
5055	6245	260	Saint Frank Coffee	6.21	http://ptibdpa.biz/uUlkkty.webp	{"Japanese tamago",Mozarella}	5
5107	4537	261	Wallmart	4.00	http://gjfaxtk.edu/	{"Chili Pepper"}	5
5025	530	259	Unagi Philadelphia	6.30	http://gjylvbo.edu/	{Onion,Peperoni,Salmon,Peas,Strawberry}	2
5070	1926	260	Swedish Meatballs	5.59	http://fjyjxuf.com/bigGdLE	{Nori,Mayo,Peas,Peas,Chicken,Corn}	1
5110	6388	261	Crispy Chicken burger	5.04	http://laydhoz.com/LJCmaui.svg	{Cheese,Onion,Mushrooms,Mayo,"Cottage Cheese",Grapes}	3
5027	6607	259	Pizza Texas	5.93	https://yccwvup.top/	{Nori,Bacon,"Unagi sauce",Cheese,Tomatoes}	2
5029	2122	259	Tortellini Bowls	6.31	https://www.nlknhgq.org/	{Basil,"Chili Pepper",Basil,"Onion rings"}	2
5022	8406	259	Philadelphia with salmon	6.27	https://ceabzwn.info/	{Carrots,Mushrooms,"Original sauce","Chili Pepper"}	4
5038	4285	259	Unagi Philadelphia	5.33	https://zjurlrk.info/IflZAuh.php	{Bacon,Bacon,Corn,"Cheese cheddar",Potatoes}	2
5050	5115	260	Pizza Ocean	7.75	http://qxdjara.org/cvgWSjP.php	{Onion,Mayo}	4
5026	6379	259	Pizza Florida	7.47	https://www.vguujfo.biz/	{"Bavarian sausages",Flour,Mozarella,Nori}	4
5028	5834	259	Bacon Cheese Burger	2.35	http://ugynyly.ru/eJOFAFr.svg	{"BBQ sauce",Pineapple}	1
5036	2220	259	Philadelphia with salmon	7.13	https://www.aohcidl.net/oJmXFLw	{"Japanese tamago",Corn,"Bavarian sausages"}	5
5030	1445	259	Pizza Pepperoni with tomatoes	5.22	https://dgqdbrf.org/YhPyicI.php	{"Cream cheese",Mayo}	5
5031	497	259	Angel Food Cake	7.20	http://ngcsetz.info/ixeeuWX.html	{Onion,Strawberry}	3
5039	7273	259	Chicken Pot Pie	7.26	http://zeuhmsn.top/uXMQIog	{Mayo,"Bavarian sausages","Cottage Cheese",Salmon}	5
5033	5890	259	Pizza Florida	7.19	http://rdcgxdd.info/DenxSon.js	{Nori,"Caramelized onions",Mushrooms,Peas}	5
5048	5941	260	Pizza Texas	5.29	http://www.ufhjgft.com/OfBsWBO	{"Cottage Cheese",Nori,Mushrooms}	3
5035	3537	259	Swedish Meatballs	5.42	https://nnjeisa.net/EJbdhaO.webp	{Cheese,Bacon,Grapes,"Japanese tamago"}	5
5043	765	259	Angel Food Cake	7.06	http://www.cjhpafu.net/wbBUHwZ	{"Bavarian sausages",Garlic,Flour,Mushrooms}	3
5037	4234	259	Pizza Hawaiian	6.25	http://vdxlkwo.top/AJsIBFc.svg	{Meat}	1
5040	7457	259	Himawari	7.68	https://yaeyhwb.org/UMSsYMA.php	{"Cottage Cheese",Basil}	2
5041	7774	259	Pizza Hawaiian	5.58	http://kqjvspp.top/	{"Cream cheese",Sugar,Chicken,"Onion rings"}	3
5042	2261	259	Sweet Potato Pie	2.36	http://fqriwno.com/FVMoSoA.webp	{Bacon}	5
5112	6750	261	Himawari	5.67	https://mjomeuf.biz/aLlOCsC.js	{"Cottage Cheese",Rice,Chicken,Mushrooms,"Caramelized onions"}	1
5044	2158	259	Pizza Florida	7.23	https://nfczxrg.com/xanpXsm.css	{Strawberry,Peanuts,"Onion rings",Mayo,Sugar}	3
5032	3574	259	Peanut Butter	4.53	https://dhhldzg.org/fArIIwd.php	{"Bavarian sausages"}	4
5047	1586	259	Pizza	6.51	https://wtleogg.com/OXOrOAl.jpg	{"Bavarian sausages",Potatoes,Mozarella}	1
5052	6173	260	Pizza Texas	6.19	https://xhflset.net/NDvFQcY.php	{Corn,Nori,Cucumber}	3
5111	6288	261	Philadelphia with salmon	4.49	http://www.udhevtv.ru/GyuBcQm	{Potatoes,Potatoes,"Unagi sauce"}	1
5094	9384	261	Peanut Butter	3.05	https://retvybf.biz/UXcLxQG.js	{"Original sauce",Garlic}	4
5099	6325	261	Pizza Hawaiian	3.57	http://otacdrr.edu/xnPcsIq.php	{Meat,Nori,"Unagi sauce","Chili Pepper"}	5
5151	3552	261	Wallmart	5.19	http://hnchqwg.ru/JpbKApN.html	{Pineapple}	5
5076	6823	260	Pizza Pepperoni with tomatoes	4.97	https://jtxnfum.top/UOQvXbd.js	{"Cottage Cheese","Bavarian sausages",Meat,"Onion rings"}	5
5095	1098	261	Tortellini Bowls	3.05	http://www.emvqvkk.com/	{Mayo,"Original sauce",Bacon,"Caramelized onions",Pasta,"BBQ sauce"}	3
5101	6792	261	Pizza Hawaiian	6.36	http://blxttmy.top/LCVNsvV.html	{"Bavarian sausages",Rice,"Cottage Cheese",Pineapple,Basil,Chicken}	1
5081	1055	261	Pizza	2.52	https://qtrimry.edu/FJLMvKV.webp	{Chicken,"Caramelized onions",Salmon,Peanuts,Garlic}	3
5114	633	261	Pizza Pepperoni with tomatoes	4.29	https://hudssma.org/MOQCVAT.webp	{Tomatoes,Peanuts,"Caramelized onions"}	3
5082	7331	261	Chicken Pot Pie	5.00	http://oargzkq.ru/gATOhyW.svg	{"Unagi sauce"}	3
5102	4499	261	Pizza Florida	7.84	https://kwixvfq.ru/gIfdodn.js	{"Chili Pepper",Nori,Tomatoes,Rice,Grapes,Mushrooms}	3
5083	8063	261	Pizza	7.66	http://chnsoun.net/pyEPspS.php	{Chicken}	1
5088	8047	261	Swedish Meatballs	4.00	http://www.otkltic.biz/	{Mushrooms,"Original sauce","Japanese tamago","Japanese tamago"}	4
5089	3928	261	Crispy Chicken burger	4.79	https://htzsurx.top/CGLWLPk.html	{Rice,Chicken,Corn,Basil}	3
5115	9324	261	Angel Food Cake	2.90	https://www.dtyqdtd.edu/	{"Cheese cheddar",Flour,Peanuts,Flour,"Cheese cheddar"}	1
5152	6112	261	New York Style Cheesecake	5.62	http://www.lcdlbwi.info/	{Mozarella}	3
5077	9369	260	Unwrapped Burrito Bowl	3.11	https://yqhlxpn.com/wNMHCXS.html	{"Cheese cheddar","Cheese cheddar"}	4
5079	3889	261	Pizza Hawaiian	4.36	http://www.zgoltcm.biz/SqmkXrD	{Strawberry,Mushrooms,Corn}	4
5080	1389	261	Tortellini Bowls	7.18	https://www.gjqkghj.top/UQcVgFs	{Chicken,Tomatoes,Pasta}	2
5103	6052	261	Sweet Potato Pie	5.70	http://msvosrd.edu/NDaBxAq.svg	{"Cheese cheddar","Cream cheese",Grapes,Mayo,"Unagi sauce"}	2
5116	7900	261	Angel Food Cake	5.30	https://fnbhnus.com/qSQOyKU.php	{Carrots,Sugar,Mayo,"Caramelized onions"}	5
5153	6630	261	Saint Frank Coffee	2.91	http://tekkoge.biz/kQpPkha.js	{Corn,"Cottage Cheese"}	5
5226	4228	262	Pizza	5.03	http://www.bjncgeg.info/HmaSPYE	{Pasta,Chicken}	4
5084	700	261	Pizza Pepperoni with tomatoes	4.49	http://nuuhbqh.biz/	{Garlic,Onion,Peperoni}	4
5086	5747	261	Pizza Florida	3.19	https://pmucmhl.edu/oROkSaF.svg	{"Cream cheese",Peas,"BBQ sauce",Meat}	4
5087	5771	261	Unagi Philadelphia	6.04	https://vuzdbiv.net/BxKORAE.html	{Salmon,Rice,Rice,"Cheese cheddar",Cheese}	3
5090	8605	261	New York Style Cheesecake	5.65	http://yzdtdlz.org/kAOvclW.webp	{"Original sauce"}	2
5096	6491	261	Angel Food Cake	5.45	http://www.saxmqqe.org/hDkxhWG	{"Original sauce"}	4
5097	105	261	Pizza Italiano	2.32	http://qemofld.info/LUfAxOf.html	{Garlic,Mushrooms,Corn,"Chili Pepper"}	3
5104	6234	261	Pizza Hawaiian	4.47	https://vmunfdg.org/IwehpoH.jpg	{"Chili Pepper","Unagi sauce"}	3
5117	7206	261	Bacon Cheese Burger	4.13	http://wimwttw.ru/vwOLKfY.svg	{Mushrooms,"Caramelized onions"}	1
5098	2412	261	Peanut Butter	2.60	http://www.cwloofr.edu/YhmsgDR	{Rice,Nori}	3
5074	3870	260	New York Style Cheesecake	6.38	https://elyxolx.top/	{Corn,"Cheese cheddar"}	3
5092	2673	261	Saint Frank Coffee	2.91	http://yuiizpw.info/YdNwYig	{"BBQ sauce",Sugar,Milk,"Caramelized onions",Basil}	3
5118	7325	261	Pizza Texas	6.13	https://xygrlgk.top/oTPdrsi.html	{"Original sauce",Pasta,Rice}	1
5093	1556	261	Pizza Ocean	2.58	http://nfwfmgb.net/hNdItCP.js	{Mushrooms,"Bavarian sausages"}	2
5075	8144	260	New York Style Cheesecake	6.77	http://bzuyeiq.biz/yaGZbAG.jpg	{Sugar,Rice,"Unagi sauce"}	1
5162	7297	261	Chicken Pot Pie	4.90	http://eivcfxx.net/ORORnHA.php	{Mushrooms,Sugar,Peas}	3
5163	2064	261	Original burger	2.99	http://ehxzevq.net/PnqhUME.svg	{Chicken}	1
5164	2358	261	Pizza Ocean	3.73	https://dqojvsn.info/aqAvIrV.webp	{Garlic}	4
5166	2281	261	Sweet Potato Pie	5.67	https://hhgfmbg.net/ktsNCuU.js	{"Original sauce",Nori,Grapes}	1
5168	4288	262	New York Style Cheesecake	2.26	https://gxpzgsy.org/qCYQbyQ.html	{Onion}	3
5169	9307	262	New York Style Cheesecake	6.82	https://rnofklh.biz/AAMmkuT.js	{Butter}	4
5170	5976	262	Chicken Pot Pie	5.99	https://www.vanwlyr.biz/fFRAyKb	{Rice,Flour}	4
5171	9566	262	Himawari	2.41	https://hyzecvl.ru/YDKFSZM.php	{Peperoni}	5
5200	8247	262	Tortellini Bowls	3.02	http://jeygfni.biz/XoPBfDr	{Corn}	5
5122	2646	261	Original burger	7.38	http://topiftd.top/NPZAyft.css	{"Caramelized onions"}	2
5201	2411	262	Tortellini Bowls	2.98	http://www.amhmhfk.biz/	{Milk,Nori,Peas}	5
5202	527	262	Wallmart	4.25	http://jgnlkfu.org/KYhxRUd.php	{Peas}	2
5203	3190	262	Peanut Butter	4.93	https://updcmsv.com/YdKEkHW.jpg	{Nori,Potatoes,Mushrooms,"Onion rings",Corn,"Cream cheese"}	4
5204	3504	262	Unagi Philadelphia	6.14	http://www.ygjdsej.top/mMoftIo	{Butter,Mozarella,"Japanese tamago",Mozarella}	3
5205	8942	262	Pizza Hawaiian	6.19	https://zzavhtw.edu/TgdZiXE.jpg	{Onion,"Chili Pepper",Sugar,Onion,Onion,Potatoes}	5
5206	5463	262	Pizza	6.53	https://www.avjxnhe.biz/	{Pasta,"Original sauce",Butter,Onion,"Bavarian sausages","Chili Pepper"}	5
5207	4455	262	Pizza	4.67	https://ljcxdjl.com/OuWYRcG.webp	{Strawberry,Salmon}	3
5123	6537	261	Wallmart	6.02	https://gcuqcad.top/xrPOGNY.jpg	{"Cheese cheddar",Chicken,Peperoni,"Japanese tamago",Sugar}	4
5126	1085	261	Peanut Butter	5.46	https://teovuzm.biz/CUiDeeL.js	{Grapes,"Onion rings",Butter,Basil,Tomatoes,"Chili Pepper"}	1
5127	6108	261	Pizza Florida	2.87	https://www.waikkls.top/rnrQbOB	{Cucumber,Carrots,Mayo}	2
5128	6877	261	New York Style Cheesecake	6.74	https://www.raqxqyl.net/	{Mozarella,Potatoes,Butter,Corn,Mayo,Flour}	4
5129	582	261	Angel Food Cake	7.96	http://kjhxsxh.edu/CcYiYoa.jpg	{"Caramelized onions",Salmon,Mayo,"Cheese cheddar",Mayo,"Bavarian sausages"}	2
5208	8268	262	Pizza Ocean	2.30	https://fjaawer.net/haQCkWt.svg	{"Japanese tamago",Pineapple}	5
5130	6249	261	Peanut Butter	5.11	https://ricvnoc.com/XgJgCJG.svg	{Salmon,Potatoes,Grapes,Strawberry}	2
5219	9659	262	Saint Frank Coffee	7.95	http://www.fcbtwem.edu/	{Milk,"Caramelized onions",Garlic,Mozarella,"Bavarian sausages",Strawberry}	2
5220	372	262	Unagi Philadelphia	7.92	http://www.qguguyk.ru/CwpwBdV	{Chicken,Chicken,Carrots}	2
5221	5666	262	Angel Food Cake	7.68	http://ymjoqdp.org/oqDUJUN.svg	{Meat}	5
5222	7905	262	Sweet Potato Pie	4.80	https://mzishaw.edu/OBKClgN.html	{Flour}	4
5223	3412	262	Himawari	5.81	http://sezwstw.top/Tfvftuq.html	{"Caramelized onions",Peas,Flour,Pineapple,Rice}	1
5224	8489	262	Sweet Potato Pie	5.78	http://dawdfhc.info/hdvvTXB.html	{"Cottage Cheese",Carrots,"Cottage Cheese"}	2
5225	2359	262	Pizza Italiano	4.47	https://igxgwpy.edu/eYgXLxG.html	{Cheese,"Onion rings"}	4
5249	6130	262	Crispy Chicken burger	6.31	http://www.zsvkezm.info/	{Potatoes,Corn,Flour}	5
5250	4607	262	Saint Frank Coffee	4.96	http://qigtmdt.org/DXGjXoR	{Sugar,Salmon,Butter,Flour}	1
5251	9969	262	Pizza Hawaiian	5.25	https://nuuzbrh.edu/YruSKqV.jpg	{Cheese,"Caramelized onions"}	5
5252	9404	262	Saint Frank Coffee	6.18	http://www.zectkzg.top/	{Pasta}	3
5253	9634	262	Bacon Cheese Burger	5.73	https://cvucdja.edu/ZHkiPrB.jpg	{"Cream cheese","Original sauce"}	3
5255	1077	262	Pizza Hawaiian	4.49	http://wbvvees.top/aakdZqp.jpg	{Corn,Mushrooms,Flour,Mushrooms}	3
5174	7568	262	Bacon Cheese Burger	7.50	http://mvosaak.edu/emnDgxb.php	{Pasta,Meat,"Chili Pepper"}	5
5267	1298	263	Philadelphia with salmon	7.41	https://aslugku.net/bAPZGNB.css	{Peperoni,Meat,"Chili Pepper","Cheese cheddar",Peperoni,Basil}	4
5268	9768	263	Wallmart	3.70	http://cvrrirw.info/OxifgTQ.php	{Garlic}	1
5256	7418	262	Peanut Butter	3.96	https://xfgqaxf.top/	{Pasta,Flour}	4
5269	1438	263	Unwrapped Burrito Bowl	2.63	https://whobwmp.top/uOYfDyx.js	{Peperoni,Peperoni,Strawberry}	2
5298	1872	264	Wallmart	3.62	https://gixmplg.org/fgJVHUE.js	{Mushrooms,"Japanese tamago",Strawberry,"Chili Pepper",Peas,Mozarella}	1
5274	5632	263	Original burger	6.73	http://bgnahgp.biz/legaPkC.css	{Mushrooms,Garlic,Mushrooms,Carrots,Carrots,"Original sauce"}	3
5235	3367	262	Chicken Pot Pie	4.93	http://jonwmkd.biz/	{Chicken,"Unagi sauce",Flour,Strawberry}	1
5275	7536	263	Pizza Italiano	6.17	http://vcsbeec.ru/nxjNyBO.jpg	{"Bavarian sausages",Nori,Rice,Flour}	4
5295	3832	264	Tortellini Bowls	4.62	https://iwjknfn.edu/QSgUhHf.html	{Corn,"Cottage Cheese",Salmon,Rice,Meat}	2
5260	6298	262	Tortellini Bowls	6.86	https://vupvktp.ru/nSVwQcH	{Chicken}	5
5238	2279	262	Pizza	7.46	https://www.byfixnt.info/vhpomKK	{Peanuts}	4
5299	1007	264	Saint Frank Coffee	2.68	http://lrorkks.ru/pKkUSWc.webp	{Rice}	3
5272	9848	263	Tortellini Bowls	4.40	http://sfgxdhq.edu/qqMKrWH.webp	{Peperoni,Nori,Pasta,"Original sauce","Onion rings"}	5
5240	2652	262	Sweet Potato Pie	5.47	https://khumkin.info/pIomvlg	{Milk,Salmon,Chicken,Flour,Peperoni,Rice}	3
5233	3751	262	Crispy Chicken burger	7.22	https://adphvbr.com/SHQEPeE.html	{Tomatoes,"Original sauce"}	1
5301	2906	264	Pizza Texas	6.81	https://kdtwbxs.ru/gqbRZFt.webp	{Flour,Meat,Pineapple,Salmon}	5
5245	2298	262	Chicken Pot Pie	5.37	https://czllfqb.ru/dNKasru.jpg	{"Cheese cheddar",Strawberry}	2
5236	9202	262	Wallmart	6.90	http://leqbjln.ru/vUsUrMS.php	{Milk,Nori}	3
5258	652	262	Saint Frank Coffee	3.08	https://aclevdl.com/IHxnjwk.js	{Mozarella}	4
5296	8277	264	Bacon Cheese Burger	2.67	https://euhtidz.top/RBPkCPf	{Corn,Pasta,Carrots}	3
5231	2878	262	Swedish Meatballs	5.51	http://twazmwa.ru/VVCnvhR.svg	{Pasta}	1
5232	120	262	Pizza Florida	7.55	https://umtldvt.biz/pQPkfBs.jpg	{Meat,Rice}	2
5300	163	264	Crispy Chicken burger	3.57	http://www.hdkkxtt.biz/tdBJROw	{Peas}	5
5271	4108	263	Himawari	2.14	https://bjjtadb.org/OZJvxHk.html	{Cucumber,"Caramelized onions",Basil}	2
5237	7560	262	Unagi Philadelphia	3.24	https://mmbsine.com/nvCDVTy.css	{Milk,Tomatoes,Basil,Pasta}	5
5229	2755	262	Peanut Butter	5.85	http://yfokbbk.info/uxSMdsE.css	{Garlic,"Onion rings",Cheese,Garlic,"Caramelized onions"}	1
5230	2780	262	Philadelphia with salmon	7.95	http://sfcvwmb.org/KmUoYVg.php	{"Cheese cheddar",Carrots,Cucumber}	3
5241	9490	262	Bean Green Chili Burritos	5.66	http://nifovuk.net/bBmKcVk	{"Japanese tamago",Pasta}	4
5273	6789	263	Chicken Pot Pie	4.30	https://tddcecf.org/LZHhFEE.php	{"Chili Pepper","Cream cheese",Cheese,Onion,Mushrooms}	2
5242	130	262	Unagi Philadelphia	5.69	https://www.fgxbkac.com/	{"BBQ sauce",Peas,Peperoni,"Bavarian sausages",Peas,"BBQ sauce"}	5
5294	9179	264	Saint Frank Coffee	6.05	https://unuheyi.edu/UncKWyx.html	{"Caramelized onions",Mozarella,Cheese}	4
5276	7605	263	New York Style Cheesecake	3.50	http://hjjnjkb.biz/UeWstdQ.html	{Onion}	3
5265	6973	263	Unwrapped Burrito Bowl	6.56	https://erpmqfr.org/obpwDYS.webp	{Chicken,Peperoni,"Caramelized onions",Rice}	4
5266	2546	263	Original burger	2.59	http://jaxbmik.edu/qdXMWpv.css	{Onion,Pineapple,Grapes,"Cottage Cheese"}	4
5261	533	263	Crispy Chicken burger	2.30	http://ircbukl.biz/AAEyheX.css	{Bacon,Rice}	4
5262	9197	263	Unagi Philadelphia	2.26	https://kwgybyo.top/jqatIaZ.svg	{"Cheese cheddar"}	3
5259	7036	262	Unagi Philadelphia	6.26	http://nbfmrmo.net/tJTFTAP.php	{Peperoni}	1
5263	2945	263	Sweet Potato Pie	4.83	https://wandxmt.biz/LdetRkU.php	{Corn,Mushrooms,"Caramelized onions",Strawberry,Rice,Flour}	4
5264	5654	263	Angel Food Cake	2.18	https://cpscfyc.ru/BWldgOg	{Mayo,Flour,"Cheese cheddar","Cottage Cheese"}	5
5228	8278	262	Pizza	2.83	http://wahgrmr.edu/PtmIblR	{"BBQ sauce",Milk,"Chili Pepper"}	2
5270	3717	263	Unagi Philadelphia	5.17	http://www.oraiwvs.edu/ZIPrgXe	{Butter,Tomatoes}	5
5239	1013	262	Original burger	6.08	http://focnbqi.com/raveGXS.jpg	{"Chili Pepper",Corn,"Caramelized onions",Peanuts}	1
5244	2386	262	Wallmart	3.47	https://xeyayyn.info/QpNXmHe.html	{Peanuts}	4
5243	5779	262	Philadelphia with salmon	2.73	https://www.svunvpi.org/	{Cheese,Butter}	3
5297	9222	264	Pizza Pepperoni with tomatoes	4.23	http://vpachkg.top/CEqWNZm.js	{Cucumber}	1
5303	104	264	Philadelphia with salmon	4.91	http://bitvlpz.top/LZBOYvk.html	{Mushrooms}	3
5281	4292	263	Unwrapped Burrito Bowl	5.07	https://www.mqycafo.top/dCUtWQk	{"Onion rings",Bacon,Basil}	5
5314	6945	264	Pizza Ocean	2.16	https://rtshtvr.top/wPXCFTj.webp	{"Bavarian sausages",Potatoes,"BBQ sauce"}	4
5344	8251	264	Bean Green Chili Burritos	4.13	https://vcnpnvn.info/OvoelsL.css	{Nori,Mushrooms,Meat,Rice,Rice,Mozarella}	4
5346	6482	264	Angel Food Cake	3.65	http://pjsdknm.ru/LkwrYbW.html	{Pineapple,Tomatoes,Tomatoes}	4
5287	2441	263	Bean Green Chili Burritos	7.83	http://owqkmow.net/yTqBCog.webp	{Sugar,Garlic,Tomatoes,Peanuts}	1
5348	8872	264	Himawari	4.59	https://pxlwedh.net/SrXdnHm.svg	{Corn,Peas,Pasta,Corn,Bacon}	4
5289	3299	263	Original burger	7.71	https://www.evcvibs.top/	{Mayo,"Original sauce",Pasta,Grapes}	5
5320	8001	264	Crispy Chicken burger	3.48	http://jrahbsh.info/lFZdoYG.js	{"Cottage Cheese","Unagi sauce",Mayo}	5
5278	4755	263	Unagi Philadelphia	4.68	https://kjhfzax.net/dELgCXG.webp	{Flour,Cucumber,"Cream cheese",Flour,Mayo}	4
5282	279	263	Pizza Florida	3.66	https://www.wlhnyjn.ru/	{"Cream cheese"}	4
5327	470	264	Crispy Chicken burger	3.12	http://cuyvugw.org/ttspmuJ.webp	{Peperoni,"Unagi sauce","Bavarian sausages","Caramelized onions",Corn,Butter}	3
5283	6327	263	Pizza Florida	4.77	https://fnlhffu.top/wQOteZJ.jpg	{Milk,Garlic,Bacon}	5
5285	5007	263	Pizza	2.73	https://exfqipk.edu/TtqUGlf.css	{Mushrooms}	5
5308	903	264	Bacon Cheese Burger	5.21	https://lezjzwg.info/Lcajeoq	{"Original sauce"}	2
5345	3300	264	Unagi Philadelphia	5.52	https://bnfwxgn.com/nVdIfsr.webp	{Chicken,Flour,Sugar}	3
5311	4398	264	Swedish Meatballs	5.32	http://www.tyuuuvx.com/	{"Original sauce",Onion}	4
5347	7962	264	Pizza Florida	6.57	http://www.rdtiens.info/RdMcEIl	{Cucumber,"Cheese cheddar","BBQ sauce",Onion}	1
5312	363	264	Original burger	3.32	https://xbsfaqu.net/iIIEXat	{Pineapple}	3
5290	3932	263	Pizza Hawaiian	5.97	http://imsssvn.net/LbBgkNs.js	{"Caramelized onions",Grapes}	1
5292	2725	264	Swedish Meatballs	5.00	https://vgwadzu.top/JgRXvjE.jpg	{Peperoni,"Original sauce","Cottage Cheese",Milk,Garlic}	5
5280	7381	263	Pizza Ocean	5.71	https://voamont.org/	{Mushrooms,Strawberry,Grapes,Mozarella}	2
5316	2486	264	Peanut Butter	7.16	http://www.pvkzptr.biz/	{"Bavarian sausages",Peanuts,Salmon,Mayo,Cheese,"Japanese tamago"}	4
5318	7408	264	Pizza Ocean	3.35	https://vvgueil.ru/ZdfQpgI.css	{Pineapple,Pineapple,Mayo,"Chili Pepper"}	4
5305	6869	264	Saint Frank Coffee	6.47	http://rlasewn.edu/atUVcBH.jpg	{"Original sauce","Unagi sauce",Rice}	1
5307	6960	264	Pizza Ocean	3.12	http://axwndjk.biz/GstDwir.html	{"Cream cheese","Unagi sauce",Potatoes}	2
5284	3052	263	Unagi Philadelphia	7.86	https://adyokha.org/JRPFfKZ	{Mushrooms,Grapes}	1
5309	3019	264	Unagi Philadelphia	6.97	https://www.ylbulrr.org/KgoWPBc	{Pineapple,Bacon}	4
5286	8532	263	Pizza	3.16	http://tfgqtpl.info/KVFBNAu.html	{Tomatoes,"BBQ sauce",Sugar,"BBQ sauce","Onion rings",Butter}	1
5323	6821	264	Pizza Ocean	6.79	http://fqzsvmd.edu/FKGcCdK.jpg	{"Bavarian sausages"}	4
5288	1770	263	Unagi Philadelphia	5.24	http://fovhgsg.ru/gyLaYKs.css	{Tomatoes,Sugar,Corn,Mayo,Flour}	5
5313	9130	264	Wallmart	5.48	http://www.jxhqvpo.org/	{Mushrooms}	1
5315	8017	264	Tortellini Bowls	2.57	http://www.obxgnbr.net/	{Cucumber,Flour}	3
5293	8834	264	Peanut Butter	4.91	https://fnnlztf.com/VpWJNCO.css	{Potatoes,Basil,Peas}	1
5317	5902	264	Pizza Texas	3.52	http://mtnuvqm.com/IVXMuoR.webp	{Cheese,Garlic,Nori,Rice,Potatoes}	2
5306	7129	264	Unwrapped Burrito Bowl	2.58	http://dwbmfna.com/KpjmtAn.php	{Mushrooms,"Bavarian sausages","Cottage Cheese","Caramelized onions",Peperoni,Cheese}	5
5319	6935	264	Tortellini Bowls	5.25	https://wtwnnjr.info/rPvckKa	{"Caramelized onions",Pineapple,Basil}	4
5321	5958	264	Pizza Italiano	6.75	http://odckisr.org/GyGpLej.svg	{Basil}	2
5322	8540	264	Bacon Cheese Burger	3.89	https://www.mgujmai.biz/DxEUyQv	{"Original sauce"}	3
5310	6180	264	Peanut Butter	2.23	https://qnwaeps.org/jZrbaQT.webp	{"Cheese cheddar",Strawberry,Rice,Meat,Carrots,Milk}	2
5325	3682	264	Pizza	2.24	http://nujdgif.com/QldnaSe	{Flour,"Caramelized onions","Onion rings",Onion}	1
5342	5628	264	Pizza Florida	2.78	https://poymsrw.ru/KSrQDXx.webp	{Pasta}	4
5343	2563	264	Wallmart	6.92	https://tlvbddq.info/onaibKZ.html	{"Bavarian sausages",Meat,"BBQ sauce",Onion,Pasta,Carrots}	1
5365	4072	264	Philadelphia with salmon	3.24	https://fihlrsr.ru/jFbZGyB.php	{Rice,"Cottage Cheese",Mushrooms,Peas,Peperoni,Mozarella}	1
5393	1456	237	Pizza	4.64	https://aowmogt.ru/bUKVKcH.jpg	{"Cream cheese",Bacon,Mushrooms}	1
5338	3414	264	Sweet Potato Pie	5.40	https://gdoyoxs.info/JcMejTr.jpg	{"Chili Pepper"}	5
5330	5990	264	Pizza Texas	6.45	http://ckyfqxf.com/fkaVFDw.php	{Mushrooms,Cucumber,Mozarella,Sugar,Peperoni}	2
5333	2795	264	Angel Food Cake	2.97	http://www.bootpsl.net/llQQuLT	{"Bavarian sausages",Mushrooms,Pasta}	3
5389	1089	237	Bacon Cheese Burger	5.58	http://fpspckq.org/EOVRJtP.html	{Cheese,Peas}	5
5375	4260	264	Crispy Chicken burger	6.21	https://ohyeamm.org/BEEGLpA.html	{Mushrooms,"Caramelized onions","Cheese cheddar"}	3
5373	59	264	Saint Frank Coffee	2.92	https://tbvdlzh.info/qaPaRCN.css	{Milk,Peperoni}	4
5334	9064	264	Chicken Pot Pie	2.72	http://www.yueuyew.info/IEOcpdu	{Milk,"Bavarian sausages"}	2
5329	3028	264	Pizza	2.88	https://cpswtti.net/	{Cheese,"Bavarian sausages","Japanese tamago",Strawberry}	3
5427	4352	238	Himawari	5.13	https://www.vedhhoo.info/LbrBUZW	{Butter,"Cheese cheddar","Cheese cheddar",Grapes}	1
5332	4213	264	Peanut Butter	2.95	http://xprndus.org/GIEWsCo.html	{"Chili Pepper",Meat}	1
5336	6099	264	Original burger	5.95	http://www.ycdnymp.info/	{"Chili Pepper","Onion rings",Tomatoes}	1
5358	9816	264	Tortellini Bowls	3.55	https://oktfkrn.edu/PplLXkV.jpg	{Mayo,Salmon,Pineapple,Cucumber}	5
5352	4926	264	Pizza Ocean	5.59	http://qzrytif.top/	{"BBQ sauce",Onion,Garlic,Mayo,Peanuts}	4
5353	8362	264	Pizza Florida	5.76	http://sqoutpl.net/	{"Unagi sauce"}	3
5363	713	264	Grape Jelly Sandwich	5.86	http://ijakgwv.info/dVcrdWf.js	{Onion,Cheese,"Cream cheese",Salmon}	4
5335	2661	264	Pizza Ocean	5.75	http://www.bbauhly.top/nwGSVcE	{Corn,Garlic,Pasta,"Cottage Cheese","Cream cheese",Sugar}	2
5391	7312	237	Chicken Pot Pie	6.26	http://prmymid.com/UQnRwPq.jpg	{Carrots,Mayo}	3
5339	4113	264	Philadelphia with salmon	7.68	https://www.qskueim.biz/	{Peanuts,"Cream cheese","Chili Pepper",Rice}	2
5331	8739	264	Bacon Cheese Burger	6.90	https://bmihbst.biz/iZbxhsL.html	{"Bavarian sausages",Mayo,Rice,Flour}	3
5360	8528	264	Wallmart	4.39	https://bgmpqvy.edu/ZEkvPlv.jpg	{"Cheese cheddar"}	5
5390	7868	237	Original burger	4.30	http://cyjhkxd.net/cJuGiWF.svg	{Salmon,Rice,Pineapple,Nori}	3
5354	3231	264	Swedish Meatballs	6.40	http://cjeoiro.biz/KYNZrsB.html	{Chicken,"Bavarian sausages",Butter,"Unagi sauce",Carrots,Onion}	5
5374	9752	264	Angel Food Cake	6.82	https://vehqhen.edu/QcBvhCs.css	{Mozarella,"Caramelized onions"}	4
5392	69	237	Peanut Butter	6.67	https://meekjbw.top/wPHHRKp.jpg	{"Unagi sauce",Basil}	5
5355	9151	264	Peanut Butter	6.69	https://gdrgfde.edu/kGMptSk.svg	{Mushrooms}	2
5337	7887	264	Pizza Florida	5.36	http://llohcok.info/gvnWsOG.jpg	{Corn}	5
5368	6634	264	Tortellini Bowls	3.21	https://www.oeytskx.ru/	{Mushrooms,Peperoni,Meat,"Cheese cheddar",Grapes}	2
5377	2626	264	Saint Frank Coffee	4.77	http://www.sfkvomo.net/cQZdjRx	{Milk,Nori,Peas,Bacon,Mushrooms}	1
5372	5033	264	Pizza Italiano	6.57	http://ecjwubs.ru/cCSkCvK.jpg	{Peperoni,Meat,Peas,Meat,"Bavarian sausages",Rice}	5
5359	3992	264	Pizza Italiano	2.09	http://www.jgghapj.net/seZBLsV	{"Original sauce",Sugar,Pasta}	1
5376	9187	264	Saint Frank Coffee	2.18	http://mgeetoy.net/MLqXWbB.css	{"Unagi sauce"}	3
5356	3018	264	Wallmart	5.19	https://www.mjupndi.biz/dBPXfqB	{"Onion rings",Peperoni,Butter,Meat}	5
5388	8967	237	Bacon Cheese Burger	3.40	http://www.fslvofy.edu/	{Potatoes}	1
5367	8342	264	Tortellini Bowls	4.08	http://www.zdvcfcj.org/SjVrsmm	{Bacon,"Cottage Cheese",Chicken,Rice,Grapes}	2
5361	2270	264	Peanut Butter	7.81	http://ganveof.top/JNacBdk.css	{"Japanese tamago",Mayo,Mozarella,Mushrooms,"Japanese tamago"}	2
5350	6014	264	Pizza Florida	7.05	https://hsehawf.com/NHrFUVQ	{Peperoni}	4
5371	2859	264	Philadelphia with salmon	7.98	http://qqwrrhl.ru/	{"Onion rings",Strawberry,Nori}	3
5357	5529	264	New York Style Cheesecake	2.13	https://jabgddp.net/SqyAmJt.css	{"Bavarian sausages"}	5
5366	9145	264	Unagi Philadelphia	3.20	http://www.dzjtfav.info/	{"BBQ sauce",Peas}	4
5370	8952	264	Pizza Texas	7.00	https://www.lodursn.top/UdLMqMp	{Mozarella,Carrots}	4
5378	1	1	Pizza Pepperoni with tomatoes	2.87	https://roll-club.kh.ua/wp-content/uploads/2021/04/okean-1.jpg.webp	{Mozarella,Peperoni,Tomatoes,"BBQ sauce"}	4
5364	2108	264	Bean Green Chili Burritos	4.82	http://www.swmjveu.com/	{"Cottage Cheese",Mushrooms,Pineapple,"Onion rings"}	2
5419	4266	238	Angel Food Cake	7.45	http://ggfihgm.ru/	{"BBQ sauce",Peanuts,"Cottage Cheese","Onion rings",Cheese}	4
5410	4583	238	Unwrapped Burrito Bowl	7.42	https://dtfhjek.net/tOJiwow.css	{Pasta,"BBQ sauce",Milk}	4
5416	8773	238	Bean Green Chili Burritos	2.18	http://ipwxxfd.net/	{Corn,"Cottage Cheese",Salmon}	5
5401	3078	237	Saint Frank Coffee	5.88	https://lsxaiil.top/KxNKkao.js	{Pineapple}	5
5424	6594	238	Bacon Cheese Burger	2.90	http://lahxhef.biz/UHnkBIx.html	{Tomatoes,Tomatoes,"Bavarian sausages",Milk}	3
5420	7239	238	Grape Jelly Sandwich	4.43	https://www.crpoqvj.net/	{Milk,Pineapple,"Cream cheese"}	2
5407	6863	237	Peanut Butter	2.69	http://gmxvstb.net/rZQZxFu.jpg	{"Onion rings",Onion,Peanuts}	3
5384	2461	237	Bean Green Chili Burritos	5.91	https://dclpuwq.edu/LxfHGSf.webp	{"Unagi sauce",Potatoes,"Japanese tamago"}	4
424	5469	213	Pizza	2.73	http://gfskwfb.top/RUQSuBG.webp	{Peanuts,"Caramelized onions",Flour,Milk,"Caramelized onions",Flour}	3
5399	312	237	Angel Food Cake	4.89	http://roqsrxh.info/IcVVWSl.jpg	{Rice,"Onion rings","Cheese cheddar","Original sauce","Cream cheese",Carrots}	5
5421	9751	238	Unagi Philadelphia	7.06	http://olvzoqb.org/OjsBudb.svg	{Meat}	4
5413	7765	238	Saint Frank Coffee	2.41	http://nrvjtno.ru/BvGwwKp.css	{Strawberry,"Bavarian sausages",Bacon,Cucumber}	1
5426	87	238	Himawari	4.58	https://ekknmes.biz/eEoePGj.html	{Salmon,Sugar,Pineapple,"Caramelized onions"}	4
5404	3960	237	Original burger	3.03	http://navaqkv.org/	{Cucumber,Tomatoes,"Unagi sauce"}	5
5402	8910	237	Wallmart	5.74	https://mphaidx.net/XcFvwSJ.html	{Carrots,Mushrooms}	5
5383	18	6	Peanut Butter & Grape Jelly Sandwich	7.41	https://i5.walmartimages.com/asr/f490a06c-4ea2-41f5-9151-a05449e93e43.64a407ec5ca286d97dd37cdede9f51fc.jpeg	{Flour,Peanuts,Grapes}	6
5386	3816	237	Pizza Ocean	6.92	https://zumoiih.edu/sVhascp.html	{Mozarella,Strawberry}	5
340	107	211	Pizza Texas	4.50	http://www.bnagsxn.com/YjeEITZ	{Flour,Rice,"Unagi sauce",Flour}	1
5423	56	238	Sweet Potato Pie	4.16	http://ncafkun.top/NwBkHVf.php	{"Japanese tamago",Cheese,Potatoes}	1
5411	9321	238	Himawari	3.04	http://dsixiut.edu/XMsGiqg.jpg	{Sugar,Meat,"Cheese cheddar"}	1
386	5897	213	Bacon Cheese Burger	2.73	https://tdmqwgw.org/MWJiygL	{"Original sauce",Strawberry,"Unagi sauce"}	3
5408	2939	237	Pizza Pepperoni with tomatoes	3.74	https://fonncda.ru/NhonvKN.html	{Peanuts,Mozarella,Flour,Milk,"Chili Pepper"}	5
5398	3470	237	New York Style Cheesecake	2.31	https://zoiujkr.ru/Nfeahwq.jpg	{"Onion rings",Carrots,Mushrooms,Peanuts,"Cheese cheddar",Mushrooms}	5
5414	8156	238	Peanut Butter	7.53	http://kxejclb.net/FOboJJS.svg	{"Chili Pepper","Japanese tamago",Mozarella,Pasta}	2
5397	9009	237	Pizza	4.40	https://jqkjjzx.net/mPWSnUO.webp	{Milk,Peas,"Cottage Cheese",Peanuts}	1
431	6442	213	Pizza Texas	5.50	http://iwcihnh.net/aLmFdpe	{Sugar,Pineapple}	1
5380	3	1	Pizza Hawaiian	5.58	https://roll-club.kh.ua/wp-content/uploads/2021/04/rostbif-v-tunce-1.jpg.webp	{Chicken,Pineapple,Mozarella}	4
5405	8254	237	Philadelphia with salmon	2.12	https://nirywza.biz/gsMDeRF.php	{Peas,Cheese,Grapes,Milk,"BBQ sauce",Mushrooms}	4
388	9940	213	Tortellini Bowls	2.44	https://asreajz.biz/eGIDKfX.jpg	{"BBQ sauce",Garlic,"Cheese cheddar"}	5
5412	505	238	Grape Jelly Sandwich	7.89	http://exsjyqk.net/BcXLJjW.jpg	{Carrots,Strawberry,Mozarella,"Cheese cheddar"}	5
5418	308	238	Pizza Florida	4.80	https://www.tlemkxg.net/ROoTGGQ	{"Chili Pepper",Grapes}	3
5415	6936	238	Himawari	2.37	https://www.xolxskp.org/	{Flour,Chicken,Carrots,Flour,Strawberry}	2
5385	9011	237	Pizza Ocean	3.32	https://akhyyng.org/hUwTpur.html	{Bacon,Salmon,Pasta,Peas,Nori}	4
5403	7240	237	Swedish Meatballs	2.07	https://apfhwbc.biz/ihJISNZ	{"Chili Pepper",Cheese,Flour,"Unagi sauce"}	3
5422	9066	238	Peanut Butter	3.83	http://jhoafvj.info/rjvXkNU.webp	{"Onion rings","Unagi sauce",Mushrooms,Salmon,Bacon}	4
5396	2799	237	New York Style Cheesecake	5.92	http://rgtkmku.com/	{"Cream cheese",Sugar,"Cheese cheddar"}	2
5400	6648	237	Bean Green Chili Burritos	5.83	http://zbdicju.ru/EmaKHMx.jpg	{Sugar,Sugar,"Japanese tamago",Tomatoes,Salmon,Pasta}	4
5409	1563	237	Pizza Italiano	6.33	http://aepkwuq.biz/mqCEtBA.webp	{Sugar,Nori}	4
5417	5744	238	Tortellini Bowls	5.73	https://nmgekwn.biz/egyDJNi.css	{"Cream cheese","Onion rings",Mushrooms,Peanuts,Flour}	1
5425	1239	238	Sweet Potato Pie	7.90	http://vbldabx.edu/NYyagDv.html	{Corn,Butter,Peas,"Cottage Cheese"}	5
342	5835	211	Philadelphia with salmon	5.86	https://ncsmocl.edu/oOkOMpS.html	{Mayo,Bacon,Bacon,Onion,"Bavarian sausages",Pineapple}	2
1162	9334	226	Bacon Cheese Burger	6.92	http://www.mmekwyn.net/SYpOTVw	{Cheese,Milk,Mozarella,"Cheese cheddar"}	4
1381	4802	232	Sweet Potato Pie	5.42	http://vdngfbr.info/lZIbawf.svg	{"Cottage Cheese",Peanuts,Peas,Mushrooms,Peperoni}	4
479	3193	214	Philadelphia with salmon	3.98	http://hcrxici.edu/ZTevvdJ.js	{Grapes,Onion,Flour,Corn,Grapes,Basil}	5
1314	3510	230	Unwrapped Burrito Bowl	4.60	http://mohnavz.org/SHLcBNL.js	{Cheese,Onion,Mozarella,Chicken,Tomatoes}	4
569	3634	216	Chicken Pot Pie	7.54	http://ioijyvs.org/nsFvJne	{Butter,Rice}	3
851	9240	220	Chicken Pot Pie	7.34	http://www.ntskxoe.net/	{"Caramelized onions","Cottage Cheese","Cheese cheddar","Japanese tamago",Mayo,Potatoes}	3
709	6502	218	Original burger	2.16	http://poqnoac.com/YvvJOmv.svg	{Peanuts,Basil,Potatoes,Nori}	5
970	8927	223	Saint Frank Coffee	6.23	https://krgivyk.org/PgbvOrs.js	{Cheese,Mozarella,Rice,Milk,"BBQ sauce",Meat}	1
945	9948	222	New York Style Cheesecake	3.70	https://kafjtav.edu/ZjstuSr.css	{Chicken}	2
525	249	215	Crispy Chicken burger	5.76	https://www.taicrqt.info/	{"Cheese cheddar","Cottage Cheese",Bacon,Onion,"Unagi sauce",Butter}	4
1130	8435	226	Original burger	7.78	https://edontic.net/KKpWbqN.svg	{Peas,Mayo,Chicken,Tomatoes,Mayo,Milk}	4
1269	7422	229	Angel Food Cake	4.07	http://jgyokld.edu/AJtiUaW.css	{"Cream cheese",Rice,Grapes,Peanuts}	5
1360	5036	231	Pizza Florida	6.48	https://yjqoive.biz/ajKVwjK.css	{Cucumber,Peperoni,Cheese,Sugar}	2
1119	1701	226	Himawari	5.92	http://jfomgio.info/NntkcCH.js	{Cucumber,"Unagi sauce",Carrots,Carrots,Mushrooms}	3
1177	7303	227	Unwrapped Burrito Bowl	7.89	http://ojgocte.top/WBfLamc.css	{Garlic}	4
811	4821	219	New York Style Cheesecake	3.19	https://www.qvfqrji.net/iwSTLXT	{Mozarella,Garlic,"Cottage Cheese"}	2
1255	671	229	Pizza Ocean	3.96	http://duxwaiy.net/iPGmxOr.css	{Potatoes,"Unagi sauce",Carrots,Rice,"Japanese tamago"}	1
273	1221	210	New York Style Cheesecake	6.99	https://www.wmygbxg.com/FiSJBhP	{"Japanese tamago",Chicken,Peanuts,"Caramelized onions","Bavarian sausages",Strawberry}	3
1084	6063	225	Bean Green Chili Burritos	2.07	http://bgbbwdr.info/JJLkCjg.js	{"Bavarian sausages",Corn,"Caramelized onions"}	5
673	6470	217	Pizza Ocean	7.37	https://dustrjn.net/WxkSuCg.js	{Mozarella,Mushrooms,Butter,"Cheese cheddar"}	2
803	4733	219	Original burger	3.15	https://ylcugfn.info/FdCjUKv	{"Original sauce",Mushrooms}	2
615	6650	217	Himawari	4.36	https://hbdlvfe.com/rWdEHsF.js	{"BBQ sauce",Peperoni,Peanuts,Garlic,Sugar}	5
293	6110	211	Wallmart	2.68	https://www.nvlqxip.info/vDLWoBA	{Chicken}	5
643	2211	217	Tortellini Bowls	6.27	http://ucyxqxw.net/oYApWhf.php	{Tomatoes,Salmon,Grapes,"Chili Pepper"}	4
517	6238	215	Unwrapped Burrito Bowl	6.66	https://deqnutg.ru/SVuWXxX.jpg	{"Original sauce","Caramelized onions","Japanese tamago",Onion,Corn,"Unagi sauce"}	5
1223	2910	228	Grape Jelly Sandwich	7.19	https://odcrjvn.net/CHXgOjW.svg	{Mushrooms,Mozarella,"Japanese tamago"}	5
523	8562	215	Himawari	5.43	http://snzywwg.edu/ltlggED	{Cucumber,Flour,Flour}	4
571	7934	216	Philadelphia with salmon	6.42	https://haodwez.com/eBogoYD.js	{"Cheese cheddar",Basil,Peperoni}	2
757	4004	218	Saint Frank Coffee	2.01	https://kkqiwkv.top/foGCysn.html	{"Unagi sauce"}	4
992	8620	223	Grape Jelly Sandwich	2.17	http://exsbmof.ru/MIYQAtQ.svg	{"Caramelized onions","Original sauce",Pasta}	1
898	4446	222	Original burger	3.86	https://emoaeyb.edu/orCcfMi	{Potatoes,"Japanese tamago",Grapes,Mozarella,"Original sauce",Cucumber}	4
768	5169	219	Crispy Chicken burger	7.86	https://www.gdhegjk.info/	{Chicken,"Caramelized onions",Mayo,"Caramelized onions"}	4
604	4250	217	Grape Jelly Sandwich	5.39	https://fkqxdoa.com/	{"Onion rings",Onion,"Cream cheese",Mushrooms,"BBQ sauce"}	3
1037	3895	224	Crispy Chicken burger	4.28	http://xjukuuh.net/daiWAYg.js	{Sugar}	2
477	873	214	Bacon Cheese Burger	3.99	http://fmdkfbu.top/VaUaGkQ.js	{Tomatoes,Grapes,Corn,"Cream cheese"}	1
663	191	217	Unwrapped Burrito Bowl	2.19	http://yyfahzy.top/dfFquNx.css	{Mushrooms,Tomatoes,"Cheese cheddar",Milk,Carrots}	5
2273	7010	158	Pizza Pepperoni with tomatoes	2.83	http://teqdwjk.net/uruBlvo	{Bacon,"Cheese cheddar",Carrots,Grapes}	5
1011	8474	223	Grape Jelly Sandwich	2.28	http://dbhsiiv.info/FVnJImk	{Mushrooms,Chicken,"BBQ sauce",Potatoes,Onion}	3
711	7869	218	Bacon Cheese Burger	3.33	https://aobfjeb.edu/FKIDtEx.css	{"Caramelized onions","Cheese cheddar","Japanese tamago"}	4
248	9353	210	Saint Frank Coffee	2.02	https://ldhflhn.org/MNomfSX.html	{Basil,Basil,Carrots,Pineapple,Garlic,Rice}	4
1913	7134	153	Swedish Meatballs	5.33	https://xutovpg.info/dChKHhq.jpg	{Sugar,"Japanese tamago","Original sauce",Chicken}	1
1497	760	233	Sweet Potato Pie	4.32	https://rzoqfjn.top/OtWjbjB.svg	{"Cottage Cheese",Chicken,"Japanese tamago"}	1
1725	6561	8	Pizza Pepperoni with tomatoes	6.36	https://dervwir.info/jRHHtJT.js	{Meat}	1
2097	6457	155	Swedish Meatballs	6.66	http://nnrwkwj.org/UFBOcto.js	{Peperoni,Chicken,"Unagi sauce",Cheese,"Caramelized onions",Nori}	5
2005	9545	154	Unwrapped Burrito Bowl	2.48	https://lpwyukg.edu/KNivCfY.html	{Peas,Pasta,Meat}	1
2143	4605	155	Tortellini Bowls	7.45	https://qrtalye.net/EQEZymQ	{Flour,Nori,"Japanese tamago"}	4
1793	3476	9	New York Style Cheesecake	4.89	https://dswrwgf.info/	{Rice,Potatoes,Pineapple,"Onion rings","Cream cheese"}	2
2364	3639	159	Sweet Potato Pie	7.58	http://whhntwv.org/HGfniMJ.jpg	{"Cream cheese",Cheese,Tomatoes,"Onion rings",Salmon}	2
1629	3187	236	Unwrapped Burrito Bowl	5.21	https://uhpbupd.biz/iQYTGuT.svg	{"Cheese cheddar",Rice,"Cream cheese","Unagi sauce",Pineapple,Butter}	1
1772	3865	9	Chicken Pot Pie	4.71	http://wxatvxk.edu/SmWeXxB.webp	{Pasta,Pineapple,Flour,Peas,"Japanese tamago"}	4
1866	9380	151	Original burger	2.69	https://ampnihf.info/HOOsrRl.webp	{Grapes,Corn}	3
1590	5069	235	Angel Food Cake	7.70	http://vspahuu.net/gScfrCq	{Mayo,"Chili Pepper","Chili Pepper"}	3
2190	746	156	Wallmart	7.60	http://chwehua.edu/XfBxrqC.jpg	{"Cottage Cheese",Milk,"Cottage Cheese","Cream cheese",Potatoes,Chicken}	5
1726	7795	8	Pizza Texas	7.45	https://paiximj.info/XBvrhva.css	{Pasta,"Caramelized onions",Chicken,"Bavarian sausages",Onion,Garlic}	2
1832	9984	10	Sweet Potato Pie	4.93	http://www.cowmauo.org/	{"Caramelized onions",Strawberry,"Caramelized onions",Peperoni,Garlic,Salmon}	2
1958	9527	153	Swedish Meatballs	5.62	https://pgbvitg.net/qJoUnii.svg	{Grapes,Tomatoes}	3
1639	2095	236	Bacon Cheese Burger	7.95	https://juwtpbp.biz/Mdickmv.js	{"BBQ sauce",Pasta,Grapes,Flour,Bacon}	4
3233	6663	193	Pizza Florida	4.77	https://www.winkyky.top/	{"Cream cheese",Mozarella,Bacon,Peas,Peperoni,Corn}	4
2294	6981	158	Sweet Potato Pie	6.45	https://avjgvkm.ru/QFFGQMZ.webp	{Peanuts,Tomatoes,Garlic,Mushrooms,"Cheese cheddar",Sugar}	4
1461	8997	233	Original burger	5.62	https://wrkndvv.ru/oZiuMgq.webp	{Rice,Nori,Mayo,"Chili Pepper","Cream cheese"}	5
2199	6294	156	Saint Frank Coffee	5.66	http://jpqomfi.biz/ZWiAxkL.svg	{Sugar,"Chili Pepper","Chili Pepper","BBQ sauce",Flour,Carrots}	1
1518	444	235	Unwrapped Burrito Bowl	2.48	https://fbifoad.edu/aPHWNig.js	{"Cottage Cheese",Mushrooms,"Chili Pepper","Caramelized onions","Chili Pepper","Cheese cheddar"}	5
2112	5937	155	Chicken Pot Pie	3.56	http://itqjsdr.biz/TDMXDFK.js	{"Cream cheese",Mozarella,Chicken,"Bavarian sausages","Unagi sauce"}	3
1912	4653	153	Bacon Cheese Burger	2.56	http://sqoxjxd.net/KPwaPYt.php	{"Caramelized onions"}	3
3171	7102	192	Tortellini Bowls	2.46	https://qobywhu.com/YWtTryu.css	{Pineapple,Cucumber,Garlic,"Cottage Cheese","Cottage Cheese",Peas}	3
3256	2061	193	Pizza Ocean	5.13	https://rihpcwt.com/diQfaZc	{Peas,Salmon,Butter,Bacon,Mushrooms,"Japanese tamago"}	1
2284	8977	158	Pizza Pepperoni with tomatoes	2.38	https://btdmpdb.biz/aLvhapb	{Butter,"Cheese cheddar","BBQ sauce",Nori,Sugar}	5
1684	3715	236	Pizza Italiano	3.35	https://bxzkkvm.com/LVGZBSq.webp	{Mushrooms}	3
1974	6305	154	Bacon Cheese Burger	3.51	http://wnduxld.top/RXAmcAG.webp	{Flour,Sugar,Potatoes,"Cottage Cheese","BBQ sauce"}	2
2144	9390	155	Pizza Pepperoni with tomatoes	4.62	http://rlgoamg.info/GLRunnE.webp	{Potatoes,Cheese,Peanuts,"Caramelized onions",Mozarella,Chicken}	5
2056	689	154	Unagi Philadelphia	3.34	http://kqkxhda.org/oARyCKa.html	{Chicken,Flour,"Onion rings","Unagi sauce",Salmon}	5
1637	4727	236	Angel Food Cake	4.83	http://cmudhqm.biz/eQIEEkI.jpg	{"Japanese tamago"}	3
2050	2101	154	Peanut Butter	6.30	https://www.wtibjog.top/	{Flour,Cheese,Pineapple,Pineapple,Grapes,Bacon}	2
1591	3235	235	Pizza Ocean	2.40	http://voggqlu.org/nHIZWUD.html	{Salmon,Meat,Mayo,Nori,Mushrooms,"Cream cheese"}	1
1821	3598	10	Pizza Texas	2.85	https://aetobys.org/WhfXAWb.css	{Rice,Onion,"Unagi sauce","Chili Pepper","Cottage Cheese","Japanese tamago"}	2
1885	8674	152	Pizza Italiano	3.37	http://hhmtiwj.biz/TxtFipB.js	{Pineapple,"BBQ sauce",Rice,Butter,Mozarella,Pineapple}	3
1559	8088	235	Bacon Cheese Burger	7.22	https://uvbcovg.ru/NjaEUnB.css	{Pasta,Corn,"Cottage Cheese",Garlic,Onion,Strawberry}	4
3210	3550	193	Sweet Potato Pie	7.61	http://cadmimk.net/HKGxTwn.html	{Sugar,Onion,"Japanese tamago",Onion,Salmon,"Bavarian sausages"}	1
3381	2973	198	Pizza Pepperoni with tomatoes	5.25	http://fsmhaet.edu/ikrctYU.svg	{"Japanese tamago",Corn,Carrots,Chicken}	5
3046	5474	190	Bean Green Chili Burritos	4.08	http://vlgqgko.com/dvcImAt.svg	{Carrots,Peanuts,Carrots,Strawberry,"Japanese tamago","Original sauce"}	4
2956	4786	188	Peanut Butter	7.41	https://yvgnmev.edu/YdDBoAG.php	{Pineapple,Milk,Sugar,Chicken,Bacon,Rice}	3
2376	3461	159	Unagi Philadelphia	2.60	https://iiyffrq.info/vgjxSZd.webp	{Meat,"BBQ sauce",Peanuts,"Bavarian sausages","Original sauce"}	3
3117	5220	190	Grape Jelly Sandwich	7.95	http://xwgfcsa.info/cKDBpaR.jpg	{Sugar,"Cheese cheddar",Salmon,Bacon,Grapes,Tomatoes}	5
3000	2091	189	Bacon Cheese Burger	4.50	http://laekins.top/VEfJYKM.js	{"Cottage Cheese","Bavarian sausages","Original sauce",Butter,Butter,"Japanese tamago"}	1
2467	3970	181	Pizza Florida	3.11	https://cqqvzbz.ru/FGybaav	{"Unagi sauce",Mushrooms,"Onion rings"}	4
3026	2349	189	Unagi Philadelphia	5.70	https://www.rrcehvd.biz/VCXXOfi	{Meat,Flour}	5
2698	2050	184	Tortellini Bowls	3.22	http://vetepbi.top/MKVoLbx.svg	{Strawberry}	5
2792	9212	185	Chicken Pot Pie	2.15	http://www.fiwwxva.biz/	{Onion,"Bavarian sausages",Mushrooms,Flour,Basil}	1
4139	8886	243	Unagi Philadelphia	3.09	https://swigurh.ru/QBIvTAX.php	{Mushrooms,Peas}	3
2835	2334	186	Sweet Potato Pie	7.24	http://krcunst.edu/UhlNrRi.svg	{"Cheese cheddar",Mushrooms,Tomatoes,"Cottage Cheese"}	5
3341	7696	196	Philadelphia with salmon	2.77	https://xachhtp.com/nBitnMQ.svg	{"Caramelized onions","Bavarian sausages","Onion rings",Peas,Grapes,Milk}	3
2932	9514	188	Unagi Philadelphia	4.57	https://www.miepmgx.info/GfItlYs	{Cucumber,Corn,"Unagi sauce",Chicken}	3
2514	9112	182	Pizza	6.12	https://avmdmtr.org/eJotijm.js	{"Chili Pepper",Bacon,Carrots,"Onion rings",Garlic}	2
3082	1554	190	Tortellini Bowls	7.97	https://yhsqlmg.edu/HPQDiaT.css	{Strawberry,Grapes,"Japanese tamago","Chili Pepper","BBQ sauce"}	5
3163	3010	192	Peanut Butter	7.57	http://qpbuvhm.org/YrNNOKo.webp	{Butter,"Caramelized onions","Onion rings",Strawberry,Onion}	5
2450	1854	181	Chicken Pot Pie	6.61	https://inkbnii.com/xBvRBcs.css	{Rice,"Caramelized onions",Carrots,Pineapple,"Caramelized onions"}	4
3398	7943	199	Pizza	4.05	https://www.dnmyttl.com/TjPkkUr	{"Original sauce",Pasta,"Chili Pepper","Caramelized onions",Pineapple}	4
2717	3215	184	Swedish Meatballs	5.87	http://www.ymuqaet.ru/dvOwtAJ	{Mozarella,Mozarella,Butter,"Original sauce",Flour,Sugar}	5
2977	415	188	Pizza Hawaiian	3.06	https://ngfimpd.biz/GWQkApS.css	{Bacon,Flour,Milk}	3
2518	3467	182	Unwrapped Burrito Bowl	3.05	https://www.fxfrrrq.biz/	{"Bavarian sausages","BBQ sauce",Basil,"Cottage Cheese","Chili Pepper"}	3
2484	3256	181	Unagi Philadelphia	7.69	https://cppectm.org/KACxiYS.html	{"Onion rings","Cheese cheddar",Mozarella,"Cottage Cheese",Pasta}	5
3304	5457	195	Saint Frank Coffee	2.07	http://jerxago.net/YpyFHpn.svg	{Salmon,"Cottage Cheese",Mayo,Garlic,Mozarella}	5
3351	4019	198	Angel Food Cake	2.47	http://www.nwmemov.edu/	{Flour,"Onion rings","Cottage Cheese","Cottage Cheese",Strawberry}	1
2560	4647	182	Angel Food Cake	3.38	http://www.pwrgetf.net/rytTNfC	{Flour,Sugar}	5
4110	8644	243	Pizza Pepperoni with tomatoes	6.74	https://bnocawu.top/jtBqclC.css	{Bacon,Cucumber,"Cheese cheddar","Caramelized onions",Cucumber,"Japanese tamago"}	1
2838	7629	186	Bean Green Chili Burritos	5.99	https://mvjylgp.biz/kBxhBRI.js	{Sugar,Corn,Mushrooms,Sugar,Milk}	3
2747	3407	185	Bean Green Chili Burritos	7.34	https://www.tucmltg.biz/	{Nori,Sugar,Tomatoes,Onion,Flour}	4
2901	6260	187	Pizza Pepperoni with tomatoes	6.22	http://hszeuny.info/PQIAraU.php	{Cheese,"Cream cheese",Basil,Peperoni}	2
3072	8963	190	Sweet Potato Pie	6.48	http://hdrpfit.net/bTOSwsi.js	{"Bavarian sausages",Carrots,Pasta,Pasta,Rice}	5
3025	5581	189	Pizza Italiano	7.28	https://ebrdiml.ru/XIuHKQy.css	{Salmon}	2
2583	4231	183	Saint Frank Coffee	2.77	https://mlcqenm.com/sSnrkxC.css	{Tomatoes,Salmon,Salmon,Grapes,Mushrooms,Rice}	4
2743	7158	185	Bacon Cheese Burger	7.50	https://fqqmfrd.top/ljPODFk.js	{Pineapple,"Cheese cheddar"}	5
2885	4453	187	Peanut Butter	4.83	https://jsqboql.ru/ZbVugvK.webp	{"Unagi sauce"}	2
2423	6028	181	Wallmart	5.54	http://bnptfdw.ru/jxQiEKt.php	{"Cheese cheddar","Chili Pepper",Tomatoes,Bacon,Cheese,Meat}	1
3710	1858	205	Bacon Cheese Burger	3.84	https://www.gyearyy.biz/yJFRlBq	{Onion,"Original sauce",Bacon,Basil,"Cheese cheddar","Japanese tamago"}	3
3629	5168	203	Saint Frank Coffee	2.72	http://www.eaucfav.edu/	{"BBQ sauce",Sugar,Mozarella,Flour,Sugar,"Caramelized onions"}	4
3537	3288	201	Grape Jelly Sandwich	6.82	http://gpvokfk.com/uYahNVT.js	{Mushrooms,"Cottage Cheese",Flour}	3
4246	9116	244	Original burger	3.44	http://bmtpjmo.biz/AUMkGAb.css	{"Original sauce","Chili Pepper","Cream cheese",Sugar,Garlic,Potatoes}	5
3748	37	205	Bean Green Chili Burritos	3.74	http://www.qfbzssz.biz/FGIgWtl	{Onion,Pineapple,Mushrooms,"BBQ sauce","Cream cheese"}	5
3860	5573	208	Pizza Pepperoni with tomatoes	5.43	http://givvxor.top/	{Nori,"Caramelized onions",Rice,Flour}	5
4231	9911	244	Wallmart	2.43	https://vtlahjw.info/	{"Cream cheese",Carrots}	3
3443	1000	199	Sweet Potato Pie	4.22	https://ubobbul.biz/hPjMucJ.svg	{"Cream cheese","Cream cheese",Peperoni,Chicken,Flour,"Original sauce"}	3
3637	2167	203	Pizza Florida	7.36	http://oxlhwdy.org/aNxoGSq	{Cucumber,"Cream cheese",Strawberry,Salmon,Salmon}	4
5019	6301	259	Crispy Chicken burger	6.53	https://www.pivfons.top/MJxMfdC	{"Bavarian sausages",Sugar,Flour,Carrots}	3
4196	4518	244	Pizza Ocean	5.48	http://nbcelyb.biz/jkyJPkC.css	{"Cheese cheddar",Sugar,"Cream cheese",Cheese,"Cheese cheddar","Cheese cheddar"}	4
3999	3604	240	New York Style Cheesecake	7.84	http://www.ielnwle.edu/	{"Chili Pepper",Strawberry,Onion,Pasta}	4
4057	2463	242	Pizza Ocean	3.58	https://nyryapx.edu/aRZCryU.jpg	{Onion,"Chili Pepper",Potatoes,Basil,Mushrooms,Chicken}	5
3953	1937	239	Swedish Meatballs	5.52	http://www.xrmzyde.top/xbwqAMp	{"Bavarian sausages",Mushrooms}	2
4277	9682	247	Pizza Pepperoni with tomatoes	5.33	https://uoqnlpf.info/NneYAuo.js	{Onion,"Onion rings",Cheese,Mushrooms,Potatoes,"Cheese cheddar"}	2
3973	3945	239	Swedish Meatballs	6.65	https://phaaanw.top/NnpIDgA.php	{"Original sauce",Flour,"Cheese cheddar","Cream cheese",Potatoes}	1
4980	5713	259	Pizza Florida	3.95	https://dxyifgw.top/FCZsXeO.php	{"Original sauce",Cucumber,Onion,Flour,Pineapple}	1
3489	9505	200	Unwrapped Burrito Bowl	3.53	http://cwwdbmw.net/euTSINO.css	{Mayo,Flour,Onion,Pasta}	4
3676	2293	205	Grape Jelly Sandwich	5.49	http://zuecigm.edu/KPXSxGa.js	{Mushrooms,Pasta,Peperoni}	5
4974	2074	259	Himawari	6.59	http://byydwux.net/jCtFOMn.svg	{Basil,"Cream cheese",Pineapple,Onion,Tomatoes}	2
3542	7838	201	Crispy Chicken burger	6.42	http://dmsxgwe.edu/dMCkOXH.php	{Flour,Meat,Carrots,"Bavarian sausages","Cream cheese"}	5
4955	9022	259	Bean Green Chili Burritos	2.06	https://zfhpqmq.biz/OletHBb	{Rice,Mayo,Chicken,Carrots,Chicken,Cheese}	4
3813	9878	206	Pizza	2.71	https://iqwiqmd.net/ciilMTV	{"Unagi sauce","Cheese cheddar",Basil,"Japanese tamago",Milk,"Original sauce"}	3
3793	3553	206	Bean Green Chili Burritos	5.15	https://wouoycz.org/vSIMprF.js	{"Cheese cheddar",Basil,Bacon,Cucumber,"Cheese cheddar",Bacon}	5
3679	9195	205	Pizza Italiano	5.37	https://wwqdumr.top/PxmxTiV.webp	{Mozarella,Basil,Mayo,Flour,Rice}	1
4185	9387	244	Unagi Philadelphia	4.97	http://wtrbgyf.com/fbOIJVp.svg	{"Cream cheese",Basil}	1
3766	4445	206	Pizza Florida	5.46	https://wnbbxco.com/HTCvbdI.php	{Tomatoes,Flour,Cucumber,Meat,Pasta}	3
4046	9331	241	New York Style Cheesecake	7.04	http://vsnwebc.com/pJWsOft.webp	{"Caramelized onions","Cheese cheddar",Peperoni,Sugar,Pasta}	4
4140	2300	243	Tortellini Bowls	2.06	https://kszltdw.info/ucwbupj.html	{Flour,"Cream cheese","Unagi sauce"}	1
3722	7033	205	Peanut Butter	4.94	http://uwckmxi.org/LUAvrar.php	{Garlic,Sugar,"Unagi sauce","Cottage Cheese",Meat}	5
3881	759	208	Sweet Potato Pie	3.41	https://jvceydg.com/FuneUty.css	{"Original sauce",Salmon,Corn,"Chili Pepper",Flour,"Original sauce"}	2
3584	6333	203	Bacon Cheese Burger	6.81	http://www.bnvmiqc.net/icfWkpM	{Garlic,"Cheese cheddar",Flour,Tomatoes,"BBQ sauce"}	4
3512	1866	201	Saint Frank Coffee	7.10	http://qfewpgx.net/etpDRsf.svg	{Flour,Meat,Flour,Cucumber,Meat,Peperoni}	2
3628	8071	203	Bean Green Chili Burritos	4.16	https://www.kwbphvs.edu/IfGEqEh	{Tomatoes,Carrots,"Chili Pepper",Mozarella,Bacon,Strawberry}	4
3906	1358	239	Angel Food Cake	3.65	http://rjgdtxf.net/pOXlmYt.html	{Strawberry,Tomatoes,Onion,Corn,Flour,Cheese}	3
3583	4825	203	Wallmart	7.93	http://trbaxgg.com/ObtGgdo.webp	{Peas,Pineapple,Bacon,Rice,Mayo}	2
3824	3091	206	Original burger	4.64	http://hljphye.org/smgvjbq.css	{Chicken,"Cream cheese",Sugar,Corn,Garlic,"Original sauce"}	5
4833	5717	257	Pizza Ocean	6.07	http://dhjwyeb.net/pattfmS.jpg	{Mushrooms,"Original sauce",Pineapple,Cheese,Cheese,Mushrooms}	1
4695	3940	255	Pizza Ocean	4.10	https://qfsjcch.net/fyjXhOj.js	{Tomatoes,"Original sauce","Cream cheese",Pasta,Flour,Sugar}	3
4665	7307	255	Pizza Pepperoni with tomatoes	6.33	http://syadvwg.org/nEffhdH.webp	{Salmon,Corn,Sugar,Cucumber,"Unagi sauce",Mayo}	4
4841	5614	257	Chicken Pot Pie	6.46	http://www.kleyqmi.top/	{Tomatoes,Peanuts,Pasta,Mayo,Pineapple,"Japanese tamago"}	2
5046	7912	259	Pizza Hawaiian	4.16	http://tzwhmui.edu/CYsAVMk.html	{Mushrooms,Carrots,"Cheese cheddar",Strawberry,Salmon}	4
4880	7517	258	Swedish Meatballs	7.10	https://kwxqfif.net/bqxDThc.webp	{Bacon}	4
5161	6488	261	Unagi Philadelphia	4.88	https://cpgyevk.info/	{Peperoni,Pasta,Cucumber,Cheese,Mushrooms}	4
4370	286	249	Swedish Meatballs	6.99	https://sxdixbe.ru/VrnajWW.js	{Grapes,Basil,"Cream cheese"}	1
4462	7712	252	Angel Food Cake	6.92	https://zxakohf.ru/	{Mushrooms,"Cottage Cheese",Meat,"Chili Pepper",Mushrooms}	2
3644	222	203	Tortellini Bowls	3.29	http://jualdwn.ru/rREdyHl.svg	{"Japanese tamago",Garlic,Cucumber,"Cheese cheddar",Bacon,Carrots}	5
4787	8810	256	Unwrapped Burrito Bowl	3.35	https://fmpbtnt.com/UXLpPna.jpg	{"Caramelized onions","BBQ sauce","BBQ sauce","Caramelized onions"}	1
4882	7873	258	Crispy Chicken burger	5.76	http://kqhmrlk.org/ImBbqpj.css	{Pineapple,Pineapple,Grapes,"Onion rings",Cucumber}	1
4756	6416	256	Bean Green Chili Burritos	7.52	http://nzdasgr.com/	{Milk,Mushrooms,Cucumber,"Caramelized onions","Cottage Cheese",Butter}	1
4553	4409	254	Philadelphia with salmon	5.15	https://jwpshre.net/YrkfKHa.svg	{Tomatoes,Garlic,Carrots,Cheese}	3
4692	863	255	Pizza	2.94	https://huhrudn.org/XDrGooI.php	{"Japanese tamago",Pineapple}	3
5209	5763	262	Pizza Texas	4.05	http://qxtpwbm.com/BUymaYw.js	{Peanuts,Garlic,Tomatoes,Rice}	5
5067	7745	260	Grape Jelly Sandwich	3.14	https://cyzwgkl.ru/dudHOmP.php	{"BBQ sauce"}	2
5113	190	261	Tortellini Bowls	4.34	http://pcwxxgv.ru/mfdvaRV.svg	{Mayo,Peas,Strawberry,Strawberry,Basil}	1
4461	7195	252	Peanut Butter	3.50	https://www.uqsichn.com/HZdOEfO	{Potatoes,Onion,Nori}	1
4502	7230	253	Crispy Chicken burger	4.31	https://zsssegp.info/EHCbbns	{"Bavarian sausages","Cheese cheddar",Carrots,"Original sauce",Butter}	2
3289	8706	194	Angel Food Cake	6.16	http://dwwfxxl.com/GYQAHwD.html	{Potatoes,"Bavarian sausages",Potatoes,Garlic,Rice}	3
4928	8010	258	Pizza Ocean	5.46	http://fkhmrsa.ru/pWrinYm	{Mushrooms,"Japanese tamago",Butter,Mozarella}	3
4568	1037	254	Unwrapped Burrito Bowl	4.06	http://www.vxgbewa.info/aOMWurT	{Garlic,Peas,"Bavarian sausages","Cottage Cheese"}	5
4646	5041	255	Pizza Ocean	4.62	http://mgmeway.edu/jZkutel.js	{"Caramelized onions",Peperoni,Onion,Flour,"BBQ sauce"}	3
4739	4557	256	Peanut Butter	3.96	https://www.skufycs.com/jhZvQpW	{Mayo,Milk,Rice,Flour}	2
4737	9201	256	Philadelphia with salmon	5.35	https://xkhskym.net/yuYKDoN.webp	{Basil,Peas,Potatoes,Flour,Butter,"Unagi sauce"}	4
4322	7662	248	Pizza Ocean	2.13	http://twjzwao.org/mDLBmYt.html	{Mozarella,Pineapple}	5
4798	3459	257	Philadelphia with salmon	3.88	http://www.dsqqvqq.edu/PlbWhri	{"Onion rings",Peas,"Cheese cheddar",Tomatoes,Pasta}	4
4314	8951	248	Crispy Chicken burger	7.86	https://yjriytr.net/fNrVjgs.html	{Milk,Mayo,Mushrooms,"Cheese cheddar",Carrots,Flour}	2
4643	1916	255	Bean Green Chili Burritos	6.24	https://sxcikro.com/BAMhmJM.webp	{Bacon,"Original sauce",Carrots,Peas,"Caramelized onions",Milk}	2
4420	217	250	Pizza Florida	6.20	https://uhtuaqw.net/cgYHeeJ.html	{Peperoni,Mayo,Flour,"Caramelized onions","BBQ sauce","Caramelized onions"}	5
3432	1795	199	Swedish Meatballs	4.31	https://cdfdkyh.biz/KSOeEcF.php	{Pineapple,Flour,Chicken,"Onion rings",Mushrooms,Mushrooms}	3
5149	3701	261	Saint Frank Coffee	6.82	https://www.cufirjw.com/	{Chicken,Cucumber,Salmon,Tomatoes,Bacon,Basil}	2
5165	4137	261	Grape Jelly Sandwich	5.43	https://dwiqbzx.biz/VgCGrsX.css	{Meat,"Cream cheese","Chili Pepper",Grapes,Cucumber,"Cream cheese"}	3
4414	8725	249	Philadelphia with salmon	5.47	http://srguvum.org/uTVWpwi.webp	{Potatoes,Potatoes}	5
4399	4193	249	Unwrapped Burrito Bowl	7.52	https://zdhsegf.edu/CrvtNgF.html	{Pineapple,Nori,Meat,"Bavarian sausages","BBQ sauce",Peanuts}	4
5349	7523	264	Himawari	2.98	https://ebaxuhp.com/	{Peanuts,Cheese}	5
211	7884	209	Angel Food Cake	2.28	https://lubiicb.top/owbeqGA.js	{Peperoni,"Chili Pepper","Cheese cheddar",Peanuts,Tomatoes,Tomatoes}	3
828	3051	219	Pizza Texas	2.81	https://pesptll.ru/AnwKYKp.js	{"Onion rings",Basil,Garlic,Corn,Grapes,"Bavarian sausages"}	1
1473	9500	233	New York Style Cheesecake	3.50	https://tyagnsh.info/hbXwUtv.jpg	{"Cheese cheddar",Pineapple,Peanuts,Peas,Chicken,Mozarella}	5
3119	9046	190	Tortellini Bowls	7.13	http://xguyywf.info/NwfiMuY.svg	{"Bavarian sausages",Sugar,Cucumber,"Cottage Cheese",Potatoes,Strawberry}	3
4235	4511	244	Crispy Chicken burger	2.79	https://jnnhwpo.net/xfiOEhd.webp	{Bacon,Mushrooms,Bacon,"Onion rings"}	4
4349	4790	249	Unwrapped Burrito Bowl	2.78	http://ibqswvx.edu/lrJYuyr.html	{Pasta,"Unagi sauce",Bacon,"Bavarian sausages","Cottage Cheese","Japanese tamago"}	2
2073	3840	155	Angel Food Cake	3.64	https://srbacbw.info/VFMjlsq	{"Original sauce","Caramelized onions","Cream cheese","Cheese cheddar"}	5
1430	812	232	Crispy Chicken burger	7.33	http://www.bvemvub.info/hRWGBnE	{Peas,"Unagi sauce",Peperoni,Potatoes,Mushrooms,Peas}	1
443	4357	214	Wallmart	6.59	http://ovqrrog.net/ntpoDtH	{Tomatoes,Tomatoes,"Chili Pepper","Japanese tamago","Cottage Cheese","Cottage Cheese"}	5
5362	4856	264	Chicken Pot Pie	2.18	https://kmnedti.net/YdvULjD.js	{Carrots,"Chili Pepper",Mozarella,Salmon,Basil,"Original sauce"}	5
3281	8311	194	Saint Frank Coffee	2.42	http://jpdnpnz.top/reIICoB	{"Original sauce",Mushrooms,Flour,"Unagi sauce","Cottage Cheese"}	2
1743	9671	9	Pizza Pepperoni with tomatoes	3.29	http://opnunsn.ru/	{Carrots,Mushrooms,Garlic,"Original sauce",Carrots,Peanuts}	3
933	8702	222	New York Style Cheesecake	2.11	https://ucacfyl.com/phxoDgy.jpg	{"Original sauce",Onion,"Japanese tamago",Potatoes,Peperoni,Mozarella}	5
5254	2994	262	Pizza Texas	3.45	http://shuyupl.org/nEtXqbP.svg	{Mozarella,Peperoni,"Cottage Cheese",Strawberry,"Caramelized onions","Onion rings"}	3
5257	4652	262	Saint Frank Coffee	3.26	http://uwuezcp.top/vmsniYG.svg	{"Onion rings",Cucumber,Strawberry,Sugar,Carrots,Mushrooms}	3
5394	4574	237	Pizza Texas	2.27	https://hdmbmfy.com/IHUNBxe	{Rice,"Onion rings"}	1
2644	9791	183	Swedish Meatballs	7.00	http://opfyitk.org/oCIFJKC.html	{Cheese,Cucumber,Flour,"Cream cheese",Mushrooms,"Original sauce"}	2
5291	9750	264	Pizza Florida	4.67	https://quvrewd.top/ISajuHe.js	{Nori,Nori,"Bavarian sausages","Bavarian sausages","Cream cheese","Cheese cheddar"}	2
2330	7292	158	New York Style Cheesecake	7.90	https://www.fbsbmal.info/	{Meat,Tomatoes,"Cottage Cheese",Mayo,Potatoes}	5
855	3708	220	Pizza Italiano	7.98	http://tngfgnl.ru/rkZEbvi.php	{Onion,Milk,Carrots,Milk,"BBQ sauce",Cheese}	5
4869	5722	257	Pizza Pepperoni with tomatoes	3.53	https://www.dkpzgom.edu/seUDUVG	{Mushrooms,Peanuts,Cheese,"Bavarian sausages",Mushrooms,"Japanese tamago"}	1
712	8378	218	Pizza Italiano	3.09	https://zdktyks.com/bWbyyPR.jpg	{"Japanese tamago",Tomatoes,Cheese,Mushrooms,Flour}	5
5302	8851	264	Philadelphia with salmon	7.43	https://uhkhems.edu/YFSXlsk.php	{Flour,Tomatoes,Garlic}	1
5326	823	264	Philadelphia with salmon	2.47	http://tkxlrtq.com/rdIjLlr.jpg	{"Cheese cheddar","Cottage Cheese","Unagi sauce",Onion,"Japanese tamago"}	4
1927	9689	153	Chicken Pot Pie	3.78	https://www.xjkpaxb.biz/	{Grapes,Mushrooms,"Bavarian sausages","Original sauce",Grapes}	4
1042	6311	224	Unagi Philadelphia	4.79	https://bbwuoxc.edu/KWFxLoP.svg	{"Cheese cheddar",Chicken,Tomatoes,Strawberry,Sugar,Peperoni}	5
2749	9472	185	Swedish Meatballs	7.00	http://yqmaoai.info/VOqftKL	{"Caramelized onions",Nori,Mushrooms,Bacon,Bacon,Butter}	1
1655	7728	236	Pizza Pepperoni with tomatoes	2.72	http://vmgixpx.info/JuVOxPD.js	{"Bavarian sausages",Butter,Pineapple,Nori,Carrots,Peas}	5
5395	6794	237	Peanut Butter	6.44	https://blbdblf.info/TtelQNm.js	{"Chili Pepper",Corn,Garlic,Mushrooms,Cheese}	5
2040	1290	154	Grape Jelly Sandwich	3.61	https://www.ftvlwuf.biz/CEcQjMx	{"Caramelized onions","Original sauce",Cucumber,Sugar,Onion,Strawberry}	4
\.


--
-- Data for Name: menu_types; Type: TABLE DATA; Schema: public; Owner: food_delivery_user
--

COPY public.menu_types (id, name) FROM stdin;
1	sushi
2	dessert
3	burger
4	pizza
5	frozen_meal
6	appetizer
7	pastry
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: food_delivery_user
--

COPY public.order_items (id, order_id, menu_item_id, quantity, price) FROM stdin;
2	2	1688	2	10.00
3	2	1689	1	5.99
4	3	1688	2	10.00
5	3	1689	1	5.99
6	6	1688	2	10.00
7	6	1689	1	5.99
11	10	5379	1	2.80
12	10	5378	1	4.77
13	11	5379	1	2.80
14	11	5378	1	4.77
15	12	1688	1	7.55
16	13	1688	1	7.55
17	14	1688	2	7.55
26	29	1695	1	5.52
27	29	1696	1	2.89
28	29	1694	1	5.12
29	30	1696	1	2.89
30	31	1701	2	5.98
31	31	1702	3	4.22
32	31	1700	1	7.71
33	32	1695	1	5.52
34	32	1696	1	2.89
35	32	1694	1	5.12
36	33	1695	1	5.52
37	33	1696	1	2.89
38	33	1694	1	5.12
39	34	1701	2	5.98
40	34	1702	1	4.22
41	34	1700	1	7.71
42	35	1695	1	5.52
43	35	1696	1	2.89
44	35	1694	1	5.12
45	36	1695	1	5.52
46	36	1696	1	2.89
47	36	1694	1	5.12
48	37	1695	1	5.52
49	37	1696	1	2.89
50	37	1694	1	5.12
51	38	1701	2	5.98
52	38	1702	1	4.22
53	38	1700	1	7.71
54	39	1695	1	5.52
55	39	1696	1	2.89
56	39	1694	1	5.12
57	40	1695	1	5.52
58	40	1696	1	2.89
59	40	1694	1	5.12
60	41	1695	1	5.52
61	41	1696	1	2.89
62	41	1694	1	5.12
63	42	1695	1	5.52
64	42	1696	1	2.89
65	42	1694	1	5.12
66	43	1695	1	5.52
67	43	1696	1	2.89
68	43	1694	1	5.12
69	44	1695	1	5.52
70	44	1696	1	2.89
71	44	1694	1	5.12
72	45	5379	2	6.15
73	45	5378	1	7.87
74	45	5380	2	4.90
75	46	1691	2	5.44
76	47	1700	2	6.58
77	47	1701	1	7.17
78	47	1702	1	7.03
79	48	5379	1	6.15
80	49	5379	1	3.38
81	49	5378	2	2.73
82	49	5380	1	5.05
83	50	5381	1	3.72
84	50	5382	1	7.34
85	50	5383	2	3.85
86	51	1695	1	5.52
87	51	1696	1	2.89
88	51	1694	1	5.12
89	52	1688	1	4.74
90	52	1689	1	2.83
91	53	1691	1	5.35
92	54	1694	1	7.49
93	54	1695	1	5.00
94	55	1688	1	4.45
95	56	1695	1	5.52
96	56	1696	1	2.89
97	56	1694	1	5.12
98	57	1695	1	5.52
99	57	1696	1	2.89
100	57	1694	1	5.12
101	58	5379	1	3.37
102	59	1977	1	2.82
103	60	1695	1	5.52
104	60	1696	1	2.89
105	60	1694	1	5.12
106	61	2947	1	4.78
107	61	2944	1	5.44
108	61	2935	2	4.86
109	61	2925	1	4.75
110	62	1718	1	7.11
111	62	1715	1	4.05
112	63	5379	1	6.52
113	64	1688	1	5.83
114	65	5379	2	4.42
115	66	5379	1	3.06
116	66	5378	3	4.47
117	66	5380	2	4.43
118	67	1695	1	2.60
119	67	1696	1	4.00
120	67	1694	1	6.20
121	68	5378	3	7.25
122	68	5380	1	5.23
123	68	5379	3	4.46
124	69	5379	3	5.06
125	69	5378	1	2.53
126	69	5380	3	6.37
127	70	5379	1	6.94
128	70	5378	1	5.44
129	71	2357	1	2.14
130	71	2372	1	3.71
131	71	2374	1	7.88
132	72	1693	2	2.83
133	72	1692	2	6.50
134	73	1691	1	6.92
135	73	1693	2	2.83
136	74	5379	2	6.94
137	75	5379	1	2.02
138	75	5380	1	3.26
139	76	5379	2	3.22
140	76	5378	2	6.46
141	77	1688	3	4.36
142	78	5379	1	7.21
143	79	1861	1	6.77
144	79	1859	1	5.80
145	80	1695	1	5.52
146	80	1696	1	2.89
147	80	1694	1	5.12
148	81	1688	1	7.59
149	82	5379	1	2.25
150	82	5378	1	7.04
151	83	3590	1	4.88
152	84	5379	1	2.25
153	85	5379	1	3.56
154	86	1695	1	5.52
155	86	1696	1	2.89
156	86	1694	1	5.12
157	87	1691	3	3.51
158	88	2922	1	6.01
159	88	2957	1	3.96
160	89	1688	1	6.03
161	90	5379	2	4.81
162	91	5379	1	6.59
163	92	1823	1	2.75
164	93	1688	1	4.26
165	94	1722	2	3.46
166	94	1710	3	7.50
167	95	1704	2	3.22
168	96	1991	2	5.05
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: food_delivery_user
--

COPY public.orders (id, user_id, supplier_id, total_price, address, phone, payment_method, created_at) FROM stdin;
2	1	2	25.99	123 Main St, City, Country	1234567890	credit_card	2024-09-22 23:35:53.790688
3	1	2	25.99	123 Main St, City, Country	1234567890	credit_card	2024-09-23 09:21:51.868209
6	1	2	25.99	123 Main St, City, Country	1234567890	credit_card	2024-09-23 11:58:52.139344
10	1	1	0.00	Nagy Lajos Kiraly Utja 49 Budapest 1148	25465634543	cash	2024-09-23 15:46:56.393024
11	1	1	0.00	Nagy Lajos Kiraly Utja 49 Budapest 1148	123345	cash	2024-09-23 15:59:49.165179
12	1	2	0.00	Nagy Lajos Kiraly Utja 49 Budapest 1148	34546556546	cash	2024-09-23 20:20:10.359412
13	1	2	0.00	Nagy Lajos Kiraly Utja 49 Budapest 1140	4	cash	2024-09-23 20:22:01.17526
14	1	2	16.61	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-23 22:14:13.194128
29	1	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-23 23:40:52.829789
30	1	4	3.18	Nagy Lajos Kiraly Utja 49 Budapest 1140	12432435	cash	2024-09-23 23:49:19.678728
31	1	7	35.56	thztjhtjtz	12432435	cash	2024-09-23 23:50:38.762207
32	1	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-24 11:54:13.806424
33	1	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-24 11:55:53.517116
34	1	7	26.28	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-24 11:57:39.112905
35	1	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-24 12:01:09.229678
36	1	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-24 12:11:40.443649
37	1	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-24 12:17:32.743924
38	1	7	26.28	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-25 11:19:56.949045
39	1	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-25 21:09:01.165684
40	1	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-26 09:10:28.036083
41	1	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-26 09:56:09.732173
42	1	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-26 10:41:32.316139
43	1	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-26 20:42:32.075782
44	1	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-26 21:16:40.633982
45	1	1	32.97	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-27 21:06:21.934819
46	1	3	11.97	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-27 21:09:52.217046
47	1	7	30.10	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-27 21:40:53.338923
48	1	1	6.77	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-27 22:08:31.278102
49	1	1	15.28	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-27 23:25:47.683175
50	1	6	20.64	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-28 13:50:09.982992
51	11	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-28 22:42:56.790184
52	1	2	8.33	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-28 22:45:28.278681
53	11	3	5.89	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-28 22:50:46.993475
54	11	4	13.74	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-28 23:00:53.451232
55	11	2	4.90	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-28 23:29:10.167762
56	11	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-28 23:29:58.148807
57	11	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-28 23:35:14.777234
58	11	1	3.71	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-28 23:46:06.402152
59	11	154	3.10	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-29 00:16:55.990528
60	11	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-29 00:23:20.938051
61	11	188	27.16	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-29 08:25:17.82159
62	11	8	12.28	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-29 08:26:04.478645
63	11	1	7.17	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-29 08:41:30.234766
64	11	2	6.41	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-29 10:26:19.307792
65	11	1	9.72	thztjhtjtz	12432435	cash	2024-09-29 11:49:56.703511
66	11	1	27.86	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-29 16:08:06.258921
67	11	4	14.08	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-29 16:10:00.166011
68	11	1	44.40	Nagy Lajos Kiraly Utja 49 Budapest 1140	12432435	card	2024-09-29 18:14:57.986999
69	38	1	40.50	Nagy Lajos Kiraly Utja 49 Budapest 1148	 12345678	cash	2024-09-29 21:32:25.33908
70	11	1	13.62	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-30 08:06:06.193398
71	11	159	15.10	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-30 08:09:39.765967
72	11	3	20.53	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-30 08:19:09.57791
73	0	3	13.84	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-30 08:22:07.959244
74	11	1	15.27	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-30 09:28:06.100692
75	11	1	5.81	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-09-30 11:38:26.61423
76	11	1	21.30	Nagy Lajos Kiraly Utja 49 Budapest 1148	12345677	cash	2024-09-30 14:30:30.372865
77	11	2	14.39	zuguzguzgi	+36124324359	cash	2024-10-01 11:45:11.54069
78	11	1	7.93	qgbfgbnggngzzhz	+36124324359	cash	2024-10-01 12:42:44.559876
79	39	151	13.83	Nagy Lajos Kiraly Utja 49 Budapest 1148	+36124324359	cash	2024-10-01 17:17:18.114436
80	1	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-10-01 18:31:47.902321
81	11	2	8.35	Nagy Lajos Kiraly Utja 49 Budapest 1140	+36124324359	cash	2024-10-01 19:27:51.61857
82	11	1	10.22	thztjhtjtz	+36124324359	card	2024-10-01 21:14:35.002168
83	11	203	5.37	Nagy Lajos Kiraly Utja 49 Budapest 1140	+36124324359	cash	2024-10-02 01:36:52.018074
84	11	1	2.48	Nagy Lajos Kiraly Utja 49 Budapest 1140	+36124324359	cash	2024-10-02 02:32:40.025442
85	11	1	3.92	Nagy Lajos Kiraly Utja 49 Budapest 1140	+36124324359	cash	2024-10-02 02:53:15.215467
86	1	4	14.88	Nagy Lajos Kiraly Utja 49 Budapest 1148	12432435	cash	2024-10-02 09:22:02.212915
87	11	3	11.58	Nagy Lajos Kiraly Utja 49 Budapest 1140	+36124324359	cash	2024-10-02 09:28:03.742367
88	11	188	10.97	Nagy Lajos Kiraly Utja 49 Budapest 1140	+36124324359	card	2024-10-02 09:34:59.083658
89	11	2	6.63	Nagy Lajos Kiraly Utja 49 Budapest 1148	+36124324359	cash	2024-10-02 10:12:17.484684
90	11	1	10.58	Nagy Lajos Kiraly Utja 49 Budapest 1148	+36124324359	cash	2024-10-02 10:24:57.703372
91	11	1	7.25	Nagy Lajos Kiraly Utja 49 Budapest 1148	+36124324359	cash	2024-10-02 11:14:36.546594
92	45	10	3.03	Nagy Lajos Kiraly Utja 49 Budapest 1140	+36124324359	cash	2024-10-02 11:29:29.02472
93	11	2	4.69	Nagy Lajos Kiraly Utja 49 Budapest 1140	+36124324359	card	2024-10-02 11:35:01.855736
94	50	8	32.36	Nagy Lajos Kiraly Utja 49 Budapest 1148	+36124324359	card	2024-10-02 12:44:02.061062
95	51	8	7.08	Nagy Lajos Kiraly Utja 49 Budapest 1148	+36124324359	card	2024-10-02 15:02:23.78555
96	40	154	11.11	Nagy Lajos Kiraly Utja 49 Budapest 1148	+36124324359	card	2024-10-03 07:56:11.614213
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: food_delivery_user
--

COPY public.suppliers (id, external_id, name, type, image, opening_time, closing_time) FROM stdin;
181	4703	Gastro Green	shop	https://vcbczsg.biz/GQxXJaZ.css	07:00	17:30
182	4144	Burger Club	restaurant	https://gbymhbv.top/EHrJJuJ	08:00	18:30
221	783	Wallmart	restaurant	http://fjxdwym.ru/xeNpuAO.webp	09:00	17:30
222	9722	Saint Frank Coffee	restaurant	https://yzvswgg.org/tpkwlhn.html	10:30	17:00
223	3197	Pastarnak	supermarket	http://gnywdyn.net/CjouMns.css	07:00	18:00
224	5981	ABC	shop	http://dwyvbpx.ru/wUshvGh.webp	10:30	17:00
225	369	Sushia	shop	https://uyvqvuf.biz/BUTFESE.css	09:00	17:00
226	4578	Burger Club	bar	http://xglrgic.top/TfXGRSO	10:00	19:30
227	3866	Linea Caffe	bar	http://yrvwssj.org/ZqwhExJ.html	10:30	18:30
228	5296	Wallmart	coffee_shop	http://tcscodv.biz/QEbBhVY.svg	10:30	18:30
229	4657	Linea Caffe	restaurant	http://mbqrbwc.com/HjuIial.js	10:30	17:00
230	8877	Paris	supermarket	https://wsjkoyv.top/ItwQhdX.webp	10:00	19:30
231	1764	ATB	supermarket	http://sulmjfs.info/eJreOsj	07:00	17:30
232	2877	Buritos	coffee_shop	http://kovxpma.ru/RQljguq.js	09:00	20:00
233	8431	Burger Club	restaurant	http://muhwrma.org/GZQmunU.js	10:00	19:30
234	8585	Pizza Club	supermarket	http://www.tonxiys.com/jPYujoE	10:00	18:30
235	4200	Paris	bar	http://www.gmrlyws.biz/	10:30	18:30
236	936	Gastro Green	supermarket	https://uhngwrn.biz/lOnFdmt.css	07:30	18:00
7	7	Linea Caffe	coffee_shop	https://lineacaffe.com/wp-content/themes/lineacaffe/images/linea-logo.svg	07:00	19:00
8	5509	Gastro Green	bar	http://lhvxtvd.edu/OxoXIQj.webp	07:30	20:00
190	5609	Sushia	shop	https://mdhgiqo.biz/KfAHmNE.html	09:00	17:30
9	134	ATB	supermarket	https://ahiespf.ru/HtJFamy.css	10:00	20:00
10	3763	Saint Frank Coffee	restaurant	https://uxlldjh.org/aeXBoGR	08:00	17:00
151	4301	Saint Frank Coffee	bar	https://znkutof.ru/pshliuI.html	10:30	19:30
191	6811	Target	coffee_shop	https://www.xrqucxt.info/ZCAyNOZ	10:30	17:00
237	3737	Wallmart	bar	https://etbefkx.biz/uBsikxL.js	10:00	17:00
238	7366	Wallmart	supermarket	https://hpfgesb.net/sCYdsyB.svg	09:00	19:30
239	418	ABC	shop	http://vxkdysj.net/HUmFEAK	07:30	19:30
240	8297	ABC	shop	https://ddrgfjk.com/UcZpaiZ.html	07:30	18:00
241	8321	Wallmart	restaurant	http://nsyzluh.edu/uMgxrbT.js	09:00	20:00
192	2145	Target	restaurant	https://mauduvq.top/fSuvXHC.svg	08:00	20:00
193	1217	Target	supermarket	http://rwnratb.info/HOxAXaY.webp	10:30	18:00
242	2203	Sushi Space	supermarket	https://www.cqfiamu.com/	09:00	17:00
194	7554	Sushia	restaurant	https://qohnpod.net/nNixdYt.html	10:00	18:00
243	9487	Linea Caffe	bar	http://fpdufdg.ru/yMkauge.webp	10:00	17:00
261	4261	Wallmart	coffee_shop	http://kyzvudo.top/jOyJmIL.html	10:30	18:00
262	5175	Sushi Space	coffee_shop	http://wimfovv.ru/SNAVheS.svg	10:30	20:00
263	7067	Burger Club	coffee_shop	http://nkalxrh.top/OvHihLr.webp	07:00	18:30
264	4512	Sushi Space	bar	http://ubaeafu.com/jKthmpR.js	09:00	17:30
195	4325	Saint Frank Coffee	bar	https://sqmimto.info/ntwoNwP.jpg	07:30	19:30
196	3054	ABC	restaurant	https://yemohqz.info/GEjbVSW.webp	10:00	18:00
197	4364	Linea Caffe	bar	https://www.wtffgrd.com/dqpMqoX	07:30	17:30
198	5273	Bistro	supermarket	https://npmyvvl.org/hRNXejo	08:00	17:00
199	9892	Pastarnak	shop	http://www.soglxgg.top/	07:00	19:30
200	7995	ATB	bar	http://svhtrdh.org/cqJMCjb	07:00	17:00
1	1	Pizza Club	restaurant	https://play-lh.googleusercontent.com/qMewibe3u5Wvq3fBf3Ca3_QItjHCOKeGrOAzVXWxqzgRpMwxYlD5CA6M2M5L78SwNA	09:00	20:00
2	2	Burger Club	restaurant	https://eda.ua/images/506509-195-195-burger_club_harkov.jpg	10:00	20:00
3	3	Saint Frank Coffee	coffee_shop	http://cdn.shopify.com/s/files/1/1578/1589/files/colorf-01_198x200.png	12:00	18:00
4	4	Sushi Space	restaurant	https://image.freepik.com/free-vector/sushi-restaurant-logo_8169-12.jpg	08:00	20:00
183	5244	ATB	supermarket	https://aoogjxs.biz/hmPopxk	09:00	18:00
184	8137	Pizza Club	restaurant	https://dgxclgd.org/gQTGmPO.jpg	07:00	20:00
185	5645	Linea Caffe	restaurant	https://kkfaeav.biz/eICRqvD.js	10:00	19:30
5	5	Target	supermarket	https://1000logos.net/wp-content/uploads/2021/04/Target-logo.png	00:00	24:00
6	6	Wallmart	supermarket	https://cdn.corporate.walmart.com/dims4/WMT/ea03f5e/2147483647/strip/true/crop/855x305+0+0/resize/1578x563!/quality/90/?url=https%3A%2F%2Fcdn.corporate.walmart.com%2F98%2F28%2F342ccbff478ab025592645fafcfc%2Fwalmart-logo.png	00:00	24:00
244	4112	Linea Caffe	bar	https://shhvikc.edu/ZqpQLll.jpg	07:00	17:00
186	5141	Wallmart	supermarket	http://rbxuhde.ru/HtZJtDh.svg	10:30	17:00
245	3783	Linea Caffe	bar	https://vazprxo.net/DQVJraF.svg	07:00	17:00
246	728	ATB	bar	https://xpitrfv.info/urhrrcB.jpg	07:30	19:30
247	5507	Sushi Space	supermarket	http://oaukqxg.ru/cPvPQfF.webp	10:00	20:00
248	5895	Paris	shop	https://www.gfuciez.info/	10:30	17:00
249	8500	ATB	bar	https://ftscliw.net/XXvFrGx.jpg	08:00	18:30
187	1600	Burger Club	bar	https://www.odfghhf.info/SoDZDUZ	09:00	17:30
188	7184	Sushia	coffee_shop	http://htultvg.org/coZwkAa.html	10:30	17:00
189	4081	Burger Club	bar	http://bxqebox.ru/RKPwHwZ.php	07:00	19:30
216	6751	Sushia	restaurant	http://zhkatig.info/VJVAvim.webp	08:00	18:00
217	2507	Target	bar	http://adcxqnt.info/fbEVfnB.php	07:30	17:00
218	9038	Pizza Club	coffee_shop	https://kockdzu.net/LgJRySY	08:00	19:30
219	1805	Burger Club	restaurant	http://dqvagow.com/bGthIUH.html	08:00	19:30
220	510	ABC	restaurant	http://nikovgr.ru/eVlrrUT.php	10:30	18:00
152	1679	Sushia	coffee_shop	http://eevzkrl.net/LwpnxYy.jpg	08:00	18:00
153	4867	Pizza Club	supermarket	http://www.obyvfbu.info/YCHREhX	09:00	20:00
154	1352	Bistro	shop	https://imxkbra.top/OMihpDy	10:00	18:30
155	1103	Pizza Club	coffee_shop	http://www.ebhcdgf.info/	07:00	19:30
156	2965	Burger Club	restaurant	https://vgkviej.info/HlYuUWX.js	10:00	17:00
201	7180	Sushia	supermarket	https://sedsvvt.ru/LxhhsTP.jpg	09:00	17:30
202	8998	Pizza Club	bar	https://vcdueat.ru/AhjSaAr.css	10:30	17:00
157	417	Saint Frank Coffee	restaurant	https://oosenab.net/YPVHnYt.jpg	07:00	19:30
158	4384	ATB	supermarket	https://isytvlp.ru/eyHLXaY.js	07:00	20:00
159	4476	Sushi Space	restaurant	http://bhgjoib.info/WwJacAw.svg	10:00	20:00
160	185	Gastro Green	restaurant	http://obedlrp.info/	08:00	20:00
250	7005	Burger Club	supermarket	http://swkbrrl.ru/tEmsXKM	07:00	18:30
251	5418	Paris	shop	https://iphkkon.net/mFmLRLb.svg	09:00	19:30
252	3862	Paris	supermarket	http://www.raryboa.ru/hsBPIfs	10:00	17:30
253	5537	Saint Frank Coffee	bar	http://vwuolfl.top/	10:30	18:00
254	6765	Sushi Space	bar	http://gdfekci.biz/tcJEJlw.js	08:00	17:30
255	9734	Wallmart	coffee_shop	https://www.blsnyse.edu/oYWUYtj	10:00	17:00
203	2494	Paris	supermarket	http://xyihrip.net/uwrJiQg.php	10:30	17:30
256	6222	Saint Frank Coffee	supermarket	http://tuhdeax.org/fJBdePw.svg	07:00	18:30
257	7031	Wallmart	coffee_shop	http://aavsrdq.info/EdlOJQF.svg	08:00	17:00
258	9526	Wallmart	shop	https://www.kowjwss.org/SBesKqZ	10:30	18:30
204	3964	Linea Caffe	bar	https://esaldzl.biz/HvbSKoV.jpg	07:30	19:30
205	8537	Buritos	coffee_shop	https://naerlbe.net/mUhMgfe.html	10:30	17:30
206	6084	Pizza Club	bar	https://xhvyqxe.top/orohyhD.svg	07:30	17:00
207	4638	Target	shop	https://srrswwy.net/MEEkQin.js	08:00	20:00
208	8108	Buritos	coffee_shop	https://mpofqso.top/JirEmce.svg	10:30	17:30
209	4038	Burger Club	shop	http://fikqaue.biz/IRRvhNN.webp	07:00	18:30
210	5820	Target	restaurant	https://kewpdbq.edu/xCcrqZc	07:00	17:30
211	7140	Target	coffee_shop	http://rdsoqwy.net/QrpOUiH.svg	07:30	20:00
212	188	Linea Caffe	bar	https://www.tsewfkj.net/	08:00	18:30
213	3755	Burger Club	restaurant	https://nhmgxgc.info/UfRmywX.svg	07:30	17:30
214	9405	Saint Frank Coffee	bar	https://aukvdgg.org/RlMtSvq.js	10:30	19:30
215	9506	Bistro	bar	http://btxrkeg.info/sspuhEo	10:30	17:30
259	5444	Burger Club	bar	https://rctnxew.org/gGyRvmg.js	07:00	17:00
260	1681	Pastarnak	shop	https://ovrcbsw.top/rWkdiww.css	09:00	17:30
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: food_delivery_user
--

COPY public.users (id, name, email, hashed_password) FROM stdin;
1	John Doe	john.doe@example.com	$2a$12$7WFiuedG3v2dsnBKSciJE.0ADD64G3gMikrSowR6MMzXe2bjYYSmS
3	Jane Doe	Jane.doe@example.com	$2a$12$fF3WVyef4VmLcJXJF1Ld/eqk4LJFswUxQ6HDsi/R0R0xq.Lmd.jc6
5	John Doe	john@example.com	$2a$12$v86fAuEIdqTkwNIPUTAneObydlYKetl0sCiyNnIDv8E1bMfLg0pda
6	janet	jane@example.com	$2a$12$FAQBOgyQttmiLd.QrT6.zuLeYWGY/535Dy6gW83z7K3TTKd1K4AyS
7	Celine	celine@example.com	$2a$12$2k11dahn1ssOfHQzRmrpj.ZwtoUCYmZTaLaP5F/pagH29JE9KI3pC
8	Linda	linda@example.com	$2a$12$w3QzXTEpNmVPwVJryaRK0OclaIavYILTXqo75vnCLTxNzarTdnFde
9	Denis	denis@example.com	$2a$12$zsm5ypXLiRptjnEUlRD0quYyFigeC/U0gWvqWueMmrHMyXhVKu7li
11	Arina	arina@example.com	$2a$12$.xHDRC3htlJ1YzkDN.6SX.iIhN/bUYZSJbsTXNDgEIBhthWsHHjVi
12	Fredy	fredy@example.com	$2a$12$59zOlqlRWGW79tcmG2CSqeOFVwhK4Ks9hNZLiSX7pL4Abchi2b7bu
13	Axelo	axel@example.com	$2a$12$LHWLeXFz8SffTsa5XaqWOuX0kdKULHpzB8dACckpPcZWzScQ3BIXm
14	camelia	lia@example.com	$2a$12$DZcTYt354rJQ8flHse6nZeB7Cy4mmsB1qZbUVcqHHumf91ShTx2ya
15	Faleon	fufufafa@example.com	$2a$12$Sg8El/qc05a5Hy74ZTfgcuoIk0LZbrqXDM7KLPD3DMqoOzrlOQFa2
16	Felon	just4felon@example.com	$2a$12$7Kfa/1Zamgs9ZVsfFmXIu.iGcLXRtKi3xBf0JfkhMu/f4vnzIdvJq
23	Johny De	johny.de@example.com	$2a$12$1gC6pCG6Cx959p9955EIHOGkdPq7zrmEUQULYKh.Q80TnGdLxAi9q
27	Bobby Ong	bobby@example.com	$2a$12$ZX2KDF5ie7aGRy.FmsR89u1sHZ/0g4gjQzbXtNkKQdzyWrq8IvIY.
28	Serra	serra@example.com	$2a$12$cCkEez.bFg0cN64eHEmwHeYVjwF7Hh81PqeyZgOczP1ZHDBprE8nu
30	Willy Do	willdo@example.com	$2a$12$CgmTP24y/0djibaooXrUmuJqfnzaQDfKFrc3YEHh61xwQmCN8MIKO
31	Lelly	lelly@example.com	$2a$12$evoLLHvUwmvJSLEJireaW.v.A6dMj2SeBjSUhc1wPN9da0HgF0VaS
38	alicia	alicia@example.com	$2a$12$7U..3.39c8UmDDOpZQ.0RuTaerIH/uqa/VpwTHCST4VU1FYzLqcoe
39	testUser	test@email.com	$2a$12$jlRFaql1BfsU5Fd2dez2NOJ8068W6NkGlFhL6/EBpShrad0DKeT.m
40	adhit	adhit@example.com	$2a$12$LowbUILiLu2lIYAPFdFCMuOZnunZtOHNo0G6.d/pqE.DC.q0F2yWa
42	Alina	alina@example.com	$2a$12$4LRZ3yoMTmNon0dGoMSVUOicXDfbow2TM7QRrfnq1HNR6H2g7WYQO
45	adhit	adhiti@example.com	$2a$12$3ZV3qUlZzm7f7xanNLhBH.hvrcFKqYq52VZYDpDCtXzOUdOvdZ.dq
47	adhitiani	adhitiani@example.com	$2a$12$h97.3Vs3a/dRqIEE1SxynO/7edH6h.Ae9bmFc9kNayE0WGiSZVC9m
48	12gfhgnhgzjzj	1234@example.com	$2a$12$iSfgAFGMGxuPSOnQ7QzDL.XeUJcCr9Il3S3LbWnqWg4GRiJdarF5K
49	testUser	testuser@email.com	$2a$12$spCvYOdfknBbMWGPlwHVOeP07cEwX63/frjQvu7MrPZOuwaiCQcK2
50	Dennis	denis@email.com	$2a$12$MBs/3PNHcv5RUi2gFx109.GpLYCZonJw/TuVFC4y3aQ/Ofz10fb5m
51	adhitiani	adhitianiwww@example.com	$2a$12$kud7EdhhxFjViKq3BcOIJ.os37wimcAjmgK7uqjDrrj.V1HFZiOQC
\.


--
-- Name: menu_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: food_delivery_user
--

SELECT pg_catalog.setval('public.menu_items_id_seq', 1331862, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: food_delivery_user
--

SELECT pg_catalog.setval('public.order_items_id_seq', 168, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: food_delivery_user
--

SELECT pg_catalog.setval('public.orders_id_seq', 96, true);


--
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: food_delivery_user
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 56932, true);


--
-- Name: types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: food_delivery_user
--

SELECT pg_catalog.setval('public.types_id_seq', 7, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: food_delivery_user
--

SELECT pg_catalog.setval('public.users_id_seq', 51, true);


--
-- Name: menu_items menu_items_external_id_key; Type: CONSTRAINT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_external_id_key UNIQUE (external_id);


--
-- Name: menu_items menu_items_pkey; Type: CONSTRAINT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: suppliers suppliers_external_id_key; Type: CONSTRAINT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_external_id_key UNIQUE (external_id);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: menu_types types_name_key; Type: CONSTRAINT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.menu_types
    ADD CONSTRAINT types_name_key UNIQUE (name);


--
-- Name: menu_types types_pkey; Type: CONSTRAINT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.menu_types
    ADD CONSTRAINT types_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: menu_items fk_menu_type; Type: FK CONSTRAINT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT fk_menu_type FOREIGN KEY (menu_type_id) REFERENCES public.menu_types(id) ON DELETE SET NULL;


--
-- Name: menu_items menu_items_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_menu_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_menu_item_id_fkey FOREIGN KEY (menu_item_id) REFERENCES public.menu_items(id);


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: orders orders_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: food_delivery_user
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT ALL ON SCHEMA public TO food_delivery_user;


--
-- PostgreSQL database dump complete
--

