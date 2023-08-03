Return-Path: <virtio-dev-return-13458-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441AAC001DB
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 17:03:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C570D3E335
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 17:03:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BED8B9866E2
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 17:03:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B04B698657E; Thu,  3 Aug 2023 17:03:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B9EB9866D9;
	Thu,  3 Aug 2023 17:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jj1WzyiRz9D/88Jx1ZlTglT7lyKUA8t/MKcgUzmpKXOPWBIninVUWB4M8IeQSUMM71Ft7ABplkFQR6FUwAKjKG2w4k/772Yc8yDvfqe8nT6v+k4hWA1h0cEhu0WS8CD8qYI9NWbUtp9zJ+SrtHCHocM+1WMLQuYE0CNQ067ttRGCyu9hbnrnNxLrZENOXgWNePU6vHIEXW7eHoCsQDMcPlrAqisNXibgpmM8VyvLCW+GO50cUsyxi05VIInlqswagXRuxVLqVcPqcAgCcJQo1wX8BGbGeubFIBpi1DawCJyzcBtVACng5A+13/WqYq8X4L9LA3XwNqEamPOdeLRaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16cMcLwCj7Dc/DQvF9D24GlBTC0BuA+8h/FjQ4Vltok=;
 b=exMIAWU/AdYCPynB+2FpgMA0BkHqvlZepGZcNoj26Toej2WIGtQ2tve2sPwkUjUGP9wXxaZfJy8Nnf7TcO0UdA6x482BNRI/SVpu7wHdkPnoiwTky0UlsuOHqaabpiB19LYdWYGp7JN9i/QCw/l6HDYPn3Cl7T3jTAlvJ5TW2huuQnd054g+HSxBQezm3favNs1UkqKpinzRiwIBJYlPeWATzgbNJh6vyd/rOYJenofpDB+jYZRul618291dOi7BX1m0QVKaedkgUNMacJIczdVlus+6zrvsi1VWtzQMxUClVsAmY1twffn8BiiDCDkhRBAXpEnCOQgANWB1Ihrtag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
From: Satananda Burla <sburla@marvell.com>
To: Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net: support
 access and control the member devices
Thread-Index: AQHZxgyto/aC4fNhQ02vPERyz11iO6/YwLXg
Date: Thu, 3 Aug 2023 17:03:15 +0000
Message-ID: 
 <SJ0PR18MB44773DCEDDEF6B612F7BC5B7C308A@SJ0PR18MB4477.namprd18.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
 <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060652.3764465-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548191AE225B08BACFC0C350DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061508.9066079-5-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062204.2378864-7-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: 
 <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB4477:EE_|MW4PR18MB5207:EE_
x-ms-office365-filtering-correlation-id: fb56fd1d-fd2b-4624-b8c8-08db94438721
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 gNXAIeVccL/+2aZiQ3SM568pM1G6mUVeUPMtLZezqKpoyGdNZ3IP4Ylwba7DiDbSg6SOIeDIYiBxHhLJHtLsWFZ+BTzPqda4yeE0Jbig4aS3GVHcv8r40MAUMR2UmU8Z07X7wxFdr3GxBuV6vCDSAcNMj/qz08yH8QhVdxhJ+lwzrKsqwTnnCwGRJE08+CwB5BgIXeyZNEeeLkTrMiP/d7g0kak2WNXI1/T8TAAWv5aIN6CBrORoz6nP8o21PZfzbX1BWOGzEj7MjOHKCiNs9kIPSfgqJKkp6dyXd3lBuo3uOm/l+MIZ5/Q13wJmH8p71WMZigDF7w4V0ZqVepIcFs3+j+bHn+V6GiBjb6UJ+oDLaYE1X5pPhMdcGa8m391SukvkA9ES6AjyFgFvm9ISDy3SltFhgeP/q59enqu3mJfSOMce0rQgmw+QOGpEaUbG18yJLP2LMVrAAjz+oCFJb4kjLWeTeChJzpUJvXgLWhojP6MCu5YcgpcRdI6oumn9JD4kOTlBt5uYDEeb6TcbybmleXw12VOkhqJAjXD6yJydQ/JEuP+zuhX6lMZ6qpI5eIgs5aUszdxTt1BZc0f5G9+2M0jd9gJ72O3T7j+vELjPhwR2jL8KYV40jgwlkwOB
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB4477.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199021)(66446008)(64756008)(66556008)(4326008)(66476007)(52536014)(66946007)(76116006)(38100700002)(186003)(122000001)(53546011)(38070700005)(2906002)(6506007)(26005)(83380400001)(54906003)(110136005)(55016003)(478600001)(86362001)(33656002)(9686003)(71200400001)(7696005)(41300700001)(8676002)(8936002)(5660300002)(316002)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0CEnQGpYCi+65zPUONTKekTKTn8O+Dfuh74JPglz2rQfaFIRK/TXiHqNi//j?=
 =?us-ascii?Q?Mj24e1vgnKuqMMLlCGeLeaYsXyiCbUIg9a75dy5rl/7bqxBZaw9zmgT+v+aa?=
 =?us-ascii?Q?TJRqG1VjysUYRymN9zieyUry3DUKnFo+u142asa+uuH6gBpwDg7iKkpRahB/?=
 =?us-ascii?Q?p5+FI247eBd2B1LxfuO3nTT5c8npGg7Omqth58bTBrJRIjU3XfcnEwFI4wJx?=
 =?us-ascii?Q?t5XnY+qiQMmuHAFF1QTyjP2RUAu0Z7mF9wj9SLtVcE79Kd+DwR503hqzrVye?=
 =?us-ascii?Q?dBVy/YBGeBBZCgnfGZAT7lmVD5WSQR3n0K4A4wVDqFiQpc9QrXmxgNLbbDGj?=
 =?us-ascii?Q?ZClqdBhAg/XAalgpHSCqpbVKb9gezS2DkfcLidpN45PqetgE7O0/7UuKShJ5?=
 =?us-ascii?Q?SXD1G29IMeWWooK8kwK9UJLPGqXHgv+B7fDzc1gJtZG3mGwRJRMHh9Pg888P?=
 =?us-ascii?Q?oCUMkFTyED6ytGbP6hqvc5QbZCDNfwZrF+LsUjKQ4iyh0M36ThlKrB3penXG?=
 =?us-ascii?Q?6XE6wv/q6+dKPO6djwHFQHtgaDRirF6tJfJbeFOMF5omCS3CycxzetuDg+Xw?=
 =?us-ascii?Q?Bt4cDeT04tjp0TQZ79mfpRemaFxs3g8q3C3p5ZEW4aXUrOAj2SCYTFM9fjxL?=
 =?us-ascii?Q?AMxEfJquyeR2oBGDacDQ0bUnB6mP/5B+0/Y4os+uXk6D3BaxQjKR9FPn/TZ9?=
 =?us-ascii?Q?cUirt52qlup+ZFbwVmTxsddYCgIGOgVyUxPMIOPSFSODd7pX6njDaUUlWGED?=
 =?us-ascii?Q?dGMlc7WHMyXx8XdwYiIFWShJTNdWhfCFnV+o0SPyT4GcPtVZJfmyubPVE33x?=
 =?us-ascii?Q?pK2g1qiJdFJjBXnxEnamsCFa8oRPopHIM/zfEOVYgVBDBhcIL0bQovOQmoXJ?=
 =?us-ascii?Q?G86TqF4zquMM8XMWj8aIbYaLaOoDMNN+M+ZyZieCs6lLaxSUN/HhuJvwN+4J?=
 =?us-ascii?Q?//KnAXvdqaUAfDYyDVKO2iskYBd+w+H3Fidj3grZeWqzFnQOoMWYplHl8dTb?=
 =?us-ascii?Q?IWibHMwOcVs6r23lTWPo/Uh2d8LkJGyJSbx6Bi0xRK+3gBXEraIAKGzOsBJn?=
 =?us-ascii?Q?kIVV8fX+8J1SEJ5E4Uh44LJPCkeIh2hJEeDcK7q+d0q+5pCpCQ+4TlvCjoti?=
 =?us-ascii?Q?hdwqIRJ2/Cj9AuSBP2fha1U2/8BzRiEP9Tt4Nd/gUIbSrQEZFAXgP/Q1JApt?=
 =?us-ascii?Q?xZyqX4Zb+EBNvAqzYIvN/q/0Z+D+Www6JwIUUA4Gj/z8mDlWCNbFZiPB6XZr?=
 =?us-ascii?Q?aO/EYVVF1r4hCQJYOaZV+iT/ITFMlhx43k8TTAIJmiy4eP9H2ATnmCqb6nbP?=
 =?us-ascii?Q?LUlXQ0nFqIbZZLoZB++skutyb+BOtW9QFgsU5+aCKVNspHEd0wYZjPI13RmZ?=
 =?us-ascii?Q?Jq4pfT6HhMjBH+arbTy5/h+BThDVKYn+7LloA4KMqW79HW4ND2LuEQiSoFxB?=
 =?us-ascii?Q?I/Rs0jGnh+rkFWQNdDtXJqPNQaADl15vQfNE5RsquIiQ1gTClNSrhLHVd4UT?=
 =?us-ascii?Q?T9QTg6DHV+1Ydn5ws8mWRyTOUeERm+NvBoRbBAtNk4M3/1MB2XWV+JZHwwIo?=
 =?us-ascii?Q?2jV0WPnoJEB/4BDLGFY/5VY+D2V9L0zSZ2LbjDsT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4477.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb56fd1d-fd2b-4624-b8c8-08db94438721
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 17:03:15.3835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i8S6cG6ptx/6yEVFRimfjNLmRzvJuShCgWWAI64RZmHVT68CaYltZSULjR2tAYimVQksGnlarvwzEmvHzaAvQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5207
X-Proofpoint-ORIG-GUID: SYzhJ4lDEeEfEm9f4iF973qYkmDtsTwh
X-Proofpoint-GUID: SYzhJ4lDEeEfEm9f4iF973qYkmDtsTwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_18,2023-08-03_01,2023-05-22_02
Subject: [virtio-dev] RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net: support access
 and control the member devices



> -----Original Message-----
> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org>
> On Behalf Of Parav Pandit
> Sent: Thursday, August 3, 2023 6:16 AM
> To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: virtio-dev@lists.oasis-open.org; jasowang@redhat.com; virtio-
> comment@lists.oasis-open.org; Michael S. Tsirkin <mst@redhat.com>
> Subject: [EXT] [virtio-dev] RE: [virtio-comment] RE: RE: RE: RE: [RFC]
> virtio-net: support access and control the member devices
>=20
> External Email
>=20
> ----------------------------------------------------------------------
>=20
>=20
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Thursday, August 3, 2023 5:11 PM
> >
> > On Thu, 3 Aug 2023 11:39:20 +0000, Parav Pandit <parav@nvidia.com>
> wrote:
> > >
> > > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Sent: Thursday, August 3, 2023 5:00 PM
> > >
> > >
> > > > > Admin command is what is suitable for device management,
> including
> > > > features and configspace fields setup.
> > > >
> > > > I agree.
> > > >
> > > > But some configuration such as mac, ip(eswitch rule) for vfs that
> > > > are suitable for the admin queue?
> > > Mac, why not.
> >
> > Mac is the concept of the virtio-net.
> > How do abstract it? Or a admin queue command
> > VIRTIO_ADMIN_CMD_NET_MAC_SET?
> >
> I don't think we should abstract it.
> A one command that can set one or multiple fields of the config space is
> fine.
>=20
> > >
> > > Eswith rules should be programmed through the flow vq, that we are
> working
> > with Heng, Satananda and David.
> >
> > I know you are doing for the n-tuple receive flow filters.
> >
> > Here I mean we want to limit the ip of the VF. In the cloud case, the
> vm is
> > untrust, we should force the vm that it just can use the specified ip.
> >
> That is fine,
>  It is just that the flow filter commands may be different for ingress
> and egress direction of the VF.
> The command that we are adding does not have concept of switch ports,
> because there is no switch.
>=20
> For eswitch case, you would define more commands that will have switch
> ports...
>=20
> > Then can we configure the ip of the vfs via the admin queue?
>=20
> It should be through the flow filter queue so that it can be performant
> like nic tx/rxq which has dedicated role.
> For switch use case command formats or fields needs extension.
IMO, kernel already prescribes using representors for mac/vlan  programming
for SRIOV/SIOV eswitch devices, member devices may have to support represen=
tor
interfaces.
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

