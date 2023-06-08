Return-Path: <virtio-dev-return-12891-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDC4C7EE25
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 14:53:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 518722B018
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 14:53:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3DE84986681
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 14:53:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 31D2A986655; Thu,  8 Jun 2023 14:53:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0C20098666B;
	Thu,  8 Jun 2023 14:53:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m95ckG4EjtcMLuMcXYYKEB1Mj+DTryR2U4FU5vqkdIPYbLKthPOvmJeiKbYDaAQz9Wte5LFMTzkZV7dojabHUMTalSCfcmhSZsI+beE5VpvdHsCWWQn/gKCbIX9521EkLpuwideFfvz5GD4xJgtmoL+SVgj50SKaPC2bGlwqjJyoP+vNDZA8o6AwElAZ74TybGy9rqjYjcEC0xHGsBlZW/bmHFXG3WCNHgbxS8TJhZDwJ0hRrp0iOdsX1xu9fVRCvrEUjgDPzUDMHs+XHjFVh5dK47RSdfXNYlCtGWZWgywZfNhTWV9bzIcSfteqXokQG35OMHfxeSM12yc9GPcC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djSsf0R3VW3PgWi2JSL9d+3T1uTFQhgxXE0/euQOVJs=;
 b=RusLbxDFrZWyq2WHoGC3uDkNvoXy3muKxmpeSGuqeBzNYirdDDwdoHWetFp10uJXkUFj8LsLMlkPB4oi+pbtWweniSBi+U6QIfRxFtI4eZvw0miGnxkCP8jBeRvPH2hN6esB55FaK0B3pseCXhr7QPvTXgQ4go5N5E4E4TzzVuv4nGs+DQuhbWZv/YSeBv6HP5bBcD3zsPwkP040ik09/Jj2mQhEe0I6+/f6MkdrntwZEjo4yXiy8rmI1Qc0d1BE1lXSgv8Ap13QEoI7AWN9ppHZxlu2jF7Hoi0wrwy69NYqr9EWtEqds7m++0LnPimOgbJ4gNr3s5ZLiqhDEyD4pg==
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
Thread-Topic: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQgABBawCAAhKfIIAAAwqAgAAAcVA=
Date: Thu, 8 Jun 2023 14:53:28 +0000
Message-ID:
 <PH0PR12MB54810E0A5A5E56B6420EB05CDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605092859-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org>
 <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608104215-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230608104215-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB8116:EE_
x-ms-office365-filtering-correlation-id: aec85ba2-01d9-4119-7d78-08db68301ec7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XAXsnhMDptE83PzVcWiMXQ2o2IAmwwyGIJZAYRw0IAb9c4vAIX3LXfpaGUeY2107UUQQ1kltTDyO1pebuaC12109bl1hWMzitD6aookJR0hOwDSXrbhoJRdtZ3cSXA22ihqfF4LNXOM+D/ezhdFs6bgT220eNUw+wySz7qni/hcIPxGMYlu+CS+m6YMwzFgZN0kcY6MmEw3nh0d+eH24nq7Wihw4xPkCaixVuRZJVkfLQ7/JeAeb2Ygg7WYmvGwqGcMbCuFRbbCCzDcVTARs+TO/87PPNWiLMX+1MNIBjRlek0zdX8lDboysg9pZ3yXC0XHdu5CC/k9vdInzBrgr3ZDy505RCBPVoH7KyoVTgmFEtJjk7SCTureP1OtUA3etLAgYukyOs/t68ZGUxAXHZSz4M00ozwfhSpw9chGtaD1nb/Zle4pN9gl9RyiPRd9z6wRAGybKDgsR2pYUkog6wovsd8B/A9NSAqk+pedQnbVA+XDHEKjtjvKdmXhNpj7YwpUCHj1/10vgJZAUzkT/LkJ9SV0uf2UdvCefzMvGSqp/yF3nJ5f8GnGgEOhp5lL3+h3FEvAKrxt4v//mgrq54GnuShZSHxZlMdyhxj3ESWEz3rAZYShhLjLGaX4lAdui
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199021)(26005)(66446008)(6506007)(9686003)(6916009)(316002)(83380400001)(76116006)(66476007)(66556008)(66946007)(64756008)(4326008)(122000001)(7696005)(107886003)(186003)(54906003)(71200400001)(33656002)(478600001)(38070700005)(2906002)(5660300002)(8936002)(8676002)(55016003)(52536014)(86362001)(41300700001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RVNktJhDyd4CVtmryMz/4ubl5+9jYQ9K8zaKmAs64WS4aelOBENWP+cbJ/DP?=
 =?us-ascii?Q?FSiL7KrvyTCrmIYO8iT2TR4M/k5BP+wuw24s49CtFtz971SrqR+VpBItddd/?=
 =?us-ascii?Q?bgSiJ4sTbI+nyBm0HlJ5pwBMVg59tDpcmRBjPacmzOFAXb3X/vtC5BXtoV4r?=
 =?us-ascii?Q?tUYdvVdZiWHVojtWvXC9TbneNNXxYq0OI02496D9A6gFzl3h5EKaxomKxZ3c?=
 =?us-ascii?Q?ByfYzJ3qi82gv7oqSB5N+OU8SvGxHzrSpfuz+QKMO3sGqeyKfQ+43pfLoSEG?=
 =?us-ascii?Q?It9mCFgxCr2WmRVPEmPmj6F46Hx5ObQ0sprisRcNmzsha7IJcsY8vkuUPRUo?=
 =?us-ascii?Q?RTaDneysxiXLFMUQI+MZFruzKRec127TlKFgabTKmyxq5IWaClCVIbKu1FCp?=
 =?us-ascii?Q?8TLaIVCvFguZd8J+2UoBtncZ9t1uiNQigJcZk3M9s0MvfCwSl6vBiAfR1dXq?=
 =?us-ascii?Q?GrdEgec8vgjt3XOg3ZtvG6Rw4+IOpUNUr7yg3f3m/fe7QBp8IQOVRNh41kyq?=
 =?us-ascii?Q?djMDWhEhWL9PhndUqd9lqG7zgHVEw0HLg/NCoAhZlM7+CSkZAJTDByX8IS8o?=
 =?us-ascii?Q?4NKG4x+V8XFCnw/0Rhj4CBT4uFVyivSSt3bU8byAATxrAciJIZHQhvGfCofl?=
 =?us-ascii?Q?UirLGfnylP++iW9O4X8cX88cLUmLkYADrBCDz+BHkvDkB+xgKG0xTHndsHFD?=
 =?us-ascii?Q?m40hFrSRBmHXRo3849Nwj7xmQUPc+ilvGkZE8ViBxfCSibPGDrXrTkW+x/se?=
 =?us-ascii?Q?Vx3darbb5Z8/b0uSWPma3NCNYP4eejyNgrfSq465fzsgf2Lii+cctSjfOuCo?=
 =?us-ascii?Q?O11sCoz+aajRM0ktyiILuYBYrPuEjUmENFNXg9riNFEmM2Ct2LOm5qXyoq33?=
 =?us-ascii?Q?ktQZ1Mbgs9FY6D2e4L441/L5qeXu31WSfZVxOlbcVl1wL91Uz6+gl7BKdW3Y?=
 =?us-ascii?Q?N+tnJ+qsZjPjcL1ULXd+6Fqo3Qpap2NFsRpt1lZKyObj2E7gSAJiM7Eg1ypk?=
 =?us-ascii?Q?Z+Y6eO4aymYF7+SHY1Ezhz1vne4CbvhG0QTvoUaglLLpjlnFEaljeEz1bddC?=
 =?us-ascii?Q?m1DWf/kOYe4QGCI4IsH5Nkzxl1xl1APjSXfvMJAMgoGUJ2jXa/DbeqM44Cl1?=
 =?us-ascii?Q?sPkGKDAhVcG5zhs26+438Tsx6VG73UAPJLIO0RR7VBBsyP49WppHb4xRTTyx?=
 =?us-ascii?Q?DkpdpXf99UecU1Ou8pvcHyCxStLjGqHQsFZ/2/vFsqQy/Tb46L8rgvSR9kZV?=
 =?us-ascii?Q?+/9gUwwBVBBUrbzOT7anHWeO08hZ6KmPXZr8Nr0kl2638HqfLQPajcogS+92?=
 =?us-ascii?Q?/TBSTl2H9x+7XuUOEOMWIwA8FOIDPr+q0IRvRhpjaBFjZCs3ikvNaV9VZDUx?=
 =?us-ascii?Q?OvXrjaHCxBrZElVUIOtB4GmyIKdfC4oFdqqTXIBV2rkAvUFM4E/fpKDnDBvY?=
 =?us-ascii?Q?14krdr1yJ5n3W4u7AiWaCoXCcMVDEwISK4E1/+YNn0KFb2BiHJT6rSsW9y1h?=
 =?us-ascii?Q?In7DViPdjlL56q/0R2TVbxf32dYMGIifXKiQgqRbWnky1hZBETjhVLHPdcLM?=
 =?us-ascii?Q?3ySru0f9kobpgc5eYOc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec85ba2-01d9-4119-7d78-08db68301ec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 14:53:28.6585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0gOgRW4mJ54/7vsPXDEg/0/0TvV+R5CLFNoPfobKDM6B2PfZSAp6UdhaxSLY2sMMCV8TzkP0or/9t/onMb++g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116
Subject: RE: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 8, 2023 10:44 AM
> > Since this ABI reflects what we agree on, I would want to raise for
> > vote in coming days to be part of 1.3 in few days as we have more than =
3
> weeks to sort out non-ABI language part.
>=20
> I think there's a bunch of work to tighten wording in v4, don't believe i=
t is ready
> for vote yet.=20
3rd patch has the conformance section.
Rest of the legacy interface semantics are just same as today.
We are not fixing the legacy interface itself, so not sure what to tighten =
specifically.

> Unfortunately I need to get ready for travel and then travel for the
> kvm forum, during this time I will try but I can't promise when I will be=
 able to
> go over it in detail and send comments. Back June 20.

Ok. that will be really helpful. I will revise v5 as soon as you and others=
 have comments.

Total line of spec line are < 200 lines including the 1st clean patch.
And changelog anyway precisely captures what changed so should not be too m=
any reviews to me.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

