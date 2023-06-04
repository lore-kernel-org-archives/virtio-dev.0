Return-Path: <virtio-dev-return-12856-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B53C7EE29
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 23:41:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3CF78EEA15
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 23:41:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 30D7998646D
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 23:41:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 25A25986338; Sun,  4 Jun 2023 23:41:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 114E1986332;
	Sun,  4 Jun 2023 23:40:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixxC6AEoS5Sf6I95tODr0+8eB947Vldwdl6nU1b+2Zlf/9wu6pVre28k+b/mafVmZBm8q6aUX/DHGaTlsox29vR/AQI7dm3jeAst19ZPur+7aEPM8E8gfhm6mcIUob0Gpzf6/rl9gETmKdjfaSyOIScZ8ksH6OfFiNgPTLcxreWSeZKfU+iiP4IWdcuJ/+m/G1jV4IRxMryTbgzr9jJgdfbA5er9HFu387sQIjIDiNJTSv7hfbwj1J/28xuZTYtYqAhJy/SKu+TKIlTIXhfqUwofSTU3WRN3DBwvJeuoC/2hcSDZhF+WGYk1JrZEW7wu9H9/uIqaSk23vwPJz7jZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia49QL51spnOkisVEaOBpKA9CNsA97ZlbUfQDi8yovs=;
 b=hUPbOYlRCsedHzW3c7zJIim6Hq7Gfty8eqIMfCxCwmYcxIBy+egeOr7tK8fKfzdLBJ7mkfnqUE5AuM+J8zTxqh+1uhnfkLmjDH4uEf5vocITUgdWRWqyt1YoZXub0ix5WzZjDX/P+vgZUOfTuFU+QqDb9DYoesXnG6/3X3GYfWZ+hCXlNDx1iKN+RlwC/OnFX/x8trW1q26qZJt3EYnS9p6LZ7q0p8pz/MiPjFsjcZHuV64jwnmdHxz+x1ACfb1w+LLSFjgAXBXhgg88xy3rhzzkl1OmMLvxYMiDSmxKDG84MRNQAnxNYec/03wUGTo3dofBYYhLB9qtjhY44g03LA==
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
Thread-Topic: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6g
Date: Sun, 4 Jun 2023 23:40:54 +0000
Message-ID:
 <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230604092441-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815C9677C9E1F3EDE032A9DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604094535-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481443CD383D9BFA0369151DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604101351-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548139ACEC00E7CA6D988182DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604105027-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174224-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230604174224-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB6804:EE_
x-ms-office365-filtering-correlation-id: de141fff-1efe-4987-fafe-08db65552380
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yuU3EXl2Ea7kGmTWE5klUjcGl94+U4EztBHLueGZ0FlqBy0OVG1hZDL15cmKiZyrekvj74z3gghRX7viF6O+h/G2BJ2uWZGy8siihjGvpZnGHrdZrTrIcQxTRi/hitfrxDC/JQcTbCqmOGVez8e1Or7JzdiAOpBAV2fE6PzvZ1AZIu8a+M0aAMIx6Ln7pQbTZLNiDmcpxTgg7tCH/bSShA5iOuH9KOdsLg7rfwhlsbYM/SmYM46Ff/CQKyYDrWe0czOLKv3kfA4oKlqC9wBBiBmeaEqR6xxRxoW9TKUpaDc+O7XlSZrtTXU5Vpp02cy3xS/fqNtCjYb9atFWAN+d6OQiYXvSQdAf3Jki1qeVaW5W3fsXXg/hohiueByY6KbobnZnFtQxEQC3ujk01TdOgZOsjVcL0BYMoA1mBXL5VBzz2WDwXLFqCqcNJ2MLvuAkbJIsN2yLkFHvEtV1+u2DAXY4qv3lv6upIEaRX/xEj1N+wtp7XImYkWcBoSlrA79FDYmH94LmwojTeiaWwbwxkhKMVgJAJPTyX88EbyYBEfn8A8a2qDu5Msvno7IV025RR5LPej+zEN49+0n08w/olrVJmal0ra6VZkQLQEmOaNGgTpSus6MA2ZFlIqsTt5NP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(54906003)(71200400001)(478600001)(52536014)(5660300002)(8936002)(8676002)(38070700005)(2906002)(86362001)(33656002)(4326008)(6916009)(122000001)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(55016003)(38100700002)(41300700001)(107886003)(9686003)(6506007)(186003)(83380400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c6JCw2vEnyNo80tGLxG+wETIrSJ/ieQb+pghYfdptW12uCsJ34BXHU4W/6Q6?=
 =?us-ascii?Q?cmiMatpDF1HX5QJxn9QMU2tePkZ7miAprNg3bkjHwumnhjsY2e7T00sey7kP?=
 =?us-ascii?Q?vd1oA4s5MlRneM6yV08VfAqtDo1uDnpMbX0CBrDoDqrDbbtgVZ7qjRPLacoX?=
 =?us-ascii?Q?PpxZp+ME0q+Gg97eDE9/TkUf31GoczMu6kuN9IjxpVkbD+hu85xByPy923fp?=
 =?us-ascii?Q?eExp8pNdTlU7Ms+xAlIM4ZhyBitCkgy5gAkiy6qOLNvU0mHbORH6TWoZPluS?=
 =?us-ascii?Q?gs8oB7k9vQix0nxCQjlELTbK8SJijgZPNl5a3p2wMhFvxBqBT0KcezvgfKl8?=
 =?us-ascii?Q?eY3uSRuNbwLfjT4jUV5P9jfvnoY/SeIWUe35qlr1dmLpA1T9HAsz0MsSpsd4?=
 =?us-ascii?Q?NxHQ0CAVaTF7wolGIUMqMMfL+1tZ4tZwdS0ljIsGcnY2x9OwxmG3SOJkQekY?=
 =?us-ascii?Q?860D23IfcdD5ZiKxP4ju0/pnZq0W39vMsnsR+RANakyG9A70X6yWAbAi3ak+?=
 =?us-ascii?Q?sUT1QKoo5uAHPqaQD6eQqllu1lQ5k1DDyWDBykedvPEx6Wf2xZEVax0HKMDc?=
 =?us-ascii?Q?aLSXDknWVtJekKWGZDW7bpllgOLEGmps1CvDFrSoCo+UogocFcobfip4NUzo?=
 =?us-ascii?Q?KLkGt+Q8VdYz2JJBqVjZQp31Anto/jLf87h6fo3N6yyGnA4YvBWPCTHOz7Vl?=
 =?us-ascii?Q?1NeOELCG46VJLO2lemIw1rZY6dofbeeT8fXnv4YkDPz0jJwElMEwGSfeKa5Y?=
 =?us-ascii?Q?1kEiMbrQ1DeXpAq+Oq2z7xdU166d5wru+VBXqDOPiYu+HlDQ3zl87M46mKUM?=
 =?us-ascii?Q?IBYGlKbf9HTalx06DnciqHYyW9/4QrdZWJaRkUG0N4WY+D5rZX+942Vz6Ed6?=
 =?us-ascii?Q?mSruPdWV1loLGA1y6L/VhBTphv7ahBYn4OfavQ17UOElIintG8+iqsFeodCs?=
 =?us-ascii?Q?J8OuizeZ+1l5ep/mRVLXz7LRuXg1uySCcn/J8MkYvLEHuOOcrc3q9f/xkZhe?=
 =?us-ascii?Q?yPkMVhtWrpmcJF4XBzIPgljSLpGp0Vx4k6Rrj2qderkacB9WndeelE6S1BHQ?=
 =?us-ascii?Q?YeqnFp+6JkyqTwEi+/N+fRNmLztVKMVfAHE04LXNJ7V8nLvqVALSu6pEd48D?=
 =?us-ascii?Q?HvJGT1RiHtdr+uCej7g92Cb/UA+sQxp5vFO8BRlZsy/UP0pY79FwNbqXGHFB?=
 =?us-ascii?Q?N8hLaZNy4+QBtiQmbDZa1Rha8aPA+1k6JHWe7bcA9TyaW68pzz1acUY5D3Iu?=
 =?us-ascii?Q?/AQRBMCcUvwPWMvhHOENLVSBnMKQEx7WjM4uDeA6Ln9z5KvBOciscEMKUXya?=
 =?us-ascii?Q?J8WI15nl46pz2PmVBfazlJSmm7SUMX/e8CH5Ohd0+gX9oZOe8PF5vCUF+lh4?=
 =?us-ascii?Q?/DidZNOnPwxBY/JWhzHa1U0O1eZAwVwTxl7U3RSyrK5J++cpGwL2F5sHzncm?=
 =?us-ascii?Q?x6nx2vJ1Rc1tfHEmldjv6gwPepCVxpALxKlRvSuBUfdFZBhvib2MesSpNHwO?=
 =?us-ascii?Q?VzNj6KUjnxMR2SyvdZZZFEo/nlmovUC9AGUBADlACgFM7gElcr2WLrtYBrQ1?=
 =?us-ascii?Q?1f4691DtV0nQOKKgqAZhBtAg69egkLdRdZheWTO+ET1dZ4UlLOCFItTsd8dt?=
 =?us-ascii?Q?vsNVw3QLqYJsKM5wwrewLZM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de141fff-1efe-4987-fafe-08db65552380
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2023 23:40:54.5305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98aCXaP8mU6GdjNYQKuTuxIOBjm/5+GUV+qaTvfGSr9/t8LFoRj9cP30LCTcauU4RWiMjsrmeCCqAh6wrgiQsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
Subject: [virtio-dev] RE: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, June 4, 2023 5:49 PM

> > Legacy can utilize the 1.x hw plumbing without building new hypothetica=
l PF
> hardware.
>=20
> Maybe.
> Whether 1.x BAR can be reused for legacy would depend on a bunch of facto=
rs.
> E.g. with 1.x using VIRTIO_F_NOTIF_CONFIG_DATA - probably not.
>
Not really because legacy doesn't have that feature.
Legacy notifications are subset of 1.x feature.
This was also discussed.

> Let's just say, we are not in the position where we dictate these things =
to OS
> vendors yet.  One of motivations of the spec is making writing drivers ea=
sier so
> let's add an option for that pls.
>
There is no need to add multiple options at this point when the hw vendors =
are not going to implement.
When we find another vendor to implement, we can always add the new method.
Marvell and Nvidia both are forwarding with AQ at present proposal.

> > VF has BAR for driver notifications. This BAR is used for 1.x and legac=
y.
>=20
> But it's the same piece of silicon - be it in PF or in VF.
> I really don't see why it matters.
>
In same piece of silicon one needs to open yet another PCI steering entry t=
o tell that treat this for VF.
This double size programming is useless.

Yet again we are discussing same point as before.

> > There is no need to ask vendors to build new HW to put driver notificat=
ions
> on the PF BAR for VFs, when it already exists on the VF.
> I'm talking about giving vendors an option not asking them.
>
Ok. Understood.
When a vendor prefers to implement such cross hw forwarding it can be done.
There isn't a desire to burn and program extra hw for functionality that al=
ready exists on the VF.
Hence, VF's doorbell on PF can be parked for the future option when one act=
ually wants to implement it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

