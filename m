Return-Path: <virtio-dev-return-13821-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23705CD549B
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 07:53:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 798EB6126F
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 07:53:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4FA29986553
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 07:53:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 370AD983E25; Tue, 19 Sep 2023 07:53:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2724A9864C2
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Sep 2023 07:53:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kv9GN3cSYcyp8YhznNpxLFAt8a1nSErV5Qd8CrV7Y00fle/3PkstC+aGimFGUOXi+YAlGeAPIU/FyIr7l82dCWMhZMJm+8vpslT8vKd/MD/TmgChUFb+o7GUg0uQBTb8RJXtCa9uOfDT/1hy9sIqNafWy0lCfYhFKQ5xF8Yrlw5ToCB4DeeC1Tpc3dqIPP0odFIXZKN9LpxuzEf4Fdnew/ahV0g1trNimgaJbUwZ98aYjVYVHInKZyTPVa4qbRqW7zdeB2kmIgx/fNDKdbrnxVFiylVlLRVHQG1dWkai1vSUH4xOklxWpwynS37rf4aYvbb4MgLXspmqUXFsJg3/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMhEz5xNjlrtW+TbjQFffWXi9xOcZYNGVNUYicomwYs=;
 b=BIusdbakPdj9aB6hV3xqenC1fm28DSbqErYV7edk7zYOxvx3rxYp32OHquhB7cC3vhiFPwVnrFV0o5pzUxew2Mab0fQGyH/+oi2sFchnY7NPs+/m+5KUXsTgRfUOzxM+OEqfWx23vteqJ0//7Gb61RkLRao4i0lN5LKy3bM1M4uqoVtW06yASOlqcqyA1HLYahz/7+2Rp0eaXZWrAcvzpHDpkut5CTvOw45kuZR0v2Kqgg9f3SJMxddeXDWZfhh3PKMqpHpkg5YH30W6KNYjJacytK7Wnw0zoG8gSLNVyAM9F7katbaMCN+6vwaY3WQOOLhck19NkhkyC496jVzPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAWpyAIAAEyeQgAAkaoCAAAFRwA==
Date: Tue, 19 Sep 2023 07:53:11 +0000
Message-ID:
 <PH0PR12MB5481236F275C1A0314D85FCFDCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230914070911-mutt-send-email-mst@kernel.org>
 <559c0875-24b8-0709-712e-24ffe7830022@intel.com>
 <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <09045654-d69c-845d-ee26-636fa08f68b4@intel.com>
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvebT7wWUdEamq0u7d2EOrUsjfdyLW4qu2-78UVs7vj1A@mail.gmail.com>
 <PH0PR12MB54815BB722153D38E8496562DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <474be878-333b-7c80-f116-28b90a3eca4d@intel.com>
In-Reply-To: <474be878-333b-7c80-f116-28b90a3eca4d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB8609:EE_
x-ms-office365-filtering-correlation-id: 5a9bb63d-c471-4378-0028-08dbb8e578ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 U0g4Hc889pM7bYT/JlhCzeKXKzGCNulzGxMHsJqXaAm2i1231aOuTb9vWkJXg6Vzj3slt0QYBycByKS2uoXWgwFPpdJ6WTSbhTeqUMybggTW7Dr21O2Ga+ch8z0Ak1OMTokqPa2pmXgp286WvGanNc5QLud6QptXXXHnEU0vmgaYFMMokyLFwPXPR/spolDMo7U7311SS5SLYJNyLnUqmOBgDQO2Kq8kkC8YEcZswZHhARZh2gJOAb83tJlWpHQaL6fxoxaW69ANmV9ze3AFnJMaL+0Yth/HTJM17bJhZJFu6YoFzKPd3CTdt0JHEX4biozzipCu9/Y6ceEffguD6YYRqDjdSqs/AI5PcTgGqeI6Ryy3ikolCn0AcJdK/ghbAjDInMhYjdLnIxrGhtZcTdIxUSiZ8uKBCdSa57dS5fg6VviYNGtBN9e6zYuJX7o+/GMUfJDgYMIWWwte5k6nnZPO916M1qpGko4ak/45PONe05RbzGp32ghmUGhvGY/v8gwkSq4OAtu+/IqCjCzQTxaYe6iwALxV0qnBe6nLDW5zHCLeV1X61PzaRGColtZASB59ZFWcXtwqUCZGOdX6LyB5xZWzBZvtdFjN18h/z1x+o0mn9x4A5rT6/Y+bdeR/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(1800799009)(186009)(451199024)(6506007)(7696005)(55236004)(53546011)(9686003)(83380400001)(478600001)(8936002)(71200400001)(2906002)(316002)(66476007)(76116006)(66946007)(66556008)(66446008)(54906003)(64756008)(41300700001)(110136005)(5660300002)(8676002)(52536014)(4326008)(26005)(122000001)(33656002)(55016003)(86362001)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVRIV2xIVXgwU1AvNm4vT3lMK29yZ1hRM0FMWXBZM1NNOU9Wd0twc2tyNzQ5?=
 =?utf-8?B?TE13bDlmTFhMSDRaZnV2S3AxY1RFR2pkN2JDYmI2U0FBNDMrdm1vUGVrL3kr?=
 =?utf-8?B?R0hFQ1NFOXNucGlIcEpGT1B3WW5uUEVZNlZUMW1rWHVvYzdkUDNqV0VGZHA1?=
 =?utf-8?B?SXFFRW5kYmJicU5rL292S1ZaS1E4cjZleWpDZFQ4cWVyTVNVQWtFa09qYUNS?=
 =?utf-8?B?cDZoV21nRHF3c1hOUFBabGhyYUdGTkV5TVBsYVpiSHlnOWdDUHFKUkdkdVp5?=
 =?utf-8?B?OEFibUtYOSs1WnZMbWlrMVBhWjV5MVd0c1VETWhyVXdlZER0NVVHTUNMenFD?=
 =?utf-8?B?b1BvT01qOExCK1VTRVBQenZFZHVWVk1udnhJSUZUcFNhUTdwNGlub01Va3Fa?=
 =?utf-8?B?em5DUzRoaXhYbVkxaWRvdzQwS0J2Snl3MHdpeDMvT3NlY2ttMmhFaVVGLzlu?=
 =?utf-8?B?d2ZudUNkWXp0V0xiWllTN0VTUzFuZjladytSWXNnT0tZNDhlL2VsVWM1VzBO?=
 =?utf-8?B?VDdNWlUvMFpPZE5DTTJZUE9WSjdWT2IxdVlBTnV1MHpQS1BrMm5tanJHQWts?=
 =?utf-8?B?WU5XVmZIdGhwTi9BV1A1V3M0aTBOSzFKNll5MVA5aUhHcWI0M2l6NVprclQy?=
 =?utf-8?B?aGI0emRkZEFhQmpMZTEzTE9ieEJnYzJIQkdsYk5vZ0hZSTV5RDMzc3VqcHJp?=
 =?utf-8?B?bFlEUGVZSnBWcWdaUElpMWQxcjU4YmlsRWNQU3k1S0d3eUxnYVVWc2FwKyt1?=
 =?utf-8?B?NE9WMGg1bTBHOUwybThzUVE1RENHL0NRdDNJUDBieU1ZRmxBUmZRQnoxRnF4?=
 =?utf-8?B?NnZ0MS82enF6Yks3dm14OUtJSHFuakZMMnpndEdTZGI2MHgzL1Q5czRZSm9q?=
 =?utf-8?B?aWg0RnRORUdiS3pYV3BjM1U0OTJCQmg0K2NmWkRraFdmMG1icFBFMUltMWNm?=
 =?utf-8?B?d1dyUUNqcnIwcjRFTWlvakJvKzl5T0hrNEtQak56eFZBQWlCNmhVZjB5WkRl?=
 =?utf-8?B?UEVCb2ZPc2NCREVWckZKSlo4d2xSdFdGTzFUWm1xU29zNUxiUzVXcWJhbUdj?=
 =?utf-8?B?RFF1T0hUWDkvUUxSVWVra3BrTDZOK1lHYkQxbkVWemlKQytNdC9Ecmd3UThw?=
 =?utf-8?B?ZkhFeURWcCtXWGVFNzhVWkVnQ0owN3FaL3N0MFcwYjdmSTdVbXJVN3gxNUpa?=
 =?utf-8?B?UytiYmkzcnl3NTQ1MlN4cUFyM2cwTWlBQVBBL3Z0SzdiZzFDYmZZMTU2MzB6?=
 =?utf-8?B?Y3RzSUQ3Q3FEZHhYSmJ3OU5laTAwdG9sNEFtTWI1QllacXJPZXJoVmRpU0ZD?=
 =?utf-8?B?TnB3M1d0K0U1NVAyTjdaUEppZDQwczJhTFJYd0RzYjJxNEZ2MzFvaUcrUENn?=
 =?utf-8?B?ZGlSMDJFb0dXWFJxSUx3SUxRbXd3T05LUlRWdTErN0o3VSt3dHd1eWNoaUhX?=
 =?utf-8?B?UUhnZTRSWU9mYkFFaFpFL3BnMVVyR2FxbkcraHZOcDVUOGpuL0hoVGZ6dms0?=
 =?utf-8?B?QVhsMHYvNDFuVUphWW1XQlJiYWVJOHpFZzljWVBReVA3aGEra3NVcE9xMHcx?=
 =?utf-8?B?UEFvZDRCd3pVQWdkbXpIdnVNcHE2R0krWUhsT3lWR21YLzVqRWVWckFGY3Ra?=
 =?utf-8?B?eFp4bHJwdVNZdXVPUTcrOEU1QysySVJSdkJVamRabm5SR3FKQTNBVUxINWtG?=
 =?utf-8?B?bFI2U2F0UWJOdkVWQ2ROdDdHS0hQWE1uOUthRW1rT1RWN05yaTBWZHVPM2J2?=
 =?utf-8?B?Y1BMeXB0MzkxV0g0RHE2ZkhacDgwaVRXRW8wR1B5bEhzbDUzd09DdEEvZEtW?=
 =?utf-8?B?anExY0JLb1Z6ZUdITUtnZVhzb2o2VXE3bWpTaC9MQ1hTWll0dkxYNTFlOWx0?=
 =?utf-8?B?UFBkSjhOSm8zRkZpU0d0c0txVC9NbDloQ3plNmNMMndqME9aVjhjQWhRZXl4?=
 =?utf-8?B?cGg3YWpXYmhVK2EvME8zOGVsVThEeDZHWXkzZ2xlQmhMMzN1c1NOTk1kN1Ro?=
 =?utf-8?B?NnhVaWoxMzNkWlVYNHVaQlpncUVCc3R1WWg1T3dpZ2ZiQ1lqT2MwSm1tSVZL?=
 =?utf-8?B?YXFmK0xqS3g1SUgzYlFhd29vc0J3aXBId0R2Rnp4ODZ5bHBrN2dBOFJsUXNY?=
 =?utf-8?Q?f3U8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9bb63d-c471-4378-0028-08dbb8e578ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 07:53:11.8972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fybYlRP6VBjz910dvIgHOKXC0cMRfosFuTP5JDgy3rBMjdgMxNRSY4Fzj4q7e38VxH9MNhJm2vGOU4TJGnPzQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxOSwgMjAyMyAxOjE2IFBNDQo+IA0KPiBPbiA5LzE5LzIwMjMg
MzozMiBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTksIDIwMjMg
OTo1OCBBTQ0KPiA+Pg0KPiA+PiBPbiBNb24sIFNlcCAxOCwgMjAyMyBhdCAyOjU14oCvUE0gUGFy
YXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPiB3cm90ZToNCj4gPj4+PiBGcm9tOiBaaHUsIExp
bmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiA+Pj4+IFNlbnQ6IE1vbmRheSwgU2Vw
dGVtYmVyIDE4LCAyMDIzIDEyOjE5IFBNDQo+ID4+Pg0KPiA+Pj4+IHNvIGFkbWluIHZxIGJhc2Vk
IExNIHNvbHV0aW9uIGNhbiBiZSBhIHNpZGUgY2hhbm5lbCBhdHRhY2tpbmcNCj4gPj4+PiBzdXJm
YWNlDQo+ID4+PiBJdCB3aWxsIGJlIHBhcnQgb2YgdGhlIERTTSB3aGVuZXZlciBpdCB3aWxsIGJl
IHVzZWQgaW4gZnV0dXJlLg0KPiA+Pj4gSGVuY2UsIGl0IGlzIG5vdCBhdHRhY2sgc3VyZmFjZS4N
Cj4gPj4gRFNNIGlzIG5vdCBhIHBhcnQgb2YgVFZNLiBTbyBpdCByZWFsbHkgZGVwZW5kcyBvbiB3
aGF0IGtpbmQgb2Ygd29yaw0KPiA+PiBkaWQgdGhlIGFkbWluIHZpcnRxdWV1ZSBkby4gRm9yIGNv
bW1hbmRzIHRoYXQgY2FuJ3QgYmUgc2VsZi1jb250YWluZWQNCj4gPj4gbGlrZSBwcm92aXNpb25p
bmcsIGl0IGlzIGZpbmUsIHNpbmNlIGl0IGlzIGRvbmUgYmVmb3JlIHRoZSBUREkNCj4gPj4gYXNz
aWdubWVudC4gQnV0IGl0IG5vdCBuZWNlc3NhcmlseSBmb3IgeW91ciBtaWdyYXRpb24gcHJvcG9z
YWwuIEl0DQo+ID4+IHNlZW1zIHlvdSd2ZSBmb3VuZCBhbm90aGVyIGNhc2UgdGhhdCBzZWxmLWNv
bnRhaW5pbmcgaXMgaW1wb3J0YW50Og0KPiA+PiBhbGxvd2luZyB0aGUgb3duZXIgdG8gYWNjZXNz
IHRoZSBtZW1iZXIgYWZ0ZXIgVERJIGlzIGF0dGFjaGVkIHRvIFRWTQ0KPiA+PiBpcyBhIHNpZGUg
Y2hhbm5lbCBhdHRhY2suDQo+ID4gVFZNIGFuZCBEU00gc3BlY3Mgd2lsbCBiZSBleHRlbmRlZCBp
biBmdXR1cmUgd2hlbiB3ZSBnZXQgdGhlcmUsIHNvIGNvcmUNCj4gaHlwZXJ2aXNvciB3aWxsIG5v
dCBiZSBpbnZvbHZlZC4NCj4gPiBXaXRoIHRyYXArbWVkaWF0aW9uLCBpdCBpcyBpbnZvbHZlZC4N
Cj4gPg0KPiA+IExpbmdzaGFuIHdhbnRlZCB0byB0YWtlIHRoaXMgVERJU1AgZXh0ZW5zaW9uIGlu
IGZ1dHVyZS4NCj4gPiBTbyBhcmUgeW91IGJvdGggYWxpZ25lZCBvciBub3QgeWV0Pw0KPiBJIGRp
ZG4ndCBzYXkgdGhhdCwgbmV2ZXIgZXZlci4NCg0KSW4geW91ciBwcmV2aW91cyBlbWFpbCB5b3Ug
d3JvdGUsDQoNCjEuICJzbyBsZXRzIGZvY3VzIG9uIExNIHRvcGljLCBvdGhlciB0aGFuIGNvbmZp
ZGVudGlhbCBjb21wdXRpbmcuIg0KMi4gImFnYWluLCBURElTUCBpcyBvdXQgb2Ygc3BlYyBhbmQg
VERJU1AgZGV2aWNlcyBhcmUgbm90IG1pZ3JhdGFibGUuIg0KDQpGcm9tIGFib3ZlIHR3byBjb21t
ZW50cyBmcm9tIHlvdSBJIHVuZGVyc3Rvb2QgaXQgdGhhdCB3YXksIHlvdSB3YW50IHRvIGZvY3Vz
IG5vdyBvbiB0aGUgTE0gX290aGVyX3RoYW5fIENDLg0KSG93IHRvIHJlYWQgaXQgZGlmZmVyZW50
bHk/DQoNCg0K

