Return-Path: <virtio-dev-return-13859-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637FFCE79AC
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 07:48:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C7BD41318CB
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 07:48:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BFEF1986689
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 07:48:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B28F398666F; Wed, 20 Sep 2023 07:48:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A0E57986669;
	Wed, 20 Sep 2023 07:47:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOa+g7ChrKPoTBFe9xBQBrSK5Ljo2qgRheUqutDI3ME9UGpVLOmvZVAU4MOLzxHP7rtwWxr+e/zLmqLRwfCWfitqThRgAiovef8fGQWTu9gdGZDcJoLzqmf7KuORYoORoB3mCouyyvnHBsIGPYKYx94u+3W8F5HQcaLTOI3NQfBVwwF4PCFcTQCVhBmA1JX/NaetbxiajeKfPeSpP8/dQ7oI1X8RVGCbTtFYAOvYnayquFkbuNUbdhILvo3hrDO3cfsyUviUJcomq/hnihD1sQvvhGvn45gKda3u5UBw/7H4OR82bzFLc4ttM2+00P2LEkZTcbrAH2eBEeTffqTt2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRApjjk30V4TvYwfvRYiiToW+eg62ecciafHaHPK4k8=;
 b=Dkbdj99QUmSkCRJQvR/DrLL8ca4DJcs3E9QxwJlYGoWJEG3TNBMJy6fFQiOWcCXHhAzM1epAeSAkstESVym8tBCU5yX+aXWuCGQPNx8uIFzPWhNpoPIkGHBvVS/oz7cFQRKgqC1DS7Y/3hR6Sb53RmOsc38ONwNuKqV6ci/Qc73s/99aQqNRbSOB256QE29PixdpMiRdmO+hCYWVm8sSuUntIYzgMFbXooiwKN9DIiWwVJahcGtguM0jMb/Tgz96D56MciaLwYT8ckI2dHQROrt+VcM7LnzKaf+EauKjAmV603Hreoaio6Cp25fsueYY74JDzl2+kUYnyCOtzWYquQ==
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
 AQHZ6u55wdLgYEJT5UeWhzYWiXOCmrAiFHuAgAEk1ACAAAlvAIAABTWAgAAEKYCAAABRIIAABYkAgAAAuWCAAARYAIAAAGwg
Date: Wed, 20 Sep 2023 07:47:56 +0000
Message-ID:
 <PH0PR12MB5481C47461D4E8415EE27CE5DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
 <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
 <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481D2CBCFBF7BCBF427EE1EDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <701bb67c-c52d-4eb3-a6ed-f73bd5d0ff33@intel.com>
 <PH0PR12MB5481891053E37A79920991F6DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <91c3e7ec-d702-ee61-c420-59ddc8dac6dc@intel.com>
 <PH0PR12MB548118296F71CBD9158963B0DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1a2537e9-b70c-0d85-20f5-e8ef5c8a9bb8@intel.com>
In-Reply-To: <1a2537e9-b70c-0d85-20f5-e8ef5c8a9bb8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB6734:EE_
x-ms-office365-filtering-correlation-id: 3f34b731-8056-48fd-88cf-08dbb9ade751
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HA4PQGhoEahWGRQfWFxnuDXdg9hH7MMklGZM9uzk1EUGllddsV+GfI/M01bbdkKTXIZxDDwO0+Z65Gj4txNrvsHEhDY+gpUeyCikPWm7NxIM6VItdb8RxR8pmBzyEJIPAsTBeua6MXu7wxT/uauhrR/lrfIJuy5bH27iFVvfqgpnIgtaYWKS0h5XVV2GFHTokE4dsl1FdSInZTCUU01BLttcVQiyQI4TCQ5Xna9lBAViGC1of11p6KDIOUDVqw2Um9mxbWwjkmaSjxsTF50G5FQ+Hykc8JZihTupMQr3J3PWdVUdf9karvGQss3db4vZITtIs6cGWYC/YP3/UDgYsCHJjPDWqDr13JcMyhgum8QZeZ+DPy0FGXKhJV56k7EZhwqJThZ04nKSQrQpEG+1ht4XgE1vLvVF9o/OYVcdBWNXoEaqEy8MTStUBH2SqWEUONYm7J0A1xwooyXqwgWtpL7+Y85flkMAx0dDOHe6SmtIei0tDQHu6xbwJ8cmQPDTPUblU39eO0suWQssoqlht97qJ/YGiYiZE7ukXC/N0j/vhCeNP4nJZW6vX5rKA4Jl0LoiBzG0DAzAr4N7aaUNwyYs/BIizu5gKTySX2Lw1gOERF5DBcYKz0gs7vujzUeb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199024)(1800799009)(186009)(6506007)(478600001)(55016003)(7416002)(71200400001)(26005)(316002)(2906002)(5660300002)(83380400001)(52536014)(7696005)(122000001)(86362001)(38070700005)(66446008)(41300700001)(66476007)(9686003)(76116006)(66556008)(66946007)(38100700002)(110136005)(4326008)(54906003)(8936002)(64756008)(8676002)(558084003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWtDM0pudmxVSlJvc2NIU2tqOU9qOGJXMFFDY2NLQ0FJNVNtOEdxRi9hV29R?=
 =?utf-8?B?eFY5ajM4cWNRYmNPNkRBVm1PZzA2WTdSdlMvRksxRzAwTmdHanNSc0ZmRGZT?=
 =?utf-8?B?V2RTVzdHM1haNUhwUkt0OHUxdFN4THlGamowQUdXUzJmSldUZ3BiWklKY0hx?=
 =?utf-8?B?UkxDeFhyWUh0NGRCRGV3OStaczBGVWU5dXBhcTJYTlVXZWVueG4zanFlWDhN?=
 =?utf-8?B?VS9oZXhWR2pLRlg0TVBEa3RZMjhRUTBYZGtQZytzYVpYWGlmeVZqa2lQbWY5?=
 =?utf-8?B?VFk5OGhRY2RSQm5pSWszVWx2MHJMd0pKNmlNOGFqb242ODNWUmxLZDJFd2Vj?=
 =?utf-8?B?YTlPOFdBNlVlN2F2elhMblVwbW1HYVpKSUtEd2dRK0dyTkdKUHFJY3ZVbmd3?=
 =?utf-8?B?ZnhZMk1kTThmZFJQWmEydjVMcWp5THdobmQrbTF3R2ZuN0orMXVyY2x5Yzkx?=
 =?utf-8?B?U3BQWUdtbXRlR3A2Ung3S1ZOeUF2Tko4ZEdTa2hwSTVleEtoMDFacjJYQXY3?=
 =?utf-8?B?TUZhb2xRYWZpR2x1bS94Q0tHTzdZemlKZVV2b1RodWNSTnlvbTc1V1JuNFZh?=
 =?utf-8?B?REhoL0I2b2UwUjRUVkdKL1lyNDMwREIzT0pZRFZob2loeFNsWG5EWGZhcU4v?=
 =?utf-8?B?OFlsSlRVNHpXNTV2elZlYUpBYmNYTzNUVkExUlFPN0Q5ZHVXYnBaRi9yQ01M?=
 =?utf-8?B?SzBIdE1LbUdIMEJkcEU4elBCNTE3STRQVzRhRUdwM2phSnBIUUhpaENSN2VK?=
 =?utf-8?B?L1MvdWpIanRqQnN1QlVmQkRBSGxqa05wUWlERUh6cXJUcnhHZTRPblA1djVn?=
 =?utf-8?B?TlA1MHN2VWRORzdJSTBTTDRzRUJlbjN2WFdwUXJSVXFMWEI4OC82VllPMkN2?=
 =?utf-8?B?cHc1YUxBaE5reVJ4bjh5NGVaa0JKOGZSYW41RURLN1JOQldvWlBUTXpDSEc1?=
 =?utf-8?B?cTZVZE5LZ21DeXJ5WVU0MEFlamJhWDBLTXJ6MGRMai9waVVqVjBTd1g1eEl0?=
 =?utf-8?B?T3V2Y3ErdjRnZFNwNWt3YVFCb1VsSExobENlekJXd1htL3BoZG1oZmhuT09Q?=
 =?utf-8?B?U3FQcS9IeUE1UzRKZC8vMnpCS1JCQTNQWlVxd2dtSkVYMzMyR0RCNHRVK0dk?=
 =?utf-8?B?ZVZ4OGpUNzVYOEYxY3hHaDRIT3gxUndWSnRTRWYzZms4dmlTT1VlbHJxVTRu?=
 =?utf-8?B?TFBSbFdpNXFUR0t5enE3OVVnYlMxT2tCUnBLRUxBYitoVDl1SWt3UjJjWmF3?=
 =?utf-8?B?RFh4SWJPZUFJWTVBZytBeld2K3hqb20yVEdPMjU2RS9YSlJxZlNIYmlzbTBy?=
 =?utf-8?B?U2ZoLzNjbncwblV3THZQVDJDcDJhUGNab1RNOFZUR1R1M0ZRQTNrRlg1dW40?=
 =?utf-8?B?ZXFjTFgwR2ZaSkRmcExMK1duTGsveXRvQXYwdjF6dGRPQkFXSjF6Z3RnRmIy?=
 =?utf-8?B?cGZzSDJMWnVlUTdPMlFBdG5qUGxHY1JNTWVqK0JOSGU2d1R0WmJ0dlphNll4?=
 =?utf-8?B?YmZrbzJqamlJQmtBQUphSGJ5cWtwSUhtb1Nxc3R5ZVo1M2tYN2tHQXhUSlEv?=
 =?utf-8?B?anVCMWNOUDJsWUNKK2x6ZDFUUG5oN1R5aE9FZnFlUjh5OXZoQ3pWK3Jqdlha?=
 =?utf-8?B?T1kwVXBoSVZ0Z3NURXp4OWNJSmdnV0JVdEFwZk1yQ0M0cFZaTXV4dkZqYkdC?=
 =?utf-8?B?Unk3ZUtTdVluNk5peS9jdURyUGt2QjJjaEpnSEdtNjV0a3JSeHJCSkJBMzc1?=
 =?utf-8?B?L1BlQU91VFNtNk9NRUhwc1UzL2hPT2pOWjNiQzEyQmVuNTdZWEVJb1lUQlV4?=
 =?utf-8?B?eHpRWGxVRG90MkpvY1I5dzRac3JpKy94TTVnMThybCt4bm5iTFZxOUJpR1g0?=
 =?utf-8?B?QWIrRVFlcjR2YlpCNjEvQm5EbXA0NGFIQklrNDJrbHZaWWI0OUZ2Z3orbWV5?=
 =?utf-8?B?aVBaWk5NMWNzYnBTTkF2Y0FlaHBESG0zZ0pKbUZOZjU0bU5KOU5VaXRoWFE3?=
 =?utf-8?B?WEhVbFZvUUhRcDI0RGJzUnp2QVNzVFc0VE9oS1ZtUmxucksvVnlENWViUCt6?=
 =?utf-8?B?Z0cwN3Y2ZHo1a3p6Mk1SN3ZSMmhnSVVIYnJZUW5NYzFzTDR4Uk9CL0tKS1Ft?=
 =?utf-8?Q?TkQ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f34b731-8056-48fd-88cf-08dbb9ade751
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 07:47:56.4299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lgp/xuaPyV52CdCFqd4A62IFnCmwfyLz2Qsms0XWxLnu/9lkziHdc5pG/gedillhZuPcDr9sPMDy3798I2iQJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734
Subject: RE: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIwLCAyMDIzIDE6MTYgUE0NCg0KWy4uXQ0KPiA+IEluIG15
IHZpZXcsIHNldHRpbmcgdGhlIERSSVZFUl9PSyBpcyB0aGUgc2lnbmFsIHJlZ2FyZGxlc3Mgb2Yg
aHlwZXJ2aXNvciBvcg0KPiBwaHlzaWNhbCBkZXZpY2UuDQo+ID4gSGVuY2UgdGhlIHJlLXJlYWQg
aXMgbXVzdC4NCj4gWWVzLCBhcyBJIHNhaWQgYmVsb3csIHNob3VsZCB2ZXJpZnkgYnkgcmUtcmVh
ZC4NCj4gPg0KVGhhbmtzLg0K

