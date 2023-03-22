Return-Path: <virtio-dev-return-11716-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206FEC6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:52:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 893CF86E8
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:52:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 793FB986460
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:52:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6CE3698644E; Wed, 22 Mar 2023 16:52:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D2A2986450;
	Wed, 22 Mar 2023 16:52:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vqpch5YxRrUiOzvEtbyZB/r54ZdR0nUf5xdk8Rl/CfwUd0KjONXkjU6NAdokLzslDForMdecFDJCnkhcnXLnylKlh0Gb4qkpJFG+8g7NOfhFvs+9O4+ZRB/VB1yKnfO6zQqAf8NjUXkn21sBgR2I5pW4EzWIkz8lBW0UoKG6NNHKvGS4CSW1T+f7uKDQc6wKgmYGWbfXBR/iytWkpWeNA88kTXHvlIt2ogyqQlKCERjF9dxCrxdU0emr2VXUrwu2m/DPYLFy2aqV/C4xLNf2MKIZ6lVFNrKpQUMM5ZkZfFMb60WqPd8XOrhSZCIQdUeTRyMCIzYASNEBDt/VaP+B8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9xGiBnd74zJL4Hh/xK7GAb//1j6aF6JRJD+sOGuHTM=;
 b=PDD78FkQytu7uuHsRMtuhGYw/Y/o+Mul+KTNi4emi7kWlnH7Swg95fTBIT6qJuAR0JpX1YSXgyBakLHkb8rgZ1o8/ITzukedcEKNP2LCd/nCavTZbW+SdTB4HmQBqewD26M2pwAg+V76m8uUuf1jeVvoD7vGyFuXPPLfyAQAwr9ZM7ks6isN2DDBkZ7VHsT7PvqoMxxsSvDUXiBz6PA/YDG/rg3E3yAn3RQqObyr3XC+UaqHNBAXSBXppO1R3Vmg3Emj5O+21ytAqHryGBlyPPl0TBWCoClFh782pzMAW83mxcHu5ZgpmgMU7qi4eAjnfDZsiyI5uv3Au646huwqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v3 6/8] transport-ccw: Refer to the vq by its number
Thread-Index: AQHZXEBgSCtJtVXRPkiej6PDk45tcq8FzniAgABHowCAABUDgIAA10cw
Date: Wed, 22 Mar 2023 16:52:36 +0000
Message-ID:
 <PH0PR12MB548115757F72BB333651C1D8DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230321215834.225856-1-parav@nvidia.com>
 <20230321215834.225856-7-parav@nvidia.com>
 <20230321181704-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D1A39CACD02A2BBD4721DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230321234626-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230321234626-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ2PR12MB7893:EE_
x-ms-office365-filtering-correlation-id: 0b863776-f69a-47c4-b39f-08db2af5d6c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GFy4JUPz1upIxAmQM+ttRJY7vdd3NUDbLa3iKkMbBcEWSO+g6IE1nYOZ5MxuorsxMXK4G+8TY30YHTNzeK5P5Jb/2ol1r/TBz8RXzpmq8+PQUjO0S74APksK6JbdpUH6mWw1WJfSj60zCxYYciuBKsMEmCnrRtg/HKR42D+5B87PPjoP5LpYhEMeJM/aYXgt2Way7Ozo52mGZ8Yx9D3E4x1hUAHDouLYTzrG+WW+ahH9/VASWnSiM5zIWsK0Pcg1TsmXECmA89GFq9JPW4t8U2MIOeHUZxlrMg9z5c93l/VuTL6HzbwSQR0V8kGQ2zB93LqHBwIu5Q8RhlXQD9pAwpnc1IDHwmqBlJkkkM9+ox5sWrHvP7XWv9MqXCjajzLO1p5Y8Dsb9nI9EsAm3fGnwa5aGloC3BLrOkn2L0MoGUxO9ZaohtfnRXuWutMadyT+WAaP2D3ugiGn3lbhPpt9kooQt5Fl+qBZ+6y68qa40IXFz+C/30G5Q1h+lIh2jsjfxx1HV3mtnLPpPjvLc/ifk/7o4YsGnXV/GCL2hDtjXsTtEQnaUs6POv5SpHe5De9xWMLN0EVjojzpJ5auadnVaasw/hmKjhj5p7Uo+NsNymgDQjkxaClKnPHTZn0F6d9IrcP/bQH+p1wI8SBYc7tkuuu2qKMJqqGuNrrt6Ck1ZQ5P8rr8is4VJUdmTlPqY+oMfdUD6Fzn9i/LT/rRJnJl5A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199018)(86362001)(54906003)(316002)(83380400001)(9686003)(6506007)(122000001)(38070700005)(26005)(71200400001)(7696005)(55016003)(478600001)(33656002)(38100700002)(186003)(107886003)(8936002)(2906002)(41300700001)(52536014)(5660300002)(64756008)(8676002)(66946007)(66556008)(66446008)(66476007)(6916009)(76116006)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fZDIU/62m0TYVf8c32fKCaLZaWgP5VD3oWVG3qwA0oIZx1vIrikGZhqDsOhp?=
 =?us-ascii?Q?dazil/cWWXfi/GjbS8VArS3YNm8JAR1lX3ZS+h0x0TJ4+XtseylMWdvmCBTA?=
 =?us-ascii?Q?NcmeHN9c1zI592YnyUtMQk+WD/v/Kzi0loLpIwtwsb9IsaUBVpJWNoQEc6Z2?=
 =?us-ascii?Q?+afCFlbyxLx1U9B4VtkZH1/87dFkG3P15UwHV0Z26hr59MLScjh99t7YTmsa?=
 =?us-ascii?Q?GYx4fJeHrKrfVrTGkdqiyAsO6jS4IzhqCZli8PwmrbAv/Wd+2hScv9GL9KuI?=
 =?us-ascii?Q?k3xQBYX2FKC4DgjpItKETEjMclckSsGfPdoajja5JY8+XD9uwY25/I9NxVtd?=
 =?us-ascii?Q?oedRYD5jW5IOsIh/AupUv+dy8tEyDemZIEz7KT/hemsiZA7oz3mE1tbaseKZ?=
 =?us-ascii?Q?qZs1yKc6L3Z0mWBGBO3hg2kcLvbD6kAABVWQtQOc+IGGGwujD2Xa2HS1WiVu?=
 =?us-ascii?Q?hihnuvfR9eCKmUEvXKahLnHhc98hIEY++pbVRuJcdOwritp/nnFUgiGVyfc2?=
 =?us-ascii?Q?3Svmu7etWmlgE7eO5dbzxK1ikTMqOk5n2nhAbdRidp4IBcufS1wBSo1mnuAZ?=
 =?us-ascii?Q?nlrptUZvGc8M74r7ajtCk6uyBZyoQfr3KxZEGaI7J/3Cln6Afp7xb1PI1RH/?=
 =?us-ascii?Q?TNoBi2XaYyztChqFWimvT6j3A1DnScfktug4hVERF1CdD5DAq5dQ41dGzBcW?=
 =?us-ascii?Q?KCnw7xG5PDxDzrzQ2Z1SZqY6m7WBkc+KX7t3Nkk8WEzy7nQL9lKOfQp9VbKO?=
 =?us-ascii?Q?GLChSSngh2SL+AwkzO6ux9iujb3M6sAknjGneAxRu1WLu9aeMHrsdLdBAh5+?=
 =?us-ascii?Q?6KlTETvQ8rMX0YH1cnmXveiudQbNUdyjiJBvmhLuCqH6vikRVY9cfWeby78Y?=
 =?us-ascii?Q?9ANXLwVtq7v4/p8Ke73ZhbTn4efJzb662+gEAh6a12rSBS2YLulWkSu3OFFw?=
 =?us-ascii?Q?8/N58nnXgcjm3ykm/dFR0VoUeTRCn3PfOjLuA5BXW5pZ3y8VgfI6fopaf1ts?=
 =?us-ascii?Q?e9p1CXp4EEPzz06uj69ozfOD8pLAi62Tni1AaeLYEcsBA2cfHauoBqzD7jkX?=
 =?us-ascii?Q?GAyDuvZoD+3rlNPW1+74HAFTKODLhO6B3qoiWqNE2lQ9+b3I7OHnwpHRYUZ+?=
 =?us-ascii?Q?GsvC1KnoDr5tahLmEcoHzoQMkCzVvwb3OZUxoTrmoI/g7+3lwGVp6mu5gnqs?=
 =?us-ascii?Q?VXHZBlR+7czMFOKEC3qjMfOx3rAPN13KgjcQFKyFVjxnvhUOdUvPHndGl0LI?=
 =?us-ascii?Q?C4i4DoiYW/QDEr9hjiXjTAzr5hG51U0dKW3Jh/SWHtQ5kp0qXNVBSfxrYbgz?=
 =?us-ascii?Q?eFDh+V/N2qxdoOS1iUZPlO3MFXjVOXw1qtvemXfr7oM73cGWgjO5+tg7aL3r?=
 =?us-ascii?Q?m1VJ+XLGux55O9WSyjD/jmL5VpusCHjnd0obcbfMV7wa1xXw34RKu7CHB+ym?=
 =?us-ascii?Q?S5hHwlstfrJ9JZYMWzdkAVWfXd9OsLZaqpfkZ5sJ5ZxUj1O/a66+6zsxtMAv?=
 =?us-ascii?Q?rD5aCgrbHps1JcvVI2OuXSXarCHSBnD4xOE0lsTHngbp9CRVFvVoHVbC2YIb?=
 =?us-ascii?Q?kb4JK8gq4fz692r0Ny8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b863776-f69a-47c4-b39f-08db2af5d6c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 16:52:36.1797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3I7/e1YuVQxKz9XKu7mJsOc3/QZPDbIlBEnDRkZFMepV2zQjuU+HQP3dX6iaF1p6dAOupeSLMSDkh8Yp4AVVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893
Subject: [virtio-dev] RE: [PATCH v3 6/8] transport-ccw: Refer to the vq by its number


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, March 21, 2023 11:53 PM
>=20
> On Wed, Mar 22, 2023 at 02:45:00AM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, March 21, 2023 6:22 PM
> >
> > > > +\begin{note}
> > > > +\field{queue_select} was previously named as index.
> > >
> > > sounds a bit strange, and \field{} is missing. If you insist I'd say
> > > 	in previous versions of this specification,
> > > 	field{queue_select} was also called queue \field{index}
> > >
> > The field is missing because field index is no longer there.
>=20
> But it was there. Look what it does, it formats in italics so it stands o=
ut from
> rest of text, making it clear it is field name (former one) and not the w=
ord
> "index" in english.
True, but since that field index was written what would it refer to.
Anyway, not important once its part of the structure comment.
>=20
> > >
> > > e.g. in blk we have this:
> > >   In the legacy interface, VIRTIO_BLK_F_FLUSH was also
> > >   called VIRTIO_BLK_F_WCE.
> > >
> > >
> > > but I really feel this misses the point, the compat is needed in the
> > > struct definition, not split out after usage is described. This is
> > > why I proposed just making this a comment in the struct. Why not?
> > >
> > Sure comment is good to me too.
> > In v0 you specifically asked to add note with example.
> > You said "like "Note: this was previously known as QueueNumMax""
> > It is hard to guess to write a comment when you mean "Note". :)
>=20
> That referred to MMIO where it's a table not a listing.
> I did not check the generated PDF the point is to make the note appear ne=
ar the
> field and also not damage the layout.
Yes, the note is next to the field. I looked in the PDF.
> Pls take a look at how it looks in PDF - another option is a footnote tho=
ugh it's a
> bit harder for readers to find these and bad for accessibility. Again I d=
on't think
> these work in listings, there we are kind of limited to code comments.
>=20
I was trying to have uniform note for mmio and ccw regardless off struct vs=
 table.
But comment is fine too.
I will change to comment format for the struct.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

