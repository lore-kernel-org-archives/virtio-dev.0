Return-Path: <virtio-dev-return-14232-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F923C47258
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 08:20:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9994E2AF97
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 08:20:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 931F1986556
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 08:20:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8570C98636D; Mon, 15 Jan 2024 08:20:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 73B2F986367;
	Mon, 15 Jan 2024 08:20:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTy0/l8tmMtrgXCgXyFwTNoZtL0OsKJ7EOYgmotgLokn6UP7RdFyXQCp3m/iJ65kswwo/bdcEhWv741q/Dzy2IUVuNQE9bzwV59qteHrk5OUyiqg0LPpWG7UeTs2lVVTUhT44hs5GMJguCV87wZv//gG8tidHAn5Ogi1BTHQURd998GlXs0HiVjJkWAhBgTmvp3NpUzTqiUD4VGUeevX57q5V37ZruKzaxBn/2IJfxlpEZrulPemZJS8httmM4gVApEUYiolQugnDQ/cr9bllRqQ/5hdBqkbkm4qhoNxVIZAWcwPg5mvTwvjBJmGMnelsVAkjwcODFPyLY0xk+T8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lDAZjvjzHmj3TOSS8MssaAzPb6UCjCLb6S9jm6ORuI=;
 b=RQ9Ql6sMAlWe3R2jcUS9vXlutqten7STO/VGruY6E8PIDrixxU/CvkpHjTD5+9FiZqGsS3qf0wR9xVxyqvb8aCjpl7fMlkEICK1sVutw4CO/q4i9s+ZmZG2G6s12ApQgclAUuCd1pZ+LkESxNJ/0Fhql29lSViYsgizZ336G3xss8UOobRcT8pzepdbihpVVyGFBEZxLaVIYjG+QDhEdGhw+llfJZUKYLab7JzOMTqtsiy+gBS0u9Vg4US+Vxvd7noMI1OdxojoEz+7GNOxo2tT1RWRfK0SgUKx4G+6PG2xH5ckAGCjH/Jr/jnWQVzzsa/Zv9SvLrO9/g6a60/9UCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Parav Pandit <parav@nvidia.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Airlie <airlied@redhat.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huang,
 Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia" <Julia.Zhang@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Thread-Topic: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index:
 AQHaA9HvmHelxVzMEkK9DIiJvUqDjbBW5OUAgAC5UoD//8WsgIAB4oYA//+CG4CAAI+hgIAAjVeAgAJwQAD//5FqAAAzXyGADyowGYD//4AlgIAAia6A//+C6oCAAItHgP//hKUAgAUWT4D//31GAAAQ5xwAABBKiAAAD6fOAA==
Date: Mon, 15 Jan 2024 08:20:45 +0000
Message-ID:
 <BL1PR12MB5849D8D396D00919482CB6D2E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <20231026062805-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849D7936DD77FECD1FE971EE7DCA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <BL1PR12MB58499AD7442C0A9FC400D747E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481553C8461B7F1F047B5D3DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58492CAC080A708809E434B0E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481AD6A2E262A419FA2CBA8DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584943FA1C20BBF618EBB73AE76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BB80679107D8E0167954DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584952204D1C8AD579F8A87CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB548102E41B13AAB57C7321FCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849F3E85F2661EB38128A67E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481158BD79A17E1C49ACB6BDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB5481158BD79A17E1C49ACB6BDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: IA1PR12MB8495.namprd12.prod.outlook.com
 (15.20.7181.004)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|MW4PR12MB5604:EE_
x-ms-office365-filtering-correlation-id: fa2b0db6-416b-4612-d347-08dc15a2df98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7u/ztuJ4uRw2Bch3+xxhD0l1uLRFJ4paziwguh8m0Lx7/o03sqAaF42lZpYcDg5zMx98pUAnmXWIyAspoghmTYgO42veEuv2TQRnaMfN1x7e8C+kpMSVwAGEzlmbIRNAkATZysfYaTFgAlkVT330K+ihShtgmKCvSjX1EkMtMsgo+gvzhBj0cG/byFd8osXAlo1GR2heuc4RIwj61pcw4wyboU1CgsRppNJvB4D5NW/kmP7qt0A7MtPtKSwWKJ/Abfx0/j04eHT78/AyotCmVNruaopymFQ1+TXtf1szlUdu0DadjyiBNJma4zzbsoDPO2hmcFVKHjwpCCl5WynrIhdp3dBzM41t0UskjkP+K3d+1hEPV75bpj9Vjv9T0VpbChPWaB0m66Tb4qAdeQxInWtgwzaXS52vv6AgjYID95G7hnibc2U4WwcvbluMHiFaO1sBhddImlIXTen+zfZ9Q/je00ZoGyV4l5MCB3o4ELenExOsIT7Y1/obcSOnsPTn/EY+EDxeAdCm88MoCpB9jUDmLVjTZMhxgnr2wRVezZdJHfxleUnaHG+FQ+uVpYhxSINeCGjZIwXq6ygwoi3VabtEnGUjf/XvwomaL+wtKxalrT/wADU65mu+ItejcGjW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(53546011)(5660300002)(26005)(66476007)(122000001)(9686003)(38100700002)(54906003)(478600001)(8676002)(4326008)(7416002)(52536014)(41300700001)(2906002)(7696005)(8936002)(6916009)(66946007)(76116006)(6506007)(316002)(64756008)(66556008)(66446008)(83380400001)(33656002)(71200400001)(38070700009)(55016003)(66899024);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjJFbjkzSjJFNmtMNFU4cUQ4SExkZ0l6SFBwT2c1L1l3ZG1Ca3owa3VnVWR3?=
 =?utf-8?B?RHFRRGxXSE9GWWNTUStmcjJKcXZYenFOVFgyajFhOUViKzJuNXMveDduYUh0?=
 =?utf-8?B?UDNsQlJtbE9iVVJCeTV3TTA2VGJ4cnpZNkZ3emFHcW8wZFNUbDVNM004MzNX?=
 =?utf-8?B?Ui9vak9TTnZLMUF0QTFLT2Q2ZjljTFQ3NXIyT3dLTTVSYWNrMmF2NDVNaW9R?=
 =?utf-8?B?d3BaOUhPaWdjMVJ1Sm1QWk1JV1pXWXFiUFZuSGNYWS9taDB6T0g1aFBFSHkx?=
 =?utf-8?B?M1BuT3NYZHFjOUU4OFVCeVdvTlcydU1jZXJoTDVIU2VWbjRjTjg4RVdNc0FC?=
 =?utf-8?B?TVRuelJYWFFkVVB5VjBjVkd5TWlJSVpTL3VmQUxxU01GUkFHVWZMNWJNUTBu?=
 =?utf-8?B?alpnemZQMStlRDI1V2N4dmkwcE5nSXdGVlExT1h4dktBVXpTaWJRMTNUbndy?=
 =?utf-8?B?aTlPTkxyMDQ3QURKdEtodHhoMGFpL2xDMGRZUk5sN3JiUkpoVXhGVWxMMmZC?=
 =?utf-8?B?MW45WVNBQ05Damg5ZHZaRFpyNC9NVDBOVnJNMnllNWhpbm9BRUd2MUorVUdp?=
 =?utf-8?B?N2dkekJrQ3MyRE9sRmJKNzRtRVpUN3dkWnI3TGZxL2ZiQmJRcDNPVGtFeEZU?=
 =?utf-8?B?T1pVSWVac1ZvSk9XSCtxc1kwOS9Nc3N3Zk5xWTlyakg0TmJmWU5pNmdGL2dt?=
 =?utf-8?B?QTJhYWxUYzFJdktDcFpCNnRQYjI0cGwvNWZ1U0pCd1FCR2t6cGhlNWlodmFm?=
 =?utf-8?B?eDN0M2VuMWMvZ3BJRTVJcU9jWHpGaHkrSFdZKytEdURDWS9oK3luOEg2VmRo?=
 =?utf-8?B?dXFZWjZBS3ZweXZhVkk1RkxnY2ovc1R2aWtTQ0t1WVVuNFNpMTAxaTEzVzNH?=
 =?utf-8?B?VyswNDR3VTg4Q2FCN2NjaDJ3M2J2M28vVzZxbG1GSVRHbndCR3J5NUVsOSsx?=
 =?utf-8?B?YXJaM2RlRmp5ZkUrNGttMk1HbzJFWUo4TnFZa1J4cGdpMWNLMWswbkFQc0ZP?=
 =?utf-8?B?Y3E1K3ZrVkZwUXZ2YTdhM1ZQN1M2VlhZT0hobmZxV3pnSlhVTm15WXAycmE5?=
 =?utf-8?B?MTA3MnJHd1lNakRaMngrUHVhOWUzY0hwYjRqZDlQdjc4VFRDMDdNckJ5RVhq?=
 =?utf-8?B?VFZYNGRBZEtFSDQrbDh3L3lGTExrb2VYNXA5emh6b0o3R2RMbzNRMkJsZVVl?=
 =?utf-8?B?QjM1cUV6QWdkNHRweG5LVDdEQkZtVStjU21xaERyMnBELzBoU3F0emlVbGkw?=
 =?utf-8?B?bklkeHA5OFlOZisvL1ZIWGZMenZPOGhpdXJEZVNkK3ZNWGpRVjljS0h3ZkdS?=
 =?utf-8?B?L2JiOU96R3F2SHc4bXkrenJnN2tMV0oyRUdWRzNZWGFMZ1hBTFNHSGNxS2VT?=
 =?utf-8?B?a0xDMEhldXNhV0RGZ2kzZHFReVh2UDhJSmFTdHArNVZLSllxZzlBTG1tK1Y2?=
 =?utf-8?B?ODEraFFyQ25jSUU3ZXltOFF1Sm1nb2tVWEVOQmdZY3JZMlliUm13YzlCY0xT?=
 =?utf-8?B?MGlnTS9HYzNDWjJsOWZzRzQ4QjhFZ3JRaFM5VTNnRVZIZDhIblhoUWFjKzNx?=
 =?utf-8?B?aUR0aWM3RUVrVWlma3Nia2xVTG95bFlnUFVmWDk1Q0J1WGppbzd5TVZZL21n?=
 =?utf-8?B?TzE1RSs3di81RUZpSXZFZHJzL3h1SWF3clQ0UmlnM0t6RFNIV1VDOWgyV1FF?=
 =?utf-8?B?T3VlaDRoWEpxM2lRY0wxbWVwRkQyNHVPVVVNaEhrRURTc0V4dGs3MmI2Tm1V?=
 =?utf-8?B?OHFySm4yaGRVZURYbEZZMERjOUpCZWIxZEZ3eXFmOGhpWjFMY1YyUEpSUGs5?=
 =?utf-8?B?dWl4ZHpMRFN0b1paQ3V5d1hRTXh4RHJQSFU1UzNodFI4cy92bk1OaUhsNVNH?=
 =?utf-8?B?OFI3TlpiVFZRV29tbUlRWlJIWDdzcU9SK0VEemRYZythRm9XazZVUHFDK05T?=
 =?utf-8?B?ZE4xREZzVjlVeFdma1N1QkFLanFYZEVJbC9UZmIrY0lLY3pQUG8xZFNBUXVR?=
 =?utf-8?B?cmh3L2tSa2pzLzFCMHQwNnFla0lFWUZIRVpNSlFxSzROUENuRWhhczd1MUpP?=
 =?utf-8?B?V0VrTjhYWHFuWnROSUhYMXYzZ3VjRFVZZEtUNXFKOGttYURtQ1E5UXRNcGIw?=
 =?utf-8?Q?Gmk0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AACC53E46406114480C12E83286070A3@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2b0db6-416b-4612-d347-08dc15a2df98
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 08:20:45.9476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3diMTZF78AtDE/t7MXfBoVQXVQy2H0Q000sbJshs4iNBgfW2yn91ityr/CQsftBc0IL6JAEkOCANDybQqyj8qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

T24gMjAyNC8xLzE1IDE1OjU1LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+IA0KPj4gRnJvbTogQ2hl
biwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4gU2VudDogTW9uZGF5LCBKYW51YXJ5
IDE1LCAyMDI0IDE6MTggUE0NCj4+DQo+PiBPbiAyMDI0LzEvMTUgMTU6MzcsIFBhcmF2IFBhbmRp
dCB3cm90ZToNCj4+Pg0KPj4+PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFtZC5j
b20+DQo+Pj4+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxNSwgMjAyNCAxOjAzIFBNDQo+Pj4+DQo+
Pj4+IE9uIDIwMjQvMS8xMiAxNzo0NCwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+
DQo+Pj4+Pj4gRnJvbTogQ2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4+Pj4+
IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAxMiwgMjAyNCAyOjU1IFBNDQo+Pj4+Pj4NCj4+Pj4+PiBP
biAyMDI0LzEvMTIgMTY6NDcsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4+Pj4+Pj4NCj4+Pj4+Pj4N
Cj4+Pj4+Pj4+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4+Pj4+
Pj4+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAxMiwgMjAyNCAxOjU1IFBNDQo+Pj4+Pj4+Pg0KPj4+
Pj4+Pj4NCj4+Pj4+Pj4+IE9uIDIwMjQvMS8xMiAxNjowMiwgUGFyYXYgUGFuZGl0IHdyb3RlOg0K
Pj4+Pj4+Pj4+IEhpIEppcWlhbiwNCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiBGcm9tOiBDaGVuLCBK
aXFpYW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+Pj4+Pj4+Pj4+IFNlbnQ6IEZyaWRheSwgSmFu
dWFyeSAxMiwgMjAyNCAxOjExIFBNDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4g
SGkgYWxsLA0KPj4+Pj4+Pj4+PiBTb3JyeSB0byByZXBseSBsYXRlLg0KPj4+Pj4+Pj4+PiBJIGRv
bid0IGtub3cgaWYgeW91IHN0aWxsIHJlbWVtYmVyIHRoaXMgcHJvYmxlbSwgbGV0IG1lIGJyaWVm
bHkNCj4+Pj4+Pj4+Pj4gZGVzY3JpcHQNCj4+Pj4+PiBpdC4NCj4+Pj4+Pj4+Pj4gSSBhbSB3b3Jr
aW5nIHRvIGltcGxlbWVudCB2aXJ0Z3B1IFMzIGZ1bmN0aW9uIG9uIFhlbi4NCj4+Pj4+Pj4+Pj4g
Q3VycmVudGx5IG9uIFhlbiwgaWYgd2Ugc3RhcnQgYSBndWVzdCB0aHJvdWdoIHFlbXUgd2l0aA0K
Pj4+Pj4+Pj4+PiBlbmFibGluZyB2aXJ0Z3B1LCBhbmQgdGhlbiBzdXNwZW5kIGFuZCByZXN1bWUg
Z3Vlc3QuIFdlIGNhbg0KPj4+Pj4+Pj4+PiBmaW5kIHRoYXQgdGhlIGd1ZXN0IGtlcm5lbCBjb21l
cyBiYWNrLCBidXQgdGhlIGRpc3BsYXkgZG9lc24ndC4NCj4+Pj4+Pj4+Pj4gSXQganVzdCBzaG93
biBhIGJsYWNrDQo+Pj4+Pj4+PiBzY3JlZW4uDQo+Pj4+Pj4+Pj4+IFRoYXQgaXMgYmVjYXVzZSBk
dXJpbmcgc3VzcGVuZGluZywgZ3Vlc3QgY2FsbGVkIGludG8gcWVtdSBhbmQNCj4+Pj4+Pj4+Pj4g
cWVtdSBkZXN0cm95ZWQgYWxsIGRpc3BsYXkgcmVzb3VyY2VzIGFuZCByZXNldCByZW5kZXJlci4g
VGhpcw0KPj4+Pj4+Pj4+PiBtYWRlIHRoZSBkaXNwbGF5IGdvbmUgYWZ0ZXIgZ3Vlc3QgcmVzdW1l
ZC4NCj4+Pj4+Pj4+Pj4gU28sIEkgYWRkIGEgbmV3IGNvbW1hbmQgZm9yIHZpcnRpby1ncHUgdGhh
dCB3aGVuIGd1ZXN0IGlzDQo+Pj4+Pj4+Pj4+IHN1c3BlbmRpbmcsIGl0IHdpbGwgbm90aWZ5IHFl
bXUgYW5kIHNldA0KPj4+Pj4+Pj4+PiBwYXJhbWV0ZXIocHJlc2VydmVyX3Jlc291cmNlKSB0byAx
IGFuZCB0aGVuIHFlbXUgd2lsbCBwcmVzZXJ2ZQ0KPj4+Pj4+Pj4+PiByZXNvdXJjZXMsIGFuZCB3
aGVuIHJlc3VtaW5nLCBndWVzdCB3aWxsIG5vdGlmeSBxZW11IHRvIHNldA0KPj4+Pj4+Pj4+PiBw
YXJhbWV0ZXIgdG8gMCwgYW5kIHRoZW4gcWVtdSB3aWxsIGtlZXAgdGhlIG5vcm1hbCBhY3Rpb25z
Lg0KPj4+Pj4+Pj4+PiBUaGF0IGNhbg0KPj4+Pj4+IGhlbHAgZ3Vlc3QncyBkaXNwbGF5IGNvbWUg
YmFjay4NCj4+Pj4+Pj4+Pj4gV2hlbiBJIHVwc3RyZWFtIGFib3ZlIGltcGxlbWVudGF0aW9uLCBQ
YXJhdiBhbmQgTVNUIHN1Z2dlc3QgbWUNCj4+Pj4gdG8NCj4+Pj4+Pj4+IHVzZQ0KPj4+Pj4+Pj4+
PiB0aGUgUE0gY2FwYWJpbGl0eSB0byBmaXggdGhpcyBwcm9ibGVtIGluc3RlYWQgb2YgYWRkaW5n
IGEgbmV3DQo+Pj4+Pj4+Pj4+IGNvbW1hbmQgb3Igc3RhdGUgYml0Lg0KPj4+Pj4+Pj4+PiBOb3cs
IEkgaGF2ZSB0cmllZCB0aGUgUE0gY2FwYWJpbGl0eSBvZiB2aXJ0aW8tZ3B1LCBpdCBjYW4ndCBi
ZQ0KPj4+Pj4+Pj4+PiB1c2VkIHRvIHNvbHZlIHRoaXMgcHJvYmxlbS4NCj4+Pj4+Pj4+Pj4gVGhl
IHJlYXNvbiBpczoNCj4+Pj4+Pj4+Pj4gZHVyaW5nIGd1ZXN0IHN1c3BlbmRpbmcsIGl0IHdpbGwg
d3JpdGUgRDMgc3RhdGUgdGhyb3VnaCBQTSBjYXAsDQo+Pj4+Pj4+Pj4+IHRoZW4gSSBjYW4gc2F2
ZSB0aGUgcmVzb3VyY2VzIG9mIHZpcnRpby1ncHUgb24gUWVtdSBzaWRlKHNldA0KPj4+Pj4+Pj4+
PiBwcmVzZXJ2ZXJfcmVzb3VyY2UgdG8gMSksIGJ1dCBkdXJpbmcgdGhlIHByb2Nlc3Mgb2YgcmVz
dW1pbmcsDQo+Pj4+Pj4+Pj4+IHRoZSBzdGF0ZSBvZiBQTSBjYXAgd2lsbCBiZSBjbGVhcmVkIGJ5
IHFlbXUNCj4+Pj4+Pj4+Pj4gcmVzZXR0aW5nKHFlbXVfc3lzdGVtX3dha2V1cC0+IHFlbXVfZGV2
aWNlc19yZXNldC0+DQo+Pj4+Pj4+Pj4+IHZpcnRpb192Z2FfYmFzZV9yZXNldC0+IHZpcnRpb19n
cHVfZ2xfcmVzZXQpLCBpdCBjYXVzZXMgdGhhdA0KPj4+Pj4+Pj4+PiB3aGVuIGd1ZXN0IHJlYWRz
IHN0YXRlIGZyb20gUE0gY2FwLCBpdCB3aWxsIGZpbmQgdGhlIHZpcnRpby1ncHUNCj4+Pj4+Pj4+
Pj4gaGFzIGFscmVhZHkgYmVlbiBEMCBzdGF0ZSwNCj4+Pj4+Pj4+PiBUaGlzIGJlaGF2aW9yIG5l
ZWRzIHRvIGJlIGZpeGVkLiBBcyB0aGUgc3BlYyBsaXN0ZWQgb3V0LCAiIFRoaXMNCj4+Pj4+Pj4+
PiAyLWJpdCBmaWVsZCBpcw0KPj4+Pj4+Pj4gdXNlZCBib3RoIHRvIGRldGVybWluZSB0aGUgY3Vy
cmVudCBwb3dlciBzdGF0ZSBvZiBhIEZ1bmN0aW9uIg0KPj4+Pj4+Pj4gRG8geW91IG1lYW4gaXQg
aXMgd3JvbmcgdG8gcmVzZXQgUE0gY2FwIHdoZW4gdnJpdGlvX2dwdSByZXNldCBpbg0KPj4+Pj4+
Pj4gY3VycmVudCBxZW11IGNvZGU/IFdoeT8NCj4+Pj4+Pj4gQmVjYXVzZSBQTSBpcyBpbXBsZW1l
bnRpbmcgdGhlIHN1cHBvcnQgZnJvbSBEMy0+ZDAgdHJhbnNpdGlvbiBhbmQNCj4+Pj4+Pj4gaWYg
aXQNCj4+Pj4+PiBkZXZpY2UgaW4gRDMsIHRoZSBkZXZpY2UgbmVlZHMgdG8gcmVzcG9uZCB0aGF0
IGl0IGlzIGluIEQzIHRvIG1hdGNoDQo+Pj4+Pj4gdGhlIFBDSSBzcGVjLg0KPj4+Pj4+Pg0KPj4+
Pj4+Pj4gU2hvdWxkbid0IGFsbCBkZXZpY2Ugc3RhdGVzLCBpbmNsdWRpbmcgUE0gcmVnaXN0ZXJz
LCBiZSByZXNldA0KPj4+Pj4+Pj4gZHVyaW5nIHRoZSBwcm9jZXNzIG9mIHZpcnRpby1ncHUgcmVz
ZXQ/DQo+Pj4+Pj4+IElmIE5vX1NvZnRfUmVzZXQ9PSAwLCBubyBkZXZpY2UgY29udGV4dCB0byBi
ZSBwcmVzZXJ2ZWQuDQo+Pj4+Pj4+IElmIE5vX1NvZnRfUmVzZXQgPT0gMSwgZGV2aWNlIHRvIHBy
ZXNlcnZlIG1pbmltYWwgcmVnaXN0ZXJzIGFuZA0KPj4+Pj4+PiBvdGhlcg0KPj4+Pj4+IHRoaW5n
cyBsaXN0ZWQgaW4gcGNpIHNwZWMuDQo+Pj4+Pj4+DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+DQo+Pj4+
Pj4+Pj4gU28gZGV2aWNlIG5lZWRzIHRvIHJldHVybiBEMyBpbiB0aGUgUG93ZXJTdGF0ZSBmaWVs
ZC4gIFRoaXMgaXMgbXVzdC4NCj4+Pj4+Pj4+IEJ1dCBjdXJyZW50IGJlaGF2aW9yIGlzIGEga2lu
ZCBvZiBzb2Z0IHJlc2V0LCBJDQo+Pj4+Pj4+PiB0aGluayghUENJX1BNX0NUUkxfTk9fU09GVF9S
RVNFVCkuIFRoZSBwbSBjYXAgaXMgcmVzZXQgYnkgcWVtdQ0KPj4gaXMNCj4+Pj4+Pj4+IHJlYXNv
bmFibGUuDQo+Pj4+Pj4+IFdoYXQgeW91IGRlc2NyaWJlZCBpcywgeW91IG5lZWQgdG8gZG8gTm9f
U29mdF9SZXNldD0xLCBzbyBwbGVhc2UNCj4+Pj4+Pj4gc2V0IHRoZQ0KPj4+Pj4+IGNhcCBhY2Nv
cmRpbmdseSB0byBhY2hpZXZlIHRoZSByZXN0b3JlLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBBbHNvIGlu
IHlvdXIgY2FzZSB0aGUgaWYgdGhlIFFFTVUga25vd3MgdGhhdCBpdCB3aWxsIGhhdmUgdG8NCj4+
Pj4+Pj4gcmVzdW1lIHRoZQ0KPj4+Pj4+IGRldmljZSBzb29uLg0KPj4+Pj4+PiBIZW5jZSwgaXQg
Y2FuIHdlbGwgcHJlcGFyZSB0aGUgZ3B1IGNvbnRleHQgYmVmb3JlIHJlc3VtaW5nIHRoZSB2Y3B1
cy4NCj4+Pj4+Pj4gSW4gc3VjaCBjYXNlLCB0aGUgZXh0cmEgcmVnaXN0ZXIgd291bGRu4oCZdCBi
ZSBuZWNlc3NhcnkuDQo+Pj4+Pj4+IEhhdmluZyBQTSBjb250cm9sIHJlZ2lzdGVyIGlzIGFueXdh
eSBuZWVkZWQgdG8gZHJpdmUgdGhlIGRldmljZQ0KPj4gcHJvcGVybHkuDQo+Pj4+Pj4gRXZlbiBh
cyB5b3Ugc2FpZCwgdGhlIHJlc2V0IGJlaGF2aW9yIG9mIFBNIGluIHRoZSBjdXJyZW50IFFFTVUg
Y29kZQ0KPj4+Pj4+IGlzIGluY29ycmVjdCwgYW5kIGV2ZW4gaWYgaXQgaXMgbW9kaWZpZWQsIGl0
IGFsc28gY2Fubm90IGZpeCB0aGlzIHByb2JsZW0gd2l0aA0KPj4gUzMuDQo+Pj4+PiBZb3UgbWVh
bnQgRDM/DQo+Pj4+Pg0KPj4+Pj4+IEJlY2F1c2UgdGhlcmUgaXMgdHdpY2UgZGV2aWNlIHJlc2V0
IGR1cmluZyByZXN1bWluZy4NCj4+Pj4+PiBGaXJzdCBpcyB3aGVuIHdlIHRyaWdnZXIgYSByZXN1
bWUgY29tbWFuZCB0byBxZW11LCBxZW11IHdpbGwgcmVzZXQNCj4+Pj4+PiBkZXZpY2UocWVtdV9z
eXN0ZW1fd2FrZXVwLT4gcWVtdV9kZXZpY2VzX3Jlc2V0LT4NCj4+Pj4+PiB2aXJ0aW9fdmdhX2Jh
c2VfcmVzZXQtPiB2aXJ0aW9fZ3B1X2dsX3Jlc2V0KS4NCj4+Pj4+IEEgZGV2aWNlIGltcGxlbWVu
dGF0aW9uIHRoYXQgc3VwcG9ydHMgUE0gc2hvdWxkIG5vdCByZXNldCB0aGUgZGV2aWNlLg0KPj4+
PiBQbGVhc2UgZml4IGl0Lg0KPj4+PiBEbyB5b3UgbWVhbiB0aGUgZGV2aWNlc19yZXNldCBiZWhh
dmlvciBvZiBxZW11IHNob3VsZG4ndCBoYXBwZW4gd2hlbg0KPj4+PiBhIGRldmljZSBoYXMgUE0g
Y2FwPw0KPj4+IFJpZ2h0LiBEZXZpY2UgcmVzZXQgc2hvdWxkIG5vdCBoYXBwZW4gb24gUE0gY2Fw
YWJsZSBkZXZpY2UgdGhhdCBvZmZlcnMNCj4+IG5vX3NvZnRfcmVzZXQ9PTEuDQo+PiBCdXQgY3Vy
cmVudCBxZW11IGNvZGUsIG5vX3NvZnRfcmVzZXQ9PTAuDQo+Pg0KPiBTbyBwbGVhc2UgZml4IHRo
ZSBxZW11IHdoZW4geW91IGFyZSBhZGRpbmcgdGhlIGZ1bmN0aW9uYWxpdHkgb2YgcmVzdG9yaW5n
IHRoZSBkZXZpY2UgY29udGV4dCBvbiBQTS4NCk15IHBhdGNoIGRpZG4ndCBhZGQgdGhlIGZ1bmN0
aW9uYWxpdHkgb2YgcmVzdG9yaW5nIHRoZSBkZXZpY2UgY29udGV4dCBvbiBQTS4NCklzIG5vX3Nv
ZnRfcmVzZXQgbXVzdCBzZXQgMSB3aGVuIGEgZGV2aWNlIGhhcyBQTSBjYXA/IEl0IHNob3VsZCBh
bHNvIGJlIGFsbG93ZWQgZm9yIHNpdHVhdGlvbnMgdGhhdCBhcmUgbm90IGVxdWFsIHRvIDEsIHJp
Z2h0Pw0KVGhlcmUgc2hvdWxkIGJlIGRldmljZXMgdGhhdCBoYXMgUE0gY2FwIGJ1dCBub19zb2Z0
X3Jlc2V0IGlzIDAgYmVjYXVzZSB0aGF0IGRldmljZXMgY2FuJ3Qgc3RvcmUgYW5kIHJlc3RvcmUg
dGhlIGRldmljZSBjb250ZXh0IG9uIGQzLT5kMCB0cmFuc2l0aW9uLCBsaWtlIGN1cnJlbnQgcWVt
dSBjb2RlLg0KU28gdGhlIGZpeCBzaG91bGQgYmUgZmVhc2libGUgZm9yIGFsbCBzaXR1YXRpb25z
IHRoYXQgd2hldGhlciB0aGUgbm9fc29mdF9yZXNldCBpcyAxIG9yIG5vdC4NCklmIHVzZSBQTSBj
YXAsIG5vdCBldmVyeSBzaXR1YXRpb24gY2FuIHNvbHZlIGN1cnJlbnQgcHJvYmxlbSAoZGlzcGxh
eSByZXNvdXJjZXMgb2YgR1BVIHdpbGwgYmUgZGVzdHJveWVkKS4NCg0KPiANCj4+Pg0KPj4+PiBP
ciBqdXN0IHRoZSBzdGF0ZSBvZiBQTSBjYXAgc2hvdWxkbid0IGJlIHJlc2V0Pw0KPj4+Pg0KPj4+
Pj4NCj4+Pj4+PiBBZnRlciB0aGUgZmlyc3QgdGltZSwgdGhlbiBzZWNvbmQgdGltZSBoYXBwZW5z
IGluIGd1ZXN0IGtlcm5lbCwNCj4+Pj4+PiB2aXJ0aW9fZGV2aWNlX3Jlc3RvcmUtPiB2aXJ0aW9f
cmVzZXRfZGV2aWNlLiBCdXQgdGhlIFBNIHN0YXRlDQo+Pj4+Pj4gY2hhbmdlcw0KPj4+Pj4+IChE
MyB0bw0KPj4+Pj4+IEQwKSBoYXBwZW5zIGJldHdlZW4gdGhvc2UgdHdvLCBzbyB0aGUgZGlzcGxh
eSByZXNvdXJjZXMgd2lsbCBiZQ0KPj4+Pj4+IHN0aWxsIGRlc3Ryb3llZCBieSB0aGUgc2Vjb25k
IHRpbWUgb2YgZGV2aWNlIHJlc2V0Lg0KPj4+Pj4gVGhlIGRyaXZlciB0aGF0IHVuZGVyc3RhbmRz
IHRoYXQgZGV2aWNlIHN1cHBvcnRzIFBNLCB3aWxsIHNraXAgdGhlDQo+Pj4+PiByZXNldA0KPj4+
PiBzdGVwcy4NCj4+Pj4gQnV0IGl0IGhhcHBlbnMgZm9yIG5vdy4NCj4+PiBUaGlzIHNob3VsZCBi
ZSBlbmhhbmNlZCBpbiB0aGUgZ3Vlc3QgZHJpdmVyLg0KPj4+DQo+Pj4+IEluIGN1cnJlbnQgcWVt
dSBjb2RlcywgdGhlIGJpdCBQQ0lfUE1fQ1RSTF9OT19TT0ZUX1JFU0VUIG9mDQo+Pj4+IHZpcnRp
by1wY2kgZGV2aWNlcyBpc24ndCBzZXQsIGlzIGl0IGEgYnVnPyBJdCBtZWFucyB0aGUgbm9fc29m
dF9yZXNldD09MC4NCj4+Pj4NCj4+PiBJdCBzaG91bGQgYmUgc2V0IHdoZW4vaWYgdGhlIGRldmlj
ZSBjYW4gc3RvcmUgYW5kIHJlc3RvcmUgdGhlIGRldmljZSBjb250ZXh0DQo+PiBvbiBkMy0+ZDAg
dHJhbnNpdGlvbi4NCj4+IEkgZG9uJ3Qga25vdyB3aHkgaXQgZG9lc24ndCBiZSBzZXQgaW4gY3Vy
cmVudCBxZW11IGNvZGUuDQo+IE1heSBiZSBiZWNhdXNlIFFFTVUgaXMgbm90IHJlc3RvcmluZyB0
aGUgY29udGV4dCBvbiBQTSBjb21tYW5kcy4NCj4gDQo+PiBXaGF0IGRvIHlvdSBtZWFuICJ0aGUg
ZGV2aWNlIGNhbiBzdG9yZSBhbmQgcmVzdG9yZSB0aGUgZGV2aWNlIGNvbnRleHQgb24NCj4+IGQz
LT5kMCB0cmFuc2l0aW9uIj8gVGhlIHJlYWwgcGh5c2ljYWwgZGV2aWNlIG9yIHRoZSBzaW11bGF0
ZWQgZGV2aWNlcyBvbiBxZW11DQo+PiBzaWRlPw0KPiBEb2VzIG5vdCBtYXR0ZXIsIHdoaWNoZXZl
ciBpbXBsZW1lbnRhdGlvbiBvZiBkZXZpY2UgaXMgZG9pbmcgdGhlIFBNIHNob3VsZCBzZXQgaXQu
DQo+IEluIHlvdXIgY2FzZSBpdCBpcyBxZW11Lg0KPiANCj4+IEhvdyBkbyBJIGNvbmZpcm0gaXQ/
DQo+IElmIHlvdSBtZWFuICJJIiBtZWFucyBndWVzdCBkcml2ZXIsIGl0IHdpbGwganVzdCB3b3Jr
IGFzIGxvbmcgYXMgaXQgcmVmZXJzIHRvIHRoZSBQTSBjYXBhYmlsaXRpZXMuDQo+IA0KPj4NCj4+
Pg0KPj4+Pj4gSGVuY2UgdGhlIDJuZCByZXNldCB3aWxsIGFsc28gbm90IG9jY3VyLg0KPj4+Pj4g
VGhlcmVmb3JlLCBkZXZpY2Ugc3RhdGUgd2lsbCBiZSByZXN0b3JlZC4NCj4+Pj4NCj4+Pj4gLS0N
Cj4+Pj4gQmVzdCByZWdhcmRzLA0KPj4+PiBKaXFpYW4gQ2hlbi4NCj4+DQo+PiAtLQ0KPj4gQmVz
dCByZWdhcmRzLA0KPj4gSmlxaWFuIENoZW4uDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KSmlxaWFu
IENoZW4uDQo=

