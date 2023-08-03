Return-Path: <virtio-dev-return-13437-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35BEC04A6A
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 10:23:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E9EDA78DA7
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 10:23:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E65C3986724
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 10:23:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DAEF49866AE; Thu,  3 Aug 2023 10:23:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C1BCC9866B1;
	Thu,  3 Aug 2023 10:23:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjBfjDagkSwPUOYcv/VfcBvDMzMRFSxUh/jZvczLqvDCbnzPLabrP07l+oIqT6ThURqGSG5KMw6/Cna8eV5OVjIXfEVnMGvchOW9F2cagn0xEcDjPJcoZywwemG5oKLsAcGS0jvMEBzNcusEdRfVLL+X0katv9RkfbdkShUFhPmb27vY2h+CAiPp19TMGc8X7BwHSLdSirZ4JUuGV/E0e+aLDUxfJjVfNauqARAy92JBFdGsUeidn7Oy0qW4LoE9G15IBibK+M0EcHBnSh1sHXtAi1ZnUDdKrwvHSOJsl83EJO5bWFba9etN8egl8vnzc22Sve5SnZl0imD8P0sGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ak5uJQD5T+pyvk5/1fNwPt/9XsfEmn7k+iQZtnMI7JE=;
 b=FxShG+RdEnRdHXA2H7+qAoQnsrsBnO2uH1HXsEjnSNPJmCbKg7koeM9qxGmSAUhp+cuATLmWabdTkIDj0IWqeececMrueaxSeOaRtCsiAaZj3HMzyCBUZzfu9kNhrYGKRelSWjzBtCVhEZ0fT/cGw3nKK2DRJXC7brOTV1i0rIVgEzhc9eFQtqdH/gGHpJfPqOMdm+dOpsKStfwesPB1XXZuv7hi4ntM9lB9dnqbLN3cBsphzg/NbfaXpvTXNehLR+Di3CP4vpRsh9X0wnRYkEmuE7btQxPFM0PUOmmKSBwUxxPkWu8aMzs5KTEoX/F1dukAou8QuFxNQFivyud5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>
Thread-Topic: [RFC] virtio-net: support access and control the member devices
Thread-Index: AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YW5SQ
Date: Thu, 3 Aug 2023 10:23:32 +0000
Message-ID:
 <PH0PR12MB5481B976E62998B8B61267C8DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB8548:EE_
x-ms-office365-filtering-correlation-id: 756d6c78-543b-4d1b-fd07-08db940bb01f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uK/y/6WNTajfOoEVTHF90FA5/AMj/6RNL05SqBWDCePC/Px0HVyrRUajV0KPXiWHg4c768HCQ2WeBBCcAVUgSiFWokiiVvmHtjRa5986pKMuTDn/fCOt2eWugyYIXPqAkNQFRFK5GV3tkc9hK4wzNFfMdUsRujcwD+UpVlr7FxsxGjwt259PbnXFDACRd/971bTw261q2R7WrFFFC6WSQYLcKKiGGTt514TLUMZeHhppF8uxVf9zOhKu46/iZoG+45qTIVEKgT1Lx/No6fxSxd5DCMVyc4kfeSAXSdHTApgoLTGaf5Yt//pxHD0bNVxLQot9dUCJxSiZAIRGWM6k1FQWv3p8u0GdsJVm5YBBldJ0Al7nDCDSL9alwR5PJegTlOJfQqz8AXYCqwplSyXQGiNDP3s3dBl8lFBgvE3Hm13f6FM3UyykDEYFBYZWtMxB3IMEdZvPPka0e1KNjPD2jx2GcHW+d54JvI1/p6BqL2zJFB5hYZ024bJuuV/Sn6j8SvP38zXH2HfhDMtVo4a6PEIVroBONX86DOIrxi3EA48VabujhTXkzldy6vVsSAmUBOesTFAD4oVL+YMr5SjEZ/G9GtAKUNgpg3hVT5Et0mCAUAD7LS5WKpXBsu2BYcis
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(54906003)(66556008)(66476007)(41300700001)(66446008)(64756008)(316002)(2906002)(76116006)(66946007)(4326008)(52536014)(8676002)(8936002)(5660300002)(122000001)(6506007)(33656002)(38100700002)(26005)(53546011)(38070700005)(186003)(83380400001)(86362001)(9686003)(478600001)(110136005)(7696005)(71200400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0G+dKK+DOB+KgLzN76CoHLITKB0/6rJ4JDGjyylOtnXNMMCJYEW6iqgfMkfe?=
 =?us-ascii?Q?xZxxyn3FYWUS5xdeN2aZvutIWlc2AtJ8KxsDb7yNqTFECiyr06zJ+lliK4wb?=
 =?us-ascii?Q?8Hj/TLB14jtu1Rcnqs8Sp5U3CO8ryfrdoCWBQxFHgZB954MFUvUqkoRA9z8u?=
 =?us-ascii?Q?bUaf7QAomwf92l3OGRXuqrFPK6As8hbHmwW5Ksja5prm2YVT955C9A6PIEDj?=
 =?us-ascii?Q?+2j6A+NYqY1AmI9ubvuZlJ+26/YUCun4XIVwyvudBsh3ieZT6iKRq5WgVnFV?=
 =?us-ascii?Q?JQb8yHnaUk8q7z9T/50EBEoP4ykLrvR9zOqNUJA/kLfgdHXuEzfmB9g80tE4?=
 =?us-ascii?Q?ufChP5z5NmG06hT8Tm6Q0PWn5OOuXM0n/clafEkYVtNjMau206sdkfwHgq/y?=
 =?us-ascii?Q?6/hcGHooo6t3YSG4rfs1o/6koaKKK1WP26dTYtZpT+zQzEybTM/4WJYNj9NT?=
 =?us-ascii?Q?/RCNzlyRS/acRdUAt4D2YXc7iZiRP8iyb5M5JbmxuafVpvf1V4O5AM7bdBVJ?=
 =?us-ascii?Q?cxPBzhY11ANdz7HeQXy7bLgATYsWk/zF2lKHqejocc0mIrEd6rGkZAFqQOUi?=
 =?us-ascii?Q?rwiB4KbMM+RptohuIHPegIJQyxiP6V9Io9/TSxjjskvVJdJ0ibkzpCiX17Bf?=
 =?us-ascii?Q?1Pj0FnVaq5poJP+slBVVLW90N9roEDsPcnZDBuJjqTR+xUr7sGHyaTJ2rMH4?=
 =?us-ascii?Q?JMHo6XtZ8ggpd/sqJRiJRHT1ElVg1/iecHUU44In3T5HwKhdV5TmZbcp03h3?=
 =?us-ascii?Q?Lv+NYkv20UebfiPmgrT34Q2mMM+48YaW5Zl00rUOWzs6daIBwbBBhiIZKEev?=
 =?us-ascii?Q?TtCt13M/NzwXoKspl3Tpm2iCcWMjid0RMrpapsMmbqht88CtAkCg7VXCyWhE?=
 =?us-ascii?Q?Ix/03xsMYKgHgQrwvQF77tthCsKqPH6z255ixV4auYwYrB/DHgfPOll1aOGC?=
 =?us-ascii?Q?2b8aPJvOW5RysCuc6rOZjDxuQ9Ysie9uzVTwCneLvk7B1LP/0LTadScz4dWk?=
 =?us-ascii?Q?/lTp1eenHijRly66+hGvIe3slwkaYfMqe6fWIPX7t44R7w6ayfsVd4mY9V8a?=
 =?us-ascii?Q?r28LXCF7aF575oYm9xr019x/6j0GzkEkfbO/DLfT0rxj1/OH2lFXPNLw2duk?=
 =?us-ascii?Q?t9k3C1p73x0pAV0AkgUlhP9sDPk/T0GHIuDa7Jcqo3OWOjaYI96IUhQdKi8P?=
 =?us-ascii?Q?CwwcS4iv1hkFPu6o3kxifmiCfxd6N243uIzftSTqVbBHb7sZ7tyI96RB6gWy?=
 =?us-ascii?Q?C6u3hyijXN6O2wXrvbEcxhVci4ilnCxzThH+thdxaCcKHocTT8Nsvk90ZKb3?=
 =?us-ascii?Q?5j3HgiCnJ3ud3aucIcgmEGGdWfIscD1UCSPjWYZKTGJlL3DvGuSqFnSxfiV+?=
 =?us-ascii?Q?NsOWIO8omNfke3/1MXDXp+BlWwC/qeX0/ShKFPfHLnSguCvJbEQAG8wuwq6R?=
 =?us-ascii?Q?IpN9p42tz14uF6TiM6O6LTwAyxXZ3EuxR0JwGEX4LAsxsSTOGIOpnplxbY88?=
 =?us-ascii?Q?+Q7twcRHId/BNAKgP/kOhdCL10YOl8xmu5bi/3sUzN6eOKCP7hVW7K+vRsJ8?=
 =?us-ascii?Q?hEBDFZRl5lnUYRa5+N8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756d6c78-543b-4d1b-fd07-08db940bb01f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 10:23:32.3217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4X+i5+jmbm5VONYMszg1utDwfpPpnWDzeXZf4k8CCukcqa5mahAldPJH4D9uCMJZHBfYbQyvCwNqgkkzk+bqEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548
Subject: [virtio-dev] RE: [RFC] virtio-net: support access and control the member devices


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Thursday, August 3, 2023 2:02 PM
> To: virtio-dev@lists.oasis-open.org
> Cc: jasowang@redhat.com; Michael S. Tsirkin <mst@redhat.com>; Parav Pandi=
t
> <parav@nvidia.com>; virtio-comment@lists.oasis-open.org
> Subject: [RFC] virtio-net: support access and control the member devices
>=20
> Now we have the concept of the device group. This allows us to support sr=
-iov
> and siov more conveniently.
>=20
> The following description uses pf, vf as an example. The scene with sf sh=
ould be
> similar.
>=20
> According to my understanding, the management at the level of virtqueue
> should be handled by admin queue. And the net related management is still
> managed by cvq of pf. So this patch works with the cvq of the pf.
>
Admin command is preferred
=20
> The problem I am trying to solve is when there are multiple vf virtio-net=
 devices
> under one pf.
> It is necessary for administrators to query the status and information of=
 each vf
> and configure mac.
This patch enables to configure also, please add it in the commit log.

>=20
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  device-types/net/description.tex        | 72 +++++++++++++++++++++++--
>  device-types/net/device-conformance.tex |  1 +
>  2 files changed, 70 insertions(+), 3 deletions(-)
>=20
> diff --git a/device-types/net/description.tex b/device-types/net/descript=
ion.tex
> index 76585b0..1494a18 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -88,6 +88,9 @@ \subsection{Feature bits}\label{sec:Device Types /
> Network Device / Feature bits  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set
> MAC address through control
>      channel.
>=20
> +\item[VIRTIO_NET_F_ACCESS_MEMBER_DEVICE(51)] Device can access and
> control the
> +    member devices.
> +
Once admin command is used, patch will be simpler without new feature bit.

>  \item[VIRTIO_NET_F_HASH_TUNNEL(51)] Device supports inner header hash
> for encapsulated packets.
>=20
>  \item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue
> notification coalescing.
> @@ -1156,6 +1159,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device
> Types / Network Device / Devi
>          u8 command;
>          u8 command-specific-data[];
>          u8 ack;
> +        u8 command-specific-data-reply[];
>  };
>=20
>  /* ack values */
> @@ -1164,9 +1168,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device
> Types / Network Device / Devi  \end{lstlisting}
>=20
>  The \field{class}, \field{command} and command-specific-data are set by =
the -
> driver, and the device sets the \field{ack} byte. There is little it can =
-do except
> issue a diagnostic if \field{ack} is not -VIRTIO_NET_OK.
> +driver, and the device sets the \field{ack} byte and optionally
> +\field{command-specific-data-reply}. There is little the driver can do
> +except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
> +
> +The command VIRTIO_NET_CTRL_MEMBER_GET_INFO contains
> \field{command-specific-data-reply}.
>=20
>  \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network De=
vice
> / Device Operation / Control Virtqueue / Packet Receive Filtering}
> \label{sec:Device Types / Network Device / Device Operation / Control
> Virtqueue / Setting Promiscuous Mode}%old label for latexdiff @@ -1805,6
> +1811,66 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types /
> Network Device / Devi
>=20
>  Upon reset, a device MUST initialize all coalescing parameters to 0.
>=20
> +\paragraph{Member Device}\label{sec:Device Types / Network Device /
> +Device Operation / Control Virtqueue / Member Info}
> +
> +If a deivce is the own deivce inside one device group and the feature
> +VIRTIO_NET_F_ACCESS_MEMBER_DEVICE is negotiated, the own driver can
> +obtain the info and change the configuration of the member devices of
> +this device group.
> +
> +\begin{lstlisting}
> +struct virtio_net_ctrl_member {
> +        le64 group_member_id;
> +};
> +
> +struct virtio_net_ctrl_member_info_reply {
We need a bitmap to indicate which fields are valid.
We did a nice work of it in vdpa tool to describe both, the fields and bitm=
ap.

Also, when you change to admin command, please change suffix to from _reply=
 to _result to align to its terminology.

> +        u8 mac[6];
> +        le16 status;
> +        le16 max_virtqueue_pairs;
> +        le16 mtu;
> +        le32 speed;
> +        u8 duplex;

We should above split constant config space fields and below run time field=
s meant for debug purpose.
We are working on the member device migration proposal and below fields bel=
ong to "device context" should be available through such separate command.
But if you do it before, please cover the whole device state and we will be=
 able to reuse for multiple use-cases.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

