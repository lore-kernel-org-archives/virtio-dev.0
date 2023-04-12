Return-Path: <virtio-dev-return-12186-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919E8C77B73
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:25:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EDC692B024
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:25:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E0A919865A6
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:25:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D5589986509; Wed, 12 Apr 2023 05:25:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C40E898650E;
	Wed, 12 Apr 2023 05:25:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbVJlf/YsdWu/GaqelDNmD7Ce853iLz33+10qQGs/5sIFUHBvyBuTr90M+JzdWxqQ8AVnFYwEi84cWF+8UzZRhqFh82HM2Lnhz9mnsSBp/UqTMjhG5zsuH8tU+tl3Fo0h4ZenOdO2aQpyeWZUAG7Le07r83K+nfIrjdfAdEAkXyvVWuyfYaWH/JY5I3LOQJ2MZjgPHGvUOSdpdyVgC8IGIWkjcrUpVxtzW1wztfEaK1XCAz6MjgIdp3g5rd7yL+CM1N7kq0NF6Yj1wI4AhpZWw3OunwZhpI0S0ZM5E/Y4xLCWqEHERBZpNpQMISk5cGKtXvgt2y4LdisWMl6LNoLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCYhVtuoxg1KsquXctUdaVyA5JYWdz4wovTlNzxlZuM=;
 b=GrrVXFuouwRSPnNCOfFioOBAUJOIOFvwyYhoJcvGXPp+xz/V7oy9QSxmGuYNdYFjbvhO2BqG2zRD7janDFymW7kcKmG5J+eCyb1jPC/T+ErGjHFhSAhL6vsAUm3HEOL2DtdbJ36cKrBAS2hm+G/J3Ui99nqy1Oce/0McC35VqES6vjKLl07foIh5C976LlMSdTcLbrl4P+3WluCzNLK2pZnG6qTvVrCNs1eRYE3Isf24H56jV9u7wuKfRZ8atXLTkTQv+ovnltQ7cTJpS6jqFUMXw2I6TjISN8haUJdW5FUaFDOZSHDgeFPgRq7pczcynoZi2IqYrjfaNTB138S1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [virtio-comment] Re: [PATCH 10/11] transport-pci: Use driver
 notification PCI capability
Thread-Index:
 AQHZY1tLBn6tX00VoEql9uT0hRsw3K8nKIQAgAAAVNCAAAL9AIAAAFBggAAFNICAAAAt8IAAA8uAgAAAaiA=
Date: Wed, 12 Apr 2023 05:24:57 +0000
Message-ID:
 <PH0PR12MB5481C76581B25BFE3892AF95DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-11-parav@nvidia.com>
 <20230412003006-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481394D07C5CFBB2347B5F0DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230412004152-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548170E8002F19709C6D55ADDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230412010224-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481843F73EA11341608A1B6DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230412011222-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230412011222-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5136:EE_
x-ms-office365-filtering-correlation-id: 02a9e465-4dea-472d-15eb-08db3b16418f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sqI00OoOXGe7O1EgFsImwPH1Q56x4VI4cD9nahcY0z3PSarwhLSMWGxwRNVv0oVF5OfUAJNrGsN5aMeZpRAKYNBOr2RU9pmVX8rDe6syO+ZteCfQY9FUMZLcxvUda5XcETi5mwYOMl3fnXGtWPCZM/a2wtJpUo1OjMkdSSw8Ae4LmEmeTkSDxulrXR16V6epFuS09uot2+i+0iygAiKlnrVKVLKAawVmgguq5VrY1qCfDsh7tv7zEbBMgdOjLzq0ws/v+wnhCQzJ6OK7i2FPRy6S5HbPStQmOishUTGnKI2P8CAP9VMA5g/svdhOV9dwhtjyEpbeD9cexlJmB6+C28mAcEgveogkWIImG0csxmidW/zzTuQl9T+z0dJzN8q0c5vYUbpHLvcF8YKa3ubYxeng3TYDf21Ha2OOFoZZegjdev3ZjVGO2noAunr25v8qTBprCVigCFPjK5jRapJT+2nDeDX+0GaCEVoFN2ZmmVrhwhSrvuZO7FeeMwB2/Dc8UawNq4EeFeruy0ZSfYgeKy85MYv/eIUSBb4WYdjKGPJhx8hE8/I1WNdJ6FvIV7BiCSXOMpMu6yBc6crFBvmiXqoOJhGAm48IuJoTTJZ096Ga74Av9TR4E2ip2YfzTrcE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(83380400001)(15650500001)(122000001)(41300700001)(5660300002)(52536014)(4744005)(2906002)(38070700005)(38100700002)(8676002)(8936002)(186003)(9686003)(6506007)(66899021)(66556008)(66476007)(66446008)(64756008)(4326008)(6916009)(71200400001)(7696005)(54906003)(66946007)(86362001)(76116006)(55016003)(316002)(478600001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qdIHLuPDjqbc7OD2MbvfMbNu+10dTDO0NkDK0H0C27GRE6h5PiIZkyeMb6Qh?=
 =?us-ascii?Q?itNFwyGa+fuKNOPGZaSAGzoyAeu9pzpCEv+AvpgnNn00j/RGwFaPBHU0ibhv?=
 =?us-ascii?Q?yPwvWo1D3hN7eHEQ6NnXq03GjtIu03jkf6LmW1Y7xG7wfWiEHJ8yI8EEm49s?=
 =?us-ascii?Q?Z6wQnU6OCA/FBnWpfOJyHPRBRfeXhfzE5pw5/f8IoPQVFyADWo4IjZpDdE63?=
 =?us-ascii?Q?IjiuoRQUy+qezoTTxy1SZzflvlWHabLR2NjEGBBci/gjJRW98mrhgHnyGwda?=
 =?us-ascii?Q?zOVEjGlqIjoUUENlsUiAKBRLY9qWUU8/V1A88gePPq9KRscz/pPqcVC403O+?=
 =?us-ascii?Q?voUjzspOTBeXLWYz0xgr+coO0MzEcLJtm236D1nyzG7NBRJM2qyf+1eVawsE?=
 =?us-ascii?Q?N7XsQf6i9LvARcoab/Z0/jpkakGDlizMgMBgKsY3WddoadFk+qFR2qAIBoCO?=
 =?us-ascii?Q?WBuGSGvzIJfqq8SBfYMgcQdFAaSexria1Z+hY4W2UVgxzSGdYbaroylwDbci?=
 =?us-ascii?Q?A5hp9CX9/xzizXFOPtkiZ0aHY9xW5D3lVqvAECdzQ2T8/XjhHwsD6I2N/U5j?=
 =?us-ascii?Q?tpTE7UBG+m0r1CsXBRvqjyXpGl4We8eCRe/ql8Nkpw73zBcjKvr+FaxwqE/Y?=
 =?us-ascii?Q?CVvxTg9HcJ9WgARsxOuPEOPXQTkYYWsTWVck9Yp5E+aqnWniNlwV9rqage/t?=
 =?us-ascii?Q?9OqpUSGIyep1BozMxinTXcmJD2qF+3vd5/0VIpTq1EJdm5aFew8L5EOGe2TW?=
 =?us-ascii?Q?IQWWwN/uwsZItre1wbfQQq00Y5OMiiKacIyAnJ30LWBt9xfQJstoHW0X6sfG?=
 =?us-ascii?Q?XOHvDirXMS6WfEbqNS0nq0yVKkI9av6f1XnF88zwMUePzzgPKzkzRqsc7D8c?=
 =?us-ascii?Q?dMGeTXkE1tdke5MIkCWKADm6nZrgUSjeUYShyBy2a4wd9DKi1kL0V5kbD/Sf?=
 =?us-ascii?Q?fsZIDjVaB3JgsVANDoHoDdWW0ScP++1JVR/ou/7OPTXG+fjLs/Be7SQqulov?=
 =?us-ascii?Q?lrdCCHLgygrbOf/5l13KSSHUjAhDQfr0SLum7bsa8b/IW4JdEq8IZQH2VQIG?=
 =?us-ascii?Q?M4l49jo/BqUNO6mxHxfEfMH6GgQ2ctVO+O7DoLjgUfqPoDjxij/L6WUrgxJO?=
 =?us-ascii?Q?3mxiEq68s97S8oqPkWQlPzN7kPrahXkAy2DuyXatU3WQfHPl132D7m4kc1Q2?=
 =?us-ascii?Q?iMXph/RCqoqJzH3vgiLhjmHqmxgRQlFPjj9TkUv3QBnsRCuhUojQeEKegJmm?=
 =?us-ascii?Q?gFesYB4LDw+OIYxXLDtr1lKxKV1KF33G1rlaH5wvD6yp+eA0/K8qIhhMWI0w?=
 =?us-ascii?Q?S7vs5Bl2uiI9GHTaaR64Bv9Pi223NPq6VHJWexBiYhTO6Uuv9LyDOGAKHG23?=
 =?us-ascii?Q?NRffirhYqnAdJQG4cVlDUT9IhmmWc2SB1xZam7C4QnQzNErsZqPoQSGno6So?=
 =?us-ascii?Q?kVuyimRLbL4T4kKXOp/Z/J7QR8DgtCkI4hykZGgO/OPC0RL8av45SgpOUt11?=
 =?us-ascii?Q?79OtJApUBkPFfq7FpHU/skQGEVAfznZQXZfp3gV0l/NdgGOY43HiqFKMByuZ?=
 =?us-ascii?Q?+V6DTZ9yUSRu3go1bpBKw1YCAbI+Xs8ZAxKTKqinRfjM/uU3GvmECLmMkijd?=
 =?us-ascii?Q?1WCgmQEtPDd74she/q3kZZY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a9e465-4dea-472d-15eb-08db3b16418f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 05:24:57.8171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvp4QfWcdzKUQqYewtaUl0iO7q/Z1AZ6pogZSbmtuoTEeCLMKcZjnnseKxVHiasoivoMpG9zcgTog2o7lvaHxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5136
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 10/11] transport-pci: Use driver
 notification PCI capability



> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Michael S. Tsirkin

> > Such registers do not start the VQ data path engines.
> > 1.x spec has done the right thing to have dedicated notification region=
 which
> something an actual pci hw can implement.
>=20
> okay so.. in fact it turns out existing hardware is not really happy to e=
mulate
> legacy. it does not really fit that well.
> so maybe we should stop propagating the legacy interface to modern hardwa=
re
> then.
It is not about current hw, utilize what hw has to offer and utilize what s=
w has to offer.
The key efficiency is coming by reusing what 1.x has already to offer.

> Add the legacy net header size feature and be done with it.
Hypervisor need to mediate and participate in all life cycle of the device.

One wants to run the block device too. Current proposal with other changes =
we discussed cover wider case.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

