Return-Path: <virtio-dev-return-14227-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409CEC3DA79
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 07:25:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AA2F32AF84
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 07:25:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A00FD986396
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 07:25:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 93E5098403A; Mon, 15 Jan 2024 07:25:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 80908986367;
	Mon, 15 Jan 2024 07:25:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPVq5zsl6k2w74JGA/dgW7Z9U3HBaV9B8heqM9RtJliewYPhmry/e4XFKfod1QcCi0pQ1/f2qOS9eaALCVYCr7nXQJuDJgCt2i3uH2ouZvOkLSEBCi+oQRkZSCZGEUjhtk7KOu0UzZLtW+nmhcbMpb6L49QhwO9R2MOK2udffpj69i2dT5+e07Sl90gIRGSLncPKu5d9meUH7vB4tgbrFvDd1n6Yv2lhFqb6CxmAxafmZV1MvFbnA+Wb+mLrpbmB742Vo83EPrqc5A9PHh5fioMxD9s3I7OgPtfRHr1tq3rqaODSiH8+r5rkEpEXcheGDKgWFbdSFkHfrd+P2XwT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rJU4Q/twJQGXsruujt1WWY4ctTe86dWGRCv+9jF60k=;
 b=ZYNdRHf848YX0noWy2jsQkP8a5JG5paai685Zvvxylqn66FpDtxTsxowE5fMJbi35BBqSVS4xHE2I6dXNpt8XXo+BCxVHEe+Bch1vNWPbfgUC5srFi05yqyx5RZ5XkDymftQNg7Ge/E+FYL2urm2c8oi/jxZBamg1W9Kw7QzWbXpzIr/ip3t+0USRMTwQTbBx05yMcRLWi9Gl6GLtkrlQt+BkhaTF9sxzpsxRZLrFRfdsDAvZd9aWeiixBSV1ljxf0ZahpFuK6ma6IxgAg51LchCp/p+gAnE8RW5H9/WX2+NvEy0KmgJDftqy0hoIc+rAzaRLJDtrhu7JhAyzabc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Airlie <airlied@redhat.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huang,
 Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia" <Julia.Zhang@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Thread-Topic: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index:
 AQHaA9HvmHelxVzMEkK9DIiJvUqDjbBW5OUAgAC5UoD//8WsgIAB4oYA//+CG4CAAI+hgIAAjVeAgAJwQAD//5FqAAAzXyGADyowGYAAdvF7AAAeHUQA
Date: Mon, 15 Jan 2024 07:25:22 +0000
Message-ID:
 <BL1PR12MB5849B827A1EDFB8007C4F21BE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <PH0PR12MB548182FF345FE7D1DE0D89C1DCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584997339FBFF8E8DF007755E7D8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481DBD22233808AA9497ADBDCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584959DE2A88F4968ECC6740E7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BAA4566F77FBEA8B712CDCDFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584921B4DFE8A074107904EEE7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481A43D8E5A0F580B785E1EDCDEA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58498946F163AFE8AFE7DF94E7DDA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20231026062805-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849D7936DD77FECD1FE971EE7DCA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <BL1PR12MB58499AD7442C0A9FC400D747E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEu5KV+8V+7x4TC6OQQdJ4FduRrHL9k7qP6VhQi3uTXq1Q@mail.gmail.com>
In-Reply-To:
 <CACGkMEu5KV+8V+7x4TC6OQQdJ4FduRrHL9k7qP6VhQi3uTXq1Q@mail.gmail.com>
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
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|MN0PR12MB5977:EE_
x-ms-office365-filtering-correlation-id: 405afbc3-82ed-439f-d25f-08dc159b22b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OOL1syJF8lyxvcMQhirLgcCbwbEkuWxTTx5sUPeKncTGIUcpyGWlr4L0InQowXiXhPLRtXCkjeETSjyupwUnpjzLbqUfCSRx540VpPQIZJCnZyfyKQlRTYUbUhiOtrW4Saub3AB9ZntRVdM24oRPXks56ZnhB1TZf3g9jIWKDjgNQEBvs60zQztJB7OebJtvs/deZXh59ICKsu5xTcJ33dXczANXBpgDeZ+6NKBNpvIVn6hDB3UzUDgtpeBU6SSM6uqNegnvviAWyyfFhQYofxaYz2j1jELNDBelTm65hj9KRQ00qguF4AcS+ewyh0rJk+mRZhGzXqxzTHtq8yBYOuLZ2XGN8J7cL6F79kczMGcrM+ri97a7+zJ0mmhy/pP7SHyxoWXqr4TJSSlcF8uLYRlzFnVqx4N5yy5YBbYMpQhCVjldlLaLCxtJRFgKD/02oQNv92sc7s6lSJEwjehG3ZQcOzJWAW05nDgRVkSzlKFkxTAPmf8kQ77lqUBHgTdl0gEZyrNbrbZ4C8LuA39EXiEcaUPt+CIL2jCVcN7eUmkCp9zDzVGBQhAMLChcu/mcgHUQzPbiRnmOgYVyzXSSCbhsDvrB5H0qF0QMwjk1aJk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(55016003)(71200400001)(38070700009)(66946007)(6506007)(7696005)(478600001)(53546011)(9686003)(66476007)(66446008)(76116006)(316002)(83380400001)(66556008)(26005)(966005)(64756008)(6916009)(54906003)(5660300002)(33656002)(8676002)(41300700001)(7416002)(122000001)(38100700002)(52536014)(4326008)(8936002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlNtTW5iWmRkZy9PR044RWttL2Rtc2lyYUNKTDdLN2hZcXRkcXNwWXYzN2F1?=
 =?utf-8?B?dnhRai8vT2dDUTJ5YjVvR1U2ZHdiUUROblIrZG1BZEk3MlBUUlNUdi9NWEhG?=
 =?utf-8?B?WGd1Y3RkMVZETy9UdHcrOUZ3QTJQUy9Ta3ZZaGNuSWlCNi8vU3VMbU5BN0Yy?=
 =?utf-8?B?eWZzYmQwWUtpbkVxaXBiLzVzbWhWNGlyRUV4UnhuZFUxbmMydElvd2VWZkhL?=
 =?utf-8?B?UXQzMVZYR1VSbXB3NFFhb09McnBhL2pvOFZpb1Z2QWVlY2MzVTFXUU53Mmh0?=
 =?utf-8?B?bithVG4vRnJQYm1iZEU5c1pyN1NOUzl6VjlWT1hEQ1Nscm51MVNPTkdRb3lm?=
 =?utf-8?B?Wm1hVU1WeXA1T2Q1WEpLKzMwcDRmWGtwZXA4QjVjS3hnQ2NOeDdPOVRLRlRi?=
 =?utf-8?B?NTF2cFJ1SGZLbktBbzcwcWlOSkhMaytqZ3pjVlBhek9XbFQyQzNSOW1YNnhC?=
 =?utf-8?B?bUQxTXJCZStrUDhlTVkxKzNUcHFRZm9IYkhRd0tmZmttTmFRSUtkMnE4SDJt?=
 =?utf-8?B?NWpZV1VudHhTMFRRcDU4QWlFZ3RPSDJXaGRDbmtZRXYvdDBDSld0RmRkckw0?=
 =?utf-8?B?bERPNVhqcWpodFNvUHNjZzMrOW42a2VabDA5WWtER3dBeWZRWkt2SDU4V2oz?=
 =?utf-8?B?M2VVTTl6ck8reXNBc2M3NjdoVzJYc3J0YndNUTZUZThjMHdOdWRlNk4yb0ho?=
 =?utf-8?B?VDlFc0tzcVdMbHFkZW41QU15MVptMTM5SVp5REM3UlR4eDQ2YlExQWJ0MzZP?=
 =?utf-8?B?NnYrWGllaDBMVlR5NWpRNkRPR2MyVVdBVUZEWFZpNlNac05kZ2xFUDREMzBp?=
 =?utf-8?B?c3FyZzZmMlVidC9mWkhLVEpRQVM5bXdhS0I3Y3A4RVFOa29EMW84WVdpaVBz?=
 =?utf-8?B?YVhvQ2tkbElEb3lYNGQxSkYxOWM2czdYVFdwcklhT0ZZUXhqcUticzlEWTdH?=
 =?utf-8?B?ZkFrQVR0UUFUQWZ2NE1zQ1FrTURidWtEVmRtanpBVlNaQU1BMmI5RU9MRVhE?=
 =?utf-8?B?NlJ5RFdhQUFKUys4VVdiZSt3K2NaeUZ3MmJaK2lnV0VMUXRmYVhGaGF6VXk3?=
 =?utf-8?B?dkluYysvcHFsRGo5T1d4K2Z4RkRkaXdTU1hwUVF6c2F6REluVnpEUTZHaFlv?=
 =?utf-8?B?RC82SVFzbjhwMmtKNzYzRTMxQ0FCd2sxbmN5RjYwYjlidWtRQVJ4dUEyV1lv?=
 =?utf-8?B?b1lZVmxSRDFROWI4Snl1SDZ4SXlQMllTVXFaL3lCWDJ2Ny9QVk9vcmw0Vldh?=
 =?utf-8?B?RmpsRGdjVzhVbmYzTU9XbCtPTFpqcjM1U0hITzk0a1padDcrQXFvc0pDQ2pY?=
 =?utf-8?B?ZWZFa3FSUXEyMmlkRzVFOUNBMi8wd08xSklvV1hMSmNrUUVBVTMxNEQ3eVE0?=
 =?utf-8?B?VmNwK0pMQnlmSGxYamd0Z3F1UnJjUUYvaG43aCt3cTR2R05tWnNzcFBpek4v?=
 =?utf-8?B?RkhRZ0p1VFk4L3BQR0QyK0FiVGl1Ym4zdW9jVFpRbys4c21KOVdwWUlnaVd0?=
 =?utf-8?B?S2xTQlV4clJFV0tFNEp6VkxMd1FYN1lFMVRDZXRLb3VlQThkUWk5VlR0OW4v?=
 =?utf-8?B?UnFObXY0Z25oVjRJdXFJWjJ0OGl0akxXOEtGLzhkZ201VW1RTGRvZ1doYXQy?=
 =?utf-8?B?Ynk4TGZac2t3a0NQMzVuWFpHOC85QnkwU2JoMzBjMlMzVXN3OEhjUWZyVnh0?=
 =?utf-8?B?VXZUWHpkbXpEQkxHdytlOTFMaVpkVnFobU0xdlVzMmdRNFRxSlk1VjB4Z3Qx?=
 =?utf-8?B?M21mMEVOaDRETHJFc05LQzlxQnNRSlBQVmNjemYvQkt5eExvRGNadVl4T0ZN?=
 =?utf-8?B?TVladTJYWUk4N1hXRklaU0pDWmRaOFdSVGo2Z1BSVGtsL2VrenNyVlBrL25F?=
 =?utf-8?B?UmJPSmc3ckNpRTE4ajA2d0xIa1NCSDRydHNHWWVQd1VZV3ZjNTluYm54dWNa?=
 =?utf-8?B?VFg2Nm1MVDFUMXlxbXRabDF1aTFjNk1FMFpZSStXVklTZEc1eUNpMzVtWEdJ?=
 =?utf-8?B?UTEwWENwSnBJOHY0NjFMZjA0SEJvWk95RUgwRzV1Vm5zdVRxVk40cGQyMXJw?=
 =?utf-8?B?Mk1QcEF4alVscEQwcEx3MWQ4ZnJMVW81dGM3aWsrbkMxZ0FVcFlLRUlMRjVO?=
 =?utf-8?Q?013c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C69D14D7C8BA6419751D9F103AB83A2@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405afbc3-82ed-439f-d25f-08dc159b22b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 07:25:22.5467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QcR5lUTaDco4teIMoaLmoSwpfIYXkSEYtdY+Quv2+PfPjtB6QeN9hYMRN2mXBG8c3F4IpT8ov/IniWTjJ32AZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
Subject: [virtio-dev] Re: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

T24gMjAyNC8xLzE1IDA4OjI1LCBKYXNvbiBXYW5nIHdyb3RlOg0KPiBPbiBGcmksIEphbiAxMiwg
MjAyNCBhdCAzOjQx4oCvUE0gQ2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPiB3cm90
ZToNCj4+DQo+PiBIaSBhbGwsDQo+PiBTb3JyeSB0byByZXBseSBsYXRlLg0KPj4gSSBkb24ndCBr
bm93IGlmIHlvdSBzdGlsbCByZW1lbWJlciB0aGlzIHByb2JsZW0sIGxldCBtZSBicmllZmx5IGRl
c2NyaXB0IGl0Lg0KPj4gSSBhbSB3b3JraW5nIHRvIGltcGxlbWVudCB2aXJ0Z3B1IFMzIGZ1bmN0
aW9uIG9uIFhlbi4NCj4+IEN1cnJlbnRseSBvbiBYZW4sIGlmIHdlIHN0YXJ0IGEgZ3Vlc3QgdGhy
b3VnaCBxZW11IHdpdGggZW5hYmxpbmcgdmlydGdwdSwgYW5kIHRoZW4gc3VzcGVuZCBhbmQgcmVz
dW1lIGd1ZXN0LiBXZSBjYW4gZmluZCB0aGF0IHRoZSBndWVzdCBrZXJuZWwgY29tZXMgYmFjaywg
YnV0IHRoZSBkaXNwbGF5IGRvZXNuJ3QuIEl0IGp1c3Qgc2hvd24gYSBibGFjayBzY3JlZW4uDQo+
PiBUaGF0IGlzIGJlY2F1c2UgZHVyaW5nIHN1c3BlbmRpbmcsIGd1ZXN0IGNhbGxlZCBpbnRvIHFl
bXUgYW5kIHFlbXUgZGVzdHJveWVkIGFsbCBkaXNwbGF5IHJlc291cmNlcyBhbmQgcmVzZXQgcmVu
ZGVyZXIuIFRoaXMgbWFkZSB0aGUgZGlzcGxheSBnb25lIGFmdGVyIGd1ZXN0IHJlc3VtZWQuDQo+
PiBTbywgSSBhZGQgYSBuZXcgY29tbWFuZCBmb3IgdmlydGlvLWdwdSB0aGF0IHdoZW4gZ3Vlc3Qg
aXMgc3VzcGVuZGluZywgaXQgd2lsbCBub3RpZnkgcWVtdSBhbmQgc2V0IHBhcmFtZXRlcihwcmVz
ZXJ2ZXJfcmVzb3VyY2UpIHRvIDEgYW5kIHRoZW4gcWVtdSB3aWxsIHByZXNlcnZlIHJlc291cmNl
cywgYW5kIHdoZW4gcmVzdW1pbmcsIGd1ZXN0IHdpbGwgbm90aWZ5IHFlbXUgdG8gc2V0IHBhcmFt
ZXRlciB0byAwLCBhbmQgdGhlbiBxZW11IHdpbGwga2VlcCB0aGUgbm9ybWFsIGFjdGlvbnMuIFRo
YXQgY2FuIGhlbHAgZ3Vlc3QncyBkaXNwbGF5IGNvbWUgYmFjay4NCj4+IFdoZW4gSSB1cHN0cmVh
bSBhYm92ZSBpbXBsZW1lbnRhdGlvbiwgUGFyYXYgYW5kIE1TVCBzdWdnZXN0IG1lIHRvIHVzZSB0
aGUgUE0gY2FwYWJpbGl0eSB0byBmaXggdGhpcyBwcm9ibGVtIGluc3RlYWQgb2YgYWRkaW5nIGEg
bmV3IGNvbW1hbmQgb3Igc3RhdGUgYml0Lg0KPj4gTm93LCBJIGhhdmUgdHJpZWQgdGhlIFBNIGNh
cGFiaWxpdHkgb2YgdmlydGlvLWdwdSwgaXQgY2FuJ3QgYmUgdXNlZCB0byBzb2x2ZSB0aGlzIHBy
b2JsZW0uDQo+PiBUaGUgcmVhc29uIGlzOg0KPj4gZHVyaW5nIGd1ZXN0IHN1c3BlbmRpbmcsIGl0
IHdpbGwgd3JpdGUgRDMgc3RhdGUgdGhyb3VnaCBQTSBjYXAsIHRoZW4gSSBjYW4gc2F2ZSB0aGUg
cmVzb3VyY2VzIG9mIHZpcnRpby1ncHUgb24gUWVtdSBzaWRlKHNldCBwcmVzZXJ2ZXJfcmVzb3Vy
Y2UgdG8gMSksDQo+PiBidXQgZHVyaW5nIHRoZSBwcm9jZXNzIG9mIHJlc3VtaW5nLCB0aGUgc3Rh
dGUgb2YgUE0gY2FwIHdpbGwgYmUgY2xlYXJlZCBieSBxZW11IHJlc2V0dGluZyhxZW11X3N5c3Rl
bV93YWtldXAtPiBxZW11X2RldmljZXNfcmVzZXQtPiB2aXJ0aW9fdmdhX2Jhc2VfcmVzZXQtPiB2
aXJ0aW9fZ3B1X2dsX3Jlc2V0KSwNCj4+IGl0IGNhdXNlcyB0aGF0IHdoZW4gZ3Vlc3QgcmVhZHMg
c3RhdGUgZnJvbSBQTSBjYXAsIGl0IHdpbGwgZmluZCB0aGUgdmlydGlvLWdwdSBoYXMgYWxyZWFk
eSBiZWVuIEQwIHN0YXRlLCBzbyBndWVzdCB3aWxsIG5vdCB3cml0ZSBEMCB0aHJvdWdoIFBNIGNh
cCwgc28gSSBjYW4ndCBrbm93IHdoZW4gdG8gcmVzdG9yZSB0aGUgcmVzb3VyY2VzKHNldCBwcmVz
ZXJ2ZXJfcmVzb3VyY2UgdG8gMCkuDQo+IA0KPiBMb29rcyBsaWtlIGEgYnVnIHRvIGJlIGZpeGVk
Pw0KRG8geW91IHRoaW5rIHRoZSBkZXZpY2VzX3Jlc2V0IGJlaGF2aW9yIG9mIHFlbXUgc2hvdWxk
bid0IGhhcHBlbj8gT3IganVzdCB0aGUgc3RhdGUgb2YgUE0gY2FwIHNob3VsZG4ndCBiZSBjbGVh
cmVkPw0KDQo+IA0KPj4gRG8geW91IGhhdmUgYW55IG90aGVyIHN1Z2dlc3Rpb25zPw0KPj4gT3Ig
Y2FuIEkganVzdCBmYWxsYmFjayB0byB0aGUgdmVyc2lvbiB0aGF0IGFkZCBhIG5ldyBjb21tYW5k
KFZJUlRJT19HUFVfQ01EX1BSRVNFUlZFX1JFU09VUkNFKSBpbiB2aXJ0aW8tZ3B1PyBJIHRoaW5r
IHRoYXQgd2F5IGlzIG1vcmUgcmVhc29uYWJsZSBhbmQgZmVhc2libGUgZm9yIHZpcnRpby1ncHUg
dG8gcHJvdGVjdCBkaXNwbGF5IHJlc291cmNlcyBkdXJpbmcgUzMuIEFzIGZvciBvdGhlciBkZXZp
Y2VzLCBpZiBuZWNlc3NhcnksIHRoZXkgY2FuIGFsc28gcmVmZXIgdG8gdGhlIGltcGxlbWVudGF0
aW9uIG9mIHRoZSB2aXJ0aW8tZ3B1IHRvIGFkZCBuZXcgY29tbWFuZHMgdG8gcHJldmVudCByZXNv
dXJjZSBsb3NzIGR1cmluZyBTMy4NCj4gDQo+IE5vdGUgdGhhdCB0aGVyZSdzIHJlY2VudGx5IGEg
Zml4IGZvciBub19zb2Z0X3Jlc2V0LCBhIHdlbGwgYmVoYXZlZA0KPiBkZXZpY2Ugc2hvdWxkIG5v
dCBzdWZmZXIgZnJvbSB0aGlzIGlzc3VlIGFueW1vcmUuIElmIEkgdW5kZXJzdGFuZCB0aGlzDQo+
IGNvcnJlY3RseSwgdGhlcmUncyBubyBuZWVkIGZvciBhbnkgZXh0ZW5zaW9uIGZvciB0aGUgc3Bl
YyBhcyB3ZWxsLjoNCkJ1dCBpbiBjdXJyZW50IHFlbXUgY29kZXMsIHRoZSBiaXQgUENJX1BNX0NU
UkxfTk9fU09GVF9SRVNFVCBvZiB2aXJ0aW8tcGNpIGRldmljZXMgaXNuJ3Qgc2V0LCBpcyBpdCBh
IGJ1Zz8NCkV2ZW4gd2l0aCB0aGUgZml4IHlvdSBtZW50aW9uZWQsIHRoZSByZXNldHRpbmcgY2Fu
IHN0aWxsIGhhcHBlbiBiZWNhdXNlIG9mIG5vX3NvZnRfcmVzZXQ9PTAuDQoNCj4gDQo+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQ0FDR2tNRXNfTWFqVEZ4R1ZjSzVSOG9xUXpUeHVMNFBt
PXVVbk9vbkRjeld6cWF1Y3N3QG1haWwuZ21haWwuY29tL1QvDQo+IA0KPiBUaGFua3MNCj4gDQoN
CkJlc3QgUmVnYXJkcywNCkppcWlhbiBDaGVuLg0K

