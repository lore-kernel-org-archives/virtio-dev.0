Return-Path: <virtio-dev-return-13364-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E2BC0015E
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:35:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C74C9120D4F
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:35:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B98A29867EA
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:35:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A933F9867C8; Wed, 12 Jul 2023 22:35:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83FF19867B4;
	Wed, 12 Jul 2023 22:35:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsSFPVMSAY8OLtB9r281xahiw4roQEuR9loYImdw0g6l4Q61Mp+m8NjfxQNGgTlWle1juEKLm9FRnuptzygtUxyb4LOxqMJcdkkYRwoANZqyeslynQ4A5NlcUMGD6r018IZTrW1QF0S4wqDddy2U6shvTLadjHGqJCqOyrpC5RHJD1bz60IyG8Qb9AzH5BAKvQUFfa4mJqeH7AfkJ57Uy6owp01TwQyONH1auK6nhDdCQ6qeEWrCJYWvKNBx0fZHa2dQq5Q+FdsGIf6NBoN8kGX/V8/Z4Trbyw0zurJ2DXI1AqgSdLCsToxloU3t1ZFz6UqxcAZPmGJh3+5P8cXVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcwjeTqp8HAGnuhcj/0EuY0EF2LQNxfU2HX0+ZBLljY=;
 b=QBEcA/Fbl0aZlO7MHXp5XFPM0hGy0sfxAnklQBegme5U91Gwfj+ZspP6ahvvJ0x0NNzF3Bw9rgWMScjyPW56AC+TQy8BQTWCfRDcdw14kFn3+0QndwmxrYxpPmdY8q/xUfy4tAXRSplDkT1o34MUL2q7bVR8Qbv5MjFVMs8m52B1G+Ce1msRqZv4nRowqEr3DvLRLC0z6vjjqpzz0LBsWV5Q7nDtFkglYOf2Jc1K05f9HAxXfIMl+iR0FQPL9Z8d1INPEzBZyBpHm0SJi0pZ+ZSyZHri6ajdBE7e9KwcMYGosXOO7rdMHf+1EhMeZo5/hYoAZ0ADEaTmlmwwZdXZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Cornelia Huck <cohuck@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason
 Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [PATCH v21] virtio-net: support inner header hash
Thread-Index:
 AQHZrcLbGn+M0MXS/UagA7zKbS/v/q+2G4MAgAAA34CAAASegIAABOgAgAAHJwCAABjfgIAACBiAgAAYzSCAAF66AIAAAEGA
Date: Wed, 12 Jul 2023 22:35:03 +0000
Message-ID:
 <PH0PR12MB54814AFEDD1F929B3704F97FDC36A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230703152711.106008-1-hengqi@linux.alibaba.com>
 <87pm4xjp4t.fsf@redhat.com> <20230712082508-mutt-send-email-mst@kernel.org>
 <87jzv5jo82.fsf@redhat.com>
 <e0e2b21d-a7f9-fbf1-7d93-d142c7a7618a@linux.alibaba.com>
 <87h6q9jm85.fsf@redhat.com>
 <b1b03bfa-45ac-42b8-86d9-aaf47c4704e3@linux.alibaba.com>
 <87edldjgri.fsf@redhat.com>
 <PH0PR12MB548162D04BDB6E3AAD9F05B8DC36A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230712183013-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230712183013-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB5502:EE_
x-ms-office365-filtering-correlation-id: c0a1e160-135b-4bd1-0346-08db83283c36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kKc5vA1qbzMWpLDNoYvyId3N8Jb0/S35D4+MNfnT6uYuIDs/1KEudy8kuXc2cb0lSdXuIe2tePRs53qBJEIpo6+SkPi6w/HyRzw1ggKfpcmWCPjiHTGHPdVWzI3EWNljC39XTsIbXa0ALvM4ofOFK6ZMIOuPMqokBt0Kgc81IkXvsbLucQoD0+YOzAgMDgCakkWH/oycAwUbCWj7Y2L5c3WMXwXfwv1LPxuhuVpGQfEHXAFcj1zuknmBwsWhUpkqsfnw2RLtySz6MsHF5Fo7IBwkkOv9HTD3ewPqkt0Ng25I8hsn1Bfr6PhTg+TBX+0UmvkdQGwz+1fFiRXsYghLOVwWgylHRlHa+6ctE9wXPyJF/9O9AtCWtRLzlSCsBlzA8SGwqOHtoK/yn+N5eQmJUG7A4WIfwVz0Y4uzu38LzAo2Um/l7KFUvyD+XKt6NMO8c8mxKJsvK3TjiB08pG7VLP1p39ZqiYfRVhPcJ4Ti2qJx29TnDQyhUX0jmMXIpkVYiHCCclccU1QDxz5Xn1c9FlXRPha4HTFGWsiHvRIsiOAltUUO5xx+0mc62xPy1a/sBxoSgHGfXx+3YD5gZg4t9/UlvHsdlrYyZlLdzIKh872nH6YXHRoRtCSuWe9HOypG1Vt2+8zAnyC/N/fGW0gOxw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(54906003)(7696005)(478600001)(71200400001)(76116006)(26005)(6506007)(9686003)(186003)(4744005)(966005)(2906002)(316002)(4326008)(5660300002)(6916009)(41300700001)(66446008)(8936002)(38100700002)(66946007)(122000001)(52536014)(8676002)(64756008)(66476007)(66556008)(86362001)(38070700005)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFg3ODlVakhCNXVLa2ZEaEVrVUF2N0F2L244ZTB6cFYwSzZNc2NqdTkvVDRK?=
 =?utf-8?B?Q1ptVmxwLy9ISitwL094R2RxK3NMRnBiTkdXdU1IQ2Y3MDdEb1kzdjJlRHgv?=
 =?utf-8?B?bk01dU1wSmVaQ255cWg2MnhBalRDWGR2aU9VSjVrYkZmNWFrK2FiOU5TYTYr?=
 =?utf-8?B?NzJ6eDVVcHZFQnd1YjlRWnRnYW5LdGpsL2lBM2JybS9iNjVGSGdyUFJ3RmxY?=
 =?utf-8?B?aWVPdU84UVdGakNkWTY3U0FkZ21Sc05UcUQxY05wMFBJcjk4OHNRTml6Z05t?=
 =?utf-8?B?NTVxNjl3dkxEV0wwNmdYMUphY1p1S2YvRVFsRlB3elRQV0VFWEJ4bFVlVGlW?=
 =?utf-8?B?SjZJbmRHdGdQeFk5a0VuUzhXNmVCcHZYajZhb2dGSGl5ZEpyMTR3eURGSEha?=
 =?utf-8?B?ckd0Nmk3WC9YR095Z2doSzBSRktpbXA4OHBSQ29zNVdkUHZsTzhFNXZsTVl3?=
 =?utf-8?B?cDArVkpMa2tObXROUGdsZ0V3UlhlZE91SGRtTVRmN2VKZUxRL2wwdDJBYUU1?=
 =?utf-8?B?OXI0Z1JXMnphOEJVcUJjNjM0M2tkS2hKdGNMaE9xZWdGWGpLaGRqUUEyWEJU?=
 =?utf-8?B?aW9iY1FsK09DaFdJTkNYSUtKemduTmo0bUN3OVhWNWM4N01NRUlwUXE1VjJo?=
 =?utf-8?B?LzVVNzkvVnJST3U0VVNWSVIxdUNyMGVBSkk5VGxSWHJWTzVRdW5zUldIQ3ZI?=
 =?utf-8?B?SUN5WWNsK0pkWkVNd25xNWZCVXVhRVBZOHN3cjFZczBET1FPdU9xMFlmRjUr?=
 =?utf-8?B?TExIVW9SWlczNDVEbkpBeXBEVFpUVWtGRWQ1S0ZhRnBpV2JUeUFvSGJ1TXQ5?=
 =?utf-8?B?V2JFMmk5aWlURDl6NjJxUXF4YzR6Mk4wNWxseUpscGtBdWZpN01CQ0k5RkZP?=
 =?utf-8?B?UyswdWRZTkxWaWc1RkZ5cGtBODdTN2VUODlRSFJEcnFnSHhGVVNBVVF5bWpz?=
 =?utf-8?B?SStXUUVMOTcvRHNBZS9lVmFLaUo0N20vdkZEcnF6Q01TTUxqcVcyc0ZCeVk5?=
 =?utf-8?B?S3RBMjJYRWRDci8wWDA0RjBraWZRM05hZElyd28rOXVsZFVIZ2pGVGYzRS9q?=
 =?utf-8?B?VzcvYnp0UzBLZzdramZZSEFqQVJvVHA4cEVIeFRuMEtxY0JUc1JNWkhqMmVr?=
 =?utf-8?B?SmM0V1licXIxbGw4K05wTkplaFpUK2xmTkhpMElUKzVzSVhzRGlFdzVCMWVP?=
 =?utf-8?B?eHoyZUZwVzBYWFd0dEtkaytybUFtMGhxTXVEMWdwMVBHTlc2VWFqSC83azJJ?=
 =?utf-8?B?Y0JWckt0NlQ3QXRZQmhRVW9OU2dTQ3JBb1JzSGovd3BVaW5yYWJwOHZUWXNF?=
 =?utf-8?B?NUlCcEJrMjNJK08yblovWno3bUJTc2NUWnFLMDVUbEwvMUpTUVFQU2VBeFJW?=
 =?utf-8?B?KzNDZmN4bnhGbnUxcHdIM1M4R0dLajJpelR5aFVqTkpsaVVMeGFWSjExWnNz?=
 =?utf-8?B?L1RxZzBxZnBpcjJ3VnJZWlM2bmNudmtMYkNJVzlHcmFqakZCTGJkQU1Nb1BV?=
 =?utf-8?B?MXl0ek45a3RlSWZyOWxMdVVFaE43LzlMWWxtc2xvUXdDM0RWZ0l0aUNJUXFy?=
 =?utf-8?B?bUgzclJ5NEpzMXQyMHpsSTdmcHJaQXVSVE9LKzF3NVZ5U3ByREhqazZrODRa?=
 =?utf-8?B?MUZEVDdjdWxOVXhTTXdhblR0Z1ZLbUY2SlBlSzhiZ25MODhkZ2xiSHVpa2Ry?=
 =?utf-8?B?K2tXbTBvYVVKUW1LV2RtckY5dld0T1gxNGNpNnBpRjRlUHFGb2lRcWMzTWhI?=
 =?utf-8?B?bHNzaEI2dkNjaXJFWkNKNlgxRmpIUXhxK2hVbWJaRmJyRzdZSmtTYnExR1Rv?=
 =?utf-8?B?TmF0V2tHenVPREJSd3YzYThLMHdSa1IyT2VOR3pJTE5rd09VTis4N3dYZm4v?=
 =?utf-8?B?emc3dzhhZFBBT2JSZk9Jbmw2eUg4bEM0RXprMEVvcHhxbEczRzByU1RWa2xU?=
 =?utf-8?B?cndna2FtOEd0cmZZWmZPUjJBZk5tdGdxNm1JQjJUU0JZbmZ6RVM3VVYwdGZW?=
 =?utf-8?B?ZFZEZjB5NVhtelVVemlCMVlCWGI4VW1nMS84N2ZRcm5ySGl2MnhvSWNmYUhL?=
 =?utf-8?B?SFpnQldLZ3orNXREeFR1L2NicHdHV0VVWS8yd0NScExtZmVMSkxQbS9FUm1X?=
 =?utf-8?Q?7DoI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a1e160-135b-4bd1-0346-08db83283c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 22:35:03.4954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62deMRMziClMI4/fnKHP25QnTsx7nVxNprstKVe0RvE2cgqQm6s2Os04ela61vp9Ikx3cncdnZldyl6JVOmOjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5502
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH
 v21] virtio-net: support inner header hash

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgSnVseSAxMiwgMjAyMyA2OjMxIFBNDQoNCj4gVGhlcmUncyBubyBuZWVkIHRvIHVz
ZSB1bmRlc2NvcmVzIGhlcmUuIExldCdzIGp1c3Qgc3dpdGNoIHRvIGEgZGFzaCBhbmQgYmUgZG9u
ZQ0KPiB3aXRoIGl0LiBFLmcuIEdSRS1yZmMyNzg0DQpUbyBrZWVwIHRoaW5ncyBsaWtlIGV4aXN0
aW5nIHJlZmVyZW5jZXMgYW5kIHNpbXBsZSBJIHJlbW92ZWQgdGhlIGV4dHJhIEdSRS0gcHJlZml4
IHRvby4NClBsZWFzZSByZXZpZXcgdGhlIGZpeGVzIGF0IFsxXQ0KDQpbMV0gaHR0cHM6Ly9saXN0
cy5vYXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8yMDIzMDcvbXNnMDAxNzIu
aHRtbA0K

