Return-Path: <virtio-dev-return-14240-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CECC3DA79
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 11:07:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1827C2ACA4
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 11:07:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0BB6D986556
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 11:07:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F37A0986367; Mon, 15 Jan 2024 11:07:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E115A98636D;
	Mon, 15 Jan 2024 11:07:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KK5Ka9c0GPCj9/Idb+m7Q1WbYK96WMpPdoyHdZ3iY+Tr3wTgrOojsChjJOsExFywaeL38ZytIAUcQy9Bt2iLjphNMFi5Irnelb+vCuYZYs5cA5NscrfniAQORETlIMdCedWbwmhPpLHo1xdbYC+wRbwfgqS9GmXFQM4dFz7x521tBL6RYUtT5zfjvH5In9oMfPtmyfhglsypFNy8v+ybCxPDwTW8zleIqyZikZdKogStjD7sz1zgWLfZStaNpyS7SgkRPapUd8lMWLfSJZ6FKjrrN7FiGRYusk8N8fk42GfAwnRT2idlGE63WoIQbZ2k+4/NFP+qVLyoqIm97RJc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwjQquGP3RcBXMMs0ScYObbI2oCqqF8f0Y9zT6fXTPM=;
 b=I9T5PS+dO/bgR5O7Padn6DrVDn4wG5zaDdQFdqBETB6pwUj/7e7nMcmBLPq79oR0uUxmUA0slc1CGGXhitxuiDjYeDqoR8SWM85ngVXVu6dkZ/UboKT41YC6Ccj/FhcPLu1xyHTniuHadsQRHXcvVVoIWie/JN8zv82E99xwUNQxTdSJunkKxahP7JLh+IuxS/qHJaCerJvAlDdEm6I7o5n2G8U6Ib7cc9a+HXsn4xfLBbbmZSzKDPxSbw//1xJyKdy1xsN8bi5OYkCAhs7wogRFDQOH4PkUAVM0dEIyeJFx/JKzX1FXynJSKGGHXP6odAZE6incspEFc1bI8X4N7w==
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
 AQHaA9HvmHelxVzMEkK9DIiJvUqDjbBW5OUAgAC5UoD//8WsgIAB4oYA//+CG4CAAI+hgIAAjVeAgAJwQAD//5FqAAAzXyGADyowGYD//4AlgIAAia6A//+C6oCAAItHgP//hKUAgAUWT4D//31GAAAQ5xwAABBKiAAAD6fOAAAuOxQAAEuTxoAApzqngAE9jPcAAorzqoAFA43jgAoXI46AFB1tXwA=
Date: Mon, 15 Jan 2024 11:07:18 +0000
Message-ID:
 <BL1PR12MB5849D9B54611E347DA492F0CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <PH0PR12MB548102E41B13AAB57C7321FCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849F3E85F2661EB38128A67E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481158BD79A17E1C49ACB6BDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849D8D396D00919482CB6D2E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB548145B7409F2D58AC2F6D44DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58497CDB1A3AE937CAF24BCFE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB54816CC7AEE14209D3ECF795DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58496E8AA1278A8E3573CCB7E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481469DD511988B1A0D306CDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584944D5ECADD4566A8E066CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481FC877410A34DF11CFBFCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB5481FC877410A34DF11CFBFCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: MN0PR12MB5764.namprd12.prod.outlook.com
 (15.20.7181.004)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|PH7PR12MB6612:EE_
x-ms-office365-filtering-correlation-id: 67718164-e02c-45db-7a9d-08dc15ba23d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UMQKrtC7dne4FMGnhcdKDTOe9EEaObxTyfdrz0CkMClRaXWO0ev6R/M+S74oYUtbd76jxDAT5+KTS5KdO7Zmpi0lwOhVk19eIU8orF//RYp2G7GbFJZBdEC3QSf78jqPgT8GkFFpEajBtILN6mwwPWrs+KcaRK5tlUnZgumM0yQ/5Emzjkfs3gl27QBY0gPO+skCKka0QD7DOzbdRWAbbelNi2n98bBqJrmGtRrD3uaR/he92NtD+7APn0eurGHtgmnAxIkYoBsLvcxrNXw/RSRTiLwHAqRm32i3n6f0lCD98gxkrZLZuWQ/G39Ci0KXD/FlyNhhcTSymu2BbemMiqQfHN1jgwsWTJu4wDYCucHVLMe2iAoe/paMY/LUCXE54rGwAZ8S8jjCK1I4w1st6rfgGOhe0Qe29uAg5Cg6TFGPd4liKXFiZZxF2crIE/yZAekC2wrRytFUc9TKt1/Gchyu8rwgllIbxeBkC42chUKS/v2q+22Retow4w5Dnu+jX+cc8FrnwPk4tJ+G4hVBiDlH3e5bp4xsOHtmcbCQt+hwKqDGLO93/wh7PEq+oiL5z4lL86/q4bUhToYL5cZHIfmD5ssfM9eKqJr9aMRLQYxGuSWQQoG2cw1azF+5Or7Q
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(55016003)(66899024)(5660300002)(7416002)(38070700009)(2906002)(33656002)(6916009)(64756008)(76116006)(66446008)(66476007)(54906003)(66556008)(4326008)(316002)(8936002)(71200400001)(6506007)(7696005)(53546011)(478600001)(26005)(83380400001)(9686003)(41300700001)(38100700002)(8676002)(52536014)(122000001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVBCTFhNcnJaVGxWY0RDM1dkYkYwRmtIU3dacDFFZDJDY3k0VDhOaUdYUlFu?=
 =?utf-8?B?N0NQakVDN3E3NkUvaG44ODNoclppR3ZJRnQ3OHdaZy9sQXQyM3VkcnZ5bTZT?=
 =?utf-8?B?L1pZVXU0M25zUlRqNVJVclJxVW9FTEZ0Q0E3ekJuaVA5cVJVendhOFFGMDEx?=
 =?utf-8?B?bXp5TEhCajIyU3Z4eUU1VE9jTlhsK3BwSkhuVGR0bGk5cnhScVRSaUZOaGh1?=
 =?utf-8?B?eGRJY1Z4cUgxZ2xidkNrRTI1TmJTTFFTK01TUW1SVGttM2xSSEFDaFlMaXFI?=
 =?utf-8?B?YXlOU2xFWDlneDE4NEduaGIwV0xId0NIVFlXeHpsaDJESFR1bHJia056VE94?=
 =?utf-8?B?aTVHSWNvalNKeUZwRGM0ZWNZU2k3bURFNGdYNlNONWZ1UktCaVhtWWFieHh5?=
 =?utf-8?B?bkR0dzU5bmlyN043bi8zV2V1TjRmWVNjSllPUXVyTXcrNVJaeFlCNDU3UGtO?=
 =?utf-8?B?SkZQOUtIR1Y1dVNTOUdsMGJGSlVpK1Vnc28vOWc0V1JDYThxaHNLaGtsS1dZ?=
 =?utf-8?B?VE5iUERpVEVNYkp4UkYyck5RSlVGcWk1MzREN1hmMDlsWnpKL2FKcDVpcU1y?=
 =?utf-8?B?QjFXS3ZSVzJGWXJwVThhQ21pZGVXMnE3VHN4WjV2Sll2VEEzMTVMaHZpMTZG?=
 =?utf-8?B?dzhkVnlhdU8zR2Urc3hNMG8rWWFBZVdGTEFYblRrREgrUDVNTVhtaFM2RXlB?=
 =?utf-8?B?UHRSV3NMR0xvempzWUJ5cU90a3AwbjZKbmN3YVJEM2RSSDMycUZnWHJDaGVU?=
 =?utf-8?B?anpXMW1oa1RxQ054Um5SYU1qZXdSZ25mTHNwVzZVMVB6bUFMVXhyTFZGcjZ5?=
 =?utf-8?B?bWdDS2RGbjEvYUVJUmtCUnltU0cvcFVpSzZsZVkyeFdHemlHVWlZeWhMQms4?=
 =?utf-8?B?MXRUQ0M0eGdBdTErY0phQTUwWWNmNE1NRHFEc3RseVVLcjVSNEtmL1BnRVN0?=
 =?utf-8?B?UzlVeUtwaTRLMHczOSs3QmJYb3JscUViNjY5MGRCQURYZ2wrWEo5RWEvR3Rm?=
 =?utf-8?B?Y1VSajUxNGxHTlRnV2VDVWNZZnB5dXd4YndJQnd6aEpSSjdwU3VNUHlwRzlj?=
 =?utf-8?B?QUtGQjVPbjNxS3d2Z0E4Nzh4Z3BIbjVvQi9LQ2RQcnhZN3FTeFpLK2ZQYnlG?=
 =?utf-8?B?dFFoOEJYQWEzaFY1cVZFRWRYaC9mQmNPZ3d3N3g5NkZnY0dpdS8rL2QwdTJw?=
 =?utf-8?B?N3dPMXJSdGpkNUEzM25PQnUyK2JPcW43Qm9nNXIyQU5vazBQaHk0amVrbXFT?=
 =?utf-8?B?Q2FCcnNuUVlnbzllaHdoWTlGWDNPMnhjV3htb251SUZQWThOc0taSUZ1cDlG?=
 =?utf-8?B?Zks4ZHJ6QXZiNzF5ZmJDc0pJU3R2dFBwWUVTNDhaNktNckxvWWRYeDQwcEJW?=
 =?utf-8?B?T2hOR0UwSzNSc0lrcUZ4a0pqNlhkYmNKQVVLTURValhFRUs4eTExZXZFUjRJ?=
 =?utf-8?B?K3hFd3Q5eUFieEZIMXVYTFJKSnhjdDFjMU5ueko0NE5SZ2xlK01KZ09mM2xu?=
 =?utf-8?B?YkdFdXNGZFdEZzNaSkQ2Qm4xbmh4OGU2VXMyTWwrZFhHVkE4RFFwRWlJTEN0?=
 =?utf-8?B?Yk9rNGxjMEdyR0E1NG1iTEZpSGZ2N2ZPd1IySDQzVFVJMnQyNmtuTS90blQ0?=
 =?utf-8?B?eExaQ0xuRXdmb1NEU3Fvd0hkdVd6NVB2N244YmVrN0FPWHZhR1kwYUE3eS9J?=
 =?utf-8?B?d3BaZEhYcTNpcGgxdmVqK2grQ3RmNnFOeXFRMVB0T0QvZ3NsUEUrWHU3WnlF?=
 =?utf-8?B?c0R0aDdLdjNLdGd0MEtxK0VVd3Q2Y1F2ZnU5ODdLRHRRMmp4SWVxVHc5QUNZ?=
 =?utf-8?B?Q0k3K1I5RHRzU0N4M3JRZ1p4dWl2SnNFcXJabGpUTUxYNzNHZUFNMW9wZ1da?=
 =?utf-8?B?VlN2TUt2dWV2WjFVeUFvZlpjVGJVYjZIZ2FvMStLdW40NWlEdUxJVGpib09O?=
 =?utf-8?B?ZERDNGZheDJKMm9zajhJVVVsWG9mankvYzFaUjJ2TDE5dnl3QUpiVm1McDlH?=
 =?utf-8?B?QzBRa1Y2VmpLWTU0cVl5eXBneG02SkdoSFRMeFFucGJNRzlSY3RPSlBQZUZ4?=
 =?utf-8?B?b242aXNvZHlkeGdqWEtWMUdqd3prZU5Gdmx4blIvYTZtR0RCYzJ6Rm9ZTVRq?=
 =?utf-8?Q?6U4I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52FF2C19218F784CB65908C37FF27F17@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67718164-e02c-45db-7a9d-08dc15ba23d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 11:07:18.8994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijQ4Qfy9cQhA7FbeFMSeLbE+Qg0mrKSz/tvsclsMSYTr8VprhTfi7TLOMO84fwt8XORpmAgNquDyXhoxfG8r0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6612
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

T24gMjAyNC8xLzE1IDE4OjUyLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+IA0KPj4gRnJvbTogQ2hl
biwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4gU2VudDogTW9uZGF5LCBKYW51YXJ5
IDE1LCAyMDI0IDQ6MTcgUE0NCj4+DQo+PiBPbiAyMDI0LzEvMTUgMTc6NDYsIFBhcmF2IFBhbmRp
dCB3cm90ZToNCj4+Pg0KPj4+PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFtZC5j
b20+DQo+Pj4+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxNSwgMjAyNCAzOjEwIFBNDQo+Pj4NCj4+
Pj4+IERpc3BsYXkgcmVzb3VyY2VzIHNob3VsZCBiZSBvbmx5IHJlc3RvcmVkIHdoZW4gZm9sbG93
aW5nIGNvbmRpdGlvbnMNCj4+Pj4+IGFyZQ0KPj4+PiBtZXQuDQo+Pj4+PiAxLiBQQ0kgUE0gY2Fw
IGlzIHJlcG9ydGVkLg0KPj4+Pj4gMi4gUENJIFBNIGNhcCBoYXMgbm9uX3NvZnRfcmVzZXQ9MQ0K
Pj4+Pj4gMy4gdmlydGlvIGd1ZXN0IGRyaXZlciBkbyBub3QgcGVyZm9ybSByZXNldCB3aGVuIHRy
YW5zcG9ydCBvZmZlcnMgYQ0KPj4+Pj4gcmVzdG9yZQ0KPj4+PiBjYXBhYmlsaXR5IHVzaW5nICMx
IGFuZCAjMi4NCj4+Pj4+DQo+Pj4+PiBEbyB5b3UgYWdyZWU/IFllcz8NCj4+Pj4gWWVzLCBJIHRo
aW5rIHRoaXMgcHJvYmxlbSAoZGlzcGxheSByZXNvdXJjZXMgYXJlIGRlc3Ryb3llZCBkdXJpbmcg
UzMpDQo+Pj4+IGNhbiBiZSBzb3J0ZWQgdG8gdHdvIHNpdHVhdGlvbnM6DQo+Pj4+IEZpcnN0IGlz
IHdoYXQgeW91IHNhaWQgYWJvdmUsIGluIHRoaXMgc2l0dWF0aW9uLCB0aGUgZGV2aWNlc19yZXNl
dCBvZg0KPj4+PiBxZW11IGlzIHVucmVhc29uYWJsZSwgaWYgYSBkZXZpY2UgaGFzIFBNIGNhcCBh
bmQgbm9uX3NvZnRfcmVzZXQ9MSwNCj4+Pj4gcWVtdSBzaG91bGQgbm90IGRvIHJlc2V0dGluZy4N
Cj4+Pg0KPj4+PiBTZWNvbmQgaXMgd2l0aG91dCAjMSBvciAjMiwgdGhlIHJlc2V0IGJlaGF2aW9y
IGlzIGZpbmUuIE15IHBhdGNoIGlzDQo+Pj4+IHRvIGZpeCB0aGlzIHNpdHVhdGlvbiwgdGhhdCBz
ZW5kaW5nIGEgbmV3IHZpcnRpby1ncHUgY29tbWFuZCB0bw0KPj4+PiBub3RpZnkgcWVtdSB0byBw
cmV2ZW50IGRlc3Ryb3lpbmcgZGlzcGxheSByZXNvdXJjZXMgZHVyaW5nIFMzLg0KPj4+DQo+Pj4g
SSBzdGlsbCBoYXZlIGhhcmQgdGltZSBmb2xsb3dpbmcgIk15IHBhdGNoIGlzIHRvIGZpeCB0aGlz
IHNpdHVhdGlvbi4uLiIuDQo+Pj4NCj4+PiBXaGVuICMxIGFuZCAjMiBpcyBub3QgZG9uZSwgdGhl
cmUgaXMgbm90aGluZyB0byByZXN0b3JlLg0KPj4+IERyaXZlciBzaG91bGQgbm90IHNlbmQgc29t
ZSBuZXcgdmlydGlvIHNwZWNpZmljIGNvbW1hbmQgd2hlbiAjMSBhbmQgIzIgaXMNCj4+IG5vdCB0
aGVyZS4NCj4+PiBJbnN0ZWFkLCBpZiB0aGUgZGV2aWNlIHdhbnRzIHRvIHJlc3RvcmUgdGhlIGNv
bnRleHQsIGFsbCAjMSwgIzIgYW5kICMzIHNob3VsZA0KPj4gYmUgZG9uZSB0byBpbXBsZW1lbnQg
dGhlIHJlc3RvcmUgZnVuY3Rpb25hbGl0eS4NCj4+IFdoZW4gIzEgYW5kICMyIGlzIGRvbmUuIFRo
ZSAiZGV2aWNlIHJlc2V0IGJlaGF2aW9yIiBzaG91bGQgbm90IGhhcHBlbi4gQW5kDQo+PiB0aGVu
IHRoZSBkaXNwbGF5IHJlc291cmNlcyBhcmUgbm90IGRlc3Ryb3llZC4NCj4+IEkgZGlkbuKAmXQg
c2F5IHNlbmQgY29tbWFuZCB0byByZXN0b3JlIGNvbnRleHQuDQo+IA0KPj4gSSBtZWFuIHdoZW4g
IzEgYW5kICMyIGlzIG5vdCBkb25lLiBEcml2ZXIgYW5kIHFlbXUgYm90aCByZXNldCBkZXZpY2Vz
IHdoZW4NCj4+IHJlc3VtaW5nLCBhdCB0aGF0IHRpbWUsIA0KPiBBYm92ZSBiZWhhdmlvciBpcyBh
cyBwZXIgdGhlIHNwZWMgZ3VpZGVsaW5lcy4gSGVuY2UgaXQgaXMgZmluZS4NCj4gDQo+PiB3ZSBu
ZWVkIGEgbWV0aG9kIHRvIHByZXZlbnQgdGhlIGRpc3BsYXkgcmVzb3VyY2VzIGZyb20gZGVzdHJv
eWluZy4NCj4gSSBkaXNhZ3JlZSB0byBhYm92ZSBhcyBpdCBpcyBub3QgYXMgcGVyIHRoZSBzcGVj
IGd1aWRlbGluZXMuDQo+IEp1c3QgZm9sbG93ICMxLCAjMiBhbmQgIzMgdG8gbm90IGRlc3Ryb3kg
dGhlIGRpc3BsYXkgcmVzb3VyY2UgZGVzdHJveWluZy4NCkkgYWdyZWUgdGhhdCBmb2xsb3cgIzEs
ICMyIGFuZCAjMyB3aWxsIG5vdCBkZXN0cm95IGRpc3BsYXkgcmVzb3VyY2UuDQpTbyB0aGUgcXVl
c3Rpb24gZ29lcyBiYWNrOiBJZiB0aGVyZSBpcyBubyAjMiBhbmQgeW91IHNheSB0aGF0IHRoZSBy
ZXNldCBiZWhhdmlvciBjb21wbGllcyB3aXRoIHRoZSBzcGVjIGd1aWRlbGluZXMsIGhvdyBjYW4g
SSBtYWtlIHRoZSB2aXJ0aW8gZ3B1IHdvcmsgcHJvcGVybHkgd2l0aCBkaXNwbGF5IHJlc291cmNl
cyBkZXN0cm95ZWQ/DQpXaGF0IG15IHBhdGNoIGRvIGlzIG5vdCB0byBwcmV2ZW50IHJlc2V0dGlu
ZywgaXMgdG8gcHJldmVudCBkZXN0cm95aW5nIHJlc291cmNlcyBkdXJpbmcgcmVzZXR0aW5nLiBH
ZXJkIEhvZmZtYW5uIGhhcyBhZ3JlZWQgdG8gdGhpcyBwb2ludCBpbiBteSBxZW11IHBhdGNoIHJl
dmlld2luZy4NCkV2ZW4gaWYgSSB1c2UgUE0gY2FwLCBJIHN0aWxsIG5lZWQgdG8gcHJldmVudCBk
ZXN0cm95aW5nIHJlc291cmNlcyBkdXJpbmcgcmVzZXR0aW5nLg0KDQo+IE5vIG5lZWQgZm9yIGFu
eSBjaGVjayBjb21tYW5kIGV0Yy4NCj4gDQo+PiBJIGRvbid0IG1lYW4gYW55dGhpbmcgZWxzZSwg
SSBqdXN0IGZlZWwgbGlrZSB5b3UgbWF5IG5vdCBoYXZlIHVuZGVyc3Rvb2QgdGhlDQo+PiBpc3N1
ZXMgSSBlbmNvdW50ZXJlZCBkdXJpbmcgdGhlIFMzIHByb2Nlc3MgYW5kIHRoZSBpbXBsZW1lbnRh
dGlvbiBsb2dpYyBvZg0KPj4gbXkgcGF0Y2ggZnJvbSB0aGUgYmVnaW5uaW5nLg0KPj4gSW4gY3Vy
cmVudCBrZXJuZWwgYW5kIHFlbXUgY29kZXMsIHdoZW4gd2UgZG8gUzMoc3VzcGVuZCBhbmQgcmVz
dW1lKSBmb3INCj4+IGd1ZXN0LCBkdXJpbmcgdGhlIHJlc3VtaW5nLCBxZW11IGFuZCBndWVzdCBk
cml2ZXIgd2lsbCByZXNldCB0aGUgdmlydGlvLQ0KPj4gZ3B1KGJlY2F1c2UgIzIgaXMgbm90IGRv
bmUpLCBidXQgb25jZSB0aGUgcmVzZXR0aW5nIGhhcHBlbnMsIHRoZSBkaXNwbGF5DQo+PiByZXNv
dXJjZXMgd2lsbCBiZSBkZXN0cm95ZWQgYW5kIHdlIGNhbid0IHJlc3RvcmUsIHNvIHdlIG11c3Qg
YWRkIGEgbWV0aG9kIHRvDQo+PiBwcmV2ZW50IGRlc3Ryb3lpbmcgcmVzb3VyY2VzIGF0IHRoYXQg
c2l0dWF0aW9uLiBXaGF0IG15IHBhdGNoIGRvIGlzIHRvIGFkZCBhDQo+PiBuZXcgdmlydGlvLWdw
dSBjb21tYW5kIHRvIG5vdGlmeSBxZW11IHRvIGNoZWNrIGlmIHRoZSBkaXNwbGF5IHJlc291cmNl
cw0KPj4gc2hvdWxkIGJlIGRlc3Ryb3llZCBkdXJpbmcgcmVzZXR0aW5nLg0KPj4NCj4+Pg0KPj4+
IEluIG90aGVyIHdvcmRzLCBpZiBvbmUgd2FudHMgdG8gdXNlIGRldmljZSBjb250ZXh0IHJlc3Rv
cmUgb24gUE0gc3RhdGUNCj4+IHRyYW5zaXRpb24gaXQgc2hvdWxkIGRvICMxLCAjMiBhbmQgIzMu
DQo+Pj4gKGFuZCBhdm9pZCBpbnZlbnRpbmcgbmV3IGluZnJhc3RydWN0dXJlIGJlY2F1c2UgUENJ
IFBNIGhhcyBuZWNlc3NhcnkNCj4+IHRoaW5ncykuDQo+Pg0KPj4NCj4+IC0tDQo+PiBCZXN0IHJl
Z2FyZHMsDQo+PiBKaXFpYW4gQ2hlbi4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hl
bi4NCg==

