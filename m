Return-Path: <virtio-dev-return-14229-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5815DC47258
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 07:38:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C47E82AF9D
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 07:38:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B257A98658B
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 07:38:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A1E5C9863A8; Mon, 15 Jan 2024 07:38:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 90EDB986367;
	Mon, 15 Jan 2024 07:38:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnBZ4qQOQ+D1gRH3k4HJTS3kjwodwvcn0CDSx/ImfHgDVinPB1yR+T1qCvZeL5ANlj6S0mm45lwbJLkKrCyslKXpSsTBhWzQxq7eDQbXKrnbmW2ibG3Uobohxp85BE7KehygXFuNw8ERMvDimd8k0zLLQWJrdMcceT8c8T/ufV48YU9vIF5EomLlT7IGkUc/0WoicgTFcEKLdLJtZiG1qIQUJqVimDcNYxepj/6zx47eVLIiNkMPnPQgcIIzk/mW4rS0T0CtMMCwYjke3HV4610vo+BTQXZh7ukoxLoGwEat8tXV3woVpRKUSNfpyZ8/W/AE13nJ7m6hZqhX5QfgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtxsLubKr4+9lt7qXbq8vgl8fxVZiNnV7U7gSlzKXAA=;
 b=X/I7kppj6wPGhWKFnecNH5X9RxCSwLjZfjA/YPcM5CzdLblorbGkKzPnPmjsIBoqYwSvBa/2KbLD4rIoQfO7xKpb384aYehigtuMQpuoYQQNADUKMAiPbowICkfI49OW4vmHPEwzwHseeA8YOWnB7F2ehsJEnX9QzNx44+aZ4ATtIkjKVRb2/YI80mgHOT7Qmd2paTZMybNKrK/5eWAnrFSR9jXARcNbMh4NAgw7no8dpav0hLGi9NdINtFmlukeBg6Ivb5fPBPzTsckwdizMdptfMYJNKbF66ed5/PDJRYg2T1fu8TUsKjMNYp+oQPI4GrBDOw18mqmdvqhp50RpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
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
	"Huang, Ray" <Ray.Huang@amd.com>
Thread-Topic: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index:
 AQHaA9H0ua9xMq0gbkqU60djCdCUsrBW4XZQgABREYCAAC/xEIABYZmAgAADs4CAABezgIABBRDQgAIBBQCAAAGaAIABFX6AgHlRKACAAAN/0IAACNEAgAAEgaCAAAwWgIAABN1AgASS9ACAAADIQA==
Date: Mon, 15 Jan 2024 07:37:56 +0000
Message-ID:
 <PH0PR12MB548102E41B13AAB57C7321FCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <PH0PR12MB5481BAA4566F77FBEA8B712CDCDFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584921B4DFE8A074107904EEE7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481A43D8E5A0F580B785E1EDCDEA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58498946F163AFE8AFE7DF94E7DDA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20231026062805-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849D7936DD77FECD1FE971EE7DCA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <BL1PR12MB58499AD7442C0A9FC400D747E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481553C8461B7F1F047B5D3DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58492CAC080A708809E434B0E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481AD6A2E262A419FA2CBA8DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584943FA1C20BBF618EBB73AE76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BB80679107D8E0167954DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584952204D1C8AD579F8A87CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To:
 <BL1PR12MB584952204D1C8AD579F8A87CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB7891:EE_
x-ms-office365-filtering-correlation-id: 6b0b4c9c-e028-43f5-1695-08dc159ce40f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gLPquAlW5ZR0XOh0DXtwNaIIcWsXzkDfnJJyjiZbbIXOe70AJRDnP/YTNNfe3WEsicqcyG3+ujx0Xks1ONzGZxYk1lwx7fKWM+oZ9s2IlRId7cSi1+xJ9pNcv25SwkXTUAv1X7IxXAlqzRr9rBmp6qUL+YOb4Vr9MdX2C1B0/DSYs2NLMWVWm5oQwfjOOpP48oBa5gBE8C3kdBuYceOHJKPdMEIw7oWZw+tMRKdmj0+Ki7ZqvhNiu3FROdlvSMrkpzhRpSQ8ZfzpdsNwqahoz8MZDPZ0SO07qLL5xiTj+pGfmd9HWm3Aq73pQRuezxl89lbdh6xc030V/tP6qQ4nLRI8yQbuLP5+he15yLZ5rEp2TbdtuEvhencwXByBpMeDI69rD1fTWnXYqZnEdr8ED3kxQWC/6I/2HZ8pzJkx2Utv9HxNARL+bl42UfrJIiOLGvYIx64V3l4XPvXgthS5p0yBuKksLbzYimIT/UUzcWME+fawvKSabl1Ls38/MSC+KXTjMxG7Hh0gFfMIrPLVU/nads8NztXA1ZIMtTj18I+6o4q68pipVkXE8+Kfh4fJK4uw8a3eHu+zr8YX8rMWi25f5NY89LDT6Fx6b/OyIhyQNklds44PWNR0GRZedZUP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(66899024)(55016003)(83380400001)(41300700001)(6916009)(38070700009)(66946007)(86362001)(76116006)(33656002)(55236004)(122000001)(38100700002)(66476007)(316002)(9686003)(54906003)(26005)(53546011)(66446008)(52536014)(478600001)(66556008)(6506007)(4326008)(2906002)(71200400001)(64756008)(8676002)(7696005)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFMwbisxRkdUQmZuWFpTeUdNeEx3OHBXTDNiZG5hTFAvT3Z4YUh6Wmc5OSti?=
 =?utf-8?B?d1FBOHJ2UHFTWUFUQW9BRTVnc1dlSWd4c1JNM1p5Tm1RQVB3b0hpU1Mvbmk5?=
 =?utf-8?B?MXg5dEJxYytiR0plSzJzYjdyUmZ6MHQ4OWFYeFE5MlJpRjltcGI5bGNBS3Az?=
 =?utf-8?B?Wmt3THlYZURpcXJrbXVjQlY3cXUvRHVVK21FU01YNXBPbkpHRG1XYk1pMGRL?=
 =?utf-8?B?eTRqT2duTEhrNFRpVkNkL0xlNnQ4UkdRVmZvR1N4L204dWNXTUhtMkl4cStT?=
 =?utf-8?B?OENIODY5Yk52NzJDS0ZaRkFOd2M2by9KOTNoQWFCVzVadTlRTWhDUTJrZytM?=
 =?utf-8?B?YUtpRFJEYkJjeGlsQWtOQ1JYZjBEWlJMelRKaExoY0ViRGpOQ3VuNlRtelZT?=
 =?utf-8?B?aUdXWXVJNlUrYmF4dVZoMThWeXZjazIyWWsyejRFTjdnL1B2cmJscDZiSUdp?=
 =?utf-8?B?ZSs0MkZPNnkxOTNlVWhlQUErRHRjdGVJaU8wUzdwRFl1R1lsUFVVRkh5VGhy?=
 =?utf-8?B?anNBRU9uUTBmeDNjUlNqa2JpSTJDaTVreitXeFBoVjVHcEVHNDVRdEpKZ2NE?=
 =?utf-8?B?MkduS241WjZnYnZPTm9kRDl0ekp1VVMwQVI4a2RnUGVzY2h6QWFYVkRDeUJq?=
 =?utf-8?B?TUdLTFo1QWt2aUNTaVNGYXlBdkwvRGhSdWhxSVpWTUJOeWFoN0hZS3plWUwr?=
 =?utf-8?B?UVRWUGJ5djVaYXBNd3N3TnlCUy9jd0VvRTd6TWpXK1FuU3hwMlJlK1JOekIx?=
 =?utf-8?B?VkxSVVdTRVBtME5Oa1loRnlWNUZvOVphS3RiK3J0NFBXQ1RpUGNJWTQrT3JV?=
 =?utf-8?B?Z2tXZnQzR2lrcnkwbEJuZmRUVjdBa1hkblNSeEtKWE5QenlHakljNEloOEpI?=
 =?utf-8?B?cDFSbWczbXUrUC9FdmtzVUlSZHNPSFBHeVZrenFpNHk1L1M3L2hRRVFuME80?=
 =?utf-8?B?VlhHUnVpcUZGUDFGeXFHVi9LUmx3UXkyQzIxMjVNNjJ5UHhaODE5WjFsSWd4?=
 =?utf-8?B?elREd09VN2Fmd3pVM2t1Mk5LWlovRVlXMDExQjl3L0VGdnBLc3ZyUFlMVDhB?=
 =?utf-8?B?RE02LytOL2pQMm5EcDdMd0NsbE40bkkwVTJpWmdOMk5zSGpsQlMzellCNkRo?=
 =?utf-8?B?My9JaTY5Y1c3L0hnd1hiMTgrL1AyVmhwSGZ4TVJCWXdrNHMyekhtR3Y3L1Zy?=
 =?utf-8?B?bDBDa0hBYXJzYUFTQVNLVFFoTXB5WWtDcGN2VW5lazZ2N0dtTml1MnJ2YnF4?=
 =?utf-8?B?MXFKcTR1SWVIV0RxcWpEQmM3N3ljZDhmd3NycTVaM2dVYlVYSTVxbk1ETDJo?=
 =?utf-8?B?K1h0aEkrcTZxZ0xvbzgwalJxdEtFQWJmeC84ZDZjUG9ncXFIRVJZc1pJS24v?=
 =?utf-8?B?RzN0OE1ONTJtaFRPWC9XUzJ1T09pMHpNU0hacW8yMWNibTduc294cFh2NGpi?=
 =?utf-8?B?VGcvNkVoRHJIMHNCSnRBamVDMEdBa1FNVnZjckpKZWxZbGduRTlPSlgzc2NM?=
 =?utf-8?B?SXMySGVHWTFJUFJ2ZGs3eDdHYXhUZzNrcUpxWkZnUkhMOElIVTBLRjlrZnRT?=
 =?utf-8?B?YWZmdHoxamRvR280WnZBdVVxT09HNnJXTFNxenVkVjZjUXh5MDlmZmhkbVln?=
 =?utf-8?B?YitlZHg3U1JzaGxDalY0UE8rMUl4N0o5MFVxTkRJODljdUZpeXBJcGN3MzNI?=
 =?utf-8?B?NGh2NGl0TG13Q3Bua25IdHFYazVWZGFoRVhlRWlnOXRPMWs3RENEWUx1MTAz?=
 =?utf-8?B?VDdXMDVERit1UVhkdFFuajlZaTAxR0cxOCt4WnJjcjhWcktFQWN2RVZEQ0xV?=
 =?utf-8?B?Rm9QNElJQkNvUW1XYnBMbXNSakFYdWw3c1BUUWJ0MDVoR0tUbG5QMGdBRW4z?=
 =?utf-8?B?SXZGaGpQZUZDeFZVTWFiamJmSkJvZmhrbko1UGlvUmNjNysvRFBxTk9zcits?=
 =?utf-8?B?TEV4YUt6RkdJVS9hY0VLUlBpQlBnTlUzSFY4bXdrYnByYXNxQzFoNG9ZYzNw?=
 =?utf-8?B?aG5iOHI5Y0Nub2R5MUJPcnZxTkxLWHVwUVY3cjNrMEdGN1ljbGtsTDVvakZ4?=
 =?utf-8?B?MS9LWTJDZjNlcGpDOTZ4ZnJ0Uis3OFBURkVtcjE4ZEcvTXdldE8zWVpKY0hM?=
 =?utf-8?Q?sbYE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0b4c9c-e028-43f5-1695-08dc159ce40f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 07:37:56.4605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gg5YdHr1C5IYv+dFbbGeR2ngiTB4sclvM54j3VpeA4LCIF5ISVUaEl5vuKHYmhVmK/QpWyRKWoRGiPDLHreilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891
Subject: [virtio-dev] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

DQo+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBKYW51YXJ5IDE1LCAyMDI0IDE6MDMgUE0NCj4gDQo+IE9uIDIwMjQvMS8xMiAxNzo0NCwg
UGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gRnJvbTogQ2hlbiwgSmlxaWFuIDxK
aXFpYW4uQ2hlbkBhbWQuY29tPg0KPiA+PiBTZW50OiBGcmlkYXksIEphbnVhcnkgMTIsIDIwMjQg
Mjo1NSBQTQ0KPiA+Pg0KPiA+PiBPbiAyMDI0LzEvMTIgMTY6NDcsIFBhcmF2IFBhbmRpdCB3cm90
ZToNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5A
YW1kLmNvbT4NCj4gPj4+PiBTZW50OiBGcmlkYXksIEphbnVhcnkgMTIsIDIwMjQgMTo1NSBQTQ0K
PiA+Pj4+DQo+ID4+Pj4NCj4gPj4+PiBPbiAyMDI0LzEvMTIgMTY6MDIsIFBhcmF2IFBhbmRpdCB3
cm90ZToNCj4gPj4+Pj4gSGkgSmlxaWFuLA0KPiA+Pj4+Pg0KPiA+Pj4+Pj4gRnJvbTogQ2hlbiwg
SmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPiA+Pj4+Pj4gU2VudDogRnJpZGF5LCBKYW51
YXJ5IDEyLCAyMDI0IDE6MTEgUE0NCj4gPj4+Pj4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBIaSBhbGws
DQo+ID4+Pj4+PiBTb3JyeSB0byByZXBseSBsYXRlLg0KPiA+Pj4+Pj4gSSBkb24ndCBrbm93IGlm
IHlvdSBzdGlsbCByZW1lbWJlciB0aGlzIHByb2JsZW0sIGxldCBtZSBicmllZmx5DQo+ID4+Pj4+
PiBkZXNjcmlwdA0KPiA+PiBpdC4NCj4gPj4+Pj4+IEkgYW0gd29ya2luZyB0byBpbXBsZW1lbnQg
dmlydGdwdSBTMyBmdW5jdGlvbiBvbiBYZW4uDQo+ID4+Pj4+PiBDdXJyZW50bHkgb24gWGVuLCBp
ZiB3ZSBzdGFydCBhIGd1ZXN0IHRocm91Z2ggcWVtdSB3aXRoIGVuYWJsaW5nDQo+ID4+Pj4+PiB2
aXJ0Z3B1LCBhbmQgdGhlbiBzdXNwZW5kIGFuZCByZXN1bWUgZ3Vlc3QuIFdlIGNhbiBmaW5kIHRo
YXQgdGhlDQo+ID4+Pj4+PiBndWVzdCBrZXJuZWwgY29tZXMgYmFjaywgYnV0IHRoZSBkaXNwbGF5
IGRvZXNuJ3QuIEl0IGp1c3Qgc2hvd24gYQ0KPiA+Pj4+Pj4gYmxhY2sNCj4gPj4+PiBzY3JlZW4u
DQo+ID4+Pj4+PiBUaGF0IGlzIGJlY2F1c2UgZHVyaW5nIHN1c3BlbmRpbmcsIGd1ZXN0IGNhbGxl
ZCBpbnRvIHFlbXUgYW5kDQo+ID4+Pj4+PiBxZW11IGRlc3Ryb3llZCBhbGwgZGlzcGxheSByZXNv
dXJjZXMgYW5kIHJlc2V0IHJlbmRlcmVyLiBUaGlzDQo+ID4+Pj4+PiBtYWRlIHRoZSBkaXNwbGF5
IGdvbmUgYWZ0ZXIgZ3Vlc3QgcmVzdW1lZC4NCj4gPj4+Pj4+IFNvLCBJIGFkZCBhIG5ldyBjb21t
YW5kIGZvciB2aXJ0aW8tZ3B1IHRoYXQgd2hlbiBndWVzdCBpcw0KPiA+Pj4+Pj4gc3VzcGVuZGlu
ZywgaXQgd2lsbCBub3RpZnkgcWVtdSBhbmQgc2V0DQo+ID4+Pj4+PiBwYXJhbWV0ZXIocHJlc2Vy
dmVyX3Jlc291cmNlKSB0byAxIGFuZCB0aGVuIHFlbXUgd2lsbCBwcmVzZXJ2ZQ0KPiA+Pj4+Pj4g
cmVzb3VyY2VzLCBhbmQgd2hlbiByZXN1bWluZywgZ3Vlc3Qgd2lsbCBub3RpZnkgcWVtdSB0byBz
ZXQNCj4gPj4+Pj4+IHBhcmFtZXRlciB0byAwLCBhbmQgdGhlbiBxZW11IHdpbGwga2VlcCB0aGUg
bm9ybWFsIGFjdGlvbnMuIFRoYXQNCj4gPj4+Pj4+IGNhbg0KPiA+PiBoZWxwIGd1ZXN0J3MgZGlz
cGxheSBjb21lIGJhY2suDQo+ID4+Pj4+PiBXaGVuIEkgdXBzdHJlYW0gYWJvdmUgaW1wbGVtZW50
YXRpb24sIFBhcmF2IGFuZCBNU1Qgc3VnZ2VzdCBtZQ0KPiB0bw0KPiA+Pj4+IHVzZQ0KPiA+Pj4+
Pj4gdGhlIFBNIGNhcGFiaWxpdHkgdG8gZml4IHRoaXMgcHJvYmxlbSBpbnN0ZWFkIG9mIGFkZGlu
ZyBhIG5ldw0KPiA+Pj4+Pj4gY29tbWFuZCBvciBzdGF0ZSBiaXQuDQo+ID4+Pj4+PiBOb3csIEkg
aGF2ZSB0cmllZCB0aGUgUE0gY2FwYWJpbGl0eSBvZiB2aXJ0aW8tZ3B1LCBpdCBjYW4ndCBiZQ0K
PiA+Pj4+Pj4gdXNlZCB0byBzb2x2ZSB0aGlzIHByb2JsZW0uDQo+ID4+Pj4+PiBUaGUgcmVhc29u
IGlzOg0KPiA+Pj4+Pj4gZHVyaW5nIGd1ZXN0IHN1c3BlbmRpbmcsIGl0IHdpbGwgd3JpdGUgRDMg
c3RhdGUgdGhyb3VnaCBQTSBjYXAsDQo+ID4+Pj4+PiB0aGVuIEkgY2FuIHNhdmUgdGhlIHJlc291
cmNlcyBvZiB2aXJ0aW8tZ3B1IG9uIFFlbXUgc2lkZShzZXQNCj4gPj4+Pj4+IHByZXNlcnZlcl9y
ZXNvdXJjZSB0byAxKSwgYnV0IGR1cmluZyB0aGUgcHJvY2VzcyBvZiByZXN1bWluZywgdGhlDQo+
ID4+Pj4+PiBzdGF0ZSBvZiBQTSBjYXAgd2lsbCBiZSBjbGVhcmVkIGJ5IHFlbXUNCj4gPj4+Pj4+
IHJlc2V0dGluZyhxZW11X3N5c3RlbV93YWtldXAtPiBxZW11X2RldmljZXNfcmVzZXQtPg0KPiA+
Pj4+Pj4gdmlydGlvX3ZnYV9iYXNlX3Jlc2V0LT4gdmlydGlvX2dwdV9nbF9yZXNldCksIGl0IGNh
dXNlcyB0aGF0IHdoZW4NCj4gPj4+Pj4+IGd1ZXN0IHJlYWRzIHN0YXRlIGZyb20gUE0gY2FwLCBp
dCB3aWxsIGZpbmQgdGhlIHZpcnRpby1ncHUgaGFzDQo+ID4+Pj4+PiBhbHJlYWR5IGJlZW4gRDAg
c3RhdGUsDQo+ID4+Pj4+IFRoaXMgYmVoYXZpb3IgbmVlZHMgdG8gYmUgZml4ZWQuIEFzIHRoZSBz
cGVjIGxpc3RlZCBvdXQsICIgVGhpcw0KPiA+Pj4+PiAyLWJpdCBmaWVsZCBpcw0KPiA+Pj4+IHVz
ZWQgYm90aCB0byBkZXRlcm1pbmUgdGhlIGN1cnJlbnQgcG93ZXIgc3RhdGUgb2YgYSBGdW5jdGlv
biINCj4gPj4+PiBEbyB5b3UgbWVhbiBpdCBpcyB3cm9uZyB0byByZXNldCBQTSBjYXAgd2hlbiB2
cml0aW9fZ3B1IHJlc2V0IGluDQo+ID4+Pj4gY3VycmVudCBxZW11IGNvZGU/IFdoeT8NCj4gPj4+
IEJlY2F1c2UgUE0gaXMgaW1wbGVtZW50aW5nIHRoZSBzdXBwb3J0IGZyb20gRDMtPmQwIHRyYW5z
aXRpb24gYW5kIGlmDQo+ID4+PiBpdA0KPiA+PiBkZXZpY2UgaW4gRDMsIHRoZSBkZXZpY2UgbmVl
ZHMgdG8gcmVzcG9uZCB0aGF0IGl0IGlzIGluIEQzIHRvIG1hdGNoDQo+ID4+IHRoZSBQQ0kgc3Bl
Yy4NCj4gPj4+DQo+ID4+Pj4gU2hvdWxkbid0IGFsbCBkZXZpY2Ugc3RhdGVzLCBpbmNsdWRpbmcg
UE0gcmVnaXN0ZXJzLCBiZSByZXNldA0KPiA+Pj4+IGR1cmluZyB0aGUgcHJvY2VzcyBvZiB2aXJ0
aW8tZ3B1IHJlc2V0Pw0KPiA+Pj4gSWYgTm9fU29mdF9SZXNldD09IDAsIG5vIGRldmljZSBjb250
ZXh0IHRvIGJlIHByZXNlcnZlZC4NCj4gPj4+IElmIE5vX1NvZnRfUmVzZXQgPT0gMSwgZGV2aWNl
IHRvIHByZXNlcnZlIG1pbmltYWwgcmVnaXN0ZXJzIGFuZA0KPiA+Pj4gb3RoZXINCj4gPj4gdGhp
bmdzIGxpc3RlZCBpbiBwY2kgc3BlYy4NCj4gPj4+DQo+ID4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4g
U28gZGV2aWNlIG5lZWRzIHRvIHJldHVybiBEMyBpbiB0aGUgUG93ZXJTdGF0ZSBmaWVsZC4gIFRo
aXMgaXMgbXVzdC4NCj4gPj4+PiBCdXQgY3VycmVudCBiZWhhdmlvciBpcyBhIGtpbmQgb2Ygc29m
dCByZXNldCwgSQ0KPiA+Pj4+IHRoaW5rKCFQQ0lfUE1fQ1RSTF9OT19TT0ZUX1JFU0VUKS4gVGhl
IHBtIGNhcCBpcyByZXNldCBieSBxZW11IGlzDQo+ID4+Pj4gcmVhc29uYWJsZS4NCj4gPj4+IFdo
YXQgeW91IGRlc2NyaWJlZCBpcywgeW91IG5lZWQgdG8gZG8gTm9fU29mdF9SZXNldD0xLCBzbyBw
bGVhc2Ugc2V0DQo+ID4+PiB0aGUNCj4gPj4gY2FwIGFjY29yZGluZ2x5IHRvIGFjaGlldmUgdGhl
IHJlc3RvcmUuDQo+ID4+Pg0KPiA+Pj4gQWxzbyBpbiB5b3VyIGNhc2UgdGhlIGlmIHRoZSBRRU1V
IGtub3dzIHRoYXQgaXQgd2lsbCBoYXZlIHRvIHJlc3VtZQ0KPiA+Pj4gdGhlDQo+ID4+IGRldmlj
ZSBzb29uLg0KPiA+Pj4gSGVuY2UsIGl0IGNhbiB3ZWxsIHByZXBhcmUgdGhlIGdwdSBjb250ZXh0
IGJlZm9yZSByZXN1bWluZyB0aGUgdmNwdXMuDQo+ID4+PiBJbiBzdWNoIGNhc2UsIHRoZSBleHRy
YSByZWdpc3RlciB3b3VsZG7igJl0IGJlIG5lY2Vzc2FyeS4NCj4gPj4+IEhhdmluZyBQTSBjb250
cm9sIHJlZ2lzdGVyIGlzIGFueXdheSBuZWVkZWQgdG8gZHJpdmUgdGhlIGRldmljZSBwcm9wZXJs
eS4NCj4gPj4gRXZlbiBhcyB5b3Ugc2FpZCwgdGhlIHJlc2V0IGJlaGF2aW9yIG9mIFBNIGluIHRo
ZSBjdXJyZW50IFFFTVUgY29kZQ0KPiA+PiBpcyBpbmNvcnJlY3QsIGFuZCBldmVuIGlmIGl0IGlz
IG1vZGlmaWVkLCBpdCBhbHNvIGNhbm5vdCBmaXggdGhpcyBwcm9ibGVtIHdpdGggUzMuDQo+ID4g
WW91IG1lYW50IEQzPw0KPiA+DQo+ID4+IEJlY2F1c2UgdGhlcmUgaXMgdHdpY2UgZGV2aWNlIHJl
c2V0IGR1cmluZyByZXN1bWluZy4NCj4gPj4gRmlyc3QgaXMgd2hlbiB3ZSB0cmlnZ2VyIGEgcmVz
dW1lIGNvbW1hbmQgdG8gcWVtdSwgcWVtdSB3aWxsIHJlc2V0DQo+ID4+IGRldmljZShxZW11X3N5
c3RlbV93YWtldXAtPiBxZW11X2RldmljZXNfcmVzZXQtPg0KPiA+PiB2aXJ0aW9fdmdhX2Jhc2Vf
cmVzZXQtPiB2aXJ0aW9fZ3B1X2dsX3Jlc2V0KS4NCj4gPiBBIGRldmljZSBpbXBsZW1lbnRhdGlv
biB0aGF0IHN1cHBvcnRzIFBNIHNob3VsZCBub3QgcmVzZXQgdGhlIGRldmljZS4NCj4gUGxlYXNl
IGZpeCBpdC4NCj4gRG8geW91IG1lYW4gdGhlIGRldmljZXNfcmVzZXQgYmVoYXZpb3Igb2YgcWVt
dSBzaG91bGRuJ3QgaGFwcGVuIHdoZW4gYQ0KPiBkZXZpY2UgaGFzIFBNIGNhcD8NClJpZ2h0LiBE
ZXZpY2UgcmVzZXQgc2hvdWxkIG5vdCBoYXBwZW4gb24gUE0gY2FwYWJsZSBkZXZpY2UgdGhhdCBv
ZmZlcnMgbm9fc29mdF9yZXNldD09MS4NCg0KPiBPciBqdXN0IHRoZSBzdGF0ZSBvZiBQTSBjYXAg
c2hvdWxkbid0IGJlIHJlc2V0Pw0KPiANCj4gPg0KPiA+PiBBZnRlciB0aGUgZmlyc3QgdGltZSwg
dGhlbiBzZWNvbmQgdGltZSBoYXBwZW5zIGluIGd1ZXN0IGtlcm5lbCwNCj4gPj4gdmlydGlvX2Rl
dmljZV9yZXN0b3JlLT4gdmlydGlvX3Jlc2V0X2RldmljZS4gQnV0IHRoZSBQTSBzdGF0ZSBjaGFu
Z2VzDQo+ID4+IChEMyB0bw0KPiA+PiBEMCkgaGFwcGVucyBiZXR3ZWVuIHRob3NlIHR3bywgc28g
dGhlIGRpc3BsYXkgcmVzb3VyY2VzIHdpbGwgYmUgc3RpbGwNCj4gPj4gZGVzdHJveWVkIGJ5IHRo
ZSBzZWNvbmQgdGltZSBvZiBkZXZpY2UgcmVzZXQuDQo+ID4gVGhlIGRyaXZlciB0aGF0IHVuZGVy
c3RhbmRzIHRoYXQgZGV2aWNlIHN1cHBvcnRzIFBNLCB3aWxsIHNraXAgdGhlIHJlc2V0DQo+IHN0
ZXBzLg0KPiBCdXQgaXQgaGFwcGVucyBmb3Igbm93Lg0KVGhpcyBzaG91bGQgYmUgZW5oYW5jZWQg
aW4gdGhlIGd1ZXN0IGRyaXZlci4NCg0KPiBJbiBjdXJyZW50IHFlbXUgY29kZXMsIHRoZSBiaXQg
UENJX1BNX0NUUkxfTk9fU09GVF9SRVNFVCBvZiB2aXJ0aW8tcGNpDQo+IGRldmljZXMgaXNuJ3Qg
c2V0LCBpcyBpdCBhIGJ1Zz8gSXQgbWVhbnMgdGhlIG5vX3NvZnRfcmVzZXQ9PTAuDQo+IA0KSXQg
c2hvdWxkIGJlIHNldCB3aGVuL2lmIHRoZSBkZXZpY2UgY2FuIHN0b3JlIGFuZCByZXN0b3JlIHRo
ZSBkZXZpY2UgY29udGV4dCBvbiBkMy0+ZDAgdHJhbnNpdGlvbi4NCg0KPiA+IEhlbmNlIHRoZSAy
bmQgcmVzZXQgd2lsbCBhbHNvIG5vdCBvY2N1ci4NCj4gPiBUaGVyZWZvcmUsIGRldmljZSBzdGF0
ZSB3aWxsIGJlIHJlc3RvcmVkLg0KPiANCj4gLS0NCj4gQmVzdCByZWdhcmRzLA0KPiBKaXFpYW4g
Q2hlbi4NCg==

