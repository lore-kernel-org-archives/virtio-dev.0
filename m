Return-Path: <virtio-dev-return-13660-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1EDEE7FF4
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 04:11:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 341C02AD75
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 04:11:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 23AA79864A8
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 04:11:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 131FC9863B6; Mon, 11 Sep 2023 04:11:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F15AF98635C;
	Mon, 11 Sep 2023 04:11:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+2L10HRVutTDvEndILBWYl1SG/htZzOMWzroRyVl36PK6aEgaTFntF2c/Jo1kANI5zgw4bWZcgx3uvAdPIkdzJPFNJ5Yo9OOfyTtlh+cuc/XTqt7eRpBVEeloTKgH2h9a5B//QmmT/sHMfdIlmqSC0MCNYTmUU5utoQiLJLd4xk2BiP689QwxGbyL77AVmiYd1xGSyC0kIoeZqww6YPcPRHF9jR2Rue3r3BW0EkjRoV21mFfVNMntaJ9OqQTeMd8vU8HW21hTU70BE0ee1h/aXIFMs9WHou2uanzUcsuq+/JbFEgYbHYMcHKUcm9a+RkQ/NHdLA3E8NY6DyTxN6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ztg+XGR8vlope64CpxLRcWWQvLuum9JujhbDM0FZr68=;
 b=iSzyuvIXXlv0/Xocid3dKuxR21AXPMy6GTYl5e7Nl2eYoRAxPEDM7cnaX9TI/1kREXuY5QWP4E7Ql2LS2oDao+4u9g/lzrWrJl+dbFlkT++mYe6ntxNozK1QlWlLkJ8jEoWyZnE9RCvf+FxMR0n0lDost2SXauDj7KjrHCcfzirWVsrYUz5mwF0ExvTLVZJOIZcORlu1R4Jy5LZmz4OhssRZ5cQ7TUeaYsLH8i4H4rZxpd/HiiPs19yJO/yzJvmBpyXIoFOIO1qLitP1HROVDPj8W8MNhJCaxadvv+MJ0O8ZL/5wuSS4p3q3YR5DvohhmJ1zhE+M8HgaDcjcJIF0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: Zhu Lingshan <lingshan.zhu@intel.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index: AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHA=
Date: Mon, 11 Sep 2023 04:11:46 +0000
Message-ID:
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
In-Reply-To:
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB7864:EE_
x-ms-office365-filtering-correlation-id: c519c97f-8cd1-432a-7182-08dbb27d3724
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pVALuoFHrYvV/kGdUCrpI4ilVfi8fwHDrUdAnyV8qTCfBZJw9aPCmP2Xs7LWkUWfViqKTlPunPsSoUfuT2hxv015+LTFq5HAdsXJ0w4m5RBj7L1uf9emwDD4t7e/JynmgM78GKfp8OPncoURgT4RhKm0+p+ZjsTT+fypu8O/rywGHeV51bPvBADiV5mFFDbC2UelImutydA7f5eL0QTtk/qJwlXtQsjpN4sGz521If+5xp4M5NhYnynteWDdUcGy9bvloofxQufnxo83yzURi1L3mSMKJrL36iKu0vUA4i52/DsrQc7sU4rY3ws4BFx/WvL6bEQZJBJR5XuthtXJ+7z0RGSOENuVygssB4kNv2FoNlDkbN8QA7HVK57L4Jdgz2OHVe+DB4cCy6O+iPS2+hCnzDCgu21t+rQkOVTiZ9ub7FMNe/Tu9K20Pvn3ppAT3epA6hl9C7dkzQ/Ti73Lz/t4Tq9/KiZWZgW9xQWkcgBwk7hQsK6PL10aXMhmn9XipTCZlcWvn1JRvhqkiboe3F5nJTus5+qaip+y6SDMxhbBZpJWZIBrsxoqqK2V5IgZg0pHst9Davzzd5AEcdrjbF7YiiRzmrvjzp3NcA5EQagjtOmoic32dXg8EfHoV/6z7IYLvmoFLMoBeE7xLXhdleMae2YaIxKXdK7iiuYS5zo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(1800799009)(186009)(451199024)(966005)(8676002)(52536014)(5660300002)(4326008)(8936002)(41300700001)(76116006)(66556008)(64756008)(66476007)(66946007)(54906003)(66446008)(316002)(110136005)(2906002)(38070700005)(83380400001)(122000001)(38100700002)(55016003)(33656002)(86362001)(53546011)(478600001)(9686003)(71200400001)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEc1R1Z1N29TN3pTVSswNUJFMDlqN1drZWxOZHd2MzdCRWt4YkNNdWw2bzRN?=
 =?utf-8?B?ek1PczNmcHgzd0lnMW1DR0VpUzBNWHFhRjhhcXFPanZFSFVQSlZCZ0FFTmVW?=
 =?utf-8?B?WHhJSFBESWxqbHZBUTZXSTI3aGNmcHlmMkZrZk5XamgxaysvSkdvZGdkNUUx?=
 =?utf-8?B?ZXJBclM3amhhVld1cXlVd3l1dTRnQlJkZW5MejRsWkZVZEZQMjlJM3dYYUsx?=
 =?utf-8?B?ZXkxUjg1MDRvSTNIMzlxQXRMYmw3SXRmbWpqKzd5Z0g2RkJwV1F6cEYvaksz?=
 =?utf-8?B?V0VhK3V4ampmS244Nk81Yk5VQ3ZOdjd6Z0V3T2QySTY2RG12SW11VG1PYW1u?=
 =?utf-8?B?bW1Fb1ZjZDd3NDY1b3RRUmVMVDEveGNJV3VRTUk0dCsrcCtlWTA0eTUvdGJ3?=
 =?utf-8?B?NTdBWlp3TS94LzF1bnh4b2VLMUlvcmExOHFWUGNLcmZ6dkFzKzlFY2MrelUx?=
 =?utf-8?B?R1c2WEF0bE1pOVpVZFdQVDM5WFRyd1JXQm5zaEVJMHJhekc4cFpVSnFNNklO?=
 =?utf-8?B?bFJ4THE3cGI4SUxDQ2V0TDZvTVVsVFBOSnBHZnAzbUMvTjVIOW5TajAvekU3?=
 =?utf-8?B?QkcxNEZRbmVHYnZpMUJ2SUg4bEQxOGcyekxId3o5NGh5R015YloyV1EwcHJ5?=
 =?utf-8?B?c25HcFhKYkFraVJSYTBwRS9DRGFDNWZvK1Q2bzYwRlk0cXZ4VkRENkNhT0JO?=
 =?utf-8?B?RXVmZ2Q0TmJSQ09FVE5uU1BIZHhBZXJYTkNGejU5NzhSYUxKTklIb292OXc1?=
 =?utf-8?B?SUV6WU1TWFFoQTlJQ2tYZHMvbzZVSm1ub1NVRkVUZ0VJOUt1Wmg0ekRacjdE?=
 =?utf-8?B?MEk2c2V4N0R2bkphYkl4MkZwS3VRaUN4dmNuZUZaZzZoVk9JMS9iaUdPMGMw?=
 =?utf-8?B?Qy9BaFg3SktRcERsV3BkYmFMemtPWDg2ajQxZ1ZSRDRaamFuc0VUdzErYVN2?=
 =?utf-8?B?Zkk3Qm05ajNxQVZ4V1dwWFlPd1FXd1cwdEZseFZyNnpOVTBMT0JIb2dUZkEy?=
 =?utf-8?B?YTNpRm5YVVNWL3dkN2JkVnNwOTRCdHo1aEREK01tblYyck1tcXo0ZzVya2Nu?=
 =?utf-8?B?eEV4ZlIzaFZkT0EwaVZiZ3pieE93VzF3Qk1vRHdYeVpnUzhwMnhMRmdMZjhB?=
 =?utf-8?B?TVl6NHhybUR4MXZBL1NvWU4wVHVvVWNhWkRsVW9KQXViOTl6M2VremhWUUM0?=
 =?utf-8?B?cWkzRFZkOFIwUVB4eHFsMm9ZZlgwT2NaL0I0RHZPamN3Yjl0bGVDREI2ekR0?=
 =?utf-8?B?K05zeVBPNHNKNzljWjA3dW96UDV4elpzNVE3cko1SUhtMVZYcGVrRzc1STVp?=
 =?utf-8?B?WEpFWXQyMkV6QWhUaDczUlptaytMclhLS0hpb29XK25XcW5FUUwrYnJXSXhz?=
 =?utf-8?B?UnpCb1ZlNW1pOXZHRnoxaEorSEZ4c2J2emU1enAzcDczSDZZeEhqMnExTEpB?=
 =?utf-8?B?YjJDYlNKNHI2dHRHSnd2Y2xTcXJhTHJ1bEQ0MWJSUU5MbzNQUXI5cm5ZQXFu?=
 =?utf-8?B?dHhJRDJpeldZTERQcnVKU0NIemQ0YzVSZUI1dDFxc3h5cFNycG54ODVkbGVN?=
 =?utf-8?B?bjZicXdra1VEbTk3b3VhY3RtbGJkS3daeDVDMmd3Q1BtQnJucEhXVmhzc3hB?=
 =?utf-8?B?dVVCS2pBVGNJRVpGbDdTQzBPVjd0RUNPRTZtcTRlbGZvTnNSTW9LcUZ4VTdw?=
 =?utf-8?B?L1U3Z0pJUG1yRkNVOTJ1ZnVlUTBiZUZpSzB2WVUzNnJnVDFWc0RBWG5RYlpT?=
 =?utf-8?B?bXlrb1VrZEhCSXFjZ0RodGp1eXV5bVJtSWZLaFlsYUFkYzAxVGxRaG5NSlpP?=
 =?utf-8?B?czRIeWd5c3oxRzFXajZRUFZKMXZGeW9OMzhvYVpDckNCZmZLZWtoVFk2Z0FY?=
 =?utf-8?B?N1diRW95ZGZpd2hBY1B6V1NXWXl2b1VMdUR4TzIwOTlXR015Yk16UDl6Qmxp?=
 =?utf-8?B?MEl3RzNLSUlmTjVWZzE3dTRXWjZoUUEzSG9OZnJLUmx1OFNVWGJHT1NjQVZR?=
 =?utf-8?B?aGNld2NDWmdYckZDeE41RVIwSmx4R2RvaTVneEdvcmx3RGhJYUJ1UUp5TFMx?=
 =?utf-8?B?eHRvekh5Q3dOMW5oeldJaGdOelg2d0RQeEsxMFNrOXdZcXd0SGJWUkF0UFVm?=
 =?utf-8?B?emVpYy9FMkpCWVhrLzJpL2pZYWxhc29FVVJLb2V1ZTZOMkZ1amovZFlVRWta?=
 =?utf-8?Q?W6+mPPEj9s5mcwV6KL3geNY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c519c97f-8cd1-432a-7182-08dbb27d3724
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 04:11:46.8300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peQjJDhHrvPOSK+oJm5Zqa+houIR3YjkMiF1YnPFY+DpHHAam2BmQKlesSJAIz1Xr7eCPztC4bcP7tzKsQ3I1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

SGkgTWljaGFlbCwNCg0KPiBGcm9tOiB2aXJ0aW8tY29tbWVudEBsaXN0cy5vYXNpcy1vcGVuLm9y
ZyA8dmlydGlvLWNvbW1lbnRAbGlzdHMub2FzaXMtDQo+IG9wZW4ub3JnPiBPbiBCZWhhbGYgT2Yg
SmFzb24gV2FuZw0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAxMSwgMjAyMyA4OjMxIEFNDQo+
IA0KPiBPbiBXZWQsIFNlcCA2LCAyMDIzIGF0IDQ6MzPigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFdlZCwgU2VwIDA2LCAyMDIzIGF0
IDA0OjE2OjM3UE0gKzA4MDAsIFpodSBMaW5nc2hhbiB3cm90ZToNCj4gPiA+IFRoaXMgcGF0Y2gg
YWRkcyB0d28gbmV3IGxlMTYgZmllbGRzIHRvIGNvbW1vbiBjb25maWd1cmF0aW9uDQo+ID4gPiBz
dHJ1Y3R1cmUgdG8gc3VwcG9ydCBWSVJUSU9fRl9RVUVVRV9TVEFURSBpbiBQQ0kgdHJhbnNwb3J0
IGxheWVyLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3No
YW4uemh1QGludGVsLmNvbT4NCj4gPg0KPiA+DQo+ID4gSSBkbyBub3Qgc2VlIHdoeSB0aGlzIHdv
dWxkIGJlIHBjaSBzcGVjaWZpYyBhdCBhbGwuDQo+IA0KPiBUaGlzIGlzIHRoZSBQQ0kgaW50ZXJm
YWNlIGZvciBsaXZlIG1pZ3JhdGlvbi4gVGhlIGZhY2lsaXR5IGlzIG5vdCBzcGVjaWZpYyB0byBQ
Q0kuDQo+IA0KPiBJdCBjYW4gY2hvb3NlIHRvIHJldXNlIHRoZSBjb21tb24gY29uZmlndXJhdGlv
biBvciBub3QsIGJ1dCB0aGUgc2VtYW50aWMgaXMNCj4gZ2VuZXJhbCBlbm91Z2ggdG8gYmUgdXNl
ZCBieSBvdGhlciB0cmFuc3BvcnRzLiBXZSBjYW4gaW50cm9kdWNlIG9uZSBmb3INCj4gTU1JTyBm
b3Igc3VyZS4NCj4gDQo+ID4NCj4gPiBCdXQgYmVzaWRlcyBJIHRob3VnaHQgd29yayBvbiBsaXZl
IG1pZ3JhdGlvbiB3aWxsIHVzZSBhZG1pbiBxdWV1ZS4NCj4gPiBUaGlzIHdhcyBleHBsaWNpdGx5
IG9uZSBvZiB0aGUgbW90aXZhdG9ycy4NCj4NClBsZWFzZSBmaW5kIHRoZSBwcm9wb3NhbCB0aGF0
IHVzZXMgYWRtaW5pc3RyYXRpb24gY29tbWFuZHMgZm9yIGRldmljZSBtaWdyYXRpb24gYXQgWzFd
IGZvciBwYXNzdGhyb3VnaCBkZXZpY2VzLg0KDQpbMV0gaHR0cHM6Ly9saXN0cy5vYXNpcy1vcGVu
Lm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8yMDIzMDkvbXNnMDAwNjEuaHRtbA0KDQogPiBJ
IHRoaW5rIG5vdC4gVXNpbmcgYWRtaW4gdmlydHF1ZXVlIHdpbGwgZW5kIHVwIHdpdGggc2V2ZXJh
bCBwcm9ibGVtczoNCj4gDQo+IDEpIHRoZSBmZWF0dXJlIGlzIG5vdCBzZWxmIGNvbnRhaW5lZCBz
byBhdCB0aGUgZW5kIHdlIG5lZWQgdHJhbnNwb3J0IHNwZWNpZmljDQo+IGZhY2lsaXR5IHRvIG1p
Z3JhdGUgdGhlIGFkbWluIHZpcnRxdWV1ZQ0KDQpZb3UgbWl4ZWQgdXAuDQpBZG1pbiBxdWV1ZSBv
ZiB0aGUgb3duZXIgZGV2aWNlIGlzIG5vdCBtaWdyYXRlZC4NCkFkbWluIHF1ZXVlIG9mIHRoZSBt
ZW1iZXIgZGV2aWNlIGlzIG1pZ3JhdGVkIGxpa2UgYW55IG90aGVyIHF1ZXVlIHVzaW5nIGFib3Zl
IFsxXS4NCg0KPiAyKSB3b24ndCB3b3JrIGluIHRoZSBuZXN0ZWQgZW52aXJvbm1lbnQsIG9yIHdl
IG5lZWQgY29tcGxpY2F0ZWQgU1ItSU9WDQo+IGVtdWxhdGlvbiBpbiBvcmRlciB0byB3b3JrDQo+
IA0KPiA+DQo+ID4gUG9raW5nIGF0IHRoZSBkZXZpY2UgZnJvbSB0aGUgZHJpdmVyIHRvIG1pZ3Jh
dGUgaXQgaXMgbm90IGdvaW5nIHRvDQo+ID4gd29yayBpZiB0aGUgZHJpdmVyIGxpdmVzIHdpdGhp
biBndWVzdC4NCj4gDQo+IFRoaXMgaXMgYnkgZGVzaWduIHRvIGFsbG93IGxpdmUgbWlncmF0aW9u
IHRvIHdvcmsgaW4gdGhlIG5lc3RlZCBsYXllci4NCj4gQW5kIGl0J3MgdGhlIHdheSB3ZSd2ZSB1
c2VkIGZvciBDUFUgYW5kIE1NVS4gQW55dGhpbmcgbWF5IHZpcnRpbyBkaWZmZXJlbnQNCj4gaGVy
ZT8NCg0KTmVzdGVkIGFuZCBub24tbmVzdGVkIHVzZSBjYXNlcyBsaWtlbHkgY2Fubm90IGJlIGFk
ZHJlc3NlZCBieSBzaW5nbGUgc29sdXRpb24vaW50ZXJmYWNlLg0KU28gYm90aCBhcmUgb3J0aG9n
b25hbCByZXF1aXJlbWVudHMgdG8gbWUuDQoNCk9uZSBjYW4gZGVmaW5lZCBzb21lIGFkbWluaXN0
cmF0aW9uIGNvbW1hbmRzIHRvIGlzc3VlIG9uIHRoZSBBUSBvZiB0aGUgbWVtYmVyIGRldmljZSBp
dHNlbGYgZm9yIG5lc3RlZCBjYXNlLg0K

