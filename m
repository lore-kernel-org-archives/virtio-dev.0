Return-Path: <virtio-dev-return-13815-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7BBCD5481
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 07:32:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8F728F3F57
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 07:32:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78D29986559
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 07:32:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6896D98651F; Tue, 19 Sep 2023 07:32:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 59B339864D1;
	Tue, 19 Sep 2023 07:32:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k86Iak9mE6nPlX5AjMo8OgCWYfdGeY28vMjkI63uBe/XwLt/f3w6Hv+eK7aCQ6wfDtBEsn7BKmNteTpu6+M7QEE/s2Wy4+MNY0eojfEZSbiwWRswmbW4JGkSFN6RY+o6HXsEYzQf79piOLQBxy01rX6PegFcxetGNH7CUHcTPEegrxg17OcrPad8DtSaeAnjKcIqQiYygMoHRkBfTUvByYaJLmOpPobqC/EeCEOD6Rhhe5BfMFl3W+8p6ajincu2r3y0jPDZkw+FV9VlRyZico3ikX2SCFZ+d2ovrhFv/FThnF2zO4/1LsyYNeBGw5+sITnTuRQtLLsnrNvwUXSDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4PIJFRwwCqpJmBMemj68LqqCJojssMlXYjXEi2AzeI=;
 b=avTnZCASoTSY3U0DcljF/7xeP9sRb7N5dkUzO3lyG92oWcAss+b1OxIQ+YHbeaEuoD59BoELCnVuOrpk4JyihkAv8YQLTdyNvDENGw+NsxNncLPZ31AN9Wgr/x6daYMwzmk0MV/zdXBtQluqJ+c76MP0SfdaTqYQKuuMPTOLJF0L5ONDBdoOo2IzCzZIKoQNFy5KH3PwGuwUjY6mc7NqeIfTpwC3GxIPlD9gsBwxKpchV5yJZ8j8nCEDLmmUzVdcDD5i0UK0XTV1YR7Lroztdydhl6mjC6+sDCrKN6EokCkNUyU+Km3/DGuImS88N5zqg50CZyVQcVi/DCUcJ2GBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAFrJICAAB38cIABe3mAgAAAQYCAAXhzgIAE3FuggAMT7QCAABCHwA==
Date: Tue, 19 Sep 2023 07:32:52 +0000
Message-ID:
 <PH0PR12MB5481D7D5EB50AD9E5237BE15DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt9ATuU_OwtE_9rF1XHKCd9GavWCHx6_dFXCZibMKzJjA@mail.gmail.com>
 <PH0PR12MB5481D538B4F3F76B393C5757DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEs+5AjGzeDbWZYSkOMw65d6g6oDfgbOapa1G3EbtLUy7A@mail.gmail.com>
 <PH0PR12MB54811C3EC1618E413695D8FDDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMz3KShVbxpf_DLSx8qde=8JAdPPYOnA_udEfQ8UU+uQ@mail.gmail.com>
 <PH0PR12MB5481EB8FFDE1915271D3CA4ADCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvmPh3-kWY0FmnnR+7RS3pFWtU=e_3BexkJRk3Spc8Zjg@mail.gmail.com>
In-Reply-To:
 <CACGkMEvmPh3-kWY0FmnnR+7RS3pFWtU=e_3BexkJRk3Spc8Zjg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB6709:EE_
x-ms-office365-filtering-correlation-id: 5913c7ce-8228-407c-54b1-08dbb8e2a200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jVKWZHEcdp+H4SUoPKSzVKRsT/9/L83KioZMjdPqP1+OtzSX6C5F4dVopZNHqzz93NTeSZXZIYJqpRdIo8sW0c3vPLpxGmFBYrCWNOzIeZbpGbMHifN234QkSCj1ByeaeLKH5CDMYBkdS7w3+Kp5RQRKsB6S8HOK/sEdsdjYqCjLcFAhHzrJVEMVcn/jnsYhbG8UawdX97w8S7Vm8NVHhhW840DGs81hza5p8uo7vWzbBuNsm/vYque/EvoxMNbaDmBZG53TvMprx+INMoh/kCJmKkLwyA1NtdnZNm/qlh4hxgceRnwxDJrre0mxtVW9WzA5/xD8F50GvXcB62wdQ3NTFVW/bE34+2YuHkp5SAMBzPH36frg/cua6ffCgo7fbvB+fSGtRbluSs5hpy5R1agU0QDeKi6L9Ak/JkjgQgH1Jc8eAaZOweCp4gQltC6yok8tmoAxCCxu1TsARygNkVvcDfcsimHzY1xgbzNbtOKEe78ksB5oJwvroAYq1pEG0jgVe0IRVCU+sjbZB3u7GLMclJUwXROR6O3TvRhZxc6h1Gd4qjDS+N59QNR7fmUKHaQLfLDw+FhQnub/niJeSZZ8c03z8ZKROrT6OSI5bg6kLdVMvbe+N/mDodoaZxP2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199024)(1800799009)(186009)(38100700002)(122000001)(86362001)(55016003)(38070700005)(33656002)(2906002)(55236004)(7696005)(53546011)(478600001)(6506007)(52536014)(66446008)(8936002)(66476007)(54906003)(76116006)(66946007)(4326008)(66556008)(8676002)(64756008)(83380400001)(9686003)(5660300002)(41300700001)(316002)(6916009)(26005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akdGVEZVZ29BQzZ0TEF3TU40Sk1Rd2lVZWx0WGFVcDYxRHVPR1BsNEJKWEEw?=
 =?utf-8?B?VzZzVUN2QytWa2tCZmJJV1RkSm0xNU9FNG5rbUlJTmNMSVRZanVYZS9WU3BO?=
 =?utf-8?B?OTFyUGNiUEZBbzd1WmxQT3QrR0E4ekEwOTFUdEZXNkFsOXIzUFgzQ3dkRFRo?=
 =?utf-8?B?OXA1VmdEYlNZSktLYTBER0VFcEhpRE43azZpYzNsR2hBbXd1SU1oWmFtbUt6?=
 =?utf-8?B?cWZUSkxNcTR5VTM5R3hhUkVlSTd6RE5LdU54QnNRRmJtNis1Q2hBbHNqVzJx?=
 =?utf-8?B?WmhGTGJScDNkNmFyTEpiS0tjeHJOYmR2RGdHQTB0b3F6QmErS2FadEZTcC9y?=
 =?utf-8?B?czJ4QXcyWkxmdUFVVHN4ZEJRaXFGeVZHeGx0c2VlQ2NJcmFNL0tTWnpDSUcx?=
 =?utf-8?B?bmhxWVFIK3dkZ3p1d0hYdDR3Vm9PL2xBTFdXQ2ZIZ2pCeXlWODFpUU9wNTA5?=
 =?utf-8?B?a0xTYVNCMWkzVUVodW9tWHV0N29EUm01WjZDUHNxZ3I3emgzV0QzTFl1dUpz?=
 =?utf-8?B?ZE1Nam5WdGJrWWhBMlltN0FuTjNVbTlXZnZGYUl1Z2NsbGwxN1pmbkVnMmNp?=
 =?utf-8?B?M29IeEtONXRwY1ZmUGcyUHFJdXpuNFdqb2RRcnJkei9nSkkxdlRNcUU4U1do?=
 =?utf-8?B?alYyZGd2cTR6ODRGUDZJM294eDVuMW5OYVRxWG5HUEpLOG96b1hZOG5tKzhv?=
 =?utf-8?B?NzNrL05OWHdvSlo4eVlUZlg0cHQvU0lxcmRQUEVqWjVnRlFDTHJHWVN2elNQ?=
 =?utf-8?B?MmNBWFYzbU5oMFFCK0drbVQwMk0ydHBaOGN5Y3R0VTRBakw4SVVjcVJqWEtC?=
 =?utf-8?B?c3pOTDJxWDNHbFhtejk0bWt1Q21JcHZqSmpYSGxTVm9pcW5DbVAyWHRncjZi?=
 =?utf-8?B?dTByUjUzeFJOOTZla2QyUzZWNm95eDNWdjZrUm1FazVxVjc0MGFnYUhOZzNJ?=
 =?utf-8?B?blVNaGJOQnc5YXZlbWpxZEFISDQ3d0hwdTZEU0dxRnNKY3lVVUR6dGVwS2Vr?=
 =?utf-8?B?eWlmWFRkSHhFbWcwY2ptb3dnSkgzcEprNVl5ZVl4S1d1L3JubGdRZ0lEOGRJ?=
 =?utf-8?B?QzdhQzJEZENyVDFzbzFlN2FsczNvdzl5STVXQVFxK3lsN2lKUDJwK0xZQWxX?=
 =?utf-8?B?L2pIZUh2Z2ZjRzVmUjdEZ0RCSERvSjE0OUZNcGh1M2NCQngraXNnZ0NKYUFG?=
 =?utf-8?B?eHhXMWwyVW1pR25vdUloQVkxV1ZiV0JZSEltbThNQXMxUm0zVFl1L2VBbUZr?=
 =?utf-8?B?VkVpQ3Y5UE9pNGFDQVZJK2xmL1JzM3ErbVdiYTlubDFFQVVOcUZyR3N6c1hT?=
 =?utf-8?B?NlU1Z3ZqOFArYmNiR0RIbWNVYkNYZ3JleWdnOHVqUWZsQXFlTkhTeFhnMGt5?=
 =?utf-8?B?T3d5d2x3MjlNTlVTOGxHOUFGdEZjK1RDRThVZ3dFRDB6OTFta1V3MER4QkU2?=
 =?utf-8?B?azQyYU9MY0NVcWFyWkVUbjRoQTN0d1pJZXFpVnlBQkF3aWZGNzBFMXpUcmpY?=
 =?utf-8?B?cXJtUUxYRXVISzdBNEc1S2twSkhHMkl3eTN3RTNrOC9UUFYzWGlidzJRM1BP?=
 =?utf-8?B?TmQxTmJxK29WKzFGK2N6bnpGeGx1VzFJUHdNYzJSRjZXK2FlYnkreFpCMWQ2?=
 =?utf-8?B?VUVnVGdUQU95SXgvMWUxOVl3cnBqaXE5NnJzemJleFEvLy9udmxKTGQzZmND?=
 =?utf-8?B?cW9mTTk2czFjSUYzRUNsZG9ESXFzQk9mU2ZidGwvVm9ObEZzdDNsVU1WbG0y?=
 =?utf-8?B?MUtKdnVpWk9IS2piU3dSbGlndG91QmlxTDVXNEV4MXoxakhBT0xVOVZyeTEy?=
 =?utf-8?B?RnpmcnpINHdRRmVLR0RZWHJpdXFvNWdId1QyNlh3VjdDM2IwNnlnb2x5QXdv?=
 =?utf-8?B?UURBSm15UFlVZStkY0NINmxEM3h6cXN6UTZVL0loOEFMQXZTaldIRjJYVUs1?=
 =?utf-8?B?N0N3cmd2R2dhdTFqOFp6L2VUS2Y2aTlpaklSZFRheXloVU0yMVExd2wrTllX?=
 =?utf-8?B?Zjkvc2ZpOVEwUXVPanNXZG5HbUZPbGxNbTZDNWoreXc0WmJ5eDVkMUptNTRF?=
 =?utf-8?B?UHV3WHAvdGtpZnB3L3FLQUpQYjVVTm5FOVRXNU1KUkRoY00rdVMwRzZNMDV5?=
 =?utf-8?Q?5m3Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5913c7ce-8228-407c-54b1-08dbb8e2a200
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 07:32:52.2877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9BfgoE7JdUaDHVYGxCIe84qe+UyY0WxuBiAE7GEv6SE005+QtFoPRbBVapOfUuQHYIGmsNIRiC3vfHBmofVkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIFNlcHRlbWJlciAxOSwgMjAyMyA5OjU2IEFNDQoNCj4gT24gU3VuLCBTZXAgMTcsIDIwMjMg
YXQgMToyOeKAr1BNIFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPg0KPiA+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gPiA+
IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMTQsIDIwMjMgODo0MiBBTQ0KPiA+ID4NCj4gPiA+
IE9uIFdlZCwgU2VwIDEzLCAyMDIzIGF0IDEyOjQ24oCvUE0gUGFyYXYgUGFuZGl0IDxwYXJhdkBu
dmlkaWEuY29tPg0KPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gPiBGcm9tOiBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiA+ID4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVt
YmVyIDEzLCAyMDIzIDEwOjE0IEFNDQo+ID4gPiA+DQo+ID4gPiA+ID4gSXQncyBub3QgYWJvdXQg
aG93IG1hbnkgc3RhdGVzIGluIGEgc2luZ2xlIHN0YXRlIG1hY2hpbmUsIGl0J3MNCj4gPiA+ID4g
PiBhYm91dCBob3cgbWFueSBzdGF0ZSBtYWNoaW5lcyB0aGF0IGV4aXN0IGZvciBkZXZpY2Ugc3Rh
dHVzLg0KPiA+ID4gPiA+IEhhdmluZyBtb3JlIHRoYW4gb25lIGNyZWF0ZXMgYmlnIG9ic3RhY2xl
cyBhbmQgY29tcGxleGl0eSBpbiB0aGUNCj4gPiA+ID4gPiBkZXZpY2UuIFlvdSBuZWVkIHRvIGRl
ZmluZSB0aGUgaW50ZXJhY3Rpb24gb2YgZWFjaCBzdGF0ZQ0KPiA+ID4gPiA+IG90aGVyd2lzZSB5
b3UgbGVhdmUgdW5kZWZpbmVkDQo+ID4gPiBiZWhhdmlvdXJzLg0KPiA+ID4gPiBUaGUgZGV2aWNl
IG1vZGUgaGFzIHplcm8gcmVsYXRpb24gdG8gdGhlIGRldmljZSBzdGF0dXMuDQo+ID4gPg0KPiA+
ID4gWW91IHdpbGwgc29vbiBnZXQgdGhpcyBpc3N1ZSB3aGVuIHlvdSB3YW50IHRvIGRvIG5lc3Rp
bmcuDQo+ID4gPg0KPiA+IEkgZG9u4oCZdCB0aGluayBzby4gT25lIG5lZWRzIHRvIGludGVyY2Vw
dCBpdCB3aGVuIG9uZSB3YW50cyB0byBkbw0KPiB0cmFwK2VtdWxhdGlvbiB3aGljaCBzZWVtcyB0
byBmdWxsZmlsIHRoZSBuZXN0aW5nIHVzZSBjYXNlLg0KPiANCj4gV2VsbCwgaG93IGNhbiB5b3Ug
dHJhcCBpdD8gWW91IGhhdmUgYWRtaW4gdnEgaW4gTDAsIGl0IG1lYW5zIHRoZSBzdXNwZW5kaW5n
IGlzDQo+IG5ldmVyIGV4cG9zZWQgdG8gTDEgdW5sZXNzIHlvdSBhc3NpZ24gdGhlIG93bmVyIHRv
IEwxLg0KPiBJcyB0aGlzIHdoYXQgeW91IHdhbnQ/DQo+IA0KV2hlbiBuZXN0aW5nIGlzIG5vdCBk
b25lLCBpdCBpcyBub3QgbmVlZGVkLg0KT25seSB0aGUgbmVzdCBjYXNlcyBuZWVkIHRvIHRyYXAg
aXQuDQpTbyB3aGVuIG9uZSB3YW50IHRvIGRvIG5lc3RpbmcgdXNlIGNhc2UsIG9uZSBzaG91bGQg
YWxzbyBwbGFjZSB0aGUgYWRtaW4gcGVlciBQRiBpbiB0aGF0IGd1ZXN0Lg0KUmlnaHQgYXNzaWdu
IG9uZSBWRiBhbmQgaXRzIHBlZXIgYWRtaW4gVkYgdG8gTDEuDQoNCj4gPg0KPiA+ID4gPiBJdCBk
b2VzIG5vdCBtZXNzIHdpdGggaXQgYXQgYWxsLg0KPiA+ID4gPiBJbiBmYWN0IHRoZSBuZXcgYml0
cyBpbiBkZXZpY2Ugc3RhdHVzIGlzIG1ha2luZyBpdCBtb3JlIGNvbXBsZXgNCj4gPiA+ID4gZm9y
IHRoZSBkZXZpY2UNCj4gPiA+IHRvIGhhbmRsZS4NCj4gPiA+DQo+ID4gPiBBcmUgeW91IGNoYWxs
ZW5naW5nIHRoZSBkZXNpZ24gb2YgdGhlIGRldmljZSBzdGF0dXM/IEl0J3MgZGVmaW5pdGVseQ0K
PiA+ID4gdG9vIGxhdGUgdG8gZG8gdGhpcy4NCj4gPiA+DQo+ID4gTm8uIEkgYW0gc2F5aW5nIHRo
ZSBleHRlbmRpbmcgZGV2aWNlX3N0YXR1cyB3aXRoIHlldCBhbm90aGVyIHN0YXRlIGlzIGVxdWFs
bHkNCj4gY29tcGxleCBhbmQgaXRzIGNvcmUgb2YgdGhlIGRldmljZS4NCj4gDQo+IFlvdSBuZXZl
ciBleHBsYWluIHdoeS4NCklmIHlvdSBhcmUgY29tcGFyaW5nIHR3byBtZXRob2RzLCB0aGVuIGEg
bmV3IGZlYXR1cmUgYWRkcyBjb21wbGV4aXR5Lg0KSGVuY2UsIHRoZXkgYm90aCBzY29yZSBlcXVh
bCBhZGRpbmcgY29tcGxleGl0eSBmb3IgbmV3IGZlYXR1cmUuDQpJbiBjYXNlIG9mIGRldmljZV9z
dGF0dXMgb25lIG5lZWRzIHRvIHRoaW5ncyBzeW5jaHJvbm91c2x5Lg0KVGhpcyBhZGRzIGNvbXBs
ZXhpdHkgb24gdGhlIGRldmljZSBzaWRlIHRvIGFuc3dlciB0aG9zZSByZWdpc3RlcnMgaW4gaG90
IGRvd250aW1lIHBhdGguDQpXaGVuIGRvbmUgb3ZlciBhZG1pbiBjb21tYW5kcywgdGhleSBoYXBw
ZW4gaW4gcGFyYWxsZWwuDQogDQo+IA0KPiA+DQo+ID4gPiBUaGlzIHByb3Bvc2FsIGluY3JlYXNl
cyBqdXN0IG9uZSBiaXQgYW5kIHRoYXQgd29ycmllcyB5b3U/IE9yIHlvdQ0KPiA+ID4gdGhpbmsg
b25lIG1vcmUgc3RhdGUgaXMgbXVjaCBtb3JlIGNvbXBsaWNhdGVkIHRoYW4gYSBuZXcgc3RhdGUN
Cj4gPiA+IG1hY2hpbmUgd2l0aCB0d28gc3RhdGVzPw0KPiA+DQo+ID4gSXQgaXMgbW9kZSBhbmQg
bm90IHN0YXRlLiBBbmQgdHdvIG1vZGVzIGFyZSBuZWVkZWQgZm9yIHN1cHBvcnRpbmcgUDJQDQo+
IGRldmljZS4NCj4gDQo+IFlvdSBrZWVwIHNheWluZyB5b3UgYXJlIG1pZ3JhdGluZyB0aGUgY29y
ZSB2aXJ0aW8gZGV2aWNlcyBidXQgdGhlbiB5b3UgYXJlDQo+IHNheWluZyBpdCBpcyByZXF1aXJl
ZCBmb3IgUENJLiBBbmQgeW91IG5ldmVyIGV4cGxhaW4gd2h5IGl0IGNhbid0IGJlIGRvbmUgYnkN
Cj4gcmV1c2luZyB0aGUgZGV2aWNlIHN0YXR1cyBiaXQuDQpJdCBjYW5ub3QgYmUgZG9uZSB1c2lu
ZyBkZXZpY2Ugc3RhdHVzIGJpdHMsIGJlY2F1c2UgaHlwZXJ2aXNvciBpcyBub3QgaW52b2x2ZWQg
aW4gdHJhcHBpbmcsIGFuZCBwYXJzaW5nIGl0Lg0KV2UgYmV0dGVyIGRpc2N1c3MgaW4gdGhlIGFj
dHVhbCBzZXJpZXMgd2hlcmUgdGhpbmdzIGFyZSBwb3N0ZWQuDQoNCj4gDQo+ID4gV2hlbiBvbmUg
d2FudHMgdG8gZG8gd2l0aCBtZWRpYXRpb24sIHRoZXJlIGFsc28gdHdvIHN0YXRlcyBhcmUgbmVl
ZGVkLg0KPiA+DQo+ID4gVGhlIGtleSBpcyBtb2RlcyBhcmUgbm90IGludGVyYWN0aW5nDQo+IA0K
PiBZb3UgbmVlZCB0byBleHBsYWluIHdoeSB0aGV5IGFyZSBub3QgaW50ZXJhY3RpbmcuIEl0IHRv
dWNoZXMgdGhlIHZpcnRpbyBmYWNpbGl0eQ0KPiB3aGljaCAocGFydGlhbGx5KSBvdmVybGFwcyB0
aGUgZnVuY3Rpb24gb2YgdGhlIGRldmljZSBzdGF0dXMgZm9yIHN1cmUuIFlvdSBpbnZlbnQgYQ0K
PiBuZXcgc3RhdGUgbWFjaGluZSwgYW5kIGxlYXZlIHRoZSB2ZW5kb3JzIHRvIGd1ZXNzIGhvdyBv
ciB3aHkgdGhleSBhcmUgbm90DQo+IGludGVyYWN0aW5nIHdpdGggdGhlIGV4aXN0aW5nIG9uZS4N
Ckh1aCwgc29tZXRoaW5nIG5lZWRzIGV4cGxhbmF0aW9uIHdoZW4gdGhlcmUgaXMgaW50ZXJhY3Rp
b24uDQpJIGV4cGxhaW5lZCB0aGF0IGRldmljZV9zdGF0dXMgaXMganVzdCBhbm90aGVyIHZpcnRp
byByZWdpc3Rlci4NCg0KSSBtaXNzZWQgdG8gYWRkIHRoZSBvdGhlciB2ZW5kb3JzIFNpZ24tb2Zm
LiBJIHdpbGwgYWRkIGl0Lg0KDQo+IFRoZXJlIGFyZSBqdXN0IHRvbyBtYW55IGNvcm5lciBjYXNl
cyB0aGF0IG5lZWQgdG8gYmUgZmlndXJlZCBvdXQuDQo+IA0KPiBGb3IgZXhhbXBsZToNCj4gDQo+
IEhvdyBkbyB5b3UgZGVmaW5lIHN0b3A/IElzIGl0IGEgdmlydGlvIGxldmVsIHN0b3AsIHRyYW5z
cG9ydCBsZXZlbCBvciBhIG1peGluZyBvZg0KPiB0aGVtIGJvdGg/IA0KSXQgaXMgZGVmaW5lZCBp
biB0aGUgc2VyaWVzIGFuZCBkZXZpY2UgYW5kIGRyaXZlciByZXF1aXJlbWVudHMgc2VjdGlvbiBh
bmQgYWxzbyBpbiB0aGVvcnkgb2Ygb3BlcmF0aW9uLg0KDQo+IElzIHRoZSBkZXZpY2UgYWxsb3dl
ZCB0byBzdG9wIGluIHRoZSBtaWRkbGUgb3IgcmVzZXQsIGZlYXR1cmUNCj4gbmVnb3RpYXRpb24g
b3IgZXZlbiB0cmFuc3BvcnQgc3BlY2lmaWMgdGhpbmdzIGxpa2UgRkxSPw0KWWVzLg0KDQo+IElm
IHllcywgaG93IGFib3V0IG90aGVyIG9wZXJhdGlvbnMgYW5kIHdobyBkZWZpbmVzIGFuZCBtYWlu
dGFpbnMgdGhvc2UNCj4gdHJhbnNpdGlvbmFsIHN0YXRlcz8gSWYgbm90LCB3aHkgYW5kIGhvdyBs
b25nIHdvdWxkIGEgc3RvcCB3YWl0IGZvciBhbiBvcGVyYXRpb24/DQo+IENhbiBhIHN0b3AgZmFp
bD8gV2hhdCBoYXBwZW5zIGlmIHRoZSBkcml2ZXIgd2FudHMgdG8gcmVzZXQgYnV0IHRoZSBkZXZp
Y2UgaXMNCj4gc3RvcHBlZCBieSB0aGUgYWRtaW4gY29tbWFuZHM/IFdobyBzdXBwcmVzc2VzIHdo
byBhbmQgd2h5Pw0KQWxsIGFyZSBkZXNjcmliZWQgaW4gdGhlIHNlcmllcyBpbiB0aGUgbm9ybWF0
aXZlLiBJZiBzb21ldGhpbmcgaXMgbWlzc2luZywgcGxlYXNlIHB1dCBjb21tZW50IHRoZXJlIGFu
ZCBJIHdpbGwgZml4IGluIHYxLg0KDQo+IA0KPiBUaGlzIGRlbW9uc3RyYXRlcyB0aGUgY29tcGxl
eGl0eSBvZiB5b3VyIHByb3Bvc2FsIGFuZCBJIGRvbid0IHNlZSBhbnkgb2YgdGhlDQo+IGFib3Zl
IHdlcmUgY2xlYXJseSBzdGF0ZWQgaW4geW91ciBzZXJpZXMuIFJldXNpbmcgdGhlIGV4aXN0aW5n
IGRldmljZSBzdGF0dXMNCj4gbWFjaGluZSwgZXZlcnl0aGluZyB3b3VsZCBiZSBzaW1wbGlmaWVk
Lg0KWW91IHNlZSwgdG9vIGVhcmx5IGNvbmNsdXNpb24gc2F5aW5nIHRoaW5ncyBhcmUgbWlzc2lu
ZywgdGFrZSBtaW5lLi4uDQpJIHdpbGwgZml4IG1pc3NpbmcgaXRlbXMgaW4gdjEsIHBsZWFzZSBw
dXQgcmV2aWV3IGNvbW1lbnRzIGluIHRoZXJlLg0KDQo+IA0KPiA+IHdpdGggdGhlIGRldmljZV9z
dGF0dXMgYmVjYXVzZSBkZXZpY2Vfc3RhdHVzIGlzIGp1c3QgYW5vdGhlciByZWdpc3RlciBvZiB0
aGUNCj4gdmlydGlvLg0KPiANCj4gTGV0J3MgZG9uJ3QgZG8gbGF5ZXIgdmlvbGF0aW9uLCBkZXZp
Y2Ugc3RhdHVzIGlzIHRoZSBiYXNpYyBmYWNpbGl0eSBvZiB0aGUgdmlydGlvDQo+IGRldmljZSB3
aGljaCBpcyBub3QgY291cGxlZCB3aXRoIGFueSB0cmFuc3BvcnQgc28gaXQgaXMgbm90IG5lY2Vz
c2FyaWx5DQo+IGltcGxlbWVudGVkIHZpYSByZWdpc3RlcnMuDQoNClRoZXJlIGlzIG5vIHZpb2xh
dGlvbi4gRGV2aWNlX3N0YXR1cyBpcyBhbHJlYWR5IHBhcnQgb2YgdGhlIHRyYW5zcG9ydCBzcGVj
aWZpYyBjb250ZXh0Lg0K

