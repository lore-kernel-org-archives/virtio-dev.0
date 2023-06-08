Return-Path: <virtio-dev-return-12889-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB26C7EE25
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 14:45:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AC67426A33
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 14:45:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A87419866C8
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 14:45:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9DB2C98667C; Thu,  8 Jun 2023 14:45:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8A98098666B;
	Thu,  8 Jun 2023 14:45:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPwRpP3iPgHg+1+nuppuWSHwxB61yVyHTR6j5oUEN3d2K2IV3pfvv68Tp3z3a1gOSEG9zVKB3FcxNe/4vJc+OlIcpUo+ggxMZlPIzn5qSFXJXv/SwMH0aU+syEUVoHfUeC+L81heLle2CsmM2tT387FrNtyCdkms0hcPsLvsagNs8+VJVCTRqdXZmRY1plqJLRrmyj0lyHNBIhyOD7hCdeB8XoRUP3jKdGiaatS9q+RFlXUI9FngFY/zCviFiQA++EdClNLnttc5amLEFSZNEDVQoVX2W/nz4fPppg1FiXwhSaPsJWSjoEbgA9N5oFFlbhiRYulpNxEzFy2vxkxDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvvcR8/JqrNFLyxlVZz449elDtTxQ3m1UcW5+4Jkg0o=;
 b=R7Wz8eyuu3xbGdt02rytn21RBS/OWPk0gILlCWudqYzkJ2QVi9hAwJif5+0kfL1LBetUNX41LMgYw5NbGKzWC2Sjc2bffWuHG4FDEmrSIFGIlgKy1c9tztueMmOM6DIa51Wv8owMSsMUp+garL7Q4809vSDUev9tOo3PalckwqlXs046qpZj7V/WMoD1wUSrIi0RMXqlNMKnfAajMor2W4d2a1tQNz17NxjhQOJn3SkyWAGVUAstljIQJsiofZMDmwGz5sMYV/LK3Rn+cVrNA41xYmlpvEXnsw4Bkymkmz4Vd4od14i0EDWjPRrEbeY0F3bEU6ckRJ8nacyZZ2jVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-dev] RE: [PATCH v15] virtio-net: support inner header
 hash
Thread-Index: AQHZl32d41AbT091pUmTjH3klOy5k69/wSJggAC4LQCAAIGH8IAABNmAgAAAqIA=
Date: Thu, 8 Jun 2023 14:45:15 +0000
Message-ID:
 <PH0PR12MB54819986416B73C860DF7A76DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230605071608.73016-1-hengqi@linux.alibaba.com>
 <DM8PR12MB54805C0A8E0E617EE2149851DC53A@DM8PR12MB5480.namprd12.prod.outlook.com>
 <20230608064042.GC28580@h68b04307.sqa.eu95>
 <PH0PR12MB548119AC6E8CF4A5EBCBA4D3DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608104119-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230608104119-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB7771:EE_
x-ms-office365-filtering-correlation-id: 331b30e3-76e6-4f52-914b-08db682ef899
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wEgAX3+MSsnOCahKPSVLze5Nsf/xZ6CcQgXao4pqz+ONdoP++0ZlMzNUJjqhRJXEUqJGOfgnBCV48IGjaZqqssGcB0uPixFSm5a2vCXIo/78IGh6r8pFoF2s3Fg93+OstDbzSORPOV5lYAUgc/qcKkw2O76qED11ZkXsgdOWMf04bXZYHf8n9zKJRJLZgKyJfc5P5qOq9W4VyiHLu7NCGHwB3K3FC4MYAf5+kFjjrDNcSQAbwGm43+zsIIUzH5aXr8BwMFyloMZPbII0sojpTZBbaTTgkUNRHusKxyhx3cg4e4r21LfPeOSiFm6AI1+FZKkculYH3IFa9mmFVaET4r0Z3ucTbu2Re/9gOwZdptiQ5fW5c3W+y1IrGr/8lgSRB5gRH2yyw1n+3BUcNLoemZxHXnpWqbwVvYyrRlmB/vor0pfTGQQxY+sAK+6oOfKqaQf2pcqtvnRSDBSxvI/6l6kr3sxcd3yA0fo/P3+HJ4aSNBsUCn7k9ZdbpCytx9knkzSnLP1zarsTc5/LCkoFpwYbhf/PXjWD8chA6p+3iXl0PfknhhQ+StDbjtIjFZsVw7BMib/6CdoNvwnktcl1XXtp3eeAp1iZL2SkxfmSUY8vnBByGemtzrjYEtYH2abz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199021)(9686003)(26005)(186003)(6506007)(86362001)(71200400001)(2906002)(54906003)(7696005)(8676002)(478600001)(55016003)(33656002)(6916009)(5660300002)(122000001)(41300700001)(66476007)(4326008)(66946007)(316002)(38100700002)(38070700005)(64756008)(8936002)(66556008)(66446008)(52536014)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fxI8za7OZoUDNyklW8xZratuCwjLPOu0sb/yXYbPFCsnhtiIEXkiMNATY3Lo?=
 =?us-ascii?Q?Zh/O1weQd6g/+NQcXUNnTNI4RgWBZgGTpm3xHMjgKVWkYlOROeI3EfnMYTly?=
 =?us-ascii?Q?pym+AdBbFGEzJJaToIiXDACrHy8Sj3G7i5KDLBtlpS3hVSQ1dFv49ZLIIA83?=
 =?us-ascii?Q?HPWYk1bueE1l0u2O2fQvngz02fA7In+190/+JKH8cr8H2N9MwWJKuegx1/qN?=
 =?us-ascii?Q?t8fn32gT4trxZnevU0ZEKb2w9rFi8mPyWW2yYdJn84BIZgnbmYzJzpLkaqlx?=
 =?us-ascii?Q?Yq78z0gmirBgElDdysTqfi0yjYBjdItY5LzR9l1oP/90lqi6sznDeA3Rxwzk?=
 =?us-ascii?Q?vbkGmJTSjydYikCIxewNqGySmivcb9aPNLEuM4Z11O6HuAIYxR8KLKsM7YWD?=
 =?us-ascii?Q?S3dVW8VS+VNfaWJW0kLn0V3AwZvvNQ7lVHmfAbkAeKbjZQROkuyzOuFRfPMw?=
 =?us-ascii?Q?5UAqKVMXUNFdRG8ZLE+8SggVojxcgTbbJe1IujtBa53+TI+7To9H5QQJSbNt?=
 =?us-ascii?Q?N/505QBNCvVdfakGGkEwRy/NVkKLW4DUkEPxS1s1HZFOwWiXI1906PCjoQep?=
 =?us-ascii?Q?/EKPxtrZ/CUEomLzIIAqhHjPoKDBgayTd7iTpNZPxDIY1FQz1bWoceNw1MxX?=
 =?us-ascii?Q?ZFSdPI/hBT+kVTRPBoMpVDcw4e1V/I36zZkFgNDrMrnnqIlIA3QVgNP45w6M?=
 =?us-ascii?Q?CBYUZJfSTQfaZWNYwEM58isySXSWFw83OYZY0jDhGsQKSvtAP0IQerbqC6gq?=
 =?us-ascii?Q?ZFc9s8UdWOCv4rkT+MAUoAJpPg9J55VA61iBidJ5d0zcLicyL0piRumDHy2d?=
 =?us-ascii?Q?ZZxGrx5s+bXOKBUfFxWHG2RGsCoP66bgWCdGf2tYSlF0QqOqAQjgV99h+lrN?=
 =?us-ascii?Q?zJbJ+x3gg6Tb+27OxB9Eou/Dgpx9B4ynWS5by6p5edPxbTchaDHvd2A4CSap?=
 =?us-ascii?Q?N+ReRZILpxvRpsfwleAO+VqghE2hPF4l044ujck7T3ZXjc02slzfO/Oq3bBH?=
 =?us-ascii?Q?fA+PKUawUjzgm4K9XLYOtosImMZFgZh+8lvL4wZrl54K6vJdcjusFJ/9w+uG?=
 =?us-ascii?Q?p2cVfrx0SrK4eVmDLt9+N2zKMnLwnWf/w1pdq1Prpf658na8tLOCHWhMnlI3?=
 =?us-ascii?Q?z1gk0akX3T/2vl7jhDq7tjUKjQKZlErCehx8rBDIKs+53P0jzSfhX4Rsh+i4?=
 =?us-ascii?Q?YN2E3N/YbBxSWpAp5oSK6JMXGCjWOPp7fxnHijqZJVlDByRPWcUcfFiQ5KpL?=
 =?us-ascii?Q?tCEoCnpEG0hskqA3wFVoRUCA1Oj4CA6ViuJmsMhmtw4p1YXJ8OGXD0IWlpJ5?=
 =?us-ascii?Q?6KWMxdLkBruDitd1mOvvZLeY2C19ICfrHPApJ+WqGNBke3AssPl1QoMdxZ/T?=
 =?us-ascii?Q?Awbdhsk8Qv2BN4dDhBhzo11QOvALJOZpfuQK2DxY+UbwaqLlXgypB+o7KTye?=
 =?us-ascii?Q?BfxfajVVXbBNx477PsrZKYY/PcsDwL9zO/i5CtW9/NT7zcLJvzKvwxPpyNo/?=
 =?us-ascii?Q?TszjHQK1FTRD8MeSQwo6KKAkpNNnY2HYDUvldztyDHT1C4DCHhB6gq2vOd7D?=
 =?us-ascii?Q?2+XG23uO5sDXEWMjeWM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331b30e3-76e6-4f52-914b-08db682ef899
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 14:45:15.1490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TpcIKu0JqJM6Rko+aa6duBf4r36tN0Sw73RXaroBiDpiy9hhaUCS8caDhh0oCo2IeHW6aT6W/MigGVdT9qp9Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771
Subject: RE: [virtio-dev] RE: [PATCH v15] virtio-net: support inner header
 hash


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 8, 2023 10:42 AM

> > > 2. hand over to RSS the ability to specify a hash based on the outer =
source
> port.
> > > That is, we can add VIRTIO_NET_RSS_HASH_TUNNEL_SRC_PORT_UDP_{v4,
> v6,
> > > EX} in \field{supported_hash_types} to indicate that the hash should
> > > be calculated using the outer source port for all UDP tunneling proto=
cols.
> > > This approach removes the need for \field{hash_option} and makes the
> > > line between VIRTIO_NET_F_HASH_TUNNEL and VIRTIO_NET_F_RSS clearer.
> > >
> > #2 is preferred.
> >
> > But I must be missing something.
> > Without VIRTIO_NET_RSS_HASH_TUNNEL_SRC_PORT_UDP_X, today if one
> wants
> > to do RSS based on the outer UDP ports, It is already supported by the =
RSS
> (even in presence of the inner header).
> >
> > So why do have to introduce
> VIRTIO_NET_RSS_HASH_TUNNEL_SRC_PORT_UDP_X?
>=20
> they want an option to ignore all other header fields.

Than that looks like rss config extension on which fields of the packet to =
use for RSS.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

