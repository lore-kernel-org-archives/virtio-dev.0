Return-Path: <virtio-dev-return-13318-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA4DEB64D9
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 15:31:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 40B8D2A88F
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 15:31:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 353DF98682E
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 15:31:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2651898680C; Fri,  7 Jul 2023 15:31:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 10E7F986809;
	Fri,  7 Jul 2023 15:31:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVXzs52vqmVLwLTugDsNnjDuXW5iEhxHriw+NS19Zc1g7w0SPlYIxDqAQJLEXhUZV8ilbi+82KCoGTU242b9xP6S46YrNaFj48amQIUKf75fXK9fJUqI2RbytUGJKl1VjbSUFMssaFUjs3BSAgCmlphsUzhIhb5/5NSsDNFa4NIrjgsG07adVmdeJu7mN5y3lER6OvJ982HFy3T0LUTMe/ShPoDwCj1aAdk7zTIYdjRcLoD1+rSVGRxS+X76sNJfd3hQLCktihjymtw84Poz/KP/NNX0RMr7YE3OxHIxTOu1YZYsQCHWJkQ1G3ZC++/iagNAej2PcSpFEAW0fHkMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qn5LFH1QjwonGNdydb/A5mILSDG4xthn8oQVQggkgK0=;
 b=kT9PHlfikkZprvWUk0mIrunCWmep2kmD9LnUkqkkea0+PjHlJ3MWIqFZXMwvsiWxY+EjcneEoTUIOYskLQ22yUKcL+beR9Qd4zTe/Y4/wOmXFrIGBJd959In2rc39UE3JMXBS3bjW82dJZZbiDzs+3TXApzOI4EQZupesnUA5BP47Tvwe+ACkN/FBYl5isPdB/mtTj7cq7Ecjy4/7gYoOvpwr094JzYdrMLl/HTE+jPJ8VU9j9TFbkCInT6a9iUqCaIms3WKCScePHdcu71tVi5T1ZmeQWCKK1wwiWdRHA6+9Qo0zyf3pcfTQ4cj0nlSwK1Z5E4ULPyChin/VK+uzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb
	<maorg@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v12 0/3] admin: Access legacy registers using admin
 commands
Thread-Index: AQHZsIa3/gmLafyjZkyCF1g/1JNSda+uMDsAgAA+uKA=
Date: Fri, 7 Jul 2023 15:31:01 +0000
Message-ID:
 <PH0PR12MB5481E60DF2C631E3A0FBDE56DC2DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230707035401.107855-1-parav@nvidia.com>
 <87pm540ws5.fsf@redhat.com>
In-Reply-To: <87pm540ws5.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5826:EE_
x-ms-office365-filtering-correlation-id: da32d91c-9371-4160-a692-08db7eff2b75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Jb7Kp0P5hVCXA6LbyvPKIwyfy9AVCO4Z4FKq264BNQV3taa/D9PsIBmBtaF3JwoFSz7jwT7n0AttbQZrqIkmFJVZKzMMZiQuEevzAORCxEm7j9ypN/ZH47BuRoN5A+WahfdLEl1PCsNsm1beTfRUk82zWps/TnouG5yWBlKcSe+sQtUrNf9MDUJwbzOlIk4Zfthc5aBC6D/XQZQShLrab+UiQCkXSudlEjLwXYkmHZGSaYj0IRlS9PB19awqxvuJ/1VYSARSA/kAC+p7yC4wycygP0Yk0ByhXMh6OnxMYJwzPfhz8kZiur20gH4DQtFARRRiNQW1Z4lpqokZ5RROo1pemQztsIl5yz8Y5wGh9fY5j55QfDzDhb08umF5zc7vHWgfSEv9LhfOl7au64DwcNy4Gu7xBUYemNE6cdHIgtabEC21LObgUABfETB6BY+IQgZz568y/HRZHJStcAUevABbfKevpoEtEa0U7HE9vXpQyZAV1x2NdPWVsFyeqRSsvy4wdFsfAJmssuq+ZI1bDTdN9gCCjWz9+TFnHooVvEgPubKt6G4FRwhshwiYQhzJc/AXV1TFU1bQiDCgM5ZPqkxh95SC3wdg8Epo9lAPAa3z0BgRVUTc/yTshsaEw1OZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199021)(2906002)(122000001)(55016003)(83380400001)(71200400001)(64756008)(66476007)(66446008)(76116006)(66556008)(66946007)(316002)(38070700005)(7696005)(33656002)(478600001)(558084003)(54906003)(86362001)(4326008)(110136005)(8936002)(52536014)(8676002)(107886003)(5660300002)(38100700002)(186003)(41300700001)(26005)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TS6NwRiXrzQRRJCu9Ono/tQaqgWwL9/aJGevGUxvSoH4patV4F1glgZ8gKyx?=
 =?us-ascii?Q?pvmNuXpgPwliawerL0jSBC2zMM3yK5H45b5iS6a9zNwp3ImUP0W4DuGwpkGK?=
 =?us-ascii?Q?VKm/M9qztz/C3L6quqFzqMh0/teMEsNbmAgaxrGh8f48VVCpX4XwkCDxqNXq?=
 =?us-ascii?Q?9DDpjrvcVXxnkE7x4ezJstfs+19duVz8EzYGwJKAwRn7puqiOE+qy/JUz7H6?=
 =?us-ascii?Q?JCMTq6qn6cYIWpyGkF9HoI4T3U0w4aIxPBlAnqWsOL/TS/0WEbVfMJrVzIQq?=
 =?us-ascii?Q?PFpKQ65quWQXkIS2LD0jfxKB9PcEaIdYwk8I+b6aXsdPeLTHwNM+FeuIMhE1?=
 =?us-ascii?Q?LRgjFBHeA1D3kCdvyc+Fekl3RTeElaV62KEcgVsDq5tWB+bt3/Aq/0JHhJBu?=
 =?us-ascii?Q?zbVnPRGgq7Uz/uv/emIhBIYW/J6dYW8Gx6td3VbMizLCdYyDNBQf6iXC+SD6?=
 =?us-ascii?Q?WqOJUeKmZiALHWqlRgKImubJtMjw2S2NA6pghP5qn2Pb8bQD5Hz9qVhxtOv/?=
 =?us-ascii?Q?LYuP1VTdWuDTsw0h6bi6YxhUz2O8WVvkiXjEC/UuEQ39hERzfB6XugSFqj8U?=
 =?us-ascii?Q?bTXxqlIcav/54d1zMT5mOlPpKLexThAOfvb8iVe8C1VtJh9pSMbyymMhqYAM?=
 =?us-ascii?Q?WvHxvUhj0Sz7I7Aq+qkuptpEg1YnHXj+hN9d21jatGjHGZ/ROS2fgx4NT2Ci?=
 =?us-ascii?Q?LVwTvjYnZR61Hre4hteLzH1VXFCtHyGB1SBPZZhps0NzmZWh1F0K/Dd9Hhb7?=
 =?us-ascii?Q?DBXOOoLh0ZduAQzGcD2uGAFALVupe2OgFDX20znkFQ3aVFtzuOCAnbRvSpjW?=
 =?us-ascii?Q?bCRj0uBeAtj3RV+uWhYOjCFbQZyWbEtcjRguSQO8S2g6mSD1Nr+S2MQog0Wj?=
 =?us-ascii?Q?gQWl+izRcwQFkd6bGJpqBHHHk1HCHn5FVvQYUISH3Uf5MKuWKXnPF0bF7vGh?=
 =?us-ascii?Q?aY9dBEpXDJLPPH+w0K7g2bJYaUr7h0NJbxobvLyVbIihyYF/F2jO3BAbXFCj?=
 =?us-ascii?Q?Pgi2ZlimTw+QdT26J4YRzEfIk5Gy5303GHax7TxnKNa/vGi6EV+JZL7nUesG?=
 =?us-ascii?Q?lAPfnBR6eXw63oyAqv3QFmOsQtEUdtKi9ucO5UgXZrzEmFBs7LhGCQs+ydf5?=
 =?us-ascii?Q?VVIFIIufkHNoyyxeI11zCp1wzZEaueXD9LW4rQHQPQr1WxOM1ayInLRjxOUk?=
 =?us-ascii?Q?9mxhavqdnmrbyp3bEBNp7g8hbts/+w0BSajFyGgjI2ZV+7di3qdn7dfgI5nC?=
 =?us-ascii?Q?4ZKzryFyWMkN2i3WW1LUfOeYEK/uH26sQg3uq8mosEsoC/Gf10P3wN6mmRvd?=
 =?us-ascii?Q?1mJtDfEOULzQuldwFX4AbDQCKCkQ16xOsES5oAsD65qqgRbpSn2aAmixM9En?=
 =?us-ascii?Q?xtan8sQPhn2yAoSaImf1Xk4mupX1pSTyAQbdfnoPoulmqHXS0x7s2yPZRMa8?=
 =?us-ascii?Q?A9UDcH4+aOdGYNh5m8DVLLFSijmsSAt5pI46uUfF3HdH3upiQz563jXMnvQw?=
 =?us-ascii?Q?Zg6yynMBuky8WX8fmuUZEk8Zm3cKk2L08FVL3v40KDyWFoghtWyLH0qeCTa7?=
 =?us-ascii?Q?NnG9v3X+AYnMqhOErzM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da32d91c-9371-4160-a692-08db7eff2b75
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 15:31:01.3644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YkHBkwg9+G+ySrfJZQ2kSmpCeN9g82CTPRBTeCHgOEPoVrWgYPCtp1r532d7ph8y+4bwAZPxTFGAZCqJNOcorw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5826
Subject: [virtio-dev] RE: [PATCH v12 0/3] admin: Access legacy registers using admin
 commands


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Friday, July 7, 2023 7:46 AM
> > Patch summary:
> > --------------
> > patch-1 fix split rows of admin opcode tables by a line
> > patch-2 fix section numbering
>=20
> Pushed 1+2 as editorial updates.

Thanks.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

