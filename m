Return-Path: <virtio-dev-return-13378-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58361C001DF
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 11:44:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B06091318D7
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 11:44:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A55F69867DE
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 11:44:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9769C9867C4; Thu, 13 Jul 2023 11:44:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8193C9867C2;
	Thu, 13 Jul 2023 11:44:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CK2QrVX/cGKF0k0I4XCg/wEEaMuO31DMgqApPiEsAT7yrr9IVlKIqomXHmboFPkzPF9F38PVjFvBcbsatzjWn2fMTwKZyI3RAJkdejqko1Ya5HukTSgmsbv8XMPl26dLMhmX89/K9WhV5AOBXzrn0jJ8nBMMVUl+lAN00s+1jrjg/jEv5epA/JUORynJ8rhNd1TBgl0duMwV5sx2DP7NEz+byQeyUjjmCiYZStqLiW9VqvyxflqFNmtOGTc1xnce21E41p61yrMHQEmyOQjx1/H4AU+40XB3vnI47B1bS/3e7dyoJNxws6NMHoRWJgukuXZQNKIvGDhfawWSRdTHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DQLyydb1VbGqSXUd9x9VimazGPNkfVKXC40UYipFU8=;
 b=FZv5LjJNH6G3tt3WEaIoix5dYOp//eclmgNzqivTp9WQ4sF98GPZBQ2XOsI9z3u6fGzI/jG8ZdhwPBgolCNehrwBiJkRxalunzdzN3nEq4XMzn4ZUyXtXXDuhC/NZQAYa5Prs442ENXFpWYIDAug3/PTG2mNrBXJvH0sUdYcjAxA+YFA5sx2zAE8DG7k32J7GvFjQw1y3k13B2/VnwLe37+e7Q0uXfH40/TrZ/r+lJzp49WGLI/7FZ7v1fJ3ge2SwGc/lP5uyd8DaTSUdU182OnfV3nUL5sTbArYfKzoPtYj1karewjLBcd9/GqnnCnTnI/wBeLiws5EoZVY7KLXVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"hengqi@linux.alibaba.com" <hengqi@linux.alibaba.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH 1/4] virtio-net: Place C code under
 listing
Thread-Index: AQHZtQ+iy8fc5TGtGEKaORMq55t136+3alYAgAAqPCA=
Date: Thu, 13 Jul 2023 11:44:43 +0000
Message-ID:
 <PH0PR12MB54810D3B270A5EA161E6507DDC37A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230712222405.455201-1-parav@nvidia.com>
 <20230712222405.455201-2-parav@nvidia.com> <87wmz4qin3.fsf@redhat.com>
In-Reply-To: <87wmz4qin3.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB7506:EE_
x-ms-office365-filtering-correlation-id: 007c1d0f-d822-449c-809e-08db83968cce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ueo4dg63H5luj5rzZLQOs7XGE/jRczUaAKzDZKbY51lGtofpZ0FzcOEQx/V6GZzOv0Z5lLrE5/8B8Gdiu8tf+XtL8mmCPXcCWwRNIM/TKs4bg/aD46IpB8aD5Ilqa2JaiI1ha0ZMGwUB0s+fIiy1/UnX3Jie42b4J9jaKa+tGkdLZVDJ78rWR49v+jGejKAQcr07o3MIDfBQrXWfif/YCA82eLv4zlyEUbdOWBEEP1MCiQzHr7Knko3zDMWu6k8S0oQkrwKVDF50VQwEkLADkeI56dteHZzDVJCkkDjvG+sHMYWEvvkZbTCWJGQeCOg+NVPHFaNnYKP84yO485WUg0AYoRDNeKOHqti6GjUAMKu3seh2XczHdzg+UvkJJbR/gObQ/r34i1JnUs+pc5J8XTWsLKpYc1wtN3q2WHqBNkF9YXjTwezWLmLesyke9eoiF0lhPZsn1WnCtdRj5BGkSue88uEBBZslD8iyf3bPLpt/dbChFVrMXOykl0IwtjffmqqwqbBaEbpPsYNpoU+haAASm6Oa0XO84xw4Nj2sx9fzl9CHLzDtfqXlQmJvmXjaSDIg07VPrN7ShFxfQ1x8sbz4HpsRKwQCwGXL753HeyOn/YUhYzC7LNbuIK5z55zs
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(66446008)(41300700001)(4326008)(2906002)(52536014)(66946007)(64756008)(66556008)(66476007)(5660300002)(71200400001)(478600001)(316002)(76116006)(86362001)(38100700002)(8936002)(7696005)(8676002)(9686003)(107886003)(26005)(83380400001)(6506007)(38070700005)(53546011)(33656002)(186003)(110136005)(122000001)(54906003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?m/nqf13Jw93n6BgV/uIPtzz+9nvRN4qY8eVnqfRO4Mxh74r1DgKyZqT9E4uW?=
 =?us-ascii?Q?+pywNGTNCoOyl2BcaYgFcMCx2ZGtcsIkWFzjZhZcHVkO6NMOFRMHy8ZJcR+5?=
 =?us-ascii?Q?QJh64qecvXFku72nt45KNFsNervFUvwAkPU6GRSt1yC15tCOGYE9ogajzqpv?=
 =?us-ascii?Q?B+wfS46QhfuTXUbyvknBcCGEDzDsWx62h26k0f7Q4xmH19R85VkK5o26ft7u?=
 =?us-ascii?Q?CD9mtdud6yZDyXUswhDCQUmohOCH4EGLQt1A1BxuFJXWEvNT8f9UJh16oA4S?=
 =?us-ascii?Q?Hp79C409j/V0aRyLlzI+3q5CT/Ha0M6Eke/LN7YVR9ThZS0G8jP+WBmryKvr?=
 =?us-ascii?Q?pqXVKfqoKavq0JrqIfUt1ZTnkod4ubkPVe8mg49J3QCqgMQg98qWE06vwTbi?=
 =?us-ascii?Q?qX0F19J6CzkWmd7642v+arXsEDb4y6u/5QN55t9MPIHnAgDzcaFNf6OAQdIO?=
 =?us-ascii?Q?RmqAExxdNZbc7GWdlqMIdzxEvUgL2/XF7DKkoWQh7X+HzBnCwwwp56MNd6X8?=
 =?us-ascii?Q?Kl+uItYNz7Nl50vyo2Lx+0ixuvwfLooUR89cKhFP2SlIoYCxGDpekD1p+b3g?=
 =?us-ascii?Q?uLfvfYsnOC4LRZP0iE5lJa8qDcSBTeN4H7lmRNCTtX/81dtQ7l8Os1lAUYvo?=
 =?us-ascii?Q?ZhjFY8PGPrpGHFJceh49A3fj4t8FYthevqpSWzdv3lH+IYRctZijmHxFDvmx?=
 =?us-ascii?Q?8k5rTSpL3c5IlnxhgSetEwIyECpa85lBDoEGFq1DdJ4Ymyv2dO2JP5F+DNvG?=
 =?us-ascii?Q?Hl8NQDFwkzh4dIS+9sc5F4EJ63RHtiU03nif/xcuK3aoNba/8OT90j5XzBmz?=
 =?us-ascii?Q?95tMyLXHiygUAJNwtTj5pgweix8V/vtBFtRKIGjEOMHhYeftERlwHR6IDB7M?=
 =?us-ascii?Q?g01EV+UTZ3ccMIePcz8oKEwqSx/rpJPc2B9ZLY6JeTuKdOZ7NhIHEH/RrF6e?=
 =?us-ascii?Q?jJFjpBCosWw1JTGIwxTqchbBij+duc3XFRaijAUgxbv1ITYhISg43JR72VTN?=
 =?us-ascii?Q?WMp4Baw6pm13c/p1rgDmFwl29D2sPT4R2CRCT+ws78BZz02ycn+OLXwJfIAa?=
 =?us-ascii?Q?dWkxrVR/yKjKeTrq9yHgP0ng8ltJdjy0y6pkeoXt/PhkeF/mdTPu/hi/TBSt?=
 =?us-ascii?Q?6sjQ4UXltoLp6D5yea5wbVmCnIuBaw1ZI53Uwg4qKu1V9CD7tqV9qLfj39wV?=
 =?us-ascii?Q?EMf2vFLMyE30jIy+BlPTUinLj+SK6nltj9LSGJ9fs2nbQpFQ1ZNoJ6zf3Ta2?=
 =?us-ascii?Q?eInKNfinc0mREcIKsTA0MzP2qfMdnbAQsT4/slFHrw7LLgwrD4q/UfQQ79PR?=
 =?us-ascii?Q?heYuRq9rwqc6S2Pd73sIorleo1mpDCkErM/FmmoCIbJdWgyPtW8nHTv51v5p?=
 =?us-ascii?Q?huDruuXIoqU/bWZe0LrG4JtEjaFM3EtJW9i0HgM8SUiZm9+qvyVXTXbcuSM0?=
 =?us-ascii?Q?q1dpfF57lMrpa2e4nfZA1w0Nhr4+kBzcM9qPCgfxXeInH6/lznEocNXsNKyt?=
 =?us-ascii?Q?AHIrN9N2RGpNnEhwgS9vCAv4bEcLRJBvhBFSeEDqPzsa9poRkPoqZ4A0GGAJ?=
 =?us-ascii?Q?zraPoQ1KOPadFheAJmA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007c1d0f-d822-449c-809e-08db83968cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 11:44:43.3260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTvYZFE8u+OFn7juQ0bAKwitczm40RI/yBUirEKVqdv8VvYINCrULum0VFFPH9b1ubEoaA5k7iLIcQ/cPmLQUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 1/4] virtio-net: Place C code under
 listing



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Thursday, July 13, 2023 5:13 AM
> To: Parav Pandit <parav@nvidia.com>; virtio-comment@lists.oasis-open.org;
> mst@redhat.com
> On Thu, Jul 13 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> > With extra white space for the define, pdf generation fails.
> > Also place the C code under listing.
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> >  device-types/net/description.tex | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/device-types/net/description.tex
> > b/device-types/net/description.tex
> > index 206020d..6fd4a20 100644
> > --- a/device-types/net/description.tex
> > +++ b/device-types/net/description.tex
> > @@ -1024,12 +1024,14 @@ \subsubsection{Processing of Incoming
> > Packets}\label{sec:Device Types / Network  If VIRTIO_NET_F_HASH_TUNNEL
> > has been negotiated, the driver can send the command
> VIRTIO_NET_CTRL_HASH_TUNNEL_SET to configure the calculation of the inner
> header hash.
> >
> > +\begin{lstlisting}
> >  struct virtnet_hash_tunnel {
> >      le32 enabled_tunnel_types;
> >  };
> >
> >  #define VIRTIO_NET_CTRL_HASH_TUNNEL 7
> > - #define VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0
> > +#define VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0
>=20
> I think the indentation here is intentional (as in other, similare
> sections.)
>=20
Oh right. It is the command part.

> > +\end{lstlisting}
> >
> >  Field \field{enabled_tunnel_types} contains the bitmask of encapsulati=
on
> types enabled for inner header hash.
> >  See \ref{sec:Device Types / Network Device / Device Operation /
> > Processing of Incoming Packets /


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

