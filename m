Return-Path: <virtio-dev-return-13636-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF7CEB8FAF
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:37:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BD0396846B
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:37:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B7BE79865EB
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:37:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AD2899865C9; Wed,  6 Sep 2023 08:37:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 993CC9865CD;
	Wed,  6 Sep 2023 08:37:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQc9W6r7CJXble4C6l1ol+fD1CDoEMkmTlfQh1uY/Ui3caJXr3KC63fY8S1WLfgN2TAaSF/zf2HK3VSyyQx4aVue4esdeNOSQI/nZNv0kwJDGG+1IGi/QItiJ2ESbqs2JzchPPu7qGLFVQLUdT+v17v8FXI6q+0v2Ij7Sw7zgvNLMPR8+eyb9T9Un3IQIodbuyPY9bCJ7G/KolhIpbfj0jpMHP5ERvDenLOUNZc51k4z/MN1YApTUixPCk2LTWtCTneUnf8kTyIspEojAhjodkF50Au386s5aYNRoUgmGpUP8fqOzyMUkX/hxmiuCqi5sXjCdpSCFxPQi1LJ8+/V7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CqEKRxgFgUFrnmE4Pq2+lljae+NWloJFEry9nPao5o=;
 b=gLjXbiO5X6OErH4/labDFFPdnVw82JX3C5FWL3KL9ldvdOxca50XczZwvqjGC3L5gJ58rfhcNzgjPOD9tLA59/3RTedUXNL2tnXaBdg4HNNblOm3ak705IvEhJ5ktTMIiZFICh0/VFEn9hNqmmtVDa+HALaaK/gR9+ZfAKdDtfLBWeLpYZJkQhDdUAE0nRHXrZ6kPG4IfPAs3XwSiLLtTj6lxGyicLnV4Nxkukb4JEqCTU8PKBDZ6On0VMWpApEt+p3zfaw7SZiW0fb4AlNgiCPCiprhDSHF+bnQ3JuAQIfV+Mtd7IUM8WDgB4PolDDPHxbjIoNl2gLm4NCCsPWEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Zhu Lingshan
	<lingshan.zhu@intel.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index: AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7ANeNPg
Date: Wed, 6 Sep 2023 08:37:25 +0000
Message-ID:
 <PH0PR12MB548167A156AC56B1CB395C26DCEFA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230906043016-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH0PR12MB5057:EE_
x-ms-office365-filtering-correlation-id: 9ffed9ae-4032-4178-215f-08dbaeb47efd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5NCOuV0hIu5tbfexf/bhPgM+l2YPPLKhTiEyHLu10ZN+Exiq/2YST0j1Z5FIhbHVYzPf72hytcjaQvEoUHRrfAWo60MHOCCQ3Zmr9S8+J26Ypz8wjkNZHdxv/Ank1oNbscD6FjKlbMgABaq30oFj9cRFSyUuDEvQ25/TzJJIT8WwePoMzeDB/mBQji8cRkY1dM+W8Pgov0NSL+BcmX+C4e6AYFW4V/7ry3zdpBxts1WJP2DoFJpi0nAMmcVbez4v6Dk4d1OxDxP12lTSgVJ1cS9vSndt1rv7haqSOmom35rMbtjWIuKw2gkt9uNhPVXlmoeyxGPlrL7QlDBbdAvzC8HOHsg+CqSx4iazvYTOMX4ouX5UojEbbETfdnykH8JLJpHkhcuQSkoavpIU1mGBH8aNTdolql9WKz1xnT6fbxGxHXez7awD0Lx/kSMNkyD1Lhzws8WFC8g291wO28s2wjtd8iP3WXfPSfOnGzzE3Y+nvuiYC6LXRP4aMKOMWxdI4x0Wt0cxn80exPXw8CPCSQnTTSINXjUmcD8pLNBy3jxw7h4tMrg+yf2WymfR5anScOBmlwvqIBRtkFcop3tbKr4vj3SPwGAO0Lq+Ncv+HmzQSarDeALy3ReUkFyJax7x
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(1800799009)(186009)(451199024)(8936002)(8676002)(4326008)(83380400001)(52536014)(478600001)(66946007)(66556008)(76116006)(66476007)(66446008)(54906003)(64756008)(110136005)(26005)(6506007)(7696005)(71200400001)(53546011)(9686003)(41300700001)(2906002)(316002)(38070700005)(38100700002)(122000001)(5660300002)(55016003)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HX5D9G4cPUBBvWNMzcVpQtX1K+RYmBMtFKkPaaN+7MfzzL+LohSsUtjxBGbH?=
 =?us-ascii?Q?Q9frkz+H/Ty1T71jPyL+9Qv4pfEPnFXQzAuNeFOV/K1/1Mr1u8N8XEbzaCfm?=
 =?us-ascii?Q?rpXShKJyks3l3tT8tk6J+kk2lvyV8nF5W7Yp3EUkEN4wTCKXyM3M1BZoG/AG?=
 =?us-ascii?Q?TDZOHxd6jhAu7BRePodcEZFM3I6gQbnrEcfdfXeVR88gW7kJYTtcS9LE0bKq?=
 =?us-ascii?Q?OeHh78moz4+WDkZu0sj1OdLrnX/K2DtJ8/tby8gQH2Ihd69s/0hhaGh1ACvv?=
 =?us-ascii?Q?pmoXlJcg5rlKfUYk6J6QcojMPQnK6SkCrjDOzoL2ugpCO22oB3y2KBLtvje7?=
 =?us-ascii?Q?tKNgpzmpDV5SkMbBArcrRzlNx4xUzEwDxd498dXcRAYi5h9JV+WYSYS3TZSq?=
 =?us-ascii?Q?r+Iapses04h5zQWsdAsFeJyNLBbjb0lTx4IjFWGnUaRxzAYa97sNqGcaKekv?=
 =?us-ascii?Q?wIAe9L6AJ1kzSJ2hF6JSxDADlyQ5etjuygzm/7neG5HBdmcc0J21JzXmW3Ck?=
 =?us-ascii?Q?lq4BFCPeGZ/7V0nkhbVYvHNtYFqmgPxP5YbT5VvAKlbxh5XrwpeL3iLMV2lN?=
 =?us-ascii?Q?l9el0+uLvAnCN9mYX/N5dUJHS2JJ7H3UOj2GzqjtUyh9yU/MBEZ56A7U6O4q?=
 =?us-ascii?Q?UhvzyqgCf4CBlcAj+teN33Pt3fGnBSUqV5XCD66rOD+ziMu/yZsgwaOzjnqW?=
 =?us-ascii?Q?to1e9PGiIQNIy+s4KHxHsZtysDJYl5DF5OZFviD6qV0VxIef5qxibw58qMEz?=
 =?us-ascii?Q?wtaiX11TuZ9IcjXBDoWj07EZ2ETKdOmwk0hpOZjeOcqFX75yr82JI6OL1ahA?=
 =?us-ascii?Q?6bny8EcHs2UKsAZfKlkaHKCLs7vlUMba4RE4cwNyDzN478DcWGitcRhedgvN?=
 =?us-ascii?Q?k905mhmcl1RwdoT5N7c4BmSRLlgkBjaCsATZ9bU2Ey4QN9PySzt3MCeVXERU?=
 =?us-ascii?Q?FM/TlafYynQojSss0n7GosbEUrEmTwyCsrFvVqolqRjZI6SMruYuCIsvbFem?=
 =?us-ascii?Q?qsge3D1/Dz5zUZ82asGFQLnTG+WSpfr4Le0v/eZlGIcaTbL10HW+QE6b46He?=
 =?us-ascii?Q?S3zU1W/59D5/QwvYp9YcE7dd69sHkNV+xmkE/cleHMJwZAsCJ1b0gR0VYc1D?=
 =?us-ascii?Q?dJaqlhYBkaI6NcmFd4Ujt13Ig3SiQIM3VXk0tabpZrc9lOXCY75LbIzNHQuL?=
 =?us-ascii?Q?wf9Vi9wWmyWWvouhKCa68vKXHXlHYNs00dTdurENsP9iQoq2pgiKaWVIAZ6v?=
 =?us-ascii?Q?UGkVCn5DBlv6osPot88W8Y7AjdrvAF0XHfQsbDhCmRGLPyOoenzYmrb3kAXy?=
 =?us-ascii?Q?XkPPLb4nzlnVW+F2TkJfDqTcRX1snnfNM+n5HLxiYPYCi271SfpgNeR5UkLI?=
 =?us-ascii?Q?DH+Ja8mE3RLYI2wmb4aDYOwGwawsZF1Kil+2JnvFCo3d7O4Pu3+3bmrrzu36?=
 =?us-ascii?Q?LeiX680g1cB7lYz9cS2/drxIlvlwwL46C02G32/9bBxMOf3blUahQrGHQUCo?=
 =?us-ascii?Q?ldfsqRQAwsJybMkQWeGrWUqjwy7TIzM9ZptXwA3R+SAzKoBUOEjwkdTsRIoi?=
 =?us-ascii?Q?W5F4U7Zn9i7trU832ls=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffed9ae-4032-4178-215f-08dbaeb47efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 08:37:25.0483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mu6yJ0nVYgrRMRrqQDwCdz1YqoSSrUIi78fANDqT6VPuRUFhRrmKSPGWRgNBvhHZkQbJ7vtSXgJAiDDL4wDviQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5057
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Michael S. Tsirkin
> Sent: Wednesday, September 6, 2023 2:03 PM
> To: Zhu Lingshan <lingshan.zhu@intel.com>
> Cc: jasowang@redhat.com; eperezma@redhat.com; cohuck@redhat.com;
> stefanha@redhat.com; virtio-comment@lists.oasis-open.org; virtio-
> dev@lists.oasis-open.org
> Subject: Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
> VIRTIO_F_QUEUE_STATE
>=20
> On Wed, Sep 06, 2023 at 04:16:37PM +0800, Zhu Lingshan wrote:
> > This patch adds two new le16 fields to common configuration structure
> > to support VIRTIO_F_QUEUE_STATE in PCI transport layer.
> >
> > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>=20
>=20
> I do not see why this would be pci specific at all.
>=20
> But besides I thought work on live migration will use admin queue. This w=
as
> explicitly one of the motivators.
>=20
> Poking at the device from the driver to migrate it is not going to work i=
f the
> driver lives within guest.

Exactly.
I was not paying attention to this thread as we have AQ based proposal for =
the passthrough device.
It leverages many idea of what Si-Wei presented in KVM forum 2022.
I will post the first draft in few days.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

