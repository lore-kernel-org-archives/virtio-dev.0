Return-Path: <virtio-dev-return-11569-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920ABC61DA4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 13:05:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BD9F72ACA5
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 13:05:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 96D909866FF
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 13:05:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4C32A9866F5; Thu,  9 Mar 2023 13:05:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 601D89866F6;
	Thu,  9 Mar 2023 13:04:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogcdh+ll5OZUciMdfihOMV+xyeQbc7nebb2v6HssK+gxjdoBLhpUT2wC44jVhTUAHLL5LzA+B+fNe7QLrJtN0FYDCFoVIUbAuT2UxBBd1pXWywy1O4mljJN0QSo+GGKduUeEZWVTpKpec5Drs9rmg94w+YCNgNcc7+cENXq0Vl/gCPZWJbFENpoAqOcTdLlZXDxM3eoYSpH5dn7H6IwAzVNraQ90rUuqGHZ4qGSc0fJnYruAF/trettX4CFHTShoN3oQbyjkJ0lQVKKs3XGz2eeQKYzPAoB1WMnGt2dOGbThSRuVemr7HwDO8O3BV8GjQnE3wF5v4qeIDt/qpjP30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwIXcO0ksZpmb145voVPfc1pIM36WW9VrEZkrOQFRZU=;
 b=Lk0xLlqF4BAXSGkrdZaHBuBrn3FtOtjj6ryF2dUi6B4SSg5QjEYWHjh/pAtQO+0YNtp7wtsrc+z3Bs2+90d6Iy2+walhcLmVC74HFlBKIV3CLh0kDvVgy0wTB9angmhbA4wxnw1SIK+AomLKjeDCrSypMWTSpZv3Vf49uIm6FMmRTSCsNWMPCHV5aEKhgSuQBD3ah7dmBBc48CFhtN7rf6B+r9uiNGVarxpIfQdJDgB1R65hWKutMZeNCn1ZZ7bF/8y4YTbYN7niWHv4RHidAsuix8F75j8IJfyt8vramcv7tP1Ks8cMn8joyJ7W1p6frBJ8LQWDEP2DF6aNfUsp7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jiri Pirko <jiri@nvidia.com>
CC: David Edmondson <david.edmondson@oracle.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues
Thread-Index:
 AQHZUaV1hq+swD5r7EeFCHM9rP6wha7wxScAgAAFDACAAFmxgIAACLQAgAA3RYCAAKrygIAAXFnA
Date: Thu, 9 Mar 2023 13:04:30 +0000
Message-ID:
 <PH0PR12MB54817E2CEFF003E793C9B2F3DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <ZAXfegxCfvfLwiJT@nanopsycho>
 <20230306133816-mutt-send-email-mst@kernel.org> <ZAbpiRVdo8BciELX@nanopsycho>
 <20230307111458-mutt-send-email-mst@kernel.org> <ZAhdzCd6qwWydesz@nanopsycho>
 <20230308064505-mutt-send-email-mst@kernel.org> <ZAh61E/wQ/hSY/OI@nanopsycho>
 <18d51bc0-d759-1a05-cb7c-3d46c4ed2f1a@nvidia.com> <m2wn3rxgv5.fsf@oracle.com>
 <PH0PR12MB548150700B50006F9F174104DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZAmLIc97Ud09YfGT@nanopsycho>
In-Reply-To: <ZAmLIc97Ud09YfGT@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB7518:EE_
x-ms-office365-filtering-correlation-id: 65b7b69e-06b0-4bff-d717-08db209ed23a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VYcY1pY5926k6/HtsmdBAuaCZCB1TR1HJV9OM//UPR5Vh/yZTb3piKIkMpNRIy0HNTohltX5eRV34YI8QT4O1v2yEWVw1CrCgPE6lNO6lJ16R+ineZznG7UPenIcaYRFGe9cJC6T2v0tHXJ9XYT5ljhs1qf5GyFJ1IEOuUUewLveQ0jimfDMkivuB/7nUo0ZLDToLCW5LckDvPyhfvU01kQ6R4GeeBcZBzxVYyFMDA+bgOy+g/Jfg3m4RJpWvp8EdIsUMttpi46ytIExoeqrZipVdbVxjHny2tRUaOCTsKqUDn6Ue1a9DWRxTQ4fRL+nLqWtz6FitwhNbpE/8R/KHJ0GFMhrn6hzjoLHM7waocfS6ubveV6oMPmwKGvMyyzuLphgwdx6/lFGz+eLUcEBfMCa4xGozdNaMVdyGRijrzEcCiQgx5y2QhL8nQHrydKRvVEf7+9xfhfxW3IpCCX6zK/YN3qwWyXXMIgVh/TlfJbgbaTV7Kl1WWbzsOvkHTGknDcYWZJhtnZzKJCJ261hnrJUFuPm7lC2g3G7eoRsspSBMXjIV+nDWEW9t82ByjdJEsj99BhxvQLzod0x8fjwXUo6i2xjHedJqexN/NBh6+jp56mkJ39ITuZRDOvcIsWYRcowBqDMqjz4I0ddGhoL38U5n8qb8wWjHEgRmPFje/ajt3hEhna6v87xiaHA+bYp/jXgaOFvAzGVzP3cLjxzgw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199018)(55016003)(186003)(7696005)(71200400001)(33656002)(478600001)(54906003)(122000001)(38070700005)(86362001)(316002)(38100700002)(6636002)(6506007)(83380400001)(9686003)(41300700001)(107886003)(5660300002)(7416002)(6862004)(52536014)(64756008)(76116006)(66446008)(8936002)(66556008)(2906002)(66476007)(8676002)(66946007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lpdcrY6NyFla7ty7oDSmN1nwuXnxsbbo28siA44UZh9jnkpK6zRh2SNDPQiJ?=
 =?us-ascii?Q?3VKbcLLkrTviRp3gApWQ9KHY6FADarsrU235JHZmt96cnlGlSRS2j5Ikx20C?=
 =?us-ascii?Q?3fFSpCrm7Ynlf8XKwQB3aYIo0FFn1YL5dJ1lt+f9Me+H2qLQx8h8QVkX9Bhg?=
 =?us-ascii?Q?hLQ7GxtgeuHawc03SsS6nLcIeR74WcEMes26TFNkkLkHrMeQgJgJYiFQw9/w?=
 =?us-ascii?Q?4Q4ym6RXGeLJ2udFB14Ux93lDmSCLPGJNC7ocgRVLjfKRcAHh7EsJtWOn8l4?=
 =?us-ascii?Q?gGnXPOMsZqv1QA/PmE+xAV4AFpSTymEBxV+VX0L72jl804roRT1soprl+cH+?=
 =?us-ascii?Q?SNOEQzthGdwjcf9P1M6AXkIDfbRXge8v837s6Osg2TsmzxV12mYMssDxyLTc?=
 =?us-ascii?Q?4gCmCiXeSD60vzU2BnoZppeXDE7o6REYA0nINpiBhUzY5viImgwKpp7MVfcU?=
 =?us-ascii?Q?zWmnWNnVWZuILuY76ceEWj7fxd1nRGacgKTNMo74cNF42rvzmKlv44Weq2s2?=
 =?us-ascii?Q?Tc/tObxsxYB00aQQXA1WFKKPHBS3rMiDMwkfAGebVgHu6elnYh3nCTjrq2xq?=
 =?us-ascii?Q?YdWe1uk3oOxFhoLEGnbT1WObWRCpjPgcZl75B1fYvRTyR/NMYTNddx2ji7wJ?=
 =?us-ascii?Q?Oyx+J4iuQiw9BRHj+N52/Ryr7542axUjm1qKfzVBYfnb2+7iT4PCgWrrfI/I?=
 =?us-ascii?Q?EMXhqBif/Hoq5kcA7iwXigAK7nX5lTNbuUa669JqKyW+4J+YcM4kQLrYdf7t?=
 =?us-ascii?Q?KPrXP1dvdnSvfAtO/TAoKCBlCk057oXj1tvmDZitBeQIcVmBRwxrHlsweIQn?=
 =?us-ascii?Q?UYRkR0ChS0f5pouAFzR/7lcDIHxz3RnM+h9CFvw2Pi1xorHlMJcLOul+JdIZ?=
 =?us-ascii?Q?Gtrorc53yjAgDkk2Kjf7YSomDzRG4o3KZu9EcQMt8+drxvyIzunIm6xiV9SZ?=
 =?us-ascii?Q?sehR0L2NzBnDyazFil4sP892uggctxptpwNH2TWGIEHpYXOqIVQVVvvg45BN?=
 =?us-ascii?Q?n85PnpAXFOBeyzvnTD68gBKtA454L/rl0A/6i/N5wnujzcD08mSfPVpimHaS?=
 =?us-ascii?Q?PCjHmjc2ar9MBy4QqFSfAS5CXvhu0CbcAFYaUcTwd71aQpj7Sj+hi7N1rqgd?=
 =?us-ascii?Q?2wSLBKFMtzzAKVSMOAvGmHSQtOdVjO4Llo93cxbMuplP7Ia5MCP16j6A+40o?=
 =?us-ascii?Q?hMgf29jV9N4QHUPYBx24ia75hr24D98zUT0pea2XP+T6hz1/+gYmyMkgqsi4?=
 =?us-ascii?Q?m7KR8Q/azlQvO/Amt7X7uXJNkhMNJXRWWg9CCC0SQ2TwiJNManQUJ++pvw3N?=
 =?us-ascii?Q?kq8merMN5lRKgPG41l6l/nDXkOcshsLXL/9e0uFZ+tzzghf8dSW2yMt9ly9t?=
 =?us-ascii?Q?PIMTtnrWSxam5vXSTjdic27FWAxfomPdMdWRNnKpwoQhG10wU3hnowSOn0Hv?=
 =?us-ascii?Q?PuauVsb820u8fekOE1QGuTbe84OxQkUh/cnnECX7dcFffyexUznrcAheKC6c?=
 =?us-ascii?Q?abhwJaC/hLsLdTcRK3AzXquAF+8z5P2kx6mqCjVYn/I0OaOc1NOSA3rHVF0J?=
 =?us-ascii?Q?6MZU4BPLmRfp28TPmdyoxmUBZINl22DLDeO89TDBFv6BSa5m8+Ul7z+kXbYS?=
 =?us-ascii?Q?GYMZaV+CtPm2yAB5BlKZcaE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b7b69e-06b0-4bff-d717-08db209ed23a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 13:04:30.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VofSFcaGkWqS/KWi5q78gzbHmXVhh0+Lyy9ZK9oKhNIBTZX33WBRkpQ2qWAy9jsmyHYzouAtJNv6sKB93Qmqww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues


> From: Jiri Pirko <jiri@nvidia.com>
> Sent: Thursday, March 9, 2023 2:31 AM
>=20
> Wed, Mar 08, 2023 at 10:25:32PM CET, parav@nvidia.com wrote:
> >
> >> From: virtio-comment@lists.oasis-open.org
> >> <virtio-comment@lists.oasis- open.org> On Behalf Of David Edmondson
> >
> >> In support of live migration, might we end up moving large amounts of
> >> device state through the admin queue?
> >>
> >Correct.
> >
> >> If so, that would seem to have some performance requirements, though
> >> I don't know if it would justify multiple admin queues.
> >DMA of the data through the proposed AQ is supported.
> >
> >If I understood Max correctly when Max said " This AQ is not aimed for
> >performance ", he means that AQ doesn't have performance requirements as
> io/network queues to complete millions of ops/sec.
> >
> >it is several hundred to maybe (on the higher side) thousand ops/sec dur=
ing
> LM, provisioning use case.
>=20
> But isn't it good to design it for performance from start? I mean, state =
transfer
> of thousands of VFs at a time is definitelly performance related, isn't i=
t?
>=20
It is. Which part of the proposed AQ doesn't cover this aspect?
The only issue that I see today is, that a given GET family of commands q c=
ontains the read-only and write-only descriptors which require multiple dma=
 allocations on driver side.

>=20
> >
> >DMA perspective as you mentioned, AQ still has the same perf requirement=
s
> as that of regular nw/blk io queues.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

