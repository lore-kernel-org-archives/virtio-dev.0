Return-Path: <virtio-dev-return-14265-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC2DC47DDB
	for <virtio-dev@archiver.kernel.org>; Tue, 23 Jan 2024 07:28:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5594B6034D
	for <virtio-dev@archiver.kernel.org>; Tue, 23 Jan 2024 07:28:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4C7CE9867D8
	for <virtio-dev@archiver.kernel.org>; Tue, 23 Jan 2024 07:28:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 412E79867BB; Tue, 23 Jan 2024 07:28:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 304449866B8;
	Tue, 23 Jan 2024 07:28:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cl9Ov9bMtKQ+TduK4hORrpOB6zn8UXekJNW5D13y3fCEnTgaZ1hyc3P1EaEmSVQG3nuaeSq9o/oDuqdGkYp8zxTAT+K9K2BfiMLTJZF744Yn3+ReGz523AWBUxSPW7sS+LxXRzhxt8FUZnopZ+kfZjUXzYDdvHUth38BRy8k5aZ9ZkeCRXba2qKvpH17WQLwvpLF6ZsK+EYPS8TjIfl+cxkXk9ynBck+8cfaQf7DW9xeBEXlLmCZY376g7Oj0o9TrLwdx8ExGPiOPFyD4zMlLtKBPOpveWbPFID3QE2avlQc4TWvO0Dx2nDpQn2fEPmglUdNDqJdtLeH4KUMBBg5hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+qhW11kxuBSFCRyGymetAK+sP/pvCig2lav66dHzD8=;
 b=Phtaht1yUzt+Qyc/HbIiTMIMV7eqRPuS+PSyA/eMYLAPse8MJdUIPKT0E/X/qihYrv5D4hAG2ECYw5fsV1HH358DMU+Lwc0C02ZVoJQsHOv9+LtNdx1IInm+6rdKZ+oIrMvEhq5vhHK5NYMS7cR+Tk2sEBLTrz0NtzzZ7Boj5rTzLeSphnQhIyS/cnEcjvwbYrO7/W1TWDgp/H2FbcGb7lzrJdgtYxAf4VnK/p9c1HdnVD7UEjeqVGwSa/pgLEI4KHcQhwcwZpaf2gvVROpziJ1Hm4jg6q6lCuL8liQf6IuyZ07DNiprXfNynPRL3uV3K6eyEQUm5Bj/vUax8pzSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] RE: [virtio-dev] RE: [virtio-comment] [PATCH
 v2] virtio-net: support setting coalescing params for multiple vqs
Thread-Index:
 AQHaR7Oe9QgTrn5GM0iGz2gHNb3tkrDa2d1ggAKYiwCABQnskIACsaqAgAAdlFCAADBngIABdEKAgAAYMICAAAMhwA==
Date: Tue, 23 Jan 2024 07:28:44 +0000
Message-ID:
 <PH0PR12MB54819C994B9742CF3A9466FDDC742@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1705323962-96063-1-git-send-email-hengqi@linux.alibaba.com>
 <PH0PR12MB5481EA21646CEA571FF2D3F9DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3977e2c2-f514-4b51-a646-6f729df7403d@linux.alibaba.com>
 <DM8PR12MB5480872B5E7A67D65325485BDC772@DM8PR12MB5480.namprd12.prod.outlook.com>
 <db56402e-2432-4902-b58d-6b43a4f1dd0e@linux.alibaba.com>
 <PH0PR12MB5481E1A236C868B671275DCBDC752@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20240122022002-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AB6AAB87DEDC345B1A0EDC742@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20240123020653-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240123020653-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH0PR12MB8485:EE_
x-ms-office365-filtering-correlation-id: 9d3d5693-51c0-4dbf-4431-08dc1be4ee19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 C8xph8/u9hJ4m++lBIgY85ZqDs8ImGNvpB3bfkOiyJPxa6I9Q/oROjuNXSK9ozRmUbGfvYW62y/b9t/t+Yfd+bQzXGuSGPN5mFF/TEyk1PZ+XHzgvhdWrSSNJbHEXc74c4+FifMRbisxa8lOTJ9YicXz64Dml3ralUOkC28MS3CK5akwVjBCk8t7U4zI5SM+ud5atwIlKyXSXIuahnJZOeQRgyZnd2mnsz4+hYCciePrDAR/LcOyMfEHg2TY3brcli+IxufAgDLjeKETIEaf35yGixQM4j5INms8C1eZmMsmZfCKJQkrYe14U5iMWJlLsu5wXh2ingNYMy9tWDPzbWUErO6CS0nGEXoqbM74rUTGNqFAhJ7OZf/1/MzUp3L97yxnGKPwKLsqkVnoIepdYPz+vKbAGROX4HnJO0AFhWHfP396MMOR0dKBYWQ38OqTquzOXxEKc4tJId11J68ajtW0U7LhvX24FFGw6OZW1oFnvCM3+lcpZN5tldMSXbFtdfLvcVQsdOdGmRKaU5FpnmbW3vv4CaJ4IAoGMwCDnk+93kDrIL2SiSVE4UkUI20OpZS2kqSp0u9S6PioQPRerGBCz01I7idFtrRaf2jTywnEDycq8f2RlbUlzU0sJ+DI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(86362001)(55016003)(478600001)(33656002)(38070700009)(83380400001)(26005)(41300700001)(38100700002)(122000001)(316002)(8676002)(2906002)(6916009)(52536014)(66446008)(9686003)(7696005)(6506007)(8936002)(4326008)(5660300002)(64756008)(54906003)(71200400001)(66476007)(66946007)(76116006)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lvR9ifnbYBBQGwtOwZtxonE/cvDJBfEF9RvoF+BUwm1ZLlUVy57DjUxjOKtn?=
 =?us-ascii?Q?M+nNerymW9/YP+MMsDMTIHqfHoRMsxKvaBTv1VrmWW9sifIj9fOJStzPTPLO?=
 =?us-ascii?Q?Lsl4rsqNMFtY293W5KGJCIxvD44bNyyP/ugS6PdLmENWXwapWod4iqPLEHpN?=
 =?us-ascii?Q?dnAgezlgGdA4zcSQ4JFtMiC1dGaC3evoSgctZ5cxByWrMDDTmxZwNo2v+OIe?=
 =?us-ascii?Q?7ecV70sdyPTRWiutpBPOv3EbAFztd0rkLnvbMLTK7or7EHwmWV1Xi6rTfjH2?=
 =?us-ascii?Q?5WViDslrQ9W/wPhNyPShjOi3ZxUzyAdkunFBqQfdHDalB+voeZNOZd0eoTQj?=
 =?us-ascii?Q?CNlrCM/YFu1NWulCaUR6ZP8+lKmnJf0ErECuqvWFmpY/H1+eg8Eg6PWcXtLK?=
 =?us-ascii?Q?ooHV7QOyptcGRvSUcWdO8AzWuXxMBU0WG0yTmWNKFr47XnNCRindWzulKMDz?=
 =?us-ascii?Q?AFlCEvuZirH4xVCqipMQf994hctaH9H0l8OjZY70St6jEd+CN0KRZEepQ2nh?=
 =?us-ascii?Q?HoZjTznVon4HIjOG/o0dEsbz2+NHM9Yo+UfPoKG8MEYmUqGVx8J2o7/SE32O?=
 =?us-ascii?Q?fMdp6R3YgMqNSEdI3snl+PX9V//M3E64lbakju3lR3yubBejQBhz0yC4M4gN?=
 =?us-ascii?Q?Bpirw8DqAwU4oZ9YZ+YA0TmdNfN4V/OhH0CnAJpGbePfcJkgQqkZ7k38ouck?=
 =?us-ascii?Q?WHYpo1FSVyx+CvVV16CbqjNZ50Xj78V8b0hqYfIv1Y1NuzyXn3dSlCHevWw/?=
 =?us-ascii?Q?dVwGQHjXcpGzYNAyJpMeWlpoXqNLXHnzo2D2n0iT1W+K3HxBjjN+8B+XDQaC?=
 =?us-ascii?Q?Q7iLo5VqhSvaVZ65VHx4U/2QPJznzFYY+e83dvnsT9vljbdvwffe+gBtdJFy?=
 =?us-ascii?Q?MQ/uXMGJkuuu6AhC8wMUO6OiRdQmRPePOGkw+tF1hyAitZLYL78afK2QHIlZ?=
 =?us-ascii?Q?AGQO6jVBNbzVcsnfmVZaPI5878nCDuLTzcCF7Y4P71KFfYLZA1ho+qYBMoTY?=
 =?us-ascii?Q?KME5ChyjQZPh8chUCmMkHBIkqhLi9KkBFS/EHyIxxJoPyp3r8iZfxpTZtLAc?=
 =?us-ascii?Q?uB3KkyvXV+lJ5ooGyXaEheS3HywEfLktOYLiFTS5HFJcUk8TXfW/QuwPsGrp?=
 =?us-ascii?Q?Gj3JCkThWp6YjbPJoIS3xqVgGqLIwyO9Xj6DcuQy+vuAXbBVl2mvMQYJl3eq?=
 =?us-ascii?Q?cF6Ei7Vl3F/nYs2oCoTo474AgwEhiethaj7ia/4WjSUvEuEag7lcrfFFqasu?=
 =?us-ascii?Q?GoqIgjZIT+GqBuzOI6IiCpR/NnJDnS43MrTKHwinyzFcxGDZ59GKCzlandQV?=
 =?us-ascii?Q?9IXvB4tEz7eABLm2f+8KEd6TnHy3GX2Lq7O4xZ725FAZji5AhPCP5ph5fxSI?=
 =?us-ascii?Q?VK96grICSzUUX4goplsb/zO0Md4fF69WoE3fH+US5/e00mlHylkgKqHpeUxl?=
 =?us-ascii?Q?uyJvyzgCpB+yxMG2ZpVH7hjV8Jo4qOXUrT8aWoSUuYRITYIE2WTLvtWCWq0F?=
 =?us-ascii?Q?ZxdXeheHmzn0ymSW8d9/ljQzk7666kH5JRCeyaMc5MkZvRW8tVsGa6ewPtLw?=
 =?us-ascii?Q?UnPWPiUUPC1vUkigBHU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3d5693-51c0-4dbf-4431-08dc1be4ee19
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 07:28:44.0432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U0AKbhZaImf4n6rmjDItS0iRm3cUW0LjDsTkKGTZJDS6P8YfIY6P2jg6lf9ZwXbPPLmbxlibFV82458UI62CmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485
Subject: [virtio-dev] RE: [virtio-comment] RE: [virtio-dev] RE: [virtio-comment] [PATCH v2]
 virtio-net: support setting coalescing params for multiple vqs


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 23, 2024 12:45 PM
>=20
> On Tue, Jan 23, 2024 at 05:55:02AM +0000, Parav Pandit wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Monday, January 22, 2024 1:06 PM
> > >
> > > On Mon, Jan 22, 2024 at 05:03:38AM +0000, Parav Pandit wrote:
> > > > > >>> The right test on Linux to do without rtnl lock which is
> > > > > >>> anyway ugly and
> > > > > >> wrong semantic to use blocking the whole netdev stack.
> > > > > >>> (in case if you used that).
> > > > > >> Do you have any good directions and attempts to remove rtnl_lo=
ck?
> > > > > >>
> > > > > > I think per device lock instead of rtnl is first step that we c=
an start
> with.
> > > > >
> > > > Wil check internally who if someone already started working on it.
> > >
> > > I feel the issue is at the conceptual level.
> > Not for requests which are initiated by the kernel stack (non user init=
iated).
>=20
> So how is this different? Is it basically just because tweaking coalescin=
g in
> unexpected ways is considered mostly harmless?
>=20
It is different in two ways.

1. requests are unrelated to each other (unlike the promisc/mac example).
For example, changing vq1.params have no effect on vq2.params.

2. Therefore they don't need to be blocked.

3. There is no user expecting a success/failure on this command.
If it fails, possibly the queues can be marked in error for recovery/re-ena=
blement.


> > > Yes some drivers will take a command and just queue it for execution
> > > later, but this means that errors can not be propagated back at all.
> > > Imagine device with mac
> > > 0x123 in promisc mode. Now commands:
> > >
> > > 1- program MAC 0xabcdef
> > > 2- disable promisc mode
> > >
> > User initiated commands error can be propagated when the command
> completes.
> > Enqueuing command is at the different bottom level in the driver.
> >
> > > If command 1 fails but 2 proceeds then packets with MAC 0xabc will
> > > be dropped.
> > >
> > > Any attempts to batch arbitrary commands will have this issue - be
> > > it at driver or device level.
> > >
> > There is no suggestion to batch arbitrary commands from the driver side=
.
> > The suggestion is to batch VQs notification coalescing from the driver =
side.
> >
> > > So, here's my question: what exactly is the guest behaviour that is
> > > driving this work? Is it with a linux guest?
> > At least looks to me yes based on the partial patches which are taking =
rtnl
> lock on netdim's worker callbacks.
> >
> > > which commands does userspace issue that we need to send multiple vq
> > > coalescing commands?
> > None.
> >
> > >  If all you want is to send
> > > same config to all VQs then why not just use
> > > VIRTIO_NET_CTRL_NOTF_COAL_RX_SET as opposed to
> > > VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET ?
> > Only kernel stack initiated VQ notification coalescing changes.
> > Since every VQ has different values, VIRTIO_NET_CTRL_NOTF_COAL_RX_SET
> is not sufficient.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

