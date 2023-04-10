Return-Path: <virtio-dev-return-12096-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543BAC77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 17:58:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AD3C477F0
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 17:58:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A7C679865FF
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 17:58:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9D53F98641A; Mon, 10 Apr 2023 17:58:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8A795986321;
	Mon, 10 Apr 2023 17:58:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ir2ODeI3bGDqxrsBIAO6fql5SUwa7GukRKN+Vf9p+/5Z2WI37B9758QEvFpin8quAmBwi+CTpydY54eiCCQvfICQrxSw9NMugLBjKVC32aKApV0TK/g+cROUxkZJa1XfDP+OjYzXODe/u66qwmf8aKNEaYNN7Hf8blu0ldy/ulVbDSWXdBSRnRlEXkv2gIVTj8FHGHRK/MGZoUmueI6qSg5Oi6baep/45oqy3X4v13UdnPOf2/4+8S4EX3oxTiqv2kVi35QQ85cTy/b5ee1VhAHKUqP+aS+7Nw8lWOCMqYD/bSggaXL8L7rQGr3K+FkUiILm1OuoSw0K/5lMclWOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6hHn1aKbur7rozEjEvfHZR9PnyKAF2clyNrm1Tg7Vk=;
 b=j/Hiuh5HdgFL90t0UcEpXzff3tHbdtCBJhqk9ekiEwdrAz2g0AFgiWmM4lOf8lVta6LPx44nYkyVDlO3uYA2LN5UC7tpakqYfA4dR5br/v/wYJ0PI3KKQd6PFgyYLJRuHA+fRpwj+wXIDIbYIlZL8MZj6zJqVbxhjfpntHqj+wS3CL6+JGTfYPlzl54lCQ0uhRAtbeynbfiyTGQPoulnBaknYwQ4bwQzIIv5yfCyHpnwooqjMlwVuKx3Tp7aFRqOQf4Qu+njug+k2jtMo/bZb08leLPBk/uyR5eop5oHYeR65W292Tt+svzKP/dR3jMHcGWCAfE3hyZ1yiMqX8Ld4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [virtio-comment] Re: [virtio-dev] [PATCH 08/11] transport-pci:
 Introduce virtio extended capability
Thread-Index: AQHZY1tK9bYi+VUlRk+f1PKXMn2Qra8j0vmAgAERMACAAAE+AA==
Date: Mon, 10 Apr 2023 17:58:31 +0000
Message-ID:
 <PH0PR12MB54814FC38D4ACB2EAAD1284CDC959@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <307a9f8f-6184-0403-97ab-1b1c16d4fd3c@nvidia.com>
In-Reply-To: <307a9f8f-6184-0403-97ab-1b1c16d4fd3c@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5326:EE_
x-ms-office365-filtering-correlation-id: f922a28a-de6c-4466-abb2-08db39ed3275
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3RnlSqnI6S6q0B2vP3WlhLEEyjjQZnXYym+th8byTBh4B47htgp57zLQR/oxw74krLxAiFQg4g7R9Z9XsDICepZuXMFkmOSJ9GskCxcZzjbVxIlK3qhBO7dtzhoQXkr8vehhraBcHU8uKkO/+OWZr/mLC/Uq1OU5Y5ArEKDHD43VThuNkTBjDR5gu2OEYrqcQn/UTfPboOuoC3a5yT7bZXcsbn27DVKT/qZyU+Bg823xqFqxrS/l5qFeYmY66IyimkZhg2wx5KkGaOAXnlLf5NMwYKkATz8LpvuruSuJiUSPb0EdkCv3x2LACRmwFAIXdOkOBJcnO351680Pyjr7LwZ/psUK7eJ2ejIlPO+mkDESHdBRCWIGagT+k378ep94MG4jhuPHNIdxpt6K6Y+p7XI1xpDqCMWXtAfJPY+wXkM6bhgR+pwdTDTMOucDEyqmC1zx1FllavIDVJVReDNrHsw1IqBV5O4l0W8NhT0Hx4+im0rl7CrzZaV+HaEPoRyizycrv5UAvsUtROsqmxmgklYrPnS94+PiOQxjDBvZ3p6oYTLhSyq8cf/MJ2lhWNR3pO7Y7wSOxiuR84n9MX0OYENwARQ13+lvuemv4qh5V/tsGcV+6+VIC39+akehTpgZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(64756008)(4326008)(41300700001)(6506007)(66476007)(122000001)(186003)(9686003)(38070700005)(38100700002)(66446008)(66556008)(76116006)(66946007)(71200400001)(7696005)(316002)(110136005)(55016003)(478600001)(54906003)(33656002)(52536014)(558084003)(8936002)(8676002)(5660300002)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1VWWFlJbXBPWkpFblc4eEh4aWRvbWFKVDF6b2NSTjJHbjNtVmJQcUJQZUha?=
 =?utf-8?B?d21mUTBvcFhlUnNOUXdtc09HWFNLRjNnYkxzRnJta0QzVkRFQ0pJY2F6SHFq?=
 =?utf-8?B?MXZMWDhkVUVCRHBGQ3BTbWh4dmhqTHRtNk5tNEVGaGRsQktOekt1dGM1U1pF?=
 =?utf-8?B?dDhGNlFha1Y2bkJPVlRQUHV1YnRNanlOQzN0ZFdjVGgxREtkcE92Wjh5eDJE?=
 =?utf-8?B?endIbEJyQnJabkJxVzNpU3h5OTdyUnNyMVBxQVdZMUdacmVDZzFpTXdzbGRR?=
 =?utf-8?B?cDlFRG1mZ1Nyc3NZRmNkOG1qOHAzSzlybTlHL0dYeDJvcFFIRFVtR3FUckpN?=
 =?utf-8?B?VkpUNlFDSE1POEdkRUk2VXI2Z2l4dFgrYm9GdytFdm1BczhrUk1kSVN6ODNp?=
 =?utf-8?B?UE8xU2dwdlFza05VTjdlTmRnUzZkY0JPSlAzd0FYWUs4N01qdit5dVdsc3ZP?=
 =?utf-8?B?NWhOcncxVXVjb3JhOWJxc0oxTzJqTDIrYkFuY29yaDhHN2Y4eUJLOXJpaTZN?=
 =?utf-8?B?WFdqSTd3V0U3Ti9LaDA1dWdHME9UZUk5RzkvRnF1Qm1KbEk4UmtCYlpXMEdY?=
 =?utf-8?B?UE0rRTRiRkNvRW02cEo5d3MrejRKMkcwVktGemJ5VWM5T2hFTWozVlVCbzBv?=
 =?utf-8?B?Yk43NVBBUUNzYW9HTGNZREZGc2lYb0drTld4TWZhWk1nbllWekdjYzg3b1FM?=
 =?utf-8?B?cFZGTWlGcFVjaS9LNzh2N1oweVUwVVF6Rjhsd1dzZEhjUCtKQ3c4SktyMUhC?=
 =?utf-8?B?UUxldFRuZDN6cmU4WDBscDNyQklKc21LTWlUaGJXTk8xMVJGaWJXNEpiSW9Z?=
 =?utf-8?B?dWFlTDliT3RTVlRvTE90MEFUT0QrSTQ5bVdSSHpDU3pyN0Vob1pkamw4K0Fz?=
 =?utf-8?B?d1B4VW5tZkRBRDZ2UGNTbmVPREphS0ZTV0VSN2dscjNhdEVzb1NQSFZRME52?=
 =?utf-8?B?eS9sQ0NTQzNhNTNMZE02OTY1Qzg0bVZzVVF5TW5NQXlTK09nSHFETkU0Mlhx?=
 =?utf-8?B?RFAvaW9TYzhXbm0xQ0JFa2RHT2oxR0JDM2V5eCt3ZDRqMmxmbFp0NEZmZ0hu?=
 =?utf-8?B?bTZ1ZEFDeG9TbjhSM25NSHd3algwNFlIR2p6UVJQcDYzU3FMTHVmWEhHbHlY?=
 =?utf-8?B?S1RxbGUvSWJtWVBGNTJwMjhUaDZYWUljUGlRcGNkK3dxOGdLR1lIYkxmTG9j?=
 =?utf-8?B?MThLdXdUSytIdUNodFJNSnBzTVlLalBWZWtMQ09PTW1UMWxjSWY0Tmc0WjJt?=
 =?utf-8?B?Ylh6SU1OREFQV0czZDFNSmtvWm1LdkdDWEdUWHZuYUZYR3ZWbnR6WkdXeTQ0?=
 =?utf-8?B?LzB4a1dnNFlacE0rbTRaSktObmdoMEhCZE9kekdnN0J4emt1TEpQVk44RTZL?=
 =?utf-8?B?c0hlOGtnWVp3RGF5RUlrYTVYUXJiSnhPMTh3Qzl0bTdWcEpSWTd4UlZTRVZN?=
 =?utf-8?B?ZHlsWVpuV0gvano2Q0wvSTk1K2wyTEtpLzNnaFhlR0ZOSGhXOFl5NUFnRnU3?=
 =?utf-8?B?VVJhZlRkUVFETk5xYTdXYTQxS2p3bEFBaVVOWUxualppVmZHZjIxakVpekpE?=
 =?utf-8?B?VlNhZXFHN2h3NkFUUnEyMHJuS3daMHRBbllPUk1paE45NG0xWjlnamw0aGpL?=
 =?utf-8?B?bDBuSUQ4c1pLVWFiREc2MnpmeXNtVmUwTjduc0dWTVZPVUlQQmVQaDZnMkhW?=
 =?utf-8?B?Y3NNTVIxNmV6Mk9oWnNFWm5GMXhMdlJpRFZ1bFhNTk9CMnNwbUJXeTVjMmJW?=
 =?utf-8?B?eW45ZTJIVFZsamd3S2RjVmkvelFkOWFmZDk3bHRrMGFrQzFSRUFQMzlmclJG?=
 =?utf-8?B?alQwZWJyMkJrWkIrRm1XZHhjandidTlTU1MvMFFuQStXSmNkSW56L3hwWERU?=
 =?utf-8?B?TzBwdFhmUVYxcFZ5SXZDeVd4TnlYQXRrYWpzNGFOcWNNZXVCUHNkbHllUFRJ?=
 =?utf-8?B?VXYvaTh3aElCNHY5S1phZTI0T1ZVNnRFaktVTURrVExvaVMvek1jNkcrWGRy?=
 =?utf-8?B?VzZhNjV3L2YxdElhb2VGUGNwNzdTakJ0MkxLTWFIZUN5cG9GSGllZUZXV0lJ?=
 =?utf-8?B?NWJXNHBQSVF3eFllRlM0Q0o2RmxIY1NrMjdqdngvMXM2b0VqT2Nob2ZzcHlv?=
 =?utf-8?B?bDdmK0FSQXFYUk04REVRdVdJUkVWVHdvbHc0S2xjSHFmTFFtMTF6OEVrZ3h6?=
 =?utf-8?Q?nlWJ/4eNSL+6x/yk2yIFsyw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f922a28a-de6c-4466-abb2-08db39ed3275
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 17:58:31.9310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y1gb2SAbUAr4rYEJKDAwt0aT/Qnc9+cjf2DMIxXqhOWsPr6+UA9CNWpoMP5r86Pm03jfyeGwqvbciCLA+BGrnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5326
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] [PATCH 08/11] transport-pci:
 Introduce virtio extended capability

DQo+IEZyb206IHZpcnRpby1jb21tZW50QGxpc3RzLm9hc2lzLW9wZW4ub3JnIDx2aXJ0aW8tY29t
bWVudEBsaXN0cy5vYXNpcy0NCj4gb3Blbi5vcmc+IE9uIEJlaGFsZiBPZiBQYXJhdiBQYW5kaXQN
Cg0KPiBXZSBtYXkgbmVlZCBpdCBldmVuIHNvb25lciB0aGFuIHRoaXMgYmVjYXVzZSB0aGUgQVEg
cGF0Y2ggaXMgZXhwYW5kaW5nIHRoZQ0KPiBzdHJ1Y3R1cmUgbG9jYXRlZCBpbiBsZWdhY3kgYXJl
YS4NCg0KSSBtaXhlZCB1cCB0aGUgdHdvIHN0cnVjdHVyZXMuIEFRIHJlbGF0ZWQgZmllbGQgZXhw
YW5zaW9uIGRvZXNu4oCZdCBuZWVkIGNhcGFiaWxpdHkgZXhwYW5zaW9uLg0KU29ycnkgYWJvdXQg
aXQuDQo=

