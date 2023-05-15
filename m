Return-Path: <virtio-dev-return-12693-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12B4C7EE2C
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 16:55:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 328982B04C
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 16:55:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2BCFB9865D1
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 16:55:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 202C09864EE; Mon, 15 May 2023 16:55:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E207986509;
	Mon, 15 May 2023 16:55:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixPOuzwqiJ1mNG3Xs1Xql8GZQ+ZQ9qGPgjjG1akcsbPk6bnsHFcvRPme/nwjy78TiztVsBCf5NsESq7GzL8xryA0i+mF4drpdx+8f7+2LZzDkwB40VAsLaiguoJYEPihp1Lrky5Mtckyywc0iXAraQGfg/SiwUvKz0tjPPwq1kLNg3SFyj7AGVhkVzCp3yt2NrJFAr/o9OzHmlzO9gZvqlG8rSryWaKt98+ZWdRmkIUanzl8EF5ukf9btNhcq55D+MHHkliQ96Z4tfq8C/SI/q3rmHKaCaSJjC5ugboursFo3yHilimrl6EyDrYSSQW0Pm5FBi9n+htzyCVQK8BAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s84cy8w6xWo4OhUq67Zdv84h1r18JHaGPtZTtvkzrpA=;
 b=N6wOZAcyhbRnB088QyCinTZpRS1Yo7EkDTvp9qY+yYrcUq4E9qw7IfcglqaRgtGKfUd0ruINc3ppTyCGnzz8JvJx5ZCAFVQsBCo5odOdqRITvN2iXZFOqMotX9dw5TYt0N55gm3sZ/8iM4IlAAawQaDaPhgdQNtcGFyaRVg5FFgTEqoRBozEgBRumj9rGXfWdQZaK04Nbt2tmfH1rPNNGZnHT5GrwsYIZ7cz0pBhb1mCt3BO0nVLRNGOFtwXCiV3jUKa3iLtcllno4d04U5FgfjmLm70FWkVS5sc9zQdl+39M3jO+GuioMraTnDNpHIETjU3C40quR+RC2UinseW+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgACpnQCAAAFGAIAAENkwgAA311CAALAXAIAAZyuQgAAGRoCAAHWGAIAABVgAgAABGsCABgPyoA==
Date: Mon, 15 May 2023 16:55:05 +0000
Message-ID:
 <PH0PR12MB5481A8BDE6850603BECACF69DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230511093309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548187706D06D135D3C4FF03DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230511165529-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548140424015DAEF13246042DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB548140424015DAEF13246042DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB6994:EE_
x-ms-office365-filtering-correlation-id: 1d22806d-94ec-48fa-393e-08db556521d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fAADdzc/vxupe1ustLJhgYBKTQYIVh9k0BNyAA1w2DXIAjIKVAt6VEKCEYpV3mrRqjsE9unOszheUtNsz8KE4m8BtYFFXk/u2ZMNWVnTW5k/Uv+Znxdl7q3sfsdqCwa87gZXJYuPIN1IchM7PDLloDpRsI9rGAzSGodkTmuHS75Kd7o8aUFjT9tkO2uvo7gBW8orR1UYxVssWSbx34m2DhqLlRyKR3RraTXchB0iQOKnwNC9H7+KSUDZInAqFKUgR0ZzhZ6DgFlawVvh0uADUWRjSFnnAKxoXP3g0v4JHLfvDdIMZwMRmPySX/kU+b/3i1uXpu6dilyoxkj+hrEZaVaF1bwehV47nhXlrbzgcnoonJ9vZUtZfK/vbu+73S41Hl9ujSkgM9HYNSu5etKBtcSEHmVH9hYOLA/p+Xb8Wm89H6Ag4Mvc+MFW2zIRlL8+PwdSXd7VlcCVCtN3QfsMNDbDoYY79kENk57z8/GBri851RJG6B4Buj1Z/SK9Wt9SsLTd1w0lUSFMRgAOXxlz3oVYVta1936kG5DKCJ3ONgKieJK2LyOHN4CXEHith9klJeWw2JaV+27RSXvGeesuT2RcYY1341CVbeqDaEb415CF7WALxxeo2ivVWuWvYPN270j+jsrX5uLuByDuORRokA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(55016003)(38070700005)(2906002)(86362001)(66946007)(33656002)(122000001)(478600001)(186003)(110136005)(54906003)(316002)(7696005)(966005)(4326008)(66446008)(38100700002)(66476007)(66556008)(64756008)(76116006)(83380400001)(71200400001)(9686003)(5660300002)(107886003)(6506007)(52536014)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j3SsQIz4T9XgiNivj9gIBXWTM0V4F3wiU+MzxXy6sKagi0tcCdN4Rjl0BHGS?=
 =?us-ascii?Q?hPOswbGiqHn//hp7EGo2WL9zcvWYLRkdkzNBIoRuB8tOfn6let8/BFAvSGhE?=
 =?us-ascii?Q?CtXyvpWQWlWHepjZs2yOg8Wb/Fyk48C4fTszo9044J1+SZu7VO9E5LQ29Ykw?=
 =?us-ascii?Q?Rl/YgN5GQiFhCVjs9+QgiH17t4NRZv+Df5ZDI+4eOUMCSDxXFpI5NWXvGK9p?=
 =?us-ascii?Q?A65tT8HpdsbCeUXlhLYECrmvHLHJUisqxeEAphFzQGMbL4SRu9cdV4KrlMNl?=
 =?us-ascii?Q?gH+WjlQP1+c+skoV7KPHAwf1QnUz4DFGZoMrQrx7nyuUaQoUgf433BC2WxQN?=
 =?us-ascii?Q?Tb/ZwpDqZYZOcVPHbeynPnW9rbfskEgtcwAra8dGx8pc19O0WDQziNG2gRLk?=
 =?us-ascii?Q?HT7e20YVolOQj+zq+Vk1yLk2cLHNy4PzDHhZyyZcJXDyNgicQIsnc0EPTG4m?=
 =?us-ascii?Q?y/cSj50GPzEkZsjOXAmL1QcMC8lGrw+UKBp57/IFq9RG198NN1iASaA3q/rs?=
 =?us-ascii?Q?Ni/VvNOdPn9J9F9Y3kI26zdOrXqj0uqmvDJpN6ntGnX7vSIfqicdANOf1TNL?=
 =?us-ascii?Q?OXeZglqMMuarHfVmkLOeRAHQOGi1jgFpIcIqSk7Oh3qdVWX3iyC7QtInlnmf?=
 =?us-ascii?Q?M2LFAwgaMawbFmyY50hTAszxKvGYXhhZnve6SJMwVPRDrO/zNhtlBIpbHBQz?=
 =?us-ascii?Q?RSREP4Enw5bnbFj4hpy7r4ZOJZdHxkbD5LOzTAGECdQiK1A87Qc5DArzQXSO?=
 =?us-ascii?Q?oqFBT5y92WTyzhxXEC/3E9muXU2CWG0Nzd3zeGw2yhNYg7gR81b/Ft5V7YUb?=
 =?us-ascii?Q?mxqwT/sWQzEpct9fbpaoO6ojnjJBpSUCEj0fJlCDY8GbV3XSqWCRsQyNe/a1?=
 =?us-ascii?Q?lyeDw57MPhbIkNZo1VNyZCKU8ql0upionC1FKrsqKpWzgSYRu06HHVTjZyjA?=
 =?us-ascii?Q?eo7Ljk/fKMg18MbySfqfBxCLGW5PZyZSJvbug3t19N8jv+Uj1062iZBm6Jgr?=
 =?us-ascii?Q?WnC9BYhnr2vEd0jcfFawuUR7v59JiliXPtlDj3P0d18gVJVY9JA4rAtkZpF7?=
 =?us-ascii?Q?ZswvAmtlj6efyWPkxD460FBz2XnENw3EFTcWwM4xi37BM7grNr/5Yjgk0DFi?=
 =?us-ascii?Q?Dsgkc3n3dMINCoA1Yr7bLbEmCyfD8W+d3rISXlZQEDRpy4j1rOiOD+P/izAR?=
 =?us-ascii?Q?7sWI0QbzTy9Lh9S6eu8MN+UDrhzeKjbcJFQcA8kskn2Xf6PiAHoc8XT6au4c?=
 =?us-ascii?Q?wVHEliak4SFbk0fozFUAwE4ai+bXz/CjBunAz7mvZb4nDRmes3sQF2IaWmFk?=
 =?us-ascii?Q?HQVh8PsEJcGVD6x5nTc9CAZuOkUnVEQPRW8CjzS67chHD+yxsa+Cw38wMsq2?=
 =?us-ascii?Q?UAT5ugdDtq8/uHraSVPFVg7MrUsdp5cv2iWanqq6GnJofscc9Url3qdEa6vK?=
 =?us-ascii?Q?CKK/Z5ImqIzhvkD6lHzX6u75ceNAPf5XmupXMuDfBCYnxW0QhBRIEL96VJSO?=
 =?us-ascii?Q?QucS70ZsRfyPkUfVAF6UeIfmm0NndApI44xuj1P9ERAsiEgcg46f3h1f2iGd?=
 =?us-ascii?Q?+HTcNGBhWM+sV5VMgiLaF04a+S+jXwFnTYfs37reIIg4d/66coApIcZAOykw?=
 =?us-ascii?Q?5ipCeuvm3YygC3RrIZ3fkyY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d22806d-94ec-48fa-393e-08db556521d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 16:55:05.0624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDDtFTgMya2/ZxAdD0EFChKu2XgQyQnK95d0Gphg0MiRG7yJFX5SHXnXhuPq/xLFXGKKqSB7kRbU5DpJg1kIVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

Hi Michael,

> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Parav Pandit
> Sent: Thursday, May 11, 2023 5:03 PM
>=20
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, May 11, 2023 4:58 PM
> >
> > On Thu, May 11, 2023 at 08:47:04PM +0000, Parav Pandit wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Thursday, May 11, 2023 9:39 AM
> > > >
> > > > On Thu, May 11, 2023 at 01:28:40PM +0000, Parav Pandit wrote:
> > > > > This is not the objective to transport all PCI virtio fields over=
 AQ.
> > > > > Transport VQ commands proposal commands and commands in this
> > > > > proposal
> > > > are just fine the way there without quoting it as "transport".
> > > >
> > > > I mean, it's a transport in a sense of where it will reside in e.g.
> > > > linux virtio stack - below virtio core.
> > > > We don't save much code there by reusing the same register layout
> > > > of legacy pci.
> > > > But let's at least make this feature complete, and then we'll see
> > > > whether it is cleaner to reuse legacy layout or build a new one.
> > >
> > > I don't follow your comment about "this feature complete".
> > > When you say _this_, it means the feature proposed in this patch of
> > supporting legacy over PCI VFs?
> > >
> > > If so, anything missing in this proposal?
> >
> > I think I commented at least on what I see as missing is first of all
> > a need to support INT#x emulation since level interrupts are I think no=
t
> supported for VFs.
> > right?
>=20
> I don't see it mandatory as I responded in [1].
> I didn't see your response on [1].
>=20
> [1] https://lore.kernel.org/virtio-comment/71d65eb3-c025-9287-0157-
> 81e1d05574d1@nvidia.com/

Do you have any further suggestion, or we can differ the eventq for future =
when/if there is any real problem?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

