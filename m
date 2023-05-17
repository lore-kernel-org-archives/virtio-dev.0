Return-Path: <virtio-dev-return-12750-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEB1C77B75
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 19:32:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0333571C8F
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 19:32:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EDFF9986702
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 19:32:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E12559865D8; Wed, 17 May 2023 19:32:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC6C79865ED;
	Wed, 17 May 2023 19:32:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aM2HF8tSkGu40JI/VTRboDsOACOYIlnYXI1OX3eyQogFxiepjqQ2J5fFpw2riyauHENL4Saxd2SPeexZUPtCd/8emTYsBqNupMw+YEMRIwI63363XddHljPQRqngBY8Z43HLkhcmgSA1c9qXgdjmDjBYO+gdCu3SjdCTMwFcAExZU90DH/MP2b1R+MQ4QjipQwS7KDwhoUfFGm8PLdDd2VqzZxwRa8qrtksZ03kQTmlOYXt+xd22y7UqUawtzM5aKybnyBhVmfC2FR8yVi7HHeeAIFiAdNprn8vsRAx+1V0m0UWty8wN/zCPnFTu7hXDdTQ5ApZcBiCo20ZjnsF9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M//M4jl73YI6t13GQ3eSUmJKC7LS+ZCriXI0GqYNQvs=;
 b=IJYj7DFi+RR8LJcEFYuXXdy5afwKj+zvbm6rQI6qanb0v8ADL+O4DdY/P4OMPHLp59l2AI0kfduTte6gs+7726Xkd7eEqVNK/pLiFEM3HK+saxcn9/QPuYMja0sLYYofdL3VXEalHfITK8w6P/voiWBB7S60EMoYcULzBa0aVJkbIkkxdlDvLjh4VrX60o6bEtUsdtNRwZcdHv7BHQ4OsVaQ1hJqXbfytfLedEkBhcfgm7s9hhunrUDE9+CRgRbnC/lnFg3otehLdrBEJWTFaBqmz5GZfobgx235rfgnASf4nqOPiSARLjVcoXHzcviEJ9c6BYEvz78l1cju3VzRkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 1/2] transport-pci: Introduce legacy registers access
 commands
Thread-Index: AQHZf639R6aTQu3GsEiaqC7Dtr8vQa9eBfIAgADi2pA=
Date: Wed, 17 May 2023 19:32:33 +0000
Message-ID:
 <PH0PR12MB54817CBB98900B83C4F30164DC7E9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230506000135.628899-2-parav@nvidia.com>
 <20230517013839-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230517013839-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4107:EE_
x-ms-office365-filtering-correlation-id: 15f3e6ce-98a2-4dfb-b4d5-08db570d763d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LGxQFMKWxcVdpAEphbQMNhGCn/NSDUswR6uo0XEZCqMD3hkMt2TfSH6xYNZdwjeAuEirdiELyVZxs5hKHmVM3gcHBMW1Ek8l/d+itw+F7J0aHtUHdZc7vt/uYiTBD0CcR/CXxdwlDqMiWt6vVT4NAZgGrgRqa4PFLhUG7OL4A3xRYW8asbFxfJv2y7vsWo047N+sM9NgMXRT/B5E/FG/lR+YzP+k2lgY67jM4Apr3xuvP9Rkpctacb0CuZHB2nCxgm/VeXDK6ax7OqqRn2ClBwFsZK8vc4upQQZxjuYwUECPxEz+ltRSaWESGDg+NsHOyc3WBqRp6a133qvdESkIdX3gdQELKPHWGvNpfO85CQjhz6LNrqHp8eqHO0q42WjtNkgY8tJoPTUWxjDQBmKoQCl/csK5g1vbm6o1Tlnk9KYLmZAYabVGcWWlVUnyuBFSK/LT0sw1PZtROD0ufrhVqWldbNSybm3l+uIOdobTCtlWcLER+nmAZzC3b1SA04xZq6Z1ecteX3CTie3nJ0KP+rZtXpavFljiipvBeyDIAO9YW6scEazQtrmYWDCrzmAy0x/vNTxwac0mUCMBTe22nHV4zyGuKaFl3L0wfpv3SprPFWibPyqnJ9v1TxuWejtX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199021)(5660300002)(52536014)(8936002)(86362001)(66556008)(8676002)(83380400001)(107886003)(6506007)(9686003)(26005)(71200400001)(186003)(122000001)(38100700002)(38070700005)(41300700001)(478600001)(7696005)(33656002)(55016003)(316002)(66446008)(76116006)(54906003)(66946007)(66476007)(64756008)(4326008)(6916009)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y7TxylpS7yUeoRCSsXTSOPw0Bd7ZkPNbFIQ6w2RhNAWH75VD5sTlPo3TM8R6?=
 =?us-ascii?Q?U6WHp0PI45zZvrIbAgZ5jR3yQHiBJrs9FEupGyDvOQDwGlfgcTieCBuigD9V?=
 =?us-ascii?Q?/Tg6WkUGyYV/h8q2y2dgjfTdhCKNHpRh8Kf3h8obZWkLx/1Txpp46ZNPK4V2?=
 =?us-ascii?Q?sO8kswLYwjs26b/2XWIbTV4fmrjBCVm3JYrHaVEFPFo15goj2vILX2mcv3ZI?=
 =?us-ascii?Q?vLwWHAFMODZVS3P5YiwnPfraHlK87qm68dLjIOm2ja2DR4YclKZ2TVwtHvXj?=
 =?us-ascii?Q?I0ah8swHY0jdLqn/EfWCR83HgVGcxJfYZhGlyx05TT1x8iwib1EAIbjgnd5D?=
 =?us-ascii?Q?OrI3jdrZlY1XIa7vapaUgs5NZLrg1VqXKntzcXjaSVHMreA+SN++Dy1+b6vK?=
 =?us-ascii?Q?x8R4n9ZZb/sjMxddoC7sysOH8mSvQVRc5Ki1luDhPkzes0qRSZdvetzUfi90?=
 =?us-ascii?Q?0ekj7YNlc43Fqr5t00HHpdkNXv4eHc2zdT7Fcd4UsOH4pOqcK4U02mrWKy9t?=
 =?us-ascii?Q?nNOwB9jjcvAvsMEqB3/Nhc1c7EXo7IgrrwRRLHP4P/offBgbAN1aKTumIT23?=
 =?us-ascii?Q?aW4jEaY7O1tKMarsvtjatjT29tOtCGz9t74et0dIKWyljmlS7ckrn0rYjhv4?=
 =?us-ascii?Q?RNqbilEJyOrEvMVixLS0NRDUECKXOl/Q+n1tigbtuxXACG6pj45PBCn3VySf?=
 =?us-ascii?Q?6g4kp3A26aFvVMZpD/sSKnvji7k4q624tJAyturrbG0pA5J15BEfnS8DzMU7?=
 =?us-ascii?Q?IDzI90/fpakDMU7LybYz5f6vFwY38L/Qp24L7FCfqHU4qIKXNMTP0+wZxmFT?=
 =?us-ascii?Q?CKmrnB5UAwOPxvCRpyBtuRFJ6a0sqPim4VN60Nwm6oZaDttNQxotokb7jLe/?=
 =?us-ascii?Q?PO50xLSjZHuz5EDOylCDYB51W/kZxh7w8xq8Ymaqgf6VFbek4MkNt9YmCCjo?=
 =?us-ascii?Q?Hd2VLF2t1hKKy6ya54AS2C4pLWnkl1+1+FSVcDQFd80TrfzvX1LTgG/5vy0N?=
 =?us-ascii?Q?qL3FNn/fHAcEW3ba8Jlk+jmOx6pUpg3IeyyaRTHec0gZbHw/V76OVdHMZwUH?=
 =?us-ascii?Q?dE2++7YlsCVMZ238dyo0s/i8CQv4x9vG3kokYU6/9AEvGS/0Oin0YI6nTMKF?=
 =?us-ascii?Q?rt1OxGGAHWon3aCWOCbY2umH6c+lp2OBJwA5i9AqwYdBqRxUJOfGKbIHIePC?=
 =?us-ascii?Q?/d8FFddd+SUD5uGBuapTU5Y3YVHU5iRJH6zzsLrXfMVbze5z0EUn6EiAIXkE?=
 =?us-ascii?Q?3It9zR1lDmEgWMkffAqU08zT3gQfLp6H1+5OsEwUnyWaNMxAH+WoGURK3vy9?=
 =?us-ascii?Q?KTHA4KxsrVL/xzjtQmRV4eLbwB19dH9FGXLLt6Wcda50ySl8Nsm6Rw/Ditdy?=
 =?us-ascii?Q?UWjLm/jIRJzuOBHttEV9msZI0VxNEQQptokhpNtkOnDpKMPd2eu12zlqj1/p?=
 =?us-ascii?Q?KxJM9DpsWzxGI76ZJ8B4chLzRkEn0soKtKxfojoGMXs3rx7S4qKXm9M81PRc?=
 =?us-ascii?Q?X0nZt+mawkosTTx5aXwqr7QOIe/lmDGg/XbxqCNyEqg/1cu15pK1PyxjNyTr?=
 =?us-ascii?Q?tl6AD46p0YeqsX2uZ7s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f3e6ce-98a2-4dfb-b4d5-08db570d763d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 19:32:33.2738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rt2GcwQhsXF9aVxMfo08l2IC8OWlKLiMhZ5rhoWKTHiBFSjMo7kU6vRoWJDdTgpMsdrofnQPch19usRMrndFrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
Subject: [virtio-dev] RE: [PATCH v2 1/2] transport-pci: Introduce legacy registers access
 commands

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, May 17, 2023 1:45 AM
>=20
> On Sat, May 06, 2023 at 03:01:34AM +0300, Parav Pandit wrote:
> > +\begin{lstlisting}
> > +struct virtio_admin_cmd_lreg_wr_data {
> > +	u8 offset; /* Starting byte offset of the register(s) to write */
> > +	u8 register[];
> > +};
> > +\end{lstlisting}
>=20
> So to summarize, I think the main comment here was to have separate
> commands for access to common versus device config. Just today I thought
> some more and came up with another reason why this is a good idea: if we =
ever
> want legacy MMIO emulation, we can reuse the device config command.
>=20
MMIO is actually simpler than PCI because all the registers are contiguous =
regardless of msix.
So single command with offset can service just fine.
More below.

> Jason also feels the common config command can be shared with vq transpor=
t
> effort. We can discuss this, for sure, I guess its putting code in hardwa=
re versus
> in hypervisor, but if there are hardware vendors who strictly want this c=
ode in
> hardware I don't have a big problem with this even if I don't exactly get=
 why.
>=20
> With this idea all hypervisor has to do is subtract the offset from devic=
e config
> access, sounds like a small price to pay. =20
It is more than the subtraction cost.

Hypervisor needs to inspect MSI-X enable/disable settings to decide when to=
 issue command #1 vs #3 for the requested offset.

> Does this sound like a reasonable
> compromize to you?

Splitting proposed one command to two commands,
1. one for accessing legacy common config
2. second for accessing legacy device specific config=20

seems fine to me as below.

So we will have total 5 commands (instead of 3).

1. legacy common config read
2. legacy common config write

3. legacy device config read
4. legacy device config write
5. query device notification area

#1 and #3 same cmd signature but different opcode.
#2 and #4 same cmd signature but different opcode.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

