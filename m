Return-Path: <virtio-dev-return-12817-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6536C77B7C
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 20:04:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2972A2A889
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 20:04:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0BE89986553
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 20:04:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9A4259864F6; Wed, 24 May 2023 20:04:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8E355986551;
	Wed, 24 May 2023 20:01:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k168ikTtsxIhgA8HcY3/80tdhWBtpwh1H64PEPHI/bknUPMCLQHPHq3idt4Bho2FbSv7AUProAHii05aRaXbtTb1+rBMZJWg08jVZd8bT2Ccwtz4uS1PNkWMh7YvYpSebw6C1A+qp0u/3LabVW3s5UPbz6tSbFCu4vVj69Orsd5YqmfqY5w1XgCTEs2lgCTRgbLC5L0ciRMmRQFMj+evTIqVklqMHjY/YbbNymRBtJhVcA7jbiAiJgd40Olvv+Ym2r6zHguYfsL0WalITb+wSJJH2RI06F86m9w6qjkDZCOLXscvPRoH/FFaZjBQSi42qnBPMfPOhwNoDzb9dvDl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2aWBxjvB+82CNRXaz8w4FeR/fxayF1QNsSMxeeOisw=;
 b=SVUPX3e8rbB1LKELXUy4rsIitpIxtpXxAtETEtKGDLFGk+P0muRU6G01Z4CLOSQaSWGPQoUeiuFESmSUo3XCa0JQjRfk6qHh6oT2cupdQ3J33UxjfEwXNYUfVio3wz2e24InamJ4tKPve4iHw/nvnr4gYFFDAqjWWF0LnyXKRe5CYYT2Ks3raqBFz54esYVPd4mGpHwlxOTbr1Tr88A3iRttL+x+04sN0SsvOECv0Cihd9BiphpOcCsWTio/44bc2mQvRxpfgBqxUX4/cuPKHKc1XzRZ8wurcWw6MRS0Sns14nuyUj0NpdQElzgQ5YwCjEIAR1HveVBRu4W0Obo1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgAAP1ICAAAu1gIABh4gAgABhyYCAAABooIAF7m6AgAAsIgCAAEhEoIAM0siAgAA15BCAAI2eAIAA2LtwgAASV4CAAACPgA==
Date: Wed, 24 May 2023 20:01:18 +0000
Message-ID:
 <PH0PR12MB54814EE70FDB58A2CABFB313DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <20230511085205-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812F2EFEC7B6A235953A82DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0f75a142-71e9-676a-11ae-a54e6dbb472d@redhat.com>
 <20230515060641-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817BC2F2FBFE3609AFA23CDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230523141439-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E89D0E5DD6F291F8E149DC409@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230524013429-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E07A038AFF7E461C6912DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230524155301-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230524155301-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB9108:EE_
x-ms-office365-filtering-correlation-id: 3f956f1c-779f-40a5-e66a-08db5c91a369
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 siHzg+7wzjOZiGQBjWoSDgAKHA+pSqtU2GlqwnJ22b+RumWexL8b9OcpcZtRyc0+Mx860O7KqyHVwJO992YzLlmCdGOZ19oLt9U0C7iyDs+xF018tS6XPW8rOs0WBAQAl6Xxtd175mNVXDiLYvKel3/Loh2BIfwVtYNK2uXZbSDXcTxK/++vNUiGuuEhlMHDUqQbgYzSwoy9FxaN8oqxUAC8YqcHwXTfQWKbO7wf8EL+2IoZZ03ntXX7MIWhhnP5LluuXOg+2aMmQZH4MJtZQUomzuOPwkMaIvCBtx0q5PapZGOKKkDpkCv9Cz4WNkOUziLqOPsq/PZlvoj0f0olHInlmkMEGBZTsKZOgOWYSv/Oxw/WYBnhe8hP1UsFUZyu0PfXbL56xzTQpuOV8hvwZc9fvOlGIvSmN2qK3edsA6yahT9RJI3ugKZF+tmreAibXVwBnXSC1TQ/VGRUZkL/8EcCO9Do26yamqIYLtQL7ieJphPrCaswhwHF+kVcPt+aDsKzvkHtgJFUUC+43s13mmN5d55lkPlggFbp1WK0QMVfbWEwS1u0ST7hBOGNcLaLBHnaQd/RKfGeCpSA3wAWA28go4qv7INwJHc6R7qrWQnn0KYf7DTo7RcWSfz2Ff3E
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(7696005)(33656002)(9686003)(107886003)(6506007)(186003)(26005)(86362001)(38100700002)(38070700005)(122000001)(71200400001)(55016003)(2906002)(66946007)(76116006)(4744005)(66556008)(64756008)(66446008)(4326008)(66476007)(6916009)(316002)(52536014)(8676002)(8936002)(41300700001)(5660300002)(54906003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XFVq0JEXjLk1Jx/ZWXppsKt6mSHY2bFAk3chtNDBoLPLLBD3SIQ9OMtm9JLe?=
 =?us-ascii?Q?b9hohqYRDDTYrZd3oPHwRLrpREY6gSORGx35XFh2zSi7+XvCBJz0f1acKycf?=
 =?us-ascii?Q?PQ05rFAOUNDPcara9Erahnd4gn0SYau6eYPitcQe2/mIopTwQbpJL6MWgBdT?=
 =?us-ascii?Q?+OfTfwaWQGnz5E83hez+e5tBktvoPYV0Mlc3u3FBcoc2Tb9BkT3vAu+Ac6mu?=
 =?us-ascii?Q?eesWvvJoLpaI9W6jWHGIX2Xs9HWdgUiyDBO1Bu8UEdwKxq0BG1RgId5WqUcW?=
 =?us-ascii?Q?NcQ/qt+1Wfydxj6Q29FfyfjvHvjzeFWuF/5IVt9ONUc+1iRD+ZnTr9rOg/OX?=
 =?us-ascii?Q?DH5Df5KnaNtBtZZqVRpBkw6whVNvgrnez7u0d9mMuaZdeuVtzNkqoBdI2+fq?=
 =?us-ascii?Q?sI3OFJAGoPxULcxtzl6IB34XwzPO4qhr1gtw0Z7L1oWk8CMX+59zh1ielbSp?=
 =?us-ascii?Q?883ENxt8wRcsxtDPfnN89MSlKjPAfgY9Bj5DEC8Njg93qlZavegOkO7DolL2?=
 =?us-ascii?Q?2w/cDGqqMZMUKpy7rv7Mtk+dRQYF7WCyqE6QUEuVVDqDlmCRkXmKvQdD2+qT?=
 =?us-ascii?Q?46In2gyIJE1nWVgTSYDWmjCTNY48pMNIi+cPqOwFwTYXMoeqMTwrm2+6KihO?=
 =?us-ascii?Q?HB+3J6Grffv9DcC85Hy9xjDrOQ8TRiEf+9DlbrwoofY+JDyd9xeFUeOXlNdy?=
 =?us-ascii?Q?JNc2SX4/aQBPveSF5fzPI6iUlXN8v58p6XXEhhdWU8Lg/xIdTywo+KC1QkYd?=
 =?us-ascii?Q?SV4YTaeSZlQJ87Go6hY+JX1ZUmOOGKSAkkCZ3FZHFFnaYm9/PJdI5C1CU7F7?=
 =?us-ascii?Q?V6zQpykzHEFaGIerr6bz4w61A0D3jfjWnZLoMbYP+O/JDHWjlBoMyjUBHcAR?=
 =?us-ascii?Q?dsY3gHn5Gwj7yakMMBTc3UAF9I+RPQsc6T6+eqIn0cxjT9aaB9fjg5ugyL3Q?=
 =?us-ascii?Q?PAaBM3mjc/BPCmtcyXIDbtbyxJwvoUbtVOrpgpc+qePPrR5YnV2EDk1vrfZY?=
 =?us-ascii?Q?qGwe2FZgOyP1HO+jqmUYNLSTF6a8mj9ptSFRSTqzDqOZn7poDEMTTz3vUhkJ?=
 =?us-ascii?Q?FjwxF/S6hHbRZdXtJOZ6zB3ayJq/oUBfMpa168E4ufqi4hs1FwBOYj1I1ECB?=
 =?us-ascii?Q?7X2PEwXU82Txsg5aNlifwTuhzXO8M2vRjhpYTkimMdQqNgwvTWW07y+CQ3uc?=
 =?us-ascii?Q?WA+5U7AyZBrunm/BapGyRwNph+rUhT8c5ZJaiYJcLvL6PBZDY7xQMOWgvEdq?=
 =?us-ascii?Q?vYJ853/jm+FXGa/VzPY3Axe+cERZyaoF0p1jpAfQ5BJc/QkwQxOjyEdbVyuB?=
 =?us-ascii?Q?6BNlClA9EBhWPQCsVImktPKk/K80ySNZoqNikwDQXidmEw/HlzAQ3amu/xkP?=
 =?us-ascii?Q?WiQnKA+R7X96btMggJqOgx2bjzCcIQAlCPvo/jrGaRGtQ+CZlO5lEQ5imM5Y?=
 =?us-ascii?Q?oBHigyo+TRLW7Elnd49Loh6l61SdwwlEDim/HkNWNOZIy82Q1q8US51puCr6?=
 =?us-ascii?Q?3B1pfD5E/1SPNl1lSL14sSDqivbv7mE6DGgn/KgXBzNLc+YJnL8DQ0R9biz2?=
 =?us-ascii?Q?FqgWeWWAR8EsZR67RIs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f956f1c-779f-40a5-e66a-08db5c91a369
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 20:01:18.4489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qUN1zqlJfetIOOL807HWDxylLvCZkcK57/AEb8uuECRFkF0KYtAG3OhToF36abbRpowhbqNuoswZrmdzjIxcrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, May 24, 2023 3:58 PM

> > > Hope this helps.
> > Definitely a good suggestion.
> > I will send PR for virtio-docs to maintain our TODO list.
>=20
> Hmm. This is just a dumping ground then.  Fine by me, but what I had in m=
ind is
> a common list of known problems to address by TC as a whole.
> If you want that we want patches on list and discussion, maybe even votin=
g.
>=20
It is not a dumping ground, it is the list of things to track and document =
without searching emails.

It is a patch on the list for the doc in virtio-docs area that if needed ca=
n be voted.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

