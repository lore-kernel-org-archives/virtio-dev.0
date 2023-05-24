Return-Path: <virtio-dev-return-12814-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3303CC77B7C
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 18:57:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9D35D157EE9
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 18:57:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 965CE986554
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 18:57:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 88E82983F7D; Wed, 24 May 2023 18:57:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 72A9E9864B4;
	Wed, 24 May 2023 18:57:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoJpoi6j9Mb/2R9XJn7SmMyUp5Q59qlRFFt5JulxPRGOGIkB0LcEcFqiuubz2M8/X+rbHz7NxDZjcQi7+rcJ2E8lyAfUg0aGIGs5d7UvrZKqg+CnPjKSjNoMHVNoAgiO2tlvTV0BLGg5jRm8nLcGNN1Yz0qVDwYBtwSbQul2gUIiMn/gJryT1n8vvcy+QauY7KIwVANv7Y6avZbfwcusafSxaHt3OGUK4L0NoUPXPGe+1HR7TyWq1e26Nt5y4P7twNrc/z3CN5Evu9/qPJLTDUlT+izrv80U4HBczDreinYCwr9g3CoAjfQD2wygEr9VVS1i5i52oGtBE1CYmQbpbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUtOGFm7hg59zLG2g4wrco0HRgmSWQNT964yZK1+jnY=;
 b=FaP/79u7FRLZ1t1E8H7bpXYGDzq7ZcEftfiXwx3igSWoSIVNq6OaL2VBVeP34KAsyCM370nTJbZ1cIyNc/y3d54JdQitwj4X73ZWFNCgDsEcUD8Lpn+tqzSzv2H0i5ay/Ws7+AUG8VnFJxIHN07ynRJ4i+VUALwnNF6N0OegILxxApZTMGqobDivMi+hBGRCr1NTriwAh5btFdLBft+VwqS/yj1chrmDsFnpzx4HU92XayGnRIgfKaOkGvELVZbkp5beSd1j0k+JNFYX+aSGpY24IdjjywYQzox52MjjJJEr3SUtxJsE8hIxz/MTr6BxGX7tVZ8JdQwWS7GHCkOwQA==
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
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgAAP1ICAAAu1gIABh4gAgABhyYCAAABooIAF7m6AgAAsIgCAAEhEoIAM0siAgAA15BCAAI2eAIAA2Ltw
Date: Wed, 24 May 2023 18:57:30 +0000
Message-ID:
 <PH0PR12MB5481E07A038AFF7E461C6912DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <20230511085205-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812F2EFEC7B6A235953A82DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0f75a142-71e9-676a-11ae-a54e6dbb472d@redhat.com>
 <20230515060641-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817BC2F2FBFE3609AFA23CDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230523141439-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E89D0E5DD6F291F8E149DC409@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230524013429-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230524013429-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH0PR12MB5073:EE_
x-ms-office365-filtering-correlation-id: dfc54451-ab6a-414e-d500-08db5c88ba00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +q8/HNv+Dtt85JSy0WpocQhPGo4/m8Aieu5+U7jiz5yHHQ8GY0haNzaiEjqtF66eMFjqB9Fp8m+Wq1YiX+BAfg/aZwMjS9KX0Pm7RvCPh1OveTJ1ug7OJ2UyYv1O6Y4AWZ302QuXOHDSLOIATBguNDxAWA8oTOI1RQR0UxjdS2xbOqju92ESvnKtKKVp9brB6OlOtyOSZIUbh2OYSECR56siNr8HGs975/v7o2YLzmwoPRmsFmzZatyznO/bQVkX2GfbkeQ1Hw8mo9Lt+KMysYEnC794gtQyQDl4Y1pbVGujoiUynJ6teQ/GyZ7XNUL7wX6jQtNruXrLOcBiRPMCsisfU6Jlm7cac4+pK5g2pTK+XGhoUmcF3S3uZFyRgpKMLstTcAeQ0EOKNCU4ZgzasW7AyiwE1gvjiKPvQ4BtioK4y5v3q8z0sOTz+qD16uJPD+ZmiOscW61Xfew0l+CtMEBlzU6cOSl75qHw2GSYEQiKjyY0mRh2l9IflOnXCKcYF4dcC1pt/mUyQisHjHGix7OHHVvxHXkV+vC1KHigrPdyImljV0vBFJ/0JcCCv1qkpVv0uWxOg5qyB9bVrdi6S+SkGFndr3nx/q7B3VSgtSLdvElkU16AghI2c+ua4ft5ZipiOqRrxRAIX9bOkY9CXu03TuX2Adm7cujvlWvvdwk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(5660300002)(8676002)(8936002)(52536014)(186003)(2906002)(9686003)(33656002)(86362001)(83380400001)(38100700002)(38070700005)(122000001)(55016003)(6506007)(26005)(107886003)(316002)(71200400001)(4326008)(66446008)(64756008)(66476007)(6916009)(66946007)(66556008)(76116006)(478600001)(54906003)(7696005)(41300700001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?G7TySlljJcwP2kGnwWJxZH1Nz3Qkc91DNAxfXI/4h1lX+symeOfPP/cGr7ic?=
 =?us-ascii?Q?VyN00tal1CEN1RpxiegcF96Ibf9eND930246nLjbLpQjkP1Im5Ih7oXfvFuW?=
 =?us-ascii?Q?dgEi6hFVu+FjUS3etqtLuKM6QBX8et9ZWspfkzqBuMEB/rnEqfWC2vjzNLEh?=
 =?us-ascii?Q?kqUP6tD+KNvNl2n2IYt3p1ubmJpE5ooPFWu+IRK/10QHyG4LiRcsdpvzw/F/?=
 =?us-ascii?Q?6p4PLyAYutD/1A5l814BfqFEGJGs5QBS+CjkRZ82GXIogr9g8ETmgD5MCHWP?=
 =?us-ascii?Q?sXzrXB3S1+Q6JPPN73xAW5cmSNmMSvMMqS9cKawFtVQg3pPu64chDDC4hM10?=
 =?us-ascii?Q?eMxWDbesB21mxlGE0SVDDc0jvpzmkYYG11oB3nqVhz6Xd/0acCbPjtC4nEcz?=
 =?us-ascii?Q?1SV/siZeRusgm6+MSlUBtYaDttA9dYsOev+f/iGgNcjiaZRhnboERbjy4l+c?=
 =?us-ascii?Q?qWRRQO7NRvPTyxX1e37gVJC3nss2GP15GnKjJNGLjLgesBvolSWJgzSTxioL?=
 =?us-ascii?Q?Uvt3rdVokAhHGeutNtWID4o1Ke8MGe6DqJXrDrUUA2LIpfu/O/iNb8k/QjNI?=
 =?us-ascii?Q?L3SVUGeGx2zDuDa37KGWL1CVsHYQ252UJCno9xPJh9OsrBmOiZfU439c6mAy?=
 =?us-ascii?Q?YbLBQA0thlUSGmzK84tDWe+gyPkZB/AazmC7Rveef8nE/ecjU5dCaR4jXoGd?=
 =?us-ascii?Q?pZ3pg0bPRiZA+1KRthYZZcK9ljsp06TQF8X4tp3aImP1JYjCp8smF60uI9rH?=
 =?us-ascii?Q?8jGUG6hnAtmAenUkTPLjSSCJIib8055IwClE1YAgItnoAZH/d43GGsoVT4FP?=
 =?us-ascii?Q?9FRinPo/45CplPsAokdG2CryHogVNeL+/1GuqLLIAusmSYX2hsriIeIhMn2M?=
 =?us-ascii?Q?dx0ZsWAAD1eREWUfR3BeJBi4l4T0n6D+t8eKQcIIYTzBEZLy3lNm/xhwBbpF?=
 =?us-ascii?Q?fwZH45ZiG19IJ+CkzuhJhZtAbJgrZPv6lstKAQPvNu9uh6TWDoyVfhO+5fIJ?=
 =?us-ascii?Q?DFrr3zrKgT+FzOasYN/oQurSloBIbo7mbAxGeMtmJxG2mG7I4h42V6nKSCRM?=
 =?us-ascii?Q?EcDGN/mxQsg3jbp6jxthemdmXhHLQSchDil2xhW4V7JAWMf3fAUrNysIW2Vg?=
 =?us-ascii?Q?4eFVncp74gbnbpBeKfxjIRXlSIZm3IZ8zPXaBWEzA46kN97Shs0Fdq6sQeLp?=
 =?us-ascii?Q?pyo/S2wWUNB4rbHpOLBRvMeCnjBRy/epHP/3WS9hs02kl1UlsAXP4Jq5zweN?=
 =?us-ascii?Q?P72TJ+sMjgJb3DAcXvGaFA6lU4oihcEispai0I/Ro6hPUOfpeiCNmB+l7God?=
 =?us-ascii?Q?ezTrtG/0Hfep4k1TZHhMS1DRMC8NdnDQEbWvc8ljTpFhfUFce7e7IDqTbY64?=
 =?us-ascii?Q?uTk+b47Js1fymEcadcVqKTobJm/ypew6pGEQLAuty8ZQFlwaP4oqQftHkL4M?=
 =?us-ascii?Q?XdBgUekQrCGgStvcv+fiwh02ILQfmsmi/JxctfappG+7OCr3mygyKgh8I2In?=
 =?us-ascii?Q?nqFiDimNMZPPZ+4ZaiB2DIh1pn8e/a6fWdf/nxCS8FsKYr2veo9FMOclfq7H?=
 =?us-ascii?Q?okRYfGntZrznSikeUoY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc54451-ab6a-414e-d500-08db5c88ba00
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 18:57:30.8935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lX5f0JgmYkcUGGw/laXnZ+SXkamfoI9mDZ51O9j+GwrJDIfr2rWIQ40/1ulwdUvy3bqGr98LtKY6FEmAK9bhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, May 24, 2023 1:57 AM


> I am frankly lost at this point, this thread is too big.
>=20
> So where do you want to go for this project?  I would like something spec=
ific,
> email threads are growing too big.
> I think the reason is that there is actually a host of small related subp=
rojects. So
> when you propose just this small feature, everyone jumps in with their ow=
n pet
> project proposing addressing that too.
>=20
> For example:
> - SIOV guys were adding transport over VQ. It would seem that
>   can include support for legacy.
Yes. SIOV can support legacy and modern emulation.
We need to have the SIOV devices without this emulation support so that the=
y natively good.

> - For migration we need ability to report member events to owner.
Which events you have in mind?
The AQ is design to carry the migration of the VFs and would be controlled =
via the AQ so it knows whats going on.

>   It would seem that can be used to support INT#x.
> - Ability to stick capabilities in extended config space
>   is a good idea, for a variety of reasons.
>=20
> and so on.  Understandably frustrating, and it is easy to go overboard wi=
th
> generality.
>=20
> If you feel your path for progress is clear, that's good.
The path seems clear to me for supporting legacy registers access for the V=
Fs and future SIOV.
Let's conclude it in other thread we are discussing of patch 1/2.

> if not, here are ideas for getting this unstuck:
> - start a TODO.md file with a list of things we need to address,
>   and for each one a list of options
> - everyone will add to this file then we get a higher level
>   picture and can discuss "this will be addressed by A, that by B"
This is certainly present in my personal todo list to discuss, I am happy t=
o maintain in the public virtio doc at
https://github.com/oasis-tcs/virtio-docs/

> - have a chat at the upstream developers meeting (May 31)
>   so far it's about vdpa blk
> - anyone coming to the kvm forum to have a chat there?
>=20
> Hope this helps.
Definitely a good suggestion.
I will send PR for virtio-docs to maintain our TODO list.

Since some of the discussions are ongoing basis if we can meet monthly on m=
ore practically on need basis, it will help to make progress faster.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

