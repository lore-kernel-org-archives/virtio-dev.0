Return-Path: <virtio-dev-return-13011-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726A8EB64D7
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 17:52:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9255BD41E9
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 17:52:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8A46B9865D6
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 17:52:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7E7139865BA; Wed, 21 Jun 2023 17:52:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 695BB9865BD;
	Wed, 21 Jun 2023 17:52:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5v2G2kndGz624ADLnNf+WImeiQedQA0QcGtmTUGoxpJ+O78tg0FtwTxhjsK+ECV2eBXWUUDQwG0xhVcGPrJp3i9nUUTX5R5BNb/n9fiPowLqT/GU9D3WZN7EfRWYjLCgNtocqVnOHc9IPfXZH8c/AXTvtK+Pxd9IG9SbJJ+PvZifkZnI50HgQSlj24yIneZWBlbDHoO9cK2jZctO/jg1peF9NNdAAX/fuIadI1f4AO0zZL2ie+Wdhp4hvHtRDLA3lXVqpgB9EIpAmGzPPLTrI+Twl2gTI6B8WHRvNtT1OQglW8rbCnd9Ydw5Pl+xpzVKCJpczSimeJeHO23juPBdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gw6wDttPY0OFeLt0z9MtfDHa4hDTRAAlamodC5vPv+I=;
 b=dhulqM+rIn1wgmCOQoR+1ofTqYgbrJfSYD5URZ2Zo+N1nvZDeBqP/3r9bd4T0osGAYEoEEjiD5zQ4mgfIOUnNtK7aXAqtB/guSrRcYpgwEUvSwTs+dGtpzGGPw7szEnf/7un/YVXa/a7ZH8bo0ZMF0rMgcmfEpHdQUOkOA6ZN528cFd2Dwf29p+KlKn9UjSb+s40Uj+uHtqOMGuSNcl7J7Ry01VAkvWsndTB/OIGhyMaZKNNZutfYe99rFd+VG5iq6I0LaW3s2woWpune9ECdT5bcVDUlv/AiKoh7VDHP9XdTCsNPsYlru00rlfjOD241XbroF1SopxJlRZzQ1PbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
Thread-Topic: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash
Thread-Index: AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAABD7EA==
Date: Wed, 21 Jun 2023 17:52:28 +0000
Message-ID:
 <PH0PR12MB54819746DF66F968E532195EDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
In-Reply-To: <20230621164606.GI74977@h68b04307.sqa.eu95>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB6703:EE_
x-ms-office365-filtering-correlation-id: a7ada007-dd00-409e-d0c2-08db72804759
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aJbbZ6VI+eVGePyWn7R8WeuOdqrA+s1ZEL6iZ2Jqwcfk4kuBTdD3NLi2p9iHM+p6o3c1UsykThQUf0CPnN4akShlBkzZh4a5ZrdwyRCPCwPOqlPfRpzb6FNTKutPKlmNZSki7rrP/0PRMY8h30sIbDcJZGjSF/XzNFdq6GGbvTVWyX9z5VGN4RS03m/LA/VFdZkFLWZcw/QAMB/PnMZ3n8arV7CA/dwM5whfy1sA8xfdwtg8ygAY//SRPiFGkf4wENvpMS7fAY1ht34LMw1pn+HVqjp2HViTtF54ZMo79157+bLxUfDeadRASsJpTBvhiOb1nKvy8MwiiJLmuEhWYe74VV5k4ClQUSd3fxC+swEuANZuukS3bO6yllPnFOA77qAWuQmY3izt+JmeNhLJcmW8/iDqIBD/jkS8UwHsZpIH3DQ0yn9psMjG6rWIC7sVdD7MIcQTS68ZhG4sUK/iWvYZ0GVzJ6+sWyF5x/77CnQl5+OUdljKD7Elwosi4oQ7brUEw7ljawzsTqTNHHlDXds+C/1nt70VpHNuTU2HITTlddjEEFSeFNWFhQRLE3B5RyJ+ZM0GYMH5PmRwgJb9vL0x0Ci6LxhpwxWZGmkeHmzkrKLBrUnwA0l2EaRTMTuhgIyJNqFRjFZ3ZkHUB3ZgR6aiTDMQDCYBgSq17imKLdE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(66899021)(64756008)(33656002)(5660300002)(52536014)(8676002)(41300700001)(66476007)(86362001)(8936002)(66556008)(66446008)(122000001)(4326008)(316002)(38100700002)(76116006)(55016003)(66946007)(966005)(478600001)(6506007)(2906002)(186003)(30864003)(9686003)(38070700005)(66574015)(83380400001)(7696005)(110136005)(54906003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gNN5eBfMULwxX/04ctR51hDNT/p56UiSPR7kyczq8FBy8eLdvQq8TyaRfOGk?=
 =?us-ascii?Q?KAyt0ixqgyFQ8fnkJNFI6Aqa4qOI/VbLJBV8ltvVkDrqx9DI51TjMi7jd2LO?=
 =?us-ascii?Q?XrieMFXcmKPoo619Vq8FMZVeIp7IsKnbgydXUStdq/vO6RjH4HuesBa54UUq?=
 =?us-ascii?Q?WgiXqreZNd8kSmgzcc0zEEsXXaBSUKCpZL6viaWyat9N5CGw8zYlT6SpRqEj?=
 =?us-ascii?Q?xJM9tq2gSKZsUebIy1jZaaMVlDEXbAtrKCL8Zo0kTIqkiF3EcJ10ATnp06QW?=
 =?us-ascii?Q?77FYkzoCfo2LAqF03EI1WK3R5LF4URzXcwbvrqS/65ladvRgI59sx094SQKk?=
 =?us-ascii?Q?08AvPq1X8o9/RXyuH053RLtfJXDcwZODD9mgMDfgXZhVb314kYGi9EcUacos?=
 =?us-ascii?Q?COrTXedyQh3jkQ+axiTKx8QhZj8lv5hRYt7/WgjKD1epGxd2W6n8oQ8FQCvX?=
 =?us-ascii?Q?xLigQERstIaZhRNt6zJOSGcuuieF8AFx6mpyTZVmAruWYLVT48ACfHKtMhnc?=
 =?us-ascii?Q?Lf9a24du4aB8z4wwNraYW/URIJyOqQKH5MBXAfNll4m+rZSKwdc8lHSKbReZ?=
 =?us-ascii?Q?wcEv6hSxVMZIhqQd7wMAvpPBs0CTlPOe4yLKi8mpUW+q+yNVjnD84LWskXUd?=
 =?us-ascii?Q?2qA/GMwExU2hNff1RFrD3UA2tRXX0vVfI6At4aNbLfE7JtLkhA186KYLz7OP?=
 =?us-ascii?Q?gvaxeb2UnH8sgJCD/eqh983J+QCCNGg4EAvmT2f7847hhvsRk1OIBmadBiFA?=
 =?us-ascii?Q?Rraaau0y36u+c1eGjcLNRz+jbOumOHLkUiaDbcGmpyVOXcNdeBc1F/eLMTOk?=
 =?us-ascii?Q?62X3sUWQAow9NjFmusd5e7iPYiqx1PyiL+J+k+sMFK4pWF5VXSuMzy4oSJIp?=
 =?us-ascii?Q?DgXKQm2Y9zkQNu2o8jgj66kILA2IBYiDB9v9SBjVsuQ5LQms51q3QjeNzt6W?=
 =?us-ascii?Q?3T/nN4Bw+vwe2qXvGpiQ1NS420/OMi8k1KGbeY5vq4ZUbqAtP00Jp7N043bW?=
 =?us-ascii?Q?J80B6QR5MS90yHeENb+wfOfi/XkHdnobp1SJ3IBX5kIx6i8es5QJvMUK8DNC?=
 =?us-ascii?Q?aelV37W9Kvt8n4FToBFDak1KmYTzCSob8crqKNoWEgfaBNlmB0pNk0XKPVut?=
 =?us-ascii?Q?tAVWTraQ88A704NW+l/K0Q5z5ifRAq9ExgLE+sYr4pIwokcOTxf473ZpSz3i?=
 =?us-ascii?Q?F1R9IcPdJKqZBCcNt/k2sltjqEgMNsKqr31rOxQ7UAIIWbo6BtFENwHwfwyD?=
 =?us-ascii?Q?N4e3SfY2BXAuNKMt/v7ULs1Laz8doY0S7VD0Qid7nCPjCHJMKVf2AikaFUAO?=
 =?us-ascii?Q?XjXu8C5B5TOmA01jj2bkesJ3Vo95LqvtIeT2jZb5g6bHqbkdX0J2AG2S1sdH?=
 =?us-ascii?Q?Ass6u4IFFXRDo2M0Pq32aqiNxmfwOB5CjTCYARDMpRhXFJgDeYSakRF4ga/Q?=
 =?us-ascii?Q?1tqII53F0o51KvWmTWQb+i1LoxOzaRh7BKYQNARGmKql8EmRdXyIwzQNsRps?=
 =?us-ascii?Q?p//GyW28dy6g0Rn/c5dfNE8vbgorwM5kRkgU7RLgpCvEhpgI+l1zDjBtl3cy?=
 =?us-ascii?Q?f4UwcuovW+HvC3i+9cXgtx6h4qQ69jTy5jgKbL7i/zAJvx+XNgLr+SN/5Xv4?=
 =?us-ascii?Q?WQAgEIXX58aVKfuyk2D0eQQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ada007-dd00-409e-d0c2-08db72804759
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 17:52:28.0918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZrDq5SkdBXq9T9XiWLLUIGYKFCuuSI7s1R9vOiW4dm+MDrE9SsnP+Os5QJ2EUo++sRC5ZMHtKz49+Q1+ficOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net: support inner header
 hash


> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Wednesday, June 21, 2023 12:46 PM


> SET carries an additional 32 bits of information. But if you think this w=
ill make
> the overall structure more concise, I'm ok.
>
If it is placed in single structure than it needs to be reworded to remove =
WO or RO notion.
This also requires additional sw to indicate dma attributes to be RW when m=
apping this area.
And extra text to indicate that supported_hash_tunnel_types to be ignored o=
n set command.

Two structures are more cleaner serving its purpose.
=20
> > I also think hash_tunnel is unnecessarily verbose, and _config_ is
> > also pointless.
> >
> > Returning supported_hash_tunnel_types back to device can also be
> > useful for debugging.
> >
> > How about:
> >
> >
> > struct virtnet_hash_tunnel {
> >      le32 supported_tunnel_types;
> >      le32 enabled_tunnel_types;
> > };
> >
>=20
> It's OK.
>=20
> And:
> For the GET command, both fields are WO for the device.
> For the SET command, \field{supported_tunnel_types} is RO for the device =
and
> \field{enabled_tunnel_types} is WO for the device.
>=20
> >
> > For VIRTIO_NET_CTRL_HASH_TUNNEL_GET, \field{supported_tunnel_types}
> > contains the bitmask of encapsulation types supported by the device
> > for inner header hash; \field{enabled_tunnel_types} contains the value
> > received in a previous successful call to
> > VIRTIO_NET_CTRL_HASH_TUNNEL_SET.
> >
> > For VIRTIO_NET_CTRL_HASH_TUNNEL_SET, \field{supported_tunnel_types}
> > contains the value returned by a previous successful call to
> > VIRTIO_NET_CTRL_HASH_TUNNEL_GET; \field{enabled_tunnel_types}
> contains
> > the bitmask of encapsulation types to enable for inner header hash.
> >
> > and add normative statements to this end.
> >
> >
>=20
> Ok.
>=20
> > > +#define VIRTIO_NET_CTRL_HASH_TUNNEL 7  #define
> > > +VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0  #define
> > > +VIRTIO_NET_CTRL_HASH_TUNNEL_GET 1
> > > +
> > > +
> > > +Field \field{supported_hash_tunnel_types} provided by the device
> indicates that the device supports inner header hash for these encapsulat=
ion
> types.
> > > +Field \field{supported_hash_tunnel_types} contains the bitmask of
> encapsulation types supported for inner header hash.
> >
> > We don't need these two sentences. Just second one will do.
> >
>=20
> Ok.
>=20
> > > +See \ref{sec:Device Types / Network Device / Device Operation /
> > > +Processing of Incoming Packets / Hash calculation for incoming packe=
ts /
> Encapsulation types supported/enabled for inner header hash}.
> > > +
> > > +Field \field{hash_tunnel_types} contains the bitmask of encapsulatio=
n
> types enabled for inner header hash.
> >
> > They have different meanings for set and get though.
> >
> >
> > > +See \ref{sec:Device Types / Network Device / Device Operation /
> > > +Processing of Incoming Packets / Hash calculation for incoming packe=
ts /
> Encapsulation types supported/enabled for inner header hash}.
> > > +
> > > +The class VIRTIO_NET_CTRL_HASH_TUNNEL has the following commands:
> > > +\begin{itemize}
> > > +\item VIRTIO_NET_CTRL_HASH_TUNNEL_SET: set
> \field{hash_tunnel_types} for the device using the
> > > +      virtnet_hash_tunnel_config_set structure, which is read-only f=
or the
> device.
> > > +\item VIRTIO_NET_CTRL_HASH_TUNNEL_GET: get
> \field{hash_tunnel_types} and \field{supported_hash_tunnel_types}
> > > +      from the device using the virtnet_hash_tunnel_config_get struc=
ture,
> which is write-only for the device.
> > > +\end{itemize}
> > > +
> > > +\subparagraph{Encapsulated packet}
> > > +\label{sec:Device Types / Network Device / Device Operation /
> > > +Processing of Incoming Packets / Hash calculation for incoming
> > > +packets / Encapsulated packet}
> > > +
> > > +Multiple tunneling protocols allow encapsulating an inner, payload p=
acket
> in an outer, encapsulated packet.
> > > +The encapsulated packet thus contains an outer header and an inner
> > > +header, and the device calculates the hash over either the inner hea=
der or
> the outer header.
> > > +
> > > +If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received
> > > +encapsulated packet's outer header matches one of the encapsulation
> > > +types enabled in \field{hash_tunnel_types}, then the device uses the=
 inner
> header for hash calculations (only a single level of encapsulation is cur=
rently
> supported).
> > > +
> > > +If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received packet's
> > > +(outer) header does not match any types enabled in
> \field{hash_tunnel_types}, then the device uses the outer header for hash
> calculations.
> > > +
> > > +Initially all encapsulation types are disabled (the value of
> > > +\field{hash_tunnel_types} is 0) for inner header hash before any
> VIRTIO_NET_CTRL_HASH_TUNNEL_SET command are sent by the driver.
> >
> > Initially (before driver sends VIRTIO_NET_CTRL_HASH_TUNNEL_SET) all
> > encapsulation types are disabled
> >
>=20
> Ok.
>=20
> > > +
> > > +Encapsulation types supported/enabled for inner header hash:
> > > +\begin{itemize}
> > > +    \item The outer header of the following encapsulation types does=
 not
> contain the transport protocol:
> > > +        \begin{enumerate}
> > > +	    \item \hyperref[intro:ipip]{[IPIP]}: the outer header is over I=
Pv4 and
> the inner header is over IPv4.
> > > +	    \item \hyperref[intro:nvgre]{[NVGRE]}: the outer header is over
> IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > > +	    \item \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]}: the outer he=
ader
> is over IPv4 and the inner header is over IPv4.
> > > +	    \item \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]}: the outer he=
ader
> is over IPv4 and the inner header is over IPv4.
> > > +	    \item \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]}: the outer he=
ader
> is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > > +        \end{enumerate}
> > > +
> > > +    \item The outer header of the following encapsulation types uses=
 UDP as
> the transport protocol:
> > > +        \begin{enumerate}
> > > +	    \item \hyperref[intro:vxlan]{[VXLAN]}: the outer header is over
> IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > > +	    \item \hyperref[intro:geneve]{[GENEVE]}: the outer header is ov=
er
> IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > > +	    \item \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]}: the outer header=
 is
> over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > > +	    \item \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]}: the ou=
ter
> header is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > > +        \end{enumerate}
> > > +\end{itemize}
> > > +
> > > +\subparagraph{Encapsulation types supported/enabled for inner
> > > +header hash} \label{sec:Device Types / Network Device / Device
> > > +Operation / Processing of Incoming Packets / Hash calculation for
> > > +incoming packets / Encapsulation types supported/enabled for inner
> > > +header hash}
> > > +
> > > +Encapsulation types applicable for inner header hash:
> > > +\begin{lstlisting}
> > > +The \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]} encapsulation type:
> > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 0)
> > > +
> > > +The \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]} encapsulation type:
> > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 1)
> > > +
> > > +The \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]} encapsulation type:
> > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 2)
> > > +
> > > +The \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]} encapsulation
> type:
> > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 3)
> > > +
> > > +The \hyperref[intro:vxlan]{[VXLAN]} encapsulation type:
> > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 4)
> > > +
> > > +The \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]} encapsulation type:
> > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 5)
> > > +
> > > +The \hyperref[intro:geneve]{[GENEVE]} encapsulation type:
> > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 6)
> > > +
> > > +The \hyperref[intro:ipip]{[IPIP]} encapsulation type:
> > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 7)
> > > +
> > > +The \hyperref[intro:nvgre]{[NVGRE]} encapsulation type:
> > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 8)
> > > +\end{lstlisting}
> > > +
> > > +\subparagraph{Advice}
> > > +Example uses of inner header hash:
> > > +\begin{itemize}
> > > +\item Legacy tunneling protocols, lacking outer header entropy, can =
use
> RSS with inner header hash to
> > > +      distribute flows with identical outer but different inner head=
ers across
> various queues, improving performance.
> > > +\item Identify an inner flow distributed across multiple outer tunne=
ls.
> > > +\end{itemize}
> > > +
> > > +As using the inner header hash completely discards the outer header
> > > +entropy, care must be taken if the inner header is controlled by an
> > > +adversary, as the adversary can then intentionally create configurat=
ions
> with insufficient entropy.
> > > +
> > > +Besides disabling inner header hash, mitigations would depend on:
> > > +\begin{itemize}
> > > +\item Use a tool with good forwarding performance to keep the receiv=
e
> queue from dropping packets.
> >
> > this is quite vague
> >
>=20
> Giving too specific advice would be too specific, which we discussed a lo=
ng time
> ago.
>=20
> > > +\item If the QoS (Quality of service) is unavailable, the driver can=
 set
> \field{hash_tunnel_types} to 0
> > > +      to disable inner header hash for all encapsulated packets.
> >
> > this is precisely disabling
>=20
> \field{hash_tunnel_types} to 0 disabling inner ?
>=20
> >
> > > +\item Perform appropriate QoS before packets consume the receive
> buffers of the receive queues.
> >
> > it is not at all clear how would devices do this.
> >
>=20
> The reason we're describing it broadly here is that this is done by devic=
es, which
> usually know what to do, and can also take actions off-device, such as fi=
rewalls
> off-device, etc.
>=20
> > > +\end{itemize}
> >
> > Oh sorry I didn't complete the sentence :( I suggest dropping above
> > and having something like:
> >
> > 	Besides disabling inner header hash, mitigations would depend on how
> the
> > 	hash is used, and the consequences of a successful attack.
> > 	For example, if the attack causes packet drops, using a deeper queue
> > 	might be able to mitigate it.
>=20
> Ok, I got you now!
>=20
> >
> >
> >
> > > +
> > > +\devicenormative{\subparagraph}{Inner Header Hash}{Device Types /
> > > +Network Device / Device Operation / Control Virtqueue / Inner
> > > +Header Hash}
> > > +
> > > +If the (outer) header of the received packet does not match any
> > > +value
> >
> > any encapsulation type
>=20
> Ok. And 'any bits' instead of 'any value' I think.
>=20
> >
> > > enabled in \field{hash_tunnel_types},
> > > +the device MUST calculate the hash on the outer header.
> > > +
> > > +If the device receives an unsupported or unrecognized value for
> > > +\field{hash_tunnel_types}, it MUST respond to the
> VIRTIO_NET_CTRL_HASH_TUNNEL_SET command with VIRTIO_NET_ERR.
> >
> > let's be specific. if any bits in hash_tunnel_types are not set in
> > supported_hash_tunnel_types
>=20
> Ok.
>=20
> >
> > > +
> > > +If the device offers the VIRTIO_NET_F_HASH_TUNNEL feature, it MUST
> provide the values for \field{supported_hash_tunnel_types}.
> >
> > what does this mean even?
>=20
> When the driver uses the GET command, the device should preferably return
> the corresponding value..
>=20
> >
> > > +
> > > +If \field{hash_tunnel_types} is set to 0 or upon device reset, the d=
evice
> MUST disable inner header hash for all encapsulation types.
> > > +
> > > +\drivernormative{\subparagraph}{Inner Header Hash}{Device Types /
> > > +Network Device / Device Operation / Control Virtqueue / Inner
> > > +Header Hash}
> > > +
> > > +The driver MUST have negotiated the VIRTIO_NET_F_HASH_TUNNEL
> > > +feature when issuing commands VIRTIO_NET_CTRL_HASH_TUNNEL_SET
> and VIRTIO_NET_CTRL_HASH_TUNNEL_GET.
> > > +
> > > +The driver MUST ignore the values received from the
> VIRTIO_NET_CTRL_HASH_TUNNEL_GET command if the device responds with
> VIRTIO_NET_ERR.
> > > +
> > > +The driver MUST NOT set any value in \field{hash_tunnel_types} which=
 is
> not set in \field{supported_hash_tunnel_types}.
> >
> > any bits. not any value
>=20
> Get.
>=20
> Thanks.
>=20
> >
> > > +
> > >  \paragraph{Hash reporting for incoming packets}  \label{sec:Device
> > > Types / Network Device / Device Operation / Processing of Incoming
> > > Packets / Hash reporting for incoming packets}
> > >
> > > diff --git a/device-types/net/device-conformance.tex
> > > b/device-types/net/device-conformance.tex
> > > index 54f6783..f88f48b 100644
> > > --- a/device-types/net/device-conformance.tex
> > > +++ b/device-types/net/device-conformance.tex
> > > @@ -14,4 +14,5 @@
> > >  \item \ref{devicenormative:Device Types / Network Device / Device
> > > Operation / Control Virtqueue / Automatic receive steering in
> > > multiqueue mode}  \item \ref{devicenormative:Device Types / Network
> > > Device / Device Operation / Control Virtqueue / Receive-side scaling
> > > (RSS) / RSS processing}  \item \ref{devicenormative:Device Types /
> > > Network Device / Device Operation / Control Virtqueue /
> > > Notifications Coalescing}
> > > +\item \ref{devicenormative:Device Types / Network Device / Device
> > > +Operation / Control Virtqueue / Inner Header Hash}
> > >  \end{itemize}
> > > diff --git a/device-types/net/driver-conformance.tex
> > > b/device-types/net/driver-conformance.tex
> > > index 97d0cc1..9d853d9 100644
> > > --- a/device-types/net/driver-conformance.tex
> > > +++ b/device-types/net/driver-conformance.tex
> > > @@ -14,4 +14,5 @@
> > >  \item \ref{drivernormative:Device Types / Network Device / Device
> > > Operation / Control Virtqueue / Offloads State Configuration /
> > > Setting Offloads State}  \item \ref{drivernormative:Device Types /
> > > Network Device / Device Operation / Control Virtqueue / Receive-side
> > > scaling (RSS) }  \item \ref{drivernormative:Device Types / Network
> > > Device / Device Operation / Control Virtqueue / Notifications
> > > Coalescing}
> > > +\item \ref{drivernormative:Device Types / Network Device / Device
> > > +Operation / Control Virtqueue / Inner Header Hash}
> > >  \end{itemize}
> > > diff --git a/introduction.tex b/introduction.tex index
> > > b7155bf..81f07a4 100644
> > > --- a/introduction.tex
> > > +++ b/introduction.tex
> > > @@ -102,6 +102,45 @@ \section{Normative
> References}\label{sec:Normative References}
> > >      Standards for Efficient Cryptography Group(SECG), ``SEC1: Ellipt=
ic Cureve
> Cryptography'', Version 1.0, September 2000.
> > >  	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
> > >
> > > +	\phantomsection\label{intro:gre_rfc2784}\textbf{[GRE_rfc2784]} &
> > > +    Generic Routing Encapsulation. This protocol is only specified f=
or IPv4
> and used as either the payload or delivery protocol.
> > > +	\newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
> > > +	\phantomsection\label{intro:gre_rfc2890}\textbf{[GRE_rfc2890]} &
> > > +    Key and Sequence Number Extensions to GRE \ref{intro:gre_rfc2784=
}.
> This protocol describes extensions by which two fields, Key and
> > > +    Sequence Number, can be optionally carried in the GRE Header
> \ref{intro:gre_rfc2784}.
> > > +	\newline\url{https://www.rfc-editor.org/rfc/rfc2890}\\
> > > +	\phantomsection\label{intro:gre_rfc7676}\textbf{[GRE_rfc7676]} &
> > > +    IPv6 Support for Generic Routing Encapsulation (GRE). This proto=
col is
> specified for IPv6 and used as either the payload or
> > > +    delivery protocol. Note that this does not change the GRE header=
 format
> or any behaviors specified by RFC 2784 or RFC 2890.
> > > +	\newline\url{https://datatracker.ietf.org/doc/rfc7676/}\\
> > > +	\phantomsection\label{intro:gre_in_udp_rfc8086}\textbf{[GRE-in-
> UDP]} &
> > > +    GRE-in-UDP Encapsulation. This specifies a method of encapsulati=
ng
> network protocol packets within GRE and UDP headers.
> > > +    This protocol is specified for IPv4 and IPv6, and used as either=
 the
> payload or delivery protocol.
> > > +	\newline\url{https://www.rfc-editor.org/rfc/rfc8086}\\
> > > +	\phantomsection\label{intro:vxlan}\textbf{[VXLAN]} &
> > > +    Virtual eXtensible Local Area Network.
> > > +	\newline\url{https://datatracker.ietf.org/doc/rfc7348/}\\
> > > +	\phantomsection\label{intro:vxlan-gpe}\textbf{[VXLAN-GPE]} &
> > > +    Generic Protocol Extension for VXLAN. This protocol describes ex=
tending
> Virtual eXtensible Local Area Network (VXLAN) via changes to the VXLAN
> header.
> > > +	\newline\url{https://www.ietf.org/archive/id/draft-ietf-nvo3-vxlan-=
gpe-
> 12.txt}\\
> > > +	\phantomsection\label{intro:geneve}\textbf{[GENEVE]} &
> > > +    Generic Network Virtualization Encapsulation.
> > > +	\newline\url{https://datatracker.ietf.org/doc/rfc8926/}\\
> > > +	\phantomsection\label{intro:ipip}\textbf{[IPIP]} &
> > > +    IP Encapsulation within IP.
> > > +	\newline\url{https://www.rfc-editor.org/rfc/rfc2003}\\
> > > +	\phantomsection\label{intro:nvgre}\textbf{[NVGRE]} &
> > > +    NVGRE: Network Virtualization Using Generic Routing Encapsulatio=
n
> > > +	\newline\url{https://www.rfc-editor.org/rfc/rfc7637.html}\\
> > > +	\phantomsection\label{intro:IP}\textbf{[IP]} &
> > > +    INTERNET PROTOCOL
> > > +	\newline\url{https://www.rfc-editor.org/rfc/rfc791}\\
> > > +	\phantomsection\label{intro:UDP}\textbf{[UDP]} &
> > > +    User Datagram Protocol
> > > +	\newline\url{https://www.rfc-editor.org/rfc/rfc768}\\
> > > +	\phantomsection\label{intro:TCP}\textbf{[TCP]} &
> > > +    TRANSMISSION CONTROL PROTOCOL
> > > +	\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
> > >  \end{longtable}
> > >
> > >  \section{Non-Normative References}
> > > --
> > > 2.19.1.6.gb485710b
> >
> >
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >
> > In order to verify user consent to the Feedback License terms and to
> > minimize spam in the list archive, subscription is required before
> > posting.
> >
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License:
> > https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > List Guidelines:
> > https://www.oasis-open.org/policies-guidelines/mailing-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

