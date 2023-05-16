Return-Path: <virtio-dev-return-12741-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ED4C77B7F
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:50:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 18FF516A498
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:50:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C52EC986704
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:50:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 58C0E9862F8; Tue, 16 May 2023 21:50:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64A499862F7;
	Tue, 16 May 2023 21:49:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9o5npWNNKLLJYeraQKJh90czcv+JehPwUbKGoF/cMvsRSj/RVRcaCQ4VBF8e+swolx1gSpobStqz6KB72bVdb5dO6XMKQNZZcHZ3iFOAwHmcZAhdsaXU6Eg9SCooCIFAt2ey1nY1RWz+B/YvHHjk4wIQj7tP/EGgzrdN8VECDvEaIKsBtfZB2mTrqYbw12iHjs4/XvsvOh7aKCaIpc8z20gzeYBy1yu9QdvgT9gtWq10mK9RkH3yCu7bytcDVPgxsBeunjjRxvSyY2n/Wqf+XB7ciYCVCrEwJZ0VYMYshJx0MHOwrzitB21HqtaFHlKP+rakaJ2+R4e8M5qtm9ffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2OxXw4UryGTbSdfexxX7b1Dkx07rKhiPC2GUZeJnK4=;
 b=JCzACtv6tafKknu5kYB4Vrq/pUTPZUzcxL7hQcruZz2eNRXuV88eT0xKX7v6NSRH4xXLFpnYf1isJDmeU82MatPAEBqZzi/Qlg3pKqWKrZbj/2WDBLkR0UgZ/2V2P32pHZUH9uZtZytL8YjW6KDGOjp+vnwg5nFHx5A9o/aFgsj4B+GErPPMFk8lDuyIAOFBC6ucLc7XvFFn+7PbdKqrqN07mBgmkku9q5+bWyU/aS/71GRxeZiUgkCU8xBmAS/65erDEgyOHmt1csBsmhbM/49XrlpcRD99QfROo/3MSM0SsNRf+xGu3usPpeSTBTtSqtpmKLb9nd666v036M1z6g==
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
Thread-Topic: [virtio-comment] Re: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgAAP1ICAAAu1gIABh4gAgABl1qCAB0C7gIABBZQQgAAcJwCAAAnvMA==
Date: Tue, 16 May 2023 21:49:19 +0000
Message-ID:
 <PH0PR12MB5481C64573259FEE1C191229DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <PH0PR12MB5481BCA4D8F6546B3300DD29DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <83603339-e3fa-fe56-d447-813e73eb1961@redhat.com>
 <PH0PR12MB54815633F6C88A1EFFB24500DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516170940-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230516170940-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW6PR12MB8898:EE_
x-ms-office365-filtering-correlation-id: 0b8ec5d0-4d65-4732-efa2-08db565766da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ASgSWet4VM3CQIrUw57/ielPhGvnVCZoQlrt9+4UpNQDoAwJRGQxALf3GxfjuskgK//IHnlDIMyvrSyHrBNQ7uH9KrJnnNw69icwZm28MFiJNQRPfUPLKWIwXF4m8ceQSx/fysIB0CB6SuvagW82/TSmn3jmDw+lC9zN8P7bCHTFowriOukJFhZxOKx7kvQJ69P66smPIkwBHhCcOnL5oM+U1dD2onCRHbgGzSSXIc0Mhreo/dM/tYGkKtNpIl0xyYtg9Y6gDC1/9HcqIF6HDFCsnrt110x8BiBSkYJPBbrrCdmtgdJoEW/KTm4FsJYFK8D8aH3YpbIEq1vU3DLh1u4piYkVIg6ISfxPxpux9KPMqRZ7fpB8IQ0apSkRx5GutdM7uEiXW6ipx2F2q5ON4lXdHKwfud5uum2FAlceXN4hnjPFrF9GJsb9fvAagBMY/8BltCLEplj4D2FADv86lfKvk6eEjwgEyA9l58hVKkg0VuDmHlgKKoKHEFW6Ga9HCrj1aluXJmtmjzHQux5WlYt38cH8B5zJP1Kt1gKxgHjZcsGT5MxDgMA5/90S9FBfkgOsZeU/WklfEIdLTeTjXpPADjZHd3TeaD+tZJMQ82FjzheCNfuLbUi1140GhHHA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(38070700005)(71200400001)(55016003)(122000001)(38100700002)(6506007)(107886003)(186003)(26005)(9686003)(33656002)(4744005)(5660300002)(52536014)(2906002)(8676002)(8936002)(41300700001)(478600001)(7696005)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(4326008)(6916009)(86362001)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWRhdEF3WG5uYkhwUjkwajdLQ3c3L3owbWZNMGpEMXo5enFjZ3JqZ3JMQ2J1?=
 =?utf-8?B?a1FwemFhWmd2a0hEUVV3UzFSWlBUVmdWeXQ3NlhtM1NMSnFIWjRTNFR1STR5?=
 =?utf-8?B?UjJLdkhhMkxqYzM4NElaaFFaN2RkRWdkekxjKy9pRTlqWnkvdzNkUGdObVh2?=
 =?utf-8?B?dGxPblFUV3lFRUJOcElmb1FDSlozNWVVM282TkhUL3h6RVlVTE50S1NrZGhT?=
 =?utf-8?B?TElPck13aWFHdlA0V1gwMTZuV3IvVkNHRzgrTDByTDZmcGpMK0pKNUNpbU5Y?=
 =?utf-8?B?Wml4djgvTGlONjk0RU1GZXdURFFpRlR3bGdxVVdmTjNMK0xEbVhJODJKRUhV?=
 =?utf-8?B?RHM0c2s3YzRUelBDWGc4MytkZXptVWFTM01WUEt4RUp2Q01pZVprb1ZVVUtG?=
 =?utf-8?B?emN5VVBZNy91aUwvVlFSU2h6d1FabWNjd1dNUXdiRGdJeG1wbW9haW1TLzJs?=
 =?utf-8?B?S0RiUGNBdHFFUWhjTE41eGY4MTVjVlE3Y2tUQm11aTkvbmFoV01uWjlYL1hp?=
 =?utf-8?B?Zk53VGd2WG11eTQ2QTNrQVdwZi9FVS9lZUVQTlFGb0NOUzhnbzVPckRsQXFV?=
 =?utf-8?B?VTV2MWtsWGZyVEVFbDRvdDhCSDd2bmk0MDA4MWx5NXRBd09LMGtMbkZQVXRz?=
 =?utf-8?B?UDZWOTFVaU5vSFdaWTY2S0Zhb0oydGI3N21zWUdRaS81Uk5nYmxHZThwUWV4?=
 =?utf-8?B?SndYdHhaT3RldElsQ3h4UHF0Y2YrWTlTUWdjZG80YTRLV2hTOXhoRXVqZGxX?=
 =?utf-8?B?M3BpaFlRZVZUWVZhS092M0Ywa29rd3ljN0Q1STVpcjM1RU5nZ1hFSU5Dbkxa?=
 =?utf-8?B?bloydHRmN3RhbXFXUzFmZHN0TkVCZC9zNXhrU2x3cW93TGpBMXkrdjFKKzcv?=
 =?utf-8?B?SkxvTUREbEV1UWcwV2N1bXU5V2UwZjVoVW9RcHVqeFlYNEFMNXVwK2VIMFRK?=
 =?utf-8?B?SUppTXVkaHl0RExtYW01TXlFcEM3Sm56dkpqdkhpMVR3SGs4L1Arc2ZGdlpG?=
 =?utf-8?B?bHpKdldZNnBWS2ZiZjdGK3BGdWJmTEc5eGRLR2dpWEdvUnNIdDJJdE9jZ0Zl?=
 =?utf-8?B?N2RzQm1IMUJiZGlFZW9KVjdBSndhM2JmRGkxS09KSEgrQmRzdDdDR0NPb3BR?=
 =?utf-8?B?by9DU0tXVENGeHFVMVU5bjM5UGc4WGJZQkJqY1pxQktjV3ZtVC9oU3lWc2xK?=
 =?utf-8?B?QzVzSGdWei96MTEvemlPc2t5ZytJNnhodFJrcXZ5MnV0cU9wZDNRSk9ocThl?=
 =?utf-8?B?L2M4NW13NDhaaG9CL25XWWZkUW5KTFAybEZrMitlMkp1R2wyK2hYaTVwK0Qv?=
 =?utf-8?B?Z2paVWM5OVZHalFaYzhET3pxS3B6K0JZL2NQNE5uWDRtK0dkOHdpZFVvSW1J?=
 =?utf-8?B?bkhadWZFQyt2eXdIQnRRMk5UQUZLYWYwY2xndUV3Wnl1ay9hOWZpUWk5S3Mx?=
 =?utf-8?B?NFkydm9BVEplbDVqc3B6K2kwdEdYMXFYa2U0d3JIbjVIdTFlZm1WRk1NSUZi?=
 =?utf-8?B?UDkxRE93Z2VZRkZlYmJYSjFiTVRpUTB6SXV3cmdrY0NuMExGYnN4MlFNM2sw?=
 =?utf-8?B?T3hsUU4rY1hTd2I5cE5LMjBoVU95a25TUVgzVFIyTk1UYjlod0QvTEVkQ3VS?=
 =?utf-8?B?T0g0b0pzVUVJU1V3Z3NNZkxPdGtSTjBuZi9obDNsY2NBVm1MMzE3NzdGdTBN?=
 =?utf-8?B?QVh2dWZQWFFGMVNmR0ZlaVdadE9GMURzNjFCMkplbnRsdjNSQTFDamJKSGFK?=
 =?utf-8?B?WmxlK2JzYUZBNnZoMzQrVGIxclBvbmYzeWVaTWp3Q1pmaTdKRHYrNnlxRGg5?=
 =?utf-8?B?YUNHaStSNkdhZHl1QkVrMmZKZGxkQmtRa1VqZ3ZxNEsvVng0SDg0VjFlRlV4?=
 =?utf-8?B?RkpkT2QxeG9rMm9WQ0NsQUl4TzJjNUgzamxSc2pDbUdpV216MXIrREpQVGd3?=
 =?utf-8?B?WG5JcXJwbC9CSW1RRzhhZEx5K2tVdnU0UXZLbUF3WEtSYzIzTytPcTVhdkxY?=
 =?utf-8?B?Z1NqR3lsTnJQNW1ibEFpMGgzUUdIb01TWHRNYlhyOTlvOFlpMTdyU1d0S1By?=
 =?utf-8?B?WTh1TVhGcndkbGZMK29JcGNzUzdVR01TN0RZV2QzanFTdThaUitRQjRLV1hZ?=
 =?utf-8?Q?DFDs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8ec5d0-4d65-4732-efa2-08db565766da
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 21:49:19.0336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAu9Nnk8q8rO7A520aEg4D2ECzFc3QJ7h5uNl8o2YDPmozJZUGL6OmNf7905urMMIyfmR8R8nh8SFCtWwKnAkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1
ZXNkYXksIE1heSAxNiwgMjAyMyA1OjEyIFBNDQoNCj4gDQo+IE5haCwgd2UgZG9uJ3QgbmVlZCBh
ICJicmVhayByYW5kb21seSB1bmxlc3MgaXQncyBhIGZ1bGwgbW9vbiBhbmQgeW91IGNyb3NzIHlv
dXINCj4gaGVhcnQgdGhyZWUgdGltZXMiIG1vZGUuIElmIHlvdSBhcmUgZ29pbmcgdG8gaW1wbGVt
ZW50IHN1cHBvcnQgZm9yIGxlZ2FjeQ0KPiBlbXVsYXRpb24gaW1wbGVtZW50IGl0IGluIGEgd2F5
IHRoYXQgZWl0aGVyIHByZWRpY3RhYmx5IHdvcmtzIG9yIHByZWRpY3RhYmx5DQo+IHJlZnVzZXMg
dG8gbG9hZC4NCg0KSXQgd29ya3Mgd2l0aCBzYW1lIGxldmVsIG9mIHByZWRpY3RhYmlsaXR5IGFz
IGN1cnJlbnQgbGVnYWN5IGludGVyZmFjZSBkZWZpbml0aW9uIGZvciB4ODZfNjQgcGxhdGZvcm0g
d2hlbiBtc2l4IGluIGd1ZXN0IGlzIHN1cHBvcnRlZC4NCg0KU3VwcG9ydGluZyBpbnR4IHdlIGRp
c2N1c3NlZCB0byBkZWFsIGluY3JlbWVudGFsbHkgYWZ0ZXIgdGhpcy4NCg==

