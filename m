Return-Path: <virtio-dev-return-13669-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59B1EE801F
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 08:12:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 314F871C8E
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 08:12:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B04C986641
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 08:12:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 20D7298635C; Mon, 11 Sep 2023 08:12:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F0DC9863B6;
	Mon, 11 Sep 2023 08:12:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTUH5O1IAVLIXhpCD7GlvfIQG7+BuZ6i9uTKb2caXx7B1aGk0XHbqf5vo4+MMIQNLOn03f0BX5VJDyavy4SwSVDgpT++Dtwip9MurhCcG2dChvGGnUIcbw3j8x2/vjfz3FH4/GEdhMt7EzseHgvJwuBlZijP44qsqLogcyfgdgymPQNs2TDig5sQ/ABiy6A5CvYEwbmwTD8+42FgaRnNTdood61T+G7CYPtX+zlApfaloziptIFqlcHZ7baA4a3K5anCxNI+5hD1BXD9VP67aCi98Vy/soDQ55R/HE4oFhxg7l/dlYjUGOv9BHAVwUZvOmrEkB05WHu8XYRkEeYK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yH2sUp7X7BOQ2MPreXRqnZcoOITPc+6DzNZNW6K4TC8=;
 b=Y3q+fRGobumMFZyUWlTjuSiJVHOt0bw84DQJYYibQ2oolHdk7Lsi7cqFQOk6dHDuY2lucWWXCx6VxI5BRa3dYfiI8R1dIgRm3V1zeOvtuHPFRSTZ4fA6EI0rSku7NdqPg4yL87V27Swi0KqhgL4D6aQEt6AN5eeIglZe615qYkolsQe5LoSwAMjaokYNOhA1ejbf5STAczKggNFgvvP03eko1/m1xtH0Fp+tMHbggQJhC99HjdlpLhPePe8fAx9uaEBYqWwOt15MN2JPi1QVva57wNzX3itLplanefa/zjDLGK86s2NnTbpzOaEKmjkuaL+9mSDqL+OBIRd0xZdXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNw
Date: Mon, 11 Sep 2023 08:12:08 +0000
Message-ID:
 <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com>
 <PH0PR12MB5481760E00AD18DB8BF91636DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com>
 <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com>
In-Reply-To: <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB7357:EE_
x-ms-office365-filtering-correlation-id: 26269a28-bd1b-45aa-7c94-08dbb29ecad7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +0nc3gAFhG5wY0Dsyp+dWPj46w9fJo5QZVcN5IP2GQiqBAAjQWoJaDa+uqRFXDNQJg+Tdf9L/DrfMf0HN9qDRZfhSsFg02i7wIjsPVledZ9ner0VRwt0N68MgRdrPTOWN83nIMo4pq8wiStyXty4mP9IhlODNk/WfAXxUDY0iGgtL3ksxFBU0Dh1nBP23cI81tyvvaOtQ3reeJFdthjwkJYaNfMYmuKScB4mCguAx10dA+Ja958n/Ji/eSt/B9KMrCV2Ad1CZ0G8xF7DOE0J2EaJ1sFOwscK7qk7w6G2AGI13DidnLGV37fxYNcQyhF58nqPw1npK9wwC0GxwdZvPB3oZQN8c9xATSuvlQnghyxrg8aMJ1Y9Q0SDpSUJuE6xefCWZlcyTdoQ9FazKpNUxG1PM6c5EQRV+sStPgXCT9ojTxV1ze2+HvNasF672uwthwo1w6c3F9d1P0Ed9F+lax3vM6rYV1LPMTQdkeyOUoHoKyQxtj2oQRoNDIqeORzXUW8JnGXfMPkv+AVzyo8NGxS3YsItwivIh5Bqxg0M4NAZkkR5kPJ+pbYslafXS8BXBepUAT852oaTJFRs4ix2uZhx6MjXuen9Ibb1QLYHr2R54/IwTSF7qJDFnF9p0LWYa/ytsISNQBaB9FfBiLcmovDwgzXGbTm0PhTXa3heeJ8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(186009)(1800799009)(451199024)(6506007)(7696005)(41300700001)(38070700005)(316002)(122000001)(2906002)(966005)(478600001)(33656002)(86362001)(66556008)(66446008)(66946007)(76116006)(110136005)(66476007)(64756008)(38100700002)(71200400001)(54906003)(83380400001)(5660300002)(52536014)(8936002)(4326008)(8676002)(55016003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUIwTXFlR0NoU2VaVDM2elFkRzJqZmE3M1Azd3EvODhmYmphUUE3MGFvUEM5?=
 =?utf-8?B?OXN1Wm1MRk9CV2dqNHRSdkhvVjFPbU1pT280QjM3Z0dHQjlFaDIxK1lKTTRZ?=
 =?utf-8?B?dk1rMjgrOTRwb3JrcGl5cTVBeEp4ZGRGaW9ORnJtNWdtVFRNR2hMODRwWVhG?=
 =?utf-8?B?T1h3MEtRWUNWa0VIMEtjcXZoaWVnV3ArLzNGemRIaVJRdnhOcjFzL0t4R2l5?=
 =?utf-8?B?Y2JsVUJDNjZuUU0yMHRBQVNLdE9wQ2NteEo5TitaL0VHTnRnRTJPNHh0QThB?=
 =?utf-8?B?SmkxcFE5R3o5RDE1K0ZZV0FtNmN1NTR1ak44bXZHTjY2TSsveHJqa1lpYito?=
 =?utf-8?B?clR5R2tQeU9oTWtrMUNNUzREdFlXT3BQZW5iQVZIdmRMOEc1cHpjVlh0VFgr?=
 =?utf-8?B?SjBNWk9vaDg1K0xJeXVDUDBEam52N3V5NWxJWjhCZm1KbE00R0l3QTVZVHFB?=
 =?utf-8?B?bzFLM3lTbEN0RldHaytiOEVhZ0RHd3Aya2NIcm1GOExxdUdBeDkzb0thYU13?=
 =?utf-8?B?TkFIRVpwNHdNSzFoaDRUQjA5M2R3TXhtZWtqN0IydE5tMWZKdHJhSnVoSDQ1?=
 =?utf-8?B?cE8vNlQ5bU1ZcUw3STYxZXNWMmlFRzFFWkZOUURuYlI4NHYzRk1YUHFvbE8v?=
 =?utf-8?B?cjhycGU4VUE5ZWVBM1hyWEZVQWIwbXRLWi9aMmdwcHlNYVBlMWZYR0RmbDYv?=
 =?utf-8?B?VkdlUVlwNkhKSHNFRHNsaTRhRGhCMWRnZFVOd2svQmdHMEF1VExjSW5Qb0dI?=
 =?utf-8?B?V0NXS3I0b05aTERIdXdWMmJUUERkNmlyKzRteGkwSGs0NnNmTkFBVWRyL2hD?=
 =?utf-8?B?MVNkRkNVQktQc3ZXVUx0T3FrZktESUtCcjBRKzE3MHBYOVdLa3lmR1RoakFZ?=
 =?utf-8?B?NjJDanAzeEVZQ0hUY3IxTFlqNjlNdmFOdUVyZS9nSytlUTcyZHBkQzVueHlm?=
 =?utf-8?B?QXF0K1dHblFtRmgvYjNuVlBzb1RDN1JEVG1QdXpIR1BDWHhWN0RCd2h3NTM2?=
 =?utf-8?B?TkhoYVpoaWJsRUc3Q1o2eVFtb2VjbmVlNWFyRU1NUGZZdTB4V2hYU051VnBT?=
 =?utf-8?B?YW96MDJMRnZzci9FL3FOSXRnRnh1ZzBXQXE3enZxKzBNN1BOUU1pYXRIdnRQ?=
 =?utf-8?B?SlFkQnV1cVcxamJpWHNkVk1taTdqY0swTno5dGhnR2hULzlkTlJwUFl1bTVD?=
 =?utf-8?B?MnRLLzh3eE9HYmx5TzB2TTRQSmxQT2NuRnhjYUlFT3dUK0pqUmlrZGtXbHV1?=
 =?utf-8?B?UmJOOWRkeHAwRFVoRmVvMkJDNXlLV3d4ZVgvTW9Yb2xBbklRbUVWZDh5bHdE?=
 =?utf-8?B?SVBuQk5wSis0aGJaNFZZZ2RTUzZQUzRUUi80R3Q2QlB2ZnprUWVNcE1lSWEw?=
 =?utf-8?B?SDg0TUVXS1JGckRDT3JsMDA3WlhvSnk5N2JCei96anZnM1BwUlFGUGNZQzNz?=
 =?utf-8?B?N2VscURIcG1HUHJ3YUxENFpoRHFUTVYrQzl3RWg3MERBdm82bjF0b29Ga29q?=
 =?utf-8?B?WmJFV1RvMnAzTVQ3TVlNNHdYcTBDQnc5Y3JmV2ozRDlES0hmVENXcVVLcmJk?=
 =?utf-8?B?Q3psUUVDL1JuZ05EL1ZHcCs5WjJQM1lDeVFxQUJWMXhBUVp2ZHo2VnR3RGdP?=
 =?utf-8?B?SUI3ZU5vODhYVzFpWlJSbTl6VEp3WldIdlJNMGIvWmlBZE11UG9XSHJlRktF?=
 =?utf-8?B?WkxzRUw1eC9HempLZm1hYTBvbS9MbGp6L0dKdnNpTGpxdXAxQVRHUU5lUkxC?=
 =?utf-8?B?MWE0bUI0Y0pFdm9KREs5c1lIeTI0LzErQ05XN0JCYnBCOFl0Ylp1c1pFaC96?=
 =?utf-8?B?cklNc3Y1cVQ3U2lsbThyZkt4VjY5SGtyRTFZSStjSEZVSW9oK0l5d0diRzZV?=
 =?utf-8?B?QVZWTjNucTdyMGQ5Rldkd2tiVHcyQVBaKzhkWTZHVmZYSVNybmdSMTVJUG1L?=
 =?utf-8?B?YVBsMmZZTXgrVFBQZ1dIZ3RuRkNnckpKMGRSa3FpSDlQaGQ5amVzRjY3Skx0?=
 =?utf-8?B?R1JHT0RjazljcHM2bklVYW1WM083OGhucEZoU3ZjUWdaQWNEYmhjT3prT0wx?=
 =?utf-8?B?blQzNkdibzZKRU9keUxWZWduWDJqRWRFRHhYVE9oS2paRjBHbExydUs1SzM3?=
 =?utf-8?B?aVlGRnVYbmcwY3Zxbk9OWUo3YmpONnhyWkFxRDlXbGZOcXZFMHZPejhGWjR3?=
 =?utf-8?Q?UwD9+8BGo9kMv8YbHuif2LHI28l2lAsDCPl/mlMYSSIt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26269a28-bd1b-45aa-7c94-08dbb29ecad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 08:12:08.0316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B9MlF2c4SVni8lldlMI0kjyyvmWbzUd4g+HLUhclkSYEfpWmqWA35QjpWWKodG7SpUm5VWY2YuDXTOkFI8HKhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiBTZW50OiBN
b25kYXksIFNlcHRlbWJlciAxMSwgMjAyMyAxOjI4IFBNDQoNCg0KPiA+IEJhc2ljIGZhY2lsaXRp
ZXMgYXJlIGFkZGVkIGluIFsxXSBmb3IgcGFzc3Rocm91Z2ggZGV2aWNlcy4NCj4gPiBZb3UgY2Fu
IGxldmVyYWdlIHRoZW0gaW4geW91ciB2MiBmb3Igc3VwcG9ydGluZyBwMnAgZGV2aWNlcywgZGly
dHkgcGFnZQ0KPiB0cmFja2luZywgcGFzc3Rocm91Z2ggc3VwcG9ydCwgc2hvcnRlciBkb3dudGlt
ZSBhbmQgbW9yZS4NCj4gQmFzaWMgZmFjaWxpdGllcyBzaG91bGQgYmUgYmV0dGVyIG5vdCBkZXBl
bmQgb24gb3RoZXJzLCBidXQgYWRtaW4gdnEgY2FuIHJlLXVzZQ0KPiB0aGUgYmFzaWMgZmFjaWxp
dGllcy4NCj4gDQo+IEZvciBQMlAsIHdoYXQgaWYgdGhlIGRldmljZXMgYXJlIHBsYWNlZCBpbiBk
aWZmZXJlbnQgSU9NTVUgZ3JvdXA/DQpJT01NVSBncm91cGluZyBpcyBvbmUgT1Mgc3BlY2lmaWMg
bm90aW9uIG9mIGFuIG9sZGVyIEFQSS4NCkh5cGVydmlzb3IgbmVlZHMgdG8gZG8gcmlnaHQgc2V0
dXAgYW55d2F5IGZvciB1c2luZyBQQ0kgc3BlYyBkZWZpbmUgYWNjZXNzIGNvbnRyb2wgYW5kIG90
aGVyIHNlbWFudGljcyB3aGljaCBpcyBvdXRzaWRlIHRoZSBzY29wZSBvZiBbMV0uDQpJdCBpcyBv
dXRzaWRlIHByaW1hcmlseSBiZWNhdXNlIHByb3Bvc2FsIFsxXSBpcyBub3QgbWlncmF0aW5nIHRo
ZSB3aG9sZSAiUENJIGRldmljZSIuDQpJdCBpcyBtaWdyYXRpbmcgdGhlIHZpcnRpbyBkZXZpY2Us
IHNvIHRoYXQgd2UgY2FuIG1pZ3JhdGUgZnJvbSBQQ0kgVkYgbWVtYmVyIHRvIHNvbWUgc29mdHdh
cmUgYmFzZWQgZGV2aWNlIHRvby4NCkFuZCB2aXMtdmVyc2EuDQoNCj4gPiBRT1MgaXMgc3VjaCBh
IGJyb2FkIHRlcm0gdGhhdCBpcyBoYXJkIHRvIGRlYmF0ZSB1bmxlc3MgeW91IGdldCB0byBhIHNw
ZWNpZmljDQo+IHBvaW50Lg0KPiBFLmcuLCB0aGVyZSBjYW4gYmUgaHVuZHJlZHMgb3IgdGhvdXNh
bmRzIG9mIFZNcywgaG93IG1hbnkgYWRtaW4gdnEgYXJlDQo+IHJlcXVpcmVkIHRvIHNlcnZlIHRo
ZW0gd2hlbiBMTT8gVG8gY29udmVyZ2UsIG5vIHRpbWVvdXQuDQpIb3cgbWFueSBSU1MgcXVldWVz
IGFyZSByZXF1aXJlZCB0byByZWFjaCA4MDBHYnMgTklDIHBlcmZvcm1hbmNlIGF0IHdoYXQgcSBk
ZXB0aCBhdCB3aGF0IGludGVycnVwdCBtb2RlcmF0aW9uIGxldmVsPw0KU3VjaCBkZXRhaWxzIGFy
ZSBvdXRzaWRlIHRoZSBzY29wZSBvZiB2aXJ0aW8gc3BlY2lmaWNhdGlvbi4NClRob3NlIGFyZSBp
bXBsZW1lbnRhdGlvbiBkZXRhaWxzIG9mIHRoZSBkZXZpY2UuDQoNClNpbWlsYXJseSBoZXJlIGZv
ciBBUSB0b28uDQpUaGUgaW5oZXJlbnQgbmF0dXJlIG9mIEFRIHRvIHF1ZXVlIGNvbW1hbmRzIGFu
ZCBleGVjdXRlIHRoZW0gb3V0IG9mIG9yZGVyIGluIHRoZSBkZXZpY2UgaXMgdGhlIGZ1bmRhbWVu
dGFsIHJlYXNvbiwgQVEgaXMgaW50cm9kdWNlZC4NCkFuZCBvbmUgY2FuIGhhdmUgbW9yZSBBUXMg
dG8gZG8gdW5yZWxhdGVkIHdvcmssIG1haW5seSBmcm9tIHRoZSBoeXBlcnZpc29yIG93bmVyIGRl
dmljZSB3aG8gd2FudHMgdG8gZW5xdWV1ZSB1bnJlbGF0ZWQgY29tbWFuZHMgaW4gcGFyYWxsZWwu
DQoNCj4gPj4gRS5nLiwgZG8geW91IG5lZWQgMTAwIGFkbWluIHZxcyBmb3IgMTAwMCBWTXM/IEhv
dyBkbyB5b3UgZGVjaWRlIHRoZQ0KPiA+PiBudW1iZXIgaW4gSFcgaW1wbGVtZW50YXRpb24gYW5k
IGhvdyBkb2VzIHRoZSBkcml2ZXIgZ2V0IGluZm9ybWVkPw0KPiA+IFVzdWFsbHkganVzdCBvbmUg
QVEgaXMgZW5vdWdoIGFzIHByb3Bvc2FsIFsxXSBpcyBidWlsdCBhcm91bmQgaW5oZXJlbnQNCj4g
ZG93bnRpbWUgcmVkdWN0aW9uLg0KPiA+IFlvdSBjYW4gYXNrIHNpbWlsYXIgcXVlc3Rpb24gZm9y
IFJTUywgaG93IGRvZXMgaHcgZGV2aWNlIGhvdyBtYW55IFJTUw0KPiA+IHF1ZXVlcyBhcmUgbmVl
ZGVkLiDwn5iKDQo+ID4gRGV2aWNlIGV4cG9zZXMgbnVtYmVyIG9mIHN1cHBvcnRlZCBBUXMgdGhh
dCBkcml2ZXIgaXMgZnJlZSB0byB1c2UuDQo+IFJTUyBpcyBub3QgYSBtdXN0IGZvciB0aGUgdHJh
bnNpdGlvbiB0aHJvdWdoIG1heWJlIHBlcmZvcm1hbmNlIG92ZXJoZWFkLg0KPiBCdXQgaWYgdGhl
IGhvc3QgY2FuIG5vdCBmaW5pc2ggTGl2ZSBNaWdyYXRpb24gaW4gdGhlIGR1ZSB0aW1lLCB0aGVu
IGl0IGlzIGEgZmFpbGVkDQo+IExNLg0KSXQgY2FuIGFib3J0cyB0aGUgTE0gYW5kIHJlc3RvcmUg
aXQgYmFjayBieSByZXN1bWluZyB0aGUgZGV2aWNlLg0KDQo+ID4NCj4gPiBNb3N0IHNhbmUgc3lz
IGFkbWlucyBkbyBub3QgbWlncmF0ZSAxMDAwIFZNcyBhdCBzYW1lIHRpbWUgZm9yIG9idmlvdXMN
Cj4gcmVhc29ucy4NCj4gPiBCdXQgd2hlbiBzdWNoIHJlcXVpcmVtZW50cyBhcmlzZSwgYSBkZXZp
Y2UgbWF5IHN1cHBvcnQgaXQuDQo+ID4gSnVzdCBsaWtlIGhvdyBhIG5ldCBkZXZpY2UgY2FuIHN1
cHBvcnQgZnJvbSAxIHRvIDMySyB0eHF1ZXVlcyBhdCBzcGVjIGxldmVsLg0KPiBUaGUgb3JjaGVz
dHJhdGlvbiBsYXllciBtYXkgZG8gdGhhdCBmb3IgaG9zdCB1cGdyYWRlIG9yIHBvd2VyLXNhdmlu
Zy4NCj4gQW5kIHRoZSBWTXMgbWF5IGJlIHJlcXVpcmVkIHRvIG1pZ3JhdGUgdG9nZXRoZXIsIGZv
ciBleGFtcGxlOg0KPiBhIGNsdXN0ZXIgb2YgVk1zIGluIHRoZSBzYW1lIHN1Ym5ldC4NCj4gDQpT
dXJlLiBBUSBvZiBkZXB0aCAxSyBjYW4gc3VwcG9ydCAxSyBvdXRzdGFuZGluZyBjb21tYW5kcyBh
dCBhIHRpbWUgZm9yIDEwMDAgbWVtYmVyIGRldmljZXMuDQoNCj4gTGV0cyBkbyBub3QgaW50cm9k
dWNlIG5ldyBmcmFuZ2liaWxpdHkNCkkgZG9u4oCZdCBzZWUgYW55IGZyYW5naWJpbGl0eSBhZGRl
ZCBieSBbMV0uDQpJZiB5b3Ugc2VlIG9uZSwgcGxlYXNlIGxldCBtZSBrbm93Lg0KDQo+ID4NCg0K
PiA+Pj4+IFJlbWVtYmVyIENTUCBtaWdyYXRlcyBhbGwgVk1zIG9uIGEgaG9zdCBmb3IgcG93ZXJz
YXZpbmcgb3IgdXBncmFkZS4NCj4gPj4+IEkgYW0gbm90IHN1cmUgd2h5IHRoZSBtaWdyYXRpb24g
cmVhc29uIGhhcyBhbnkgaW5mbHVlbmNlIG9uIHRoZSBkZXNpZ24uDQo+ID4+IEJlY2F1c2UgdGhp
cyBkZXNpZ24gaXMgZm9yIGxpdmUgbWlncmF0aW9uLg0KPiA+Pj4gVGhlIENTUHMgdGhhdCB3ZSBo
YWQgZGlzY3Vzc2VkLCBjYXJlIGZvciBwZXJmb3JtYW5jZSBtb3JlIGFuZCBoZW5jZQ0KPiA+PiBw
cmVmZXJzIHBhc3N0aHJvdWdoIGluc3RlYWQgb3IgbWVkaWF0aW9uIGFuZCBkb27igJl0IHNlZW0g
dG8gYmUgZG9pbmcNCj4gPj4gYW55IG5lc3RpbmcuDQo+ID4+PiBDUFUgZG9lc250IGhhdmUgc3Vw
cG9ydCBmb3IgMyBsZXZlbCBvZiBwYWdlIHRhYmxlIG5lc3RpbmcgZWl0aGVyLg0KPiA+Pj4gSSBh
Z3JlZSB0aGF0IHRoZXJlIGNvdWxkIGJlIG90aGVyIHVzZXJzIHdobyBjYXJlIGZvciBuZXN0ZWQg
ZnVuY3Rpb25hbGl0eS4NCj4gPj4+DQo+ID4+PiBBbnkgd2F5cywgbmVzdGluZyBhbmQgbm9uLW5l
c3RpbmcgYXJlIHR3byBkaWZmZXJlbnQgcmVxdWlyZW1lbnRzLg0KPiA+PiBUaGUgTE0gZmFjaWxp
dHkgc2hvdWxkIHNlcnZlciBib3RoLA0KPiA+IEkgZG9u4oCZdCBzZWUgaG93IFBDSSBzcGVjIGxl
dCB5b3UgZG8gaXQuDQo+ID4gUENJIGNvbW11bml0eSBhbHJlYWR5IGhhbmRlZCBvdmVyIHRoaXMg
dG8gU1ItUENJTSBpbnRlcmZhY2Ugb3V0c2lkZSBvZiB0aGUNCj4gUENJIHNwZWMgZG9tYWluLg0K
PiA+IEhlbmNlLCBpdHMgZG9uZSBvdmVyIGFkbWluIHF1ZXVlIGZvciBwYXNzdGhyb3VnaCBkZXZp
Y2VzLg0KPiA+DQo+ID4gSWYgeW91IGNhbiBleHBsYWluLCBob3cgeW91ciBwcm9wb3NhbCBhZGRy
ZXNzZXMgcGFzc3Rocm91Z2ggc3VwcG9ydCB3aXRob3V0DQo+IG1lZGlhdGlvbiBhbmQgYWxzbyBk
b2VzIERNQSwgSSBhbSB2ZXJ5IGludGVyZXN0ZWQgdG8gbGVhcm4gdGhhdC4NCj4gRG8geW91IG1l
YW4gbmVzdGVkPyANCkJlZm9yZSBuZXN0aW5nLCBqdXN0IGxpa2UgdG8gc2VlIGJhc2ljIHNpbmds
ZSBsZXZlbCBwYXNzdGhyb3VnaCB0byBzZWUgZnVuY3Rpb25hbCBhbmQgcGVyZm9ybWFudCBsaWtl
IFsxXS4NCg0KPiBXaHkgdGhpcyBzZXJpZXMgY2FuIG5vdCBzdXBwb3J0IG5lc3RlZD8NCkkgZG9u
4oCZdCBzZWUgYWxsIHRoZSBhc3BlY3RzIHRoYXQgSSBjb3ZlcmVkIGluIHNlcmllcyBbMV0gcmFu
Z2luZyBmcm9tIGZsciwgZGV2aWNlIGNvbnRleHQgbWlncmF0aW9uLCB2aXJ0aW8gbGV2ZWwgcmVz
ZXQsIGRpcnR5IHBhZ2UgdHJhY2tpbmcsIHAycCBzdXBwb3J0LCBldGMuIGNvdmVyZWQgaW4gc29t
ZSBkZXZpY2UsIHZxIHN1c3BlbmQgcmVzdW1lIHBpZWNlLg0KDQpbMV0gaHR0cHM6Ly9saXN0cy5v
YXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8yMDIzMDkvbXNnMDAwNjEuaHRt
bA0KDQo+ID4+IEFuZCBpdCBkb2VzIG5vdCBzZXJ2ZSBiYXJlLW1ldGFsIGxpdmUgbWlncmF0aW9u
IGVpdGhlci4NCj4gPiBBIGJhcmUtbWV0YWwgbWlncmF0aW9uIHNlZW1zIGEgZGlzdGFuY2UgdGhl
b3J5IGFzIG9uZSBuZWVkIHNpZGUgY3B1LA0KPiBtZW1vcnkgYWNjZXNzb3IgYXBhcnQgZnJvbSBk
ZXZpY2UgYWNjZXNzb3IuDQo+ID4gQnV0IHNvbWVob3cgaWYgdGhhdCBleGlzdHMsIHRoZXJlIHdp
bGwgYmUgc2ltaWxhciBhZG1pbiBkZXZpY2UgdG8gbWlncmF0ZSBpdA0KPiBtYXkgYmUgVERESVNQ
IHdpbGwgb3duIHRoaXMgd2hvbGUgcGllY2Ugb25lIGRheS4NCj4gQmFyZSBtZXRhbCBsaXZlIG1p
Z3JhdGlvbiByZXF1aXJlIG90aGVyIGNvbXBvbmVudHMgbGlrZSBmaXJtd2FyZSBPUyBhbmQNCj4g
cGFydGl0aW9uaW5nLCB0aGF0J3Mgd2h5IHRoZSBkZXZpY2UgbGl2ZSBtaWdyYXRpb24gc2hvdWxk
IG5vdCBiZSBhIGJsb2NrZXIuDQpEZXZpY2UgbWlncmF0aW9uIGlzIG5vdCBibG9ja2VyLg0KSW4t
ZmFjdCBpdCBmYWNpbGl0YXRlcyBmb3IgdGhpcyBmdXR1cmUgaW4gY2FzZSBpZiB0aGF0IGhhcHBl
bnMgd2hlcmUgc2lkZSBjcHUgbGlrZSBEUFUgb3Igc2ltaWxhciBzaWRlYmFuZCB2aXJ0aW8gYWRt
aW4gZGV2aWNlIGNhbiBtaWdyYXRlIG92ZXIgaXRzIGFkbWluIHZxLg0KDQpMb25nIGFnbyB3aGVu
IGFkbWluIGNvbW1hbmRzIHdlcmUgZGlzY3Vzc2VkLCB0aGlzIHdhcyBkaXNjdXNzZWQgdG9vIHdo
ZXJlIGEgYWRtaW4gZGV2aWNlIG1heSBub3QgYmUgYW4gb3duZXIgZGV2aWNlLg0K

