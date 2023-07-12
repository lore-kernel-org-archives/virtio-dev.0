Return-Path: <virtio-dev-return-13366-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFFFEB64DD
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:42:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 363883E306
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:42:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2F2D89867D5
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 22:42:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 223099867BB; Wed, 12 Jul 2023 22:42:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F9EE9867B4;
	Wed, 12 Jul 2023 22:42:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ci+b1sCNxMWkdOiO05iFIPOzrE2L/QE4XtZQ+tlyE+9Z6OywQsJ9EnypRvnKzx8HI5tCQgo6VJRMCvBb2F8Y5QpujsIdWL8jx9lZfmXarSh0prLKThwjAzHztUYrojfvgp9XFE9gG0M9Y+VcdueW/UfQKOd6LjcQDpuOEo1aASfdiDGeZSB05/5Z215CqXXydzSdpIsN2Ae1z4QFQTbDaWVMm9pBO9KldCHNkV2+Yc3tSfclooROn28znjQiNF4fw8LKN6jypksbpTY1j/r7zvORnVhq9lxXpzq+qsw8sXvmKqnb7IwfHfGiRVD4oYDRZwDhKR6TTVo+m3LpPlt9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9WliU5UMXDdn0vg0iv0Yya74+L1J5Ax+qFW4zIEd88=;
 b=LKvwDVnsTViOiORa9MM3+GiolZz1qcIyRL5eHcRy6YxUhpF/i35J5r7/NNk4jwBNdDTVVAy2srOVKCYbxeFCQh1RtDPI94ct+nQmI7wrUYNctYRzRMMK2Gpc5Mz3N+IuTkcK8K/j+0LJjACQzMIcGTMEsxngcyPvbZ7UZ30EE/d8Bwp3D0UDH874ILhgTxAsySfUSv8acdcEhkln79GW2NE3FclZzD/b/Oryvcw3CiiKnRFptXzy7OAo1/N0YKPLaojw/zwOoCDrZRmgIGS5EckFPT5vR1+WOVV0FCkSlsQPI2pUewkxuc0aHPiHZcVYFM+WDq+1oAZLDI0JpA2Eyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "hengqi@linux.alibaba.com"
	<hengqi@linux.alibaba.com>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH 3/4] virtio-net: Use table to describe inner hash to rfc
 mapping
Thread-Index: AQHZtQ+pzr2+92tdAkuTu4TGth4F3K+2udGAgAAAP6A=
Date: Wed, 12 Jul 2023 22:42:42 +0000
Message-ID:
 <PH0PR12MB5481634F6AA8E6553D5D0463DC36A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230712222405.455201-1-parav@nvidia.com>
 <20230712222405.455201-4-parav@nvidia.com>
 <20230712184051-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230712184051-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ2PR12MB8034:EE_
x-ms-office365-filtering-correlation-id: 69f33c54-0ea0-4041-326a-08db83294dea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 h5Apa6Ez+9/MLA5YsAymUzjWe1GA2dSgcRQRaJTZwxc7Wj4X697UYJwgwQ0l6JuC7BGHHMc06V8yncwFqPXdVisPTrQ09k+vzbNZkvHzDvGeeDGKLHrAkHxXgeQNT6gcaLK2Ei95bvO6UjJioF1fhEDMwaPE5UPXOdXrh+7Z7L+E4rNMf3GNF5imKdzJ1kYn9shkjbxPcEYYuP8W6HxwJX2B+Ex0YT0hp+R2vnkKixWuoPxpFkFgAyZxCzor0PKW4aIaLPndKB5YfLzH7lsiSjiUXtaAJFSrYa4vPEz1cXBDYZM1ZLptgT4upbk4V6Stg8Nnh7GUdALJFCt9ua0K5OdZu/dsiMsoHTrAGjy1n5Mb9+0pJjC7cAW3MSJ0Qvtwcs9mwUg5iOraU8Ugpqv5slJPagpmKDEAOx0MdybIqTGs3OwQ1eT93B7PhY1ZjuJuBxMLvUDJnOXs3l0ZMBgUkQJs3Rv4Qvbn/ANOLmn7Y6PeMYxef6FnjzVXlsYy9FuX5jSMAFtPqYByntQjaS5pmZk7ZRYB3COK0EV+iBjYXfvmmYcZgLXGBL+xXMepzvv56SA1vMoNK6lPaDxiK8JI4z6xnNgpklmOp3+5uBkBwcsop26mSgp6OxjzbCP9ZZmK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(7696005)(478600001)(71200400001)(54906003)(86362001)(38070700005)(55016003)(76116006)(2906002)(33656002)(186003)(26005)(6506007)(107886003)(9686003)(38100700002)(122000001)(8676002)(66476007)(66556008)(6916009)(316002)(64756008)(41300700001)(66946007)(8936002)(5660300002)(52536014)(4326008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BPkzTwGBVmT4UpDifqWa+U3W/MYBo/wRTH792wvoLSMpErHGAj5lqPHenF2v?=
 =?us-ascii?Q?aa0lzic2Yrs7DSzmzT+HNokX82cUaJuxk+ZUe1hQ1Q6RiUZkWESz83CnHRBF?=
 =?us-ascii?Q?YSR+M/8j9Vo/9RtADQYoxBOlo/FezuZ4vT+xOGpgVjjSyupc1oC9Jx5qP9YX?=
 =?us-ascii?Q?tKh/2mkqAR85kfjBW+p5SoRynpEYqaBhJaq5URytXOaufWH69rCxX496+tKa?=
 =?us-ascii?Q?lC+KAx4Hmu0KA3cHi167VdIOQb9jp4GPkst6c08BdwsYu7wB9TUD3eAFjpea?=
 =?us-ascii?Q?g/s9XNkvBnyNNXey4kcb3W8IXnL8GSG9DZQvz8BKN42YgPjrW/BUTV/E/d5l?=
 =?us-ascii?Q?/QqgA3ousYiRRM+3FF4Fym1FfsgkGuBkbLMoP4Ma3vUoulrAE7i4qX8Re/sc?=
 =?us-ascii?Q?63+Z95SdhvLwlrLZU2fY9KtWHPP+2V6inOBZdh8fVkwkyPpc0UoprnWJjXpo?=
 =?us-ascii?Q?sW4tL28D9rFUaorZr3acFHJboTMGO243c9s/k5y4YkwovH6HmATseh6ftvuP?=
 =?us-ascii?Q?WDobvc3y+aCuZL924Sg274pIM9YXXVKrd37Ed4qPr8PIHca//uPjTZZDLWt6?=
 =?us-ascii?Q?H4d4VFEnCC5n3fh1nVjBOEh6dF3rEbZU1qkuDcYpsF1x0gufrYl2yF7PGYG0?=
 =?us-ascii?Q?bTqetbAwW4l1RNQAaSuNFLiR/WTo16G3ibQZliN6XHNNuQkmKo5zueEFyk2+?=
 =?us-ascii?Q?R7WmbAt2M65aRZTWcCTiKmq9GAWBRPd6Zcdwg69AH0ZaZVdJ6y4ftWr0VC6i?=
 =?us-ascii?Q?DiilMn5qbG/xqpxLyFhOTIlnVfCgOf75YrAmyK3953T1BTWFh9J2YMgUaqVq?=
 =?us-ascii?Q?0ZLGpg31Iqkyjqw/SZPV0l4LOKlTSjfeFWLGyLFPjBa0MEyjXZrbv4JHRMpf?=
 =?us-ascii?Q?8GFgomkjiBJLPtyb5Diz5mdlGXbq+IKjxzAybL+hlrO2GDSL/w52fAX5etlg?=
 =?us-ascii?Q?5dy8IBXWql2+7yF2rqnzdpHSoe+0qj7ZMbLXD/N76ImxlZzfnZzqW04zmlq0?=
 =?us-ascii?Q?VmTT3LdHzTU0CCNlSfbXXx61AMmlu48UzPj1UINIdTHSBLNFmMfc0ruWCJ4Z?=
 =?us-ascii?Q?/CPc/VjES5JjQ8u05MwYDwVW0RnI05TTMUEoms74xLtncBgu0PZOhUFXp21a?=
 =?us-ascii?Q?t+aquRSJKMVeK0anajCKpgwRWi4hSqcyugFiy+z/dxM3Lw9fyZFAB3C+9SRF?=
 =?us-ascii?Q?vxPkNMiuHxWTS7UlTwM90vbLiSUXw9MC5X/ySgbdZvGFmWPoisQjeSnMn2VH?=
 =?us-ascii?Q?nPURrbJumoqOntk/dw2vtlCghJzNV9fr4G4LkDQgBEQCKuk5TFqPKYfjRtXe?=
 =?us-ascii?Q?BIip3e+tewBt7qxsXmXUrEzRaf0pQb9zuT1MdO8dN7aGUMDwFtQ9YXLbaBls?=
 =?us-ascii?Q?mWxcDjWqaOcsO7e1XCJPR9QdT9lMKg+omQd4t7d4szd0JtgKrOpbiv3+rvh9?=
 =?us-ascii?Q?snFDWQz3U1Op9TvOZhCKlKZ3HtrbCIAaHsli4HuAZiXHCwZ/0YLU3p0Nng6R?=
 =?us-ascii?Q?BMmnhkn21u1I/crhJtHgViFEGYwhrgBY9rR+fsC/KhIecTzUOalImfupJ2Rs?=
 =?us-ascii?Q?0Om3vsvKxUtwbM7JV+I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f33c54-0ea0-4041-326a-08db83294dea
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 22:42:42.6813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJUDXqwUM/3u1Hc9dx2fLQ5nic+U5w7rYtv7ozjeg85ixoG7hWde63Gf8m0fd9yZRpBNODy6mIAf0X3UZ6eLMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034
Subject: [virtio-dev] RE: [PATCH 3/4] virtio-net: Use table to describe inner hash to rfc
 mapping



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, July 12, 2023 6:41 PM
> Hmm. escapechar did not work then?

 Forgot to mention, I tried it, it didn't work.

>=20
> > +
> > +\begin{tabular}{|l|l|l|}
> > +\hline
> > +Inner header hash type & Value & Reference \\ \hline \hline
> > +VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784 & (1 << 0) &
> > +\hyperref[intro:rfc2784]{RFC2784} \\ \hline
> > +VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890 & (1 << 1) &
> > +\hyperref[intro:rfc2784]{RFC2784} \\ \hline
> > +VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676  & (1 << 2) &
> > +\hyperref[intro:rfc7676]{RFC7676} \\ \hline
> > +VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP   & (1 << 3) &
> \hyperref[intro:rfc8086]{GRE in UDP} \\
> > +\hline
> > +VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN     & (1 << 4) &
> \hyperref[intro:vxlan]{VXLAN} \\
> > +\hline
> > +VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE & (1 << 5) &
> > +\hyperref[intro:vxlan gpe]{VXLAN GPE} \\ \hline
> > +VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE    & (1 << 6) &
> \hyperref[intro:geneve]{GENEVE} \\
> > +\hline
> > +VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP      & (1 << 7) &
> \hyperref[intro:ipip]{IPIP} \\
> > +\hline
> > +VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE     & (1 << 8) &
> \hyperref[intro:nvgre]{NVGRE} \\
> > +\hline
> > +\end{tabular}
> >
> >  \subparagraph{Advice}
> >  Example uses of the inner header hash:
> > --
> > 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

