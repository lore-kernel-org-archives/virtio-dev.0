Return-Path: <virtio-dev-return-12739-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A10C7EE23
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:41:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 401CDC5B01
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:41:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 388AB9865B2
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:41:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 287EC9862F6; Tue, 16 May 2023 21:41:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 121069862F7;
	Tue, 16 May 2023 21:41:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9S9my+svNrPhQTf68wr1OAB3+ZTqIWPyqn2peX2olDwIaXh100Dgj7WzAx9FcuWuPnffX4+/7kgrKkUlTkueVzinHySil+CkUWmZkBNuWvDSsxEx7s/w0h10GEOnpmXKW4bCoHP3DbVEaNpmGPSnqijbOOs+qnMXMmuKN2XoUusranua3Q6Qbxz5ULu4w/1E/rVYNmItSQcRW1GvRIHK2vnmSnIQ2tmF4pr839dvovoOB4vFR853170QeG/zPHktX0nev8gzbRyzQaAH67v5ih8RovaNAy1pioBbxe1iDx4TgU5agoX0iikHFHcLmPBQ6wkm9atoq7C94lIwVhlpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKmtNVCwbpxH3a3WjxbBE79WFXVpCJtbkikWeYk8SCw=;
 b=XGFO13rz1CSw7CJiKUVO5g5huheNp5IBugxPCa7ua6aeH97YpATGj8uV1TT00esQ/rrYzx4Dq48l55aBEneREladjiG7LSFmE0gdEHlSWGjN927XWE3lzvSShqjFXEhLkKOJBut0uvT1xwE/xffQXec8Tq6/JvQnaH5Clz2pqNm65+ilaeEaZnfM45YryOidnzviJNDm72qEpq2SXLeTCq3t/JtSDIe0uVvHTSY9qOY3H7nDT9dkaLgd0U6po9IQskbYRmRB22vW1rgt7GQGL8gcTfqqcqxrr2tcVvsrTy0y0hn5bezT+zPT04i2UfVu9W0Ipt2VE3tzXeDdtgO8Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgACpnQCAAAFGAIAAENkwgAA311CAALAXAIAAZyuQgAXjRYCAAIxikIAAx7kAgAAAexCAAArFAIAA/IBwgAAgxYCAAALtcA==
Date: Tue, 16 May 2023 21:41:07 +0000
Message-ID:
 <PH0PR12MB5481834AB783F39C269176C7DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com>
 <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <078af8e2-fb10-b33a-6751-374c4fbd09a9@redhat.com>
 <PH0PR12MB5481F2BE9C7CB89282E4053DDC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsHqD4UUB8PSpSmwYRhvthGzPJ7Up-9xQ+RO8a1N01-rw@mail.gmail.com>
 <PH0PR12MB5481205FAA079FAB1F0E22C2DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516165853-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230516165853-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB6829:EE_
x-ms-office365-filtering-correlation-id: 011d5e6d-f399-4e21-1c4b-08db565641b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zbQlOeTC+PWAOQpyD0UawhcDRpYtrUMyjV7CeY/ZMKSbrvMeWwW1BDPaUAI2BmzHP+h8sWn8lcJ9RUjnpD+3lMn8jslSVkspchgIzsWZEpBsOzKkSf+YPdRC5IOFBjGtnmaihiFngoqE9Vbt0+I3wNzfLZNLeevQtpdKjOIFRrUyNPMrcU8O639oE2LoU1pUNFmrsMNUUTFdZry5O30LNJyP3r8jKj6KkD8YFqan6/BvvDenGC9hwepbISvggaIbySjshhUp4ciPeXeI+q4zM4fzFLvXm+byIUQkG3i+MZfwE6kisg6T7XSJLhdfasYNeaR92OnjTGzYGVQr0EUXu8NObXro8H0+42+2QEea5vZZzsmS89b8PH9MXktZOemjainQZ6g5K1Xxv3E3rbkQ8ivyVvYUvhnK6NhWUM4DLiYb62snr4E2AtFyigPUpLKE5AG4+Dkg+GVLq1P/lI4CTElQuzhfdNjs/MObapeN3nwq+vqwcpvTJtShVTRhFzLp5vG7eTLfJk4Dkn3QPsQs0U2fHhDImpjPkI4joedtdXQDMuGIo3rOMZx0SQ8ogCltsdyutSDXhmUqUdh/FS+IJvLrjYEiPtwmMLiykOJ8hAnFXG0Ufzcv66/uYiixUiH0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(38070700005)(2906002)(38100700002)(8676002)(316002)(52536014)(122000001)(66899021)(5660300002)(41300700001)(8936002)(33656002)(86362001)(55016003)(71200400001)(478600001)(9686003)(26005)(107886003)(6506007)(186003)(7696005)(66556008)(76116006)(66946007)(66446008)(54906003)(66476007)(64756008)(83380400001)(6916009)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUVudld3ZS8zWUdreFR1alp1QUdQMk9xVFpMMVAyK0F1NW9ZWVg2dDM2ZXgx?=
 =?utf-8?B?MzNpeVdwWWl4TUpaUThHdTJRU01PalNXYm93bnpVTFh1U0JnVVRKTGxPNU5o?=
 =?utf-8?B?ai9GRjlGa2JEV1JEVm8yZ21jcUJwQ0pWTDhUQkJNSkhoZElLcnowUGQraGRJ?=
 =?utf-8?B?TndiOXRTaG9LcE8vUmtXWlo2aWNzSXcxRDBiSlp6eGN4RGVKblVudC8zeTNV?=
 =?utf-8?B?MVd2eGNRZWNMeTN1WEZFcys4VVhrTTdIblVSbjJLaGoxSWF3blNsa3ZXTVdJ?=
 =?utf-8?B?NEIrUDY2Ly9DUkNNWUZiR1R0SkJLZ3B3cmVuTW5meGdncnFYdTNkNGxsbUdN?=
 =?utf-8?B?SFh0bzVaUzlReG4wK1draVl1TTk3d2M4WmVlUmpjWS9JL0NtbkJGUjV3cEc4?=
 =?utf-8?B?VXpnb0c5YmxxV05lQ2JPMEFXR3dtWWJUVzhWemg1ejV2MGwvdmNkaWpyMVA5?=
 =?utf-8?B?R0ZjQlhLRGV5WEtQYytzTkhSNE1IY2VPN0QyeExaVXRJOXA4VHE3WUxYV3pl?=
 =?utf-8?B?ZUdPd2xtbld6a2dSWDd2TE5GT3dnZnhxeDdyL20zajUyZE8zUFhuZld0QzVi?=
 =?utf-8?B?aHZRV2w2WGRlcytjcDZnV0R0QkJHS3VleDdaVmtwZXBNZWRoeGVIZ3VXLzN1?=
 =?utf-8?B?Z1BFMUtMMU5WTW1mS2w2Ukx5V00vaVJweCtTeGErNWdJMWdHSFdlU0x3czdv?=
 =?utf-8?B?dHdENFhmSkdRTHEwSUprQUZJWC96SnlyUE1mZTMvTzRBNU5jS0NEQUxlVVFN?=
 =?utf-8?B?ZFFybkg0VmZjTTI0TzdLZWQxaG1pc3M2TXBzWHhTQXUvM2JwZTNkTzNYaElN?=
 =?utf-8?B?WStDajN6OXFyOE1wUndkYWJRcjJkSFYxUitNOGxRVGtrb1B1YzJWZ1psVjRN?=
 =?utf-8?B?Q1FDM2dKMmQwbWo1ZG4xd0NpZnB2Mk5SSTU1eWpTYWMxbGdRbXpSb2tYRHpI?=
 =?utf-8?B?SUdyRGh1MkxnMkFoandacE5IbmFNS2kyRVpHZW1QT3ZiYmk5TXlteEpuNTIv?=
 =?utf-8?B?Sk11ZUpaSkd6WE9BRVNuSHU4dWV5bnpEbmhqQW1uaXF2YVNNSzJ4UzVrbEhn?=
 =?utf-8?B?QUJGK3Z5bGlYQ3F3cXJIZ1JkbzhacDVtWElkK3ZNSTJTblZUOFVnUXZjSlhJ?=
 =?utf-8?B?WFNFSmxiSk5xaWJoemFMTTUzMTVXdXg5RktpYVllTElWbnIvVW5Nd0VDWVlw?=
 =?utf-8?B?VTNBdTNBZUVwMHQrSytwUEdzMGd2MEsxN1p2YkFLVXN3NHpFbFV6aURQakk4?=
 =?utf-8?B?d2dIWWRjT0dhRDlhcUZCOU43V05mckVyV2NYVGM0ODZMV2Y1ZVQzd1pvT3B2?=
 =?utf-8?B?anJwS0Z3NE04SW1IV3hkeUlBNEVLKzIwQ25aemkxOGppVWVrNC84OElMSC8r?=
 =?utf-8?B?MXo2MXRMRi8vSnowMUJRUVl4TFRIU3VrTFNVeEdJZTIrT0JKSm5jQzZ2dUo4?=
 =?utf-8?B?UFlLTmt6REZOcWFhNTh5ZG9TNzV2ejVjSm8yVTdGQlc2U25UMm54SXc0Vmlw?=
 =?utf-8?B?WmZWQ1VCaWR0WnFESkhXZkt6ek9QeTFURCswNnRVdnFwY2JLSThnYmdXM3RY?=
 =?utf-8?B?VWJrbVV0WnJ5VHM5cEc3akRaZUtPQitJM3JLT3FVNEhacStBTkRpb0EzWkEy?=
 =?utf-8?B?dDZLTTBGb3JXYTF4ZGh4U21NMkhVelFVTS9UWjRsa2ZrS3RDSkN4eDJjOWM1?=
 =?utf-8?B?NnlwcWFObXJBcllkRDNkaHY5RXhDZDN0bmJvdE5iSS8va1plRUxuRkJwcnpD?=
 =?utf-8?B?cmhDS3BvbDFMWit0THhiL0FGSHRmUkJnVXhtL3lDWnBXOStGdGMxWWgrL3cw?=
 =?utf-8?B?eDlmZEIzZjFINGhQeUhDbHdML24yWHhqc21URGNWa3VSOGpFKytsWWZ0YnFy?=
 =?utf-8?B?MEtzWW1zaWhEakh0RVhjbFBVT0NCUHc0MjdDOWM3TDhjY2R2T0VZcVRHRisx?=
 =?utf-8?B?T2gvWDluc2k3NHI4bHVSNHNNSVpQbmZBNkJOc3h3dFJsa0VrMHVhWkZaYk9q?=
 =?utf-8?B?OEFBSzJrcko0dlFGL3RRR2VTa3Z0QlhoV215OGRMb3RBNGVBTDZsL0pnRlJ5?=
 =?utf-8?B?c0M2ZmY5RGJTeXFpVHZPSE0xVmUzQTVxUzRaSFUwSEdObm1VeDAycXRMTC81?=
 =?utf-8?Q?20o4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011d5e6d-f399-4e21-1c4b-08db565641b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 21:41:07.2415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDBrlg/gjPDfEUWMLE7WxnWfRGJpxj6jXeNf35+9kLxS+vbBVa9it1hQGHkXWgtmBU4PnHPWpHluTiYaq6MDTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1
ZXNkYXksIE1heSAxNiwgMjAyMyA1OjA5IFBNDQoNCj4gPiBQb3NzaWJseSBvbmUgY2FuIHNldC4g
SSBkb27igJl0IGtub3cgaWYgYW55IGFjdHVhbCBkZXZpY2UgcmVhbGx5IHN1cHBvcnRlZA0KPiBl
bmRpYW5uZXNzLg0KPiA+IE5vIHVzZXJzIGhhdmUgYXNrZWQgZm9yIGl0LCBldmVuIGFza2luZyBl
eHBsaWNpdGx5IHRvIHRob3NlIG5vbl9saXR0bGVfZW5kaWFuDQo+IHVzZXJzLg0KPiANCj4gRm9y
IHN1cmUsIEFSTSBCRSBkb2VzIGV4aXN0IGFuZCBSZWQgSGF0IHN1cHBvcnRzIGl0IGJlY2F1c2Ug
eWVzLCBpdCB3YXMNCj4gcmVxdWVzdGVkLiANCkludGVyZXN0aW5nLg0KQW55IHZkcGEgZGV2aWNl
IHN1cHBvcnQgdGhpcz8gSG93IGlzIHRoZSBndWVzdCBlbmRpYW5uZXNzIGNvbnZleWVkIHRvIHRo
aXMgdmRwYSBkZXZpY2U/DQpBbmQgd2hpY2ggYmFycmllciB0aGlzIEFSTSB1c2VzIGJlZm9yZSBp
c3N1aW5nIG5vdGlmaWNhdGlvbiBvbiBsZWdhY3k/DQoNCj4gWW91IGNhbiBub3QganVzdCBnbyBi
eSB3aGF0IG1hcmtldGluZyB0ZWxscyB5b3UgdG9kYXkgd2UgZWl0aGVyIHRyeQ0KPiB0byBidWls
ZCBmdXR1cmUgcHJvb2YgaW50ZXJmYWNlcyBvciB3ZSBkb24ndCBib3RoZXIgYXQgYWxsIC0gYnkg
dGhlIHRpbWUgdGhlc2UNCj4gdGhpbmdzIGFyZSBpbiB0aGUgZmllbGQgZXZlcnl0aGluZyBzaGlm
dGVkLg0KPiANCkh1aC4NCk9uZSBjYW4gYWRkIHRoZSBCRSBzdXBwb3J0IGluY3JlbWVudGFsbHkg
d2hlbiB0aGUgZGV2aWNlIHBsYW5zIHRvIHN1cHBvcnQgaXQuDQoNCjEueCBpcyBhbHJlYWR5IGZ1
dHVyZSBwcm9vZiBmcm9tIGVuZGlhbm5lc3MsIHNvIG5vIG5lZWQgdG8gYnJpbmcgZW5kaWFubmVz
cyBmb3IgaXQuDQpPbmx5IGxlZ2FjeSBjYW4gd29yayBpbiB0aGUgc2luZ2xlIHBsYXRmb3JtIHdp
dGggaHcgaW4gd2lkZXIgZGVwbG95bWVudCBhcyBEYXZpZCBhY2tlZC4NClNvIG92ZXIgZW5naW5l
ZXJpbmcgaXMgYXZvaWRlZCBieSBub3QgaW50cm9kdWNpbmcgQkUgc3VwcG9ydC4NCg0KPiA+IFNv
IG1heSBiZSB3aGVuIHRoZXJlIGlzL2lmIGEgcmVhbCB1c2VyLCBpdCBjYW4gYmUgZG9uZSBpbiBm
dXR1cmUuDQo+IA0KPiBUaGUgY29uY2VybiBpcyBpZiB5b3UgYXNzdW1lIExFIGlzIGRlZmF1bHQs
IG5vIHdheSB0byBzYXkgIkkgZG8gbm90IHN1cHBvcnQgTEUiLg0KPiBTb21ldGhpbmcgbGlrZSBh
biBleHBsaWNpdCAiU0VUIExFIiBhbmQgIlNFVCBCRSIgY29tbWFuZHMgd2lsbCBhdXRvbWF0aWNh
bGx5DQo+IGFsbG93IGRpc2NvdmVyaW5nIHdoaWNoIGVuZGlhbi1uZXNzIGlzIHN1cHBvcnRlZC4N
Cj4gDQpUaGlzIGlzIGdvb2Qgc3VnZ2VzdGlvbi4NClRoZSBMRSBmb3IgbGVnYWN5IGlzIGFzc3Vt
ZWQgYmVjYXVzZSBiYXJyaWVyIGV0YyBjYW5ub3Qgd29yay4NClNvLCBhdm9pZGluZyB0aGVvcmV0
aWNhbCBzcGVjIGNvbW1hbmRzIGhlcmUgdGhhdCBtYXkgbm90IGZpbmQgYW55IHVzZXIuDQoNCj4g
PiA+ID4NCj4gPiA+ID4gPiBGb3IgYW55IGNhc2UsIGhhdmluZyBhIHNpbXBsZSBhbmQgZGV0ZXJt
aW5pc3RpYyBkZXZpY2UgZGVzaWduIGlzDQo+ID4gPiA+ID4gYWx3YXlzIGJldHRlciBhc3N1bWlu
ZyB3ZSd2ZSBhZ3JlZWQgdGhhdCBtZWRpYXRpb24gaXMgYSBtdXN0IGZvcg0KPiA+ID4gPiA+IGxl
Z2FjeSBkcml2ZXJzLiBVc2luZyBkZWRpY2F0ZWQgY29tbWFuZHMgY2FuIG1ha2Ugc3VyZSB0aGUN
Cj4gPiA+ID4gPiBpbXBsZW1lbnRhdGlvbiB3b24ndCBuZWVkIHRvIGdvIHdpdGggY29ybmVyIGNh
c2VzIG9mIGxlZ2FjeS4NCj4gPiA+ID4gPg0KPiA+ID4gPiBDb3JuZXIgY2FzZSBoYW5kbGluZyBq
dXN0IG1vdmVkIGZyb20gdGhlIGRldmljZSB0byBoeXBlcnZpc29yLg0KPiA+ID4NCj4gPiA+IFRo
YXQncyBub3Qgc2FmZSwgdGhlIGRldmljZSBzaG91bGQgYmUgcmVhZHkgZm9yIG1hbGljaW91cyBp
bnB1dHMuDQo+ID4gPg0KPiA+IFdpdGggY3VycmVudCBvZmZzZXQsIHJlZ2lzdGVyLCBkZXZpY2Ug
d2lsbCBiZSBqdXN0IGZpbmUgYXMgbW9zdCBpbXBsZW1lbnRhdGlvbnMNCj4gaGF2ZSB0byBwcm9n
cmFtIGNvbnRyb2wgcGF0aCBldGMgb24gdGhlc2UgcmVnaXN0ZXJzIHdyaXRlL3JlYWQgZXRjLg0K
PiA+IFNvLCBkZXZpY2Ugd2lsbCBiZSBhYmxlIHRvIGhhbmRsZSB0aGVtIHdpdGggcGxhaW4gMiBj
b21tYW5kcy4NCj4gDQo+IEV4Y2VwdCBsZWdhY3kgaXMgYnJva2VuIGJyb2tlbiBicm9rZW4uICBJ
dCBqdXN0IGRvZXMgbm90IHdvcmsgZm9yIHBoeXNpY2FsDQo+IGRldmljZXMgaW4gYSBjcmF6eSBu
dW1iZXIgb2Ygd2F5cy4gSG93IGFib3V0IHRoZSB3ZWlyZCA0OCBiaXQgbGltaXRhdGlvbiBvbg0K
PiBQQXM/IEJlY2F1c2Ugbm8gb25lIGV2ZXIgd2lsbCBuZWVkIGFueSBtb3JlLg0KPiANCkxlZ2Fj
eSBpcyBicm9rZW4gYW5kIHdvcmtzIG9ubHkgaW4gc21hbGwgYnV0IHdpZGVseSB1c2VkIHBsYXRm
b3JtLg0KSGVuY2UsIGl0IGF0dGVtcHRzIHRvIHN1cHBvcnQgaXQuDQoNCjQ4LWJpdCBQQSBsaW1p
dGF0aW9uIGluIHZpcnRpbz8NCg0KPiBJIGhhdmUgMCBzeW1wYXRoeSB0byB0aGlzIGlkZWEgb2Yg
cmV2aXZpbmcgYWxsIHRoZXNlIGJ1Z3MgdGhlbiBjaXJjbGluZyBiYWNrIGFuZA0KPiBjb21pbmcg
dXAgd2l0aCB3ZWlyZCB3b3JrIGFyb3VuZHMuICBQbGVhc2UsIGp1c3QgYnVpbGQgYSBzYW5lIHRy
YW5zcG9ydCBhbmQNCj4gaGF2ZSBzb2Z0d2FyZSBkZWFsIHdpdGggYnVncyBhcyBiZXN0IGl0IGNh
bi4NCj4gDQpXaGVuIEkgcHJvcG9zZWQgdGhlIHJlZ2lzdGVyIGludGVyZmFjZSB0aGF0IGFkaGVy
ZXMgdG8gdGhlIGFsaWdubWVudCBib3VuZGFyeSwgeW91IHN1Z2dlc3RlZCB0byBmb2xsb3cgbGVn
YWN5IHNlbWFudGljcy4NCk5vdyB3aGVuIGxlZ2FjeSBzZW1hbnRpY3MgaXMgZm9sbG93ZWQsIHlv
dSBnbyBvcHBvc2l0ZSBkaXJlY3Rpb24gb2YgbGV0IHN3IGRlY2lkZSBpdC4NCg0KQ2FuIHdlIGFn
cmVlIHRoYXQgYWxpZ25tZW50LCB3aWR0aCBhbmQgb2Zmc2V0IHRvIGJlIGRlY2lkZWQgYnkgdGhl
IHN3Pw0K

