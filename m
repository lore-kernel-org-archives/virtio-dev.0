Return-Path: <virtio-dev-return-13860-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F63CE79AD
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 07:51:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D9FB22A8E2
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 07:51:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D53EC986682
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 07:51:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C82A998666A; Wed, 20 Sep 2023 07:51:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B1AEA986669;
	Wed, 20 Sep 2023 07:51:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhZMWRVPUBFki2nu4IFzzGAUJsOkZCzbzuKNQauz3njWNFnfB4G1o43w2KlZVl+DfRz6UKRNmdV5z7Jjzeqj+0jtVtFZBZUqnMzzoh+73U2JgAulvEDxSMKG2y6eQaVrTatR7sRgWkwqa6FWSlem8f0L54Myfdm08zaxjEc6tg1bsJ1Q+SNop8A21dGv88PSZnshmBesCmVjvtVtw93peLiOwXH+zJwmscNtVMwrIp3WlY5sH5JswlfMLq1u9ey8MB1lPM40a5P4mnYps7LbhLqAEAKcMAjkKIBvo5B9DnRMdJ0apISug6H3eMi/Icla7A3QF+g62dpH8YzpaJMz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccBWVdoPRdcx8EFgb+aDbYtpu0MBs8Bo5ScdIb2Sbu8=;
 b=L5lCDJ4pSNsUy94bqhO2vp25qRoonU2IeGHyh+Sp4GbX4Oj/PqC6+xQeOsd/zj7o3f56nlSbvlSsRtjNfC3riGpdugbimMVgJa1DCNelhZ0CaZcOepJMfK6VrA0s3RjnNvan5tjepaAu2oF+uJnEmR+0LhC+oTg3g71YIK9hQ3LTS/N+XTaEWooHdiVgZMsqWjLSpV4Bc4oEmrm9K88kDycF5sV3+pRQni/jAhT5UqtJ6UtJeKLqxWLafkFPd3/8diVVI6giOMhq9LYd6TF4IuKM0R45iv1RlJncioSWEar383bJYF1JagrD1oExwXBAszoGLp4u9cZXZgF58nc3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Chen, Jiqian"
	<Jiqian.Chen@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefano
 Stabellini <sstabellini@kernel.org>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
	<roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>, "Hildebrand, Stewart"
	<Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
	<Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Thread-Topic: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Thread-Index:
 AQHZ6u55wdLgYEJT5UeWhzYWiXOCmrAiFHuAgAEk1ACAAAlvAIAABTWAgAAEKYCAAATtgIAAAbEAgAAAlkCAAAQ8gIAAAD9g
Date: Wed, 20 Sep 2023 07:51:20 +0000
Message-ID:
 <PH0PR12MB5481E16E2BC9C5B4B786FD91DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
 <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
 <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481D2CBCFBF7BCBF427EE1EDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <701bb67c-c52d-4eb3-a6ed-f73bd5d0ff33@intel.com>
 <BL1PR12MB5849A542AA93F6ED9FEEAAF0E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <a636b841-1bfc-925a-406e-6c4469e7e4c6@intel.com>
 <PH0PR12MB54817E116B756914B3FC1860DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <40765650-ba6e-357a-cf73-ff6a0288c0e8@intel.com>
In-Reply-To: <40765650-ba6e-357a-cf73-ff6a0288c0e8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB7640:EE_
x-ms-office365-filtering-correlation-id: db94c5d7-86ab-4f6c-00a1-08dbb9ae60ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xj2Lq9PBK8GLmvD59PlNIFZUBp0VMSUnsWq4qj/Y2qT/h5QK7NlLxcejff9mGjaZ8giiiBCKHkmZxQso6ZrFAjU07jqTvQQ67MhNUSOM5eG6hyYhVRLVBqfi2ub19hMIU0ihgjXNC+8+Q3h47GBugOxbFnj53eF6BP38qNDr01S9BSkRfxp2SUn1iQ5zp2ij0bkEn6GC/WEPc4z8XTYk3x/gRuil8LS8m9SKFaLDu4ZSlLcNySQNBfm+7TD1mrlQ7Nn6K0KDSAMjZkFKEwVP9Ds+8RaJzX2qvYymUVVbJ+dsmOeEP753MZkRUBkY7CR58BnriX/6FQYIrQ7VpVrG19Qg3n66wsVBS3Ny08CdyGqAJ/tRe2UW3oxttkhtwTh2eS6EGa/ccCPlmNx6KGNvPjMQXV3g3V44xOLktrKy3rzgidG0YZ6oPq7Qnf65XQ8uYNaZ4UDkS+VAbaDATL82edMHi18rdr4e9PRme5CQ7V9/oNwuBWgEpp5jh+I8WA+7CoEEsvfiVhpKsnvGOnfya6dZ9ptpNWzPx6phI3ZGSLnCQCNHhVebrZec/bxFIs8DHmHRvBJmAsm5275zM+6//BLnHdBfdRrhYNyu5TvVbrVN7ZMsh71ILERV7MH+3Bey
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(86362001)(122000001)(55016003)(38070700005)(38100700002)(33656002)(110136005)(66476007)(2906002)(6506007)(478600001)(4744005)(76116006)(316002)(66556008)(7416002)(64756008)(66446008)(66946007)(9686003)(71200400001)(54906003)(5660300002)(8676002)(4326008)(8936002)(52536014)(41300700001)(7696005)(83380400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OW1RcStaQW5KQzhJaGxxU3ZKL1FkYzEyeTZtRElnNzhvaFNZM3JQVnpicm9G?=
 =?utf-8?B?eWJxU3BzNmU2MVI2eTU4ODVieFNYLzRPMGJYMnVRZnQ5SS9aaWd3RFJXejZD?=
 =?utf-8?B?bjJYQXY0b3lkUFoxQmJuL3A0aENwd2Z0VlVKcGpJYjQvUzdUaEw3d0FXQ0k5?=
 =?utf-8?B?MklHYjRSRXZhZGM5M0JNQTlXbzFnQ3dZRXZLRVNLWStwWHBaZ2NUWC9aai9N?=
 =?utf-8?B?M1NOSm0yTGJ5bUMwWUtudHhEVXE0NnR5T2JBelh2SlpkOHNVR0U1R05OdHZM?=
 =?utf-8?B?VW5VbUcxc1VDV2pWb2J0dXh3aFVJaktUWGMvS1ZuNStJS2l5M25INUhoSnlG?=
 =?utf-8?B?TWJZaTZBQVNKalJORHJRSXk1YXozdG9XSjNoVTFZZWdoSWZMblNYc1BMeFkz?=
 =?utf-8?B?S2JJd0dOUk1pZ3Rqa09WOXZTK0RkRll3N1dEdGxwZnlEdVZ6cGlkVWhTVDJ5?=
 =?utf-8?B?ckN0QWFrMWZMQVNjSWptZ0U1SWlKUE1tLzl3cVQwalVldWpNOHpmV2d1WklW?=
 =?utf-8?B?eVNDTEUvRS8rbEFLaE9hZ3BQclBzdUhNbEJITUI2MUNWZGpwQWpIL0U0WmNH?=
 =?utf-8?B?a2wranY2TGNPbkthekI5ZG5NV1Rad0lwYUhkdGdoVFpSb1JPTGFhK0VqQ1Rw?=
 =?utf-8?B?WnBDY29oS3ZCVDluYTNNN0pEZ0tGLzlBb084TGlxWDZOZ2Z4dExkdXR0RnM1?=
 =?utf-8?B?bWxTK1FoRVVWK3JRdklKeU5ZZTFMZjVyYnFqWTFwNTNtTlhCRVFyUVdMWi9i?=
 =?utf-8?B?Zkk2d1pDdGlON1hGTlFpWW1sQjZNUE95S21BZ3hwSG8vVUhiMnBaS1hwUS8v?=
 =?utf-8?B?bFhJM1pBRXZsZm1Ua3ZOSkFvMStVbUx1Si9EWjRMY1U3aEdqL3VGQ0F3THdp?=
 =?utf-8?B?RmNGbTg4dkV3YmJCUjVVZFByTXBIRlFvTFlmYjRQdUJ6V2pVM0k3TmVScDZp?=
 =?utf-8?B?b3ZINS9mZVZEbVRpYStzV252V0dZbzFUY0I1RDZEU3htWHBKNDQxQVdlTC9L?=
 =?utf-8?B?eUpaajg3cEpaSnVUcENkS09XRlNiMi9sVmRxQzJab1RrUTJnS3BUU3BTYllO?=
 =?utf-8?B?QXJOSlN3TXBnNmRJamJrWnE5WjM2WTJtSnIwSjI2QXR4TWUwSFRGNDROSURP?=
 =?utf-8?B?MW1wSVFZYmpSOVNRUlA5K0ZrNlVHNWo0ZDBiRlRWdnBvNTkwMGV3QWFJMUdO?=
 =?utf-8?B?SXBDSzV0YnRiVTkxKzVuTldxSkFnbXV2bE94VUZXeGRoem1SREFrUmVQanlQ?=
 =?utf-8?B?UnlWb2ZGTis5REpYQUNELzJKaTJzdVprelFZZ3hoZm9WemhhVExPMGlSV0pS?=
 =?utf-8?B?anJHRHo5azZhUFZ5Q1FWeldySWJUM2E3eGZOWW9vMWUwS0JEWWtLcW0zR3hU?=
 =?utf-8?B?VDc4VVpvaG9TNDNFRkYwSTRNUE5UK3JxZ0J3ZEo1NE0rYXlaaGRyTVVIRmtn?=
 =?utf-8?B?SVNsaW9LYllqdlBxSUhhaEVhV2xvVENNMGdVYXFydDd1eTFoaFJvdFpUa014?=
 =?utf-8?B?alJGeHBXMzNKK2tzSE84OE5iN2RXaDBMRlpIbHRsOExHMjhucG1zak8xa2Rs?=
 =?utf-8?B?R3RNNThscU8rNktRT1I0WU04UjVBdDNxWGtBNG5Pd3h1UjdIdllValc4eSt1?=
 =?utf-8?B?WkdNYjM2KytCbDRMcm5ZT1pDOXgwdTRDVFZ6ekxiTkxBbXA3QzltekxsVzlT?=
 =?utf-8?B?UkQ5cFB6aG1GeG55L2plNzB0WnZKR2ljYlNjb0tiR3JBeUMvQ0VlY1FYUEFT?=
 =?utf-8?B?a0tvQWt5NEppV284N3oyY3FoMVFSWlBDclcyUDE1dmc2SEFNKzJhQ2dxcS9i?=
 =?utf-8?B?OWlocDZTbWh4N1VMYXVGcytZbjhudFJEQ25yY3FvSVlSMXduWmNjd1ZsSFJV?=
 =?utf-8?B?NUJBRnloeDhTSmNxVnpwanlqTjRBK004bEV5SnQzRm95VFhXb1c4WWMyakx1?=
 =?utf-8?B?NEN2ODhBaHBGU1NnSzZDNW9pOExnWlZMQ1FGbVh4Mnk4d0hsU2NWT25jZHow?=
 =?utf-8?B?OFFiNU53WlNQRjZmdzFSYWFncEdNZWcwa2JwbWhqZDFpZEcvK1g2K3FzM1Fy?=
 =?utf-8?B?azhxNGE2ZGViRE14Z3NDbG1Kd0tZajNoWGtMeGZpb1dnbThqK1hKcG0ySzRH?=
 =?utf-8?Q?M/q8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db94c5d7-86ab-4f6c-00a1-08dbb9ae60ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 07:51:20.0202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tb+Peas80AuXTplDuT05i36rmTvqeSktNirRcIhhQK0iikKECeEaaZDGwvOb+g47pCEWLtj0NEdUo6EsWQ/3/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640
Subject: RE: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIwLCAyMDIzIDE6MTcgUE0NCg0KPiA+IFRoaXMgaXMgbm90
IGxpdmUgb3IgZGV2aWNlIG1pZ3JhdGlvbi4gVGhpcyBpcyByZXN0b3JpbmcgdGhlIGRldmljZSBj
b250ZXh0DQo+IGluaXRpYXRlZCBieSB0aGUgZHJpdmVyIG93bmluZyB0aGUgZGV2aWNlLg0KPiBy
ZXN0b3JlIHRoZSBkZXZpY2UgY29udGV4dCBzaG91bGQgYmUgZG9uZSBieSB0aGUgaHlwZXJ2aXNv
ciBiZWZvcmUgc2V0dGluZw0KPiBEUklWRVJfT0sgYW5kIHdha2luZyB1cCB0aGUgZ3Vlc3QsIG5v
dCBhIGNvbmNlcm4gaGVyZSwgb3V0IG9mIHNwZWMNCg0KVGhlIGZyYW1ld29yayBpcyBnZW5lcmlj
IGZvciB0aGUgUENJIGRldmljZXMgaGVuY2UsIHRoZXJlIG1heSBub3QgYmUgYW55IGh5cGVydmlz
b3IgYXQgYWxsLiBIZW5jZSByZXN0b3JlIG9wZXJhdGlvbiB0byB0cmlnZ2VyIG9uIERSSVZFUl9P
SyBzZXR0aW5nLCB3aGVuIHByZXZpb3VzbHkgc3VzcGVuZGVkLg0KDQpTaW5jZSB3ZSBhbHJlYWR5
IGFncmVlIGluIHByZXZpb3VzIGVtYWlsIHRoYXQgcmUtcmVhZCB1bnRpbCBkZXZpY2Ugc2V0cyB0
aGUgRFJJVkVSX09LLCBpdHMgZmluZSB0byBtZS4gSXQgY292ZXJzIHRoZSBhYm92ZSByZXN0b3Jl
IGNvbmRpdGlvbi4NCg0KVGhhbmtzLg0KDQo=

