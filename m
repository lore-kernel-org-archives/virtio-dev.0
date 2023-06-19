Return-Path: <virtio-dev-return-12974-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977B2EB64DA
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:21:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0B7DF335C7
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:21:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05941986512
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:21:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EB4BB9863B0; Mon, 19 Jun 2023 17:21:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF8DF9863A9;
	Mon, 19 Jun 2023 17:21:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LneXWQskfteAm8tZqs3of0/xPtOhEjrvWEPWVwPT6jhkh9spu1jy8yiF04kRDOle7FPqJrVg89J31GYtQEybsQkHJ30RAa44602zNqMxNh+pZFe0yTdQkex5cFLEY1VQRmbAgA8oHYx8Q8DnexRbSKAxBlbsF7xirGbssfXJitB8OKq1GPImD1PdZdT0rWsvUtT+fcsQwzx6GcWCQp2LBk6WbvZjJ3F+MoGUFY9TaghFju3y4Z/lKNsg//q8MRp7pBlRBImXrQFpAOfD4pq5grTz+hU5XW4DQfcw4roRS/HYW9GvvsitIn/d8XNMpAFK244HGQ+K2z/scqQ3O1+A0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biRcXHj7GrVZJZTfuXqYZnO2eZ373gEwYNIL4fGIbF8=;
 b=jtlUDb90gU1em6XK/eO+GcplKu26+RgDhSBEMkVvpxPy8BeS2akgdxYibpUb5+Hne86lerwBWJuBdnV0T+ztyWVzDJveUygkGnCsEP6Nz8s7FrpTbXcC6hoe1utG9LBB80oPqn9DqyII5O5DVo7lrrOr60lsvX5hobZnPag7XINCoulsfvYeK15j7iBlAtAy/Zp07JcqecKNMB95yrTBlOb+m+KtOjss/SrWWmUEyq79HWn8pen+VZdQY2ToRSVBvxPuvQ1eFUPoDENe/dR/c0fipD3q1UTlIcn9nt5py4fXi7Te1Qo3VHimV/Bz4FIxIMrhhzvVh5flpk+DNvFaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [virtio-dev] Re: [PATCH v6 3/4] admin: Add group member legacy
 register access commands
Thread-Index:
 AQHZnhzNwhtFR5mF+Uage7sFrLqCZ6+SV8kAgAABfNCAAAQDAIAAAJdAgAAH7YCAAAB3IA==
Date: Mon, 19 Jun 2023 17:21:20 +0000
Message-ID:
 <PH0PR12MB5481AE9F8C823289DD17C7B2DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-4-parav@nvidia.com>
 <20230619121724-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EE01C25B4C170E498177DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619123757-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816B14CE2DA659837D1C09DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619130440-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230619130440-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB6134:EE_
x-ms-office365-filtering-correlation-id: 81ce5a4b-1849-40a9-42ab-08db70e99960
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gUoeRYJjk1B7KeKfUwg2Jj3JkEuaivv3L2L+K16JvrGgigEl3a8voWpbZhGKa7p1M+5a6SbXxykTn/wuLJibKeDUYXFgHhdQXFSThG77w3BuHZc0CEDUGq9CxeoYK6RUOC/VNA1sr0F1fOolfATUJ8ukeqxm/xU4UIisNY2MbtvBqLIwa5C2CUmP3m+IyQVFfNh8TKYAnW8iM/+5+T66HM5UkpkslfoH1c8XSntvY/ZUeqv6h709X/bSin2N8++QhHQvixl45smd/prWqEeM8QTI46VpTd3w36zjTq8G9NjfdfXnh+XuzD5PVjlQhu4ntreFvkrH2tT1cwx01I1oeJZ116OGAcq+6jW7+0oLbYBRPQ+HvTlb1wBve1ydpoLGLna8e9Rdvu/Vlx74SRC29YDST692ny+ba5mrXq39JG0TSIlP1GwZjD/bdGE74FJoM+hCFzOn9fDUCssbnstlpXKYyxuOJi3CY5xkF6Ef6Cvbwk5/QKr3kwmHrYcsomNaBdgd9QyyAwMWyWx3nnGav8mmoHoekgfm9OYoI7KwREh078o0uTtvClgF8FOGEoi03l6eCsYaeeaYEfnVF1W7Cvn9ZBmGQEQlPKyypKZkZa7Bpdjaso+o7avVDO9hjteI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(186003)(38070700005)(107886003)(9686003)(26005)(6506007)(55016003)(83380400001)(38100700002)(122000001)(33656002)(478600001)(52536014)(4326008)(41300700001)(76116006)(66446008)(64756008)(66556008)(66476007)(6916009)(66946007)(8676002)(316002)(54906003)(8936002)(7696005)(86362001)(2906002)(71200400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0TBCZ5CDO//2uclcmfRozDVqWhi4I3r3C1Y8PW/YgFQBmILUAajTn/VSPhaC?=
 =?us-ascii?Q?Kf69zXMFhYjl/iaUoga7LsiGcTEnlpy8i/Dmh+A3eC8xQTdF1HHwLXUfTTYX?=
 =?us-ascii?Q?e/aFHaQwgtkurNPoojObNp5LPE2iV29aWRhVtzvaQgFXS6ewyxI5N2ZfPwap?=
 =?us-ascii?Q?ZBKu2ect612eSRXvZyej65zS89gJ4f8bI1i3WdukTgWmdOpVrceUQwn4TRqI?=
 =?us-ascii?Q?kwGmGmRa46Onuwk/jNGOaxmg/GQhGQzjA9FRDgmBwSEp3dNOwG3K3y0PhwbI?=
 =?us-ascii?Q?kQYAcNYuZ1tuRQGwf0rheSCj0J/ua0m0wv0kl6VFklydClzoZkOy/h+PrirU?=
 =?us-ascii?Q?LuhVh8jsHXp3kdltnbOFx3zLMxZe3mjbPAJxQnEn1FDmrTRXgzTofnB4X8bf?=
 =?us-ascii?Q?Cjj3zErcfd1JLzZ0Bn27V8cQONgddRHHE6fWrEviofAKz9sJWlNCLyod3gd4?=
 =?us-ascii?Q?tItpCYNAHtqWY1f8H0pkx0baouhgOjfkG6RnRF4V1xvFhXAGOtftRC3QNLCW?=
 =?us-ascii?Q?L1ceEX7NUizUh3gUrBwDlijwQEuQQej1wkqYyzgQwb9lxIk70Rf5cOhxag4Y?=
 =?us-ascii?Q?A4DzMprbdWUGNwx+joT1+TDVFTRLMgmqGm/LQcTLNlXDuViv3qufqXI4991D?=
 =?us-ascii?Q?2aItHyivbqOJ9C5APnEEXfP9GBuVG9X2R2Y4w1ctwgCqh6k1g3lgoL4UVBGa?=
 =?us-ascii?Q?O3xwOnb+WWdfx1YjduJZpgZYrlqkxN9VX+ncPnhYOspKnkrpjDnNwOou0T1T?=
 =?us-ascii?Q?3nQIaYA9jhNA7stoOETv+fM9Ja29mBzr1mLpYJzdQ1pEAsbbI+CjL3J2yp8D?=
 =?us-ascii?Q?i9uMdLC5917tl5SsPY3kYTR2R2oF0b8WQ8NVIC7nRA2gJ36YpBrlwfKDs7U1?=
 =?us-ascii?Q?s7gCfGhFDlwilsB71FNftp96XbWL5MhW+H846p8ip3c7gXVo4pwyWQ9MhCeR?=
 =?us-ascii?Q?oJiw9+VGqKmaqqeW6Wa2kp7G0CatbJD4e85lPRNrs+yBdXkmHgIohCrVBmaK?=
 =?us-ascii?Q?sg1BP+kKw5yxnk6mwyd0rtVEOTrysqgRFKk9ezIEnJkyrVGQaudMglWbl4Ii?=
 =?us-ascii?Q?WT17qjIcVe1kapCRBEy4P9wDjF0/alRfzjieHm341MN99lEZi2Q2eR5SDvuS?=
 =?us-ascii?Q?Zn3MI0KIdIy7Jsia0pkF4mHUYgLua7jY0/9+tu61E0JhOFc7a/wF9caF6LCh?=
 =?us-ascii?Q?FQhdYvxBXUQJ6xUFzv5Kyx/XcaIqJb3ugUd1yY0Ik0MDkgztkl2K6KYbLCh+?=
 =?us-ascii?Q?e2BAv6RWf5LDac2KbYubD7Rvl+mv2VjO0iMWQXjfqCZ5Lz86H8VREoC0o2BD?=
 =?us-ascii?Q?p+Sif1vP7Jnw58kt8aGDWkmH0ZANSZodowPOaXslRi1Uf7kKtqy0uIZ8VgAQ?=
 =?us-ascii?Q?4/oX5hzsNJYEGlxIGNVFQ+ZkPdUBfUeQadI2GsqzL4LY2CitO8ik3gZPJ2GL?=
 =?us-ascii?Q?M7/meOznWyLUmgN/Did2dZFmKBw723mNCePlil4xQlJTwyh4xT2BzJf2JmMr?=
 =?us-ascii?Q?XPpAKWOw+YvB0YCS+LVUDo3SeufFfMkdd3JHJz16NR+f6sr6TQ+/4dm5PVls?=
 =?us-ascii?Q?yC7NG0hvLPceTKtBWhU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ce5a4b-1849-40a9-42ab-08db70e99960
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 17:21:20.5468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9BdLHU0hpHKuFR53dgGPtUqbr3valSOlbO8xPftmXIbTtxQiAZcUyBxc32E8y0O482fel681B9tnBJtszAjHvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
Subject: RE: [virtio-dev] Re: [PATCH v6 3/4] admin: Add group member legacy
 register access commands



> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> O=
n
> Behalf Of Michael S. Tsirkin
> Sent: Monday, June 19, 2023 1:11 PM

> > The "legacy interface of member device" is a vague term. As implementer=
,
> reader I don't understand what that means.
> > The commands clearly communicate the scope.
>=20
> Add this as an example then.
>
I don't know what this means.=20
The section speaks for itself.
We currently have,

Section 2.12.1 as "Group administration commands".
Under this I added,
2.12.1.1 -> Legacy interface: legacy configuration access commands"

Above is no different than=20
"3.1.2 Legacy Interface: Device Initialization"

Tomorrow,
2.12.1.2 -> features config commands
2.12.1.3 ->=20
=20
> > > If you want to also have a type specific text, be my guest
> > > "specifically, for an SRIOV type" ....
> > >
> > SRIOV in generic section doesn't make sense. It is covered in the pci t=
ransport
> section.
>=20
> When it's convenient to you you argue that it's clearer, when it's not yo=
u want it
> generic.  Just mention it quickly and link to the specific text in the ne=
w section.
>
If you reviewer makes point "it is suggestion".
If patch proposer makes a point its "argue" is not good way to discuss.
So can you please avoid quoting "arguing".

It is not my convenience.
In the spec transport specific parts are not added.
Hence, I said SR-IOV in generic to be avoided. It is better kept in the pci=
 transport section.

> If you are intent on
> spreading this all over the spec we'll need to rethink the whole approach=
.
>=20
Where is this spread all over?
In v5 it was self contained mainly in pci transport section.
You asked to split to generic and pci.
Fine, I split to two.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

