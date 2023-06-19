Return-Path: <virtio-dev-return-12976-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD400EB64D9
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:26:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 21B4D71C8E
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:26:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A0989865C8
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:26:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0EC269863BD; Mon, 19 Jun 2023 17:26:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F0DC39863A9;
	Mon, 19 Jun 2023 17:26:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbDwPyuGnzKAGohQDKSd/Vplu6DzGyZQb7xYrKUlEbgGf6Mgbm7bARe8mD2Jbh47M/0+H7mCmUhCF++NZGcfC/sEGZ0/8a2k5GiqUxPqF0Ybdlus42KByuaAhO16cBI5JJva92EmZTdG8rWWw54v6bZvp5whozMK00bQA7aTYqPYatB56SHndenFHNI4K5quUfIAkia69ZjnUdgeADsZoxPVxaTDQfLM2uwJkFhVEDVdDR7iJ+ya0cim+t5zJiIuBl+m5gpP+a6WObJy1HfGyBZGmYRaNSjBDKsVNp+QjK2RrBGUWtwxyIucNvizB5bDRq1Xfbw2BBbQibRq0nLGcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aG35I3AucH9WHV+0siFJQEsorVhPSumTEXEpaaO4Wv0=;
 b=R2cSGk0qGzE8hBjQRlv0ekG32Xutyn+FCUtwzBzsoCGDkg5tZyIwxTt4GTVsd+guEUapt42OYhpZa4egGg+S0ZGd2EECoFgtbvcD0VItG5ZbcqSeOQ8YdZKAJ2xP6/DSvpMTYY96+vNk4fjQnFE+JBCDBZOJOeKeUjCjLsiqCCzNOS0gPuwTcHAYP7KrXsesIOUC1+HbsNxt9pGt6iCjxOOMz6Jj1VzRXhM0ZjQF9ep7zNX4o0EinXayiH6SFx5BabTt+KFOTH/x9+dp4Wmm+Flds47iWD3qahKy9GIjp6A7hxLqgUFf/SmuC+a5/N/9lB3OQmHAsIljm6ovBNWm+w==
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
Thread-Topic: [PATCH v6 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index: AQHZnhzOtKzAnSMZqEmlUO1lSJmuDq+SXH+AgAAALsCAAAuagIAAARvw
Date: Mon, 19 Jun 2023 17:26:22 +0000
Message-ID:
 <PH0PR12MB5481D1836A5B9A7B345A20A8DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619122836-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481758B8EE080750D6377C0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619131115-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230619131115-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB7255:EE_
x-ms-office365-filtering-correlation-id: ea9a1644-a715-4fec-274d-08db70ea4d7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IrfmYobcqDVSVl5dVAFtsE+0iq4eiZYPspSGBMWVLB13fEmeOncm0iXu3fklnMtP5I/nIciJtMiuYsSRgbZArW5WusaM08kzI3DJf2B9sQFBZrOusvQOO7O0fp0oDC7c4QkqLgnTgbjwwgmZbXF0BXD157WncAlrb3jZilkERstEMgYmeNGT6HuyyxogUWaLSlCG21XojTDOhH8T7JaEgKBJP89ScLn2lQaxj9x+y7bicPJC/Ef9SNGrapkOjuhqt/5XtHue4wRyBHZjqZUg8oIwxOrjMWCt2XS+Vz8EzZtt5zRBodYEK+TPlT4UZMKpEQoQhWJgZUpgzvM0l9feCEBxs3sktBNZDcW0YTI7CxEek5rZwisbb8Q6nS71wlvw+Q1FQpeXv4i/jGuqXjaBZEHMpYROXetC74irEGCkXRg2hP4tWMMpJDa6hjxyFI8PrxXnljcodI/xbTtoH0v3z0JcA0UzYBns+Z8ILX5jTLKpiwHzrtMy/4NnQHGxkYMA60tFT/yqqe6E2/LcEQsZhMXOmNFgYwlzWHph2v/sI2X9JcRIiyr6NorQRMj78dIgorNU2BLRxtYlXdLmLF15+dY/dmEC3McdjBVIdK5WersbSYbIfT7qb/yrJpn9bS0e
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199021)(66946007)(8936002)(8676002)(66556008)(64756008)(76116006)(66446008)(66476007)(107886003)(38070700005)(26005)(186003)(6506007)(9686003)(52536014)(41300700001)(38100700002)(5660300002)(4326008)(6916009)(316002)(54906003)(7696005)(55016003)(478600001)(2906002)(4744005)(33656002)(122000001)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4OQvbWhw6+c25/AFkeU0Yq/k4wyxh23xIIyt5d8r3ZZKKkdCc0AvZgZmpGic?=
 =?us-ascii?Q?WmSmvyA9q+s/0PW39/ShEbExjpwyIGonmksjMeFfimzX0IqxnUuotqYL3NPt?=
 =?us-ascii?Q?ogUtmG33EhbTVBNxVnsPPfGe688KS1SQHCkKAjbtI1Ji78tSteON1xk7pBk+?=
 =?us-ascii?Q?QMaZHXTo6LcI7M/1UvpvruZFE2aAsE9b/hXGYTDERtK8LIeVm4YS33/dEFOp?=
 =?us-ascii?Q?4eEfjd9HONGI3Nj5hnTGQYYCzo2XWde8/rxaXi1mJJ0wWNPEQYPEtTh4yAYC?=
 =?us-ascii?Q?4nV0Y4M+XUoW4RD+9oonBXbpEUxt5ZUwDaJea2CrbfFOwDOXszCjlFmQSaau?=
 =?us-ascii?Q?ue8ELWqB2Fs+UkrmbC0LFRq95YrZTqBCO0FrJ8GDyQY8GThA0BNyFG6yo8F9?=
 =?us-ascii?Q?tzeITF4BJDygcKcnOD0t55+nbVcj9VQXgj8yr0HCZtBjeHv44HxG7rxA1IFM?=
 =?us-ascii?Q?n2OtXtMrQ+3zGpUdnUcs7zbFZ+m1Ckfj4HNAgOEFV95ZAOIuucIhtOXhauiJ?=
 =?us-ascii?Q?rZWcPQcIqCZATjBLr9+4p3Jb3gtD+QYTh9p81+7kRMlTPgULGZzcg2cqjs7p?=
 =?us-ascii?Q?7edsneR/lH43vTnYjU49Qf1VppGkJ40ZzhGGnj+FQQ9uSlZQYZsmnLmDW5nm?=
 =?us-ascii?Q?1GwC1qNgJHdSrdJII/p/FbOOKaOvACWYkkbeypFwY+o3bxCMkLMrmwKan2F0?=
 =?us-ascii?Q?l+t1ItROqRN0sIaZH+2sP7I7ixguPgI2iU7MoIl8kEuyMzwG9iDrR5EHwBqo?=
 =?us-ascii?Q?2x2xOTYcyyhgXEUt2Qx0ILhCGbPnf0bHdwnlCjKb0/V/56qnau3MjCOQ5an+?=
 =?us-ascii?Q?bYG8/tugZuPVaiOCRgtRLslR5YGt6KG2jVdgfUs3dNtiQIEABbjrB9OebVHt?=
 =?us-ascii?Q?mrgvU3n3ZhsTfB6Wpaac1RD3ErL2w9nJNY4FtvtbyO/C8hhCUhAy8+SbQUV3?=
 =?us-ascii?Q?7NnELEDT5pPLP1rZcEoabKwOxLYWVIoLnWskxMraRPMMsNx8VyDrykb0yLVO?=
 =?us-ascii?Q?KT/HsaE3diBhlBmFAQ95R0QxUBS4i8Zn2yy3F34bTMkFgLlyrTFxRfMuaO1L?=
 =?us-ascii?Q?6wEPLAiKBL3MD0tIXYVRL36AtOa/9vsW65H/1auvje69Ia72ioq8Y2Zn4BMU?=
 =?us-ascii?Q?QVL3BIrprkxtpHhdx1nIk/+YLdRCgcSW9ADwE+Rqp/rhpxgG/xS6U9OPwTul?=
 =?us-ascii?Q?4hbMHP1lObgf4vcjvJaTEgCb34P4shkOb++rRIlRlzwADycGxy1CPraBnfok?=
 =?us-ascii?Q?Kps0A7w6jRtX6yzkNSEHXfXO10+MklP4f8YK/1KHiEFonFFQTB2AE1k4k73t?=
 =?us-ascii?Q?GNeDEHxlXrHsRRFP7IM6mzv51cAHfAD7DWTPV/y+i5HleNBKPMIJkVmXaYub?=
 =?us-ascii?Q?3xlPkYijuSKkiipL/D7AWAIzSt4Dybr8PH4V16e+fJPLSy1J2hgBmsRX0xQK?=
 =?us-ascii?Q?NIKW68Tk+W0fl+PPRtJ4iwTySt884w+FVeEo8S5Liz7OftbbREuxFprDL9+t?=
 =?us-ascii?Q?Udcjx81X2r9m0Qym7l6wnsVSktaHvVXWA+lkeRGBJcax80iwfcTKaxQG8rxD?=
 =?us-ascii?Q?c5sd1yLrsUm88Ykpj4s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9a1644-a715-4fec-274d-08db70ea4d7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 17:26:22.7158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/qzSc0ufraKllt0iBMVIPvuagH4wPvd9bQNbZd1aNN6Dw17zJoeb0qRkHIlj3G08xghtFzFYJ4WMrlSQlt0dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255
Subject: [virtio-dev] RE: [PATCH v6 4/4] transport-pci: Introduce group legacy group member
 config region access


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, June 19, 2023 1:20 PM

> > It is reused, but it doesnt come for free.
> > Do you want to re-consider AQ notify query command?
> > Or continue as proposed in v6?
>=20
>=20
> If we can't just make it come for free then maybe
> VIRTIO_PCI_CAP_LEGACY_NOTIFY_CFG is better, we can just list the number i=
n
> the common section and then link to the description in the new section.
>
How is it better? It requires burning more bytes.
Is it better because it is self contained?
=20
> I also feel we want ability to have such a capability in the owner too.
> Would prefer including it now though I guess we can add it as an extensio=
n.

Re-opening the past discussion.. amazing. :)

Why? How is it different and better than querying over AQ?
I see the AQ is better than group owner and group member specific cap.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

