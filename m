Return-Path: <virtio-dev-return-12737-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F692C77B7F
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:30:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 702153357C
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:30:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 636799865C9
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:30:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 54A779862F6; Tue, 16 May 2023 21:30:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 37E959862F7;
	Tue, 16 May 2023 21:30:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T19dUArnnq7GO/Qt6oso0wQOyzmYM6aPvvVwCIvs8H0m366CpylhKfIh3+wcsU+Vldfpkf6Dh1uZwQ3Hjr5kTexVNUF6QueNwblSE671EhsdGOvLGHdvapX7wOHR1vpmzPdBfHZ9C+XNijUgbz8TNtXmtd1IypZNMzOQ2pqKh0P6rPscPh4vDoJ6r+Bp8OpSgVF84L1GgUe2+ogZjAvwhZTx896Q4qnKDYkUu/aBp/0QcPLyNXkxyp1OIfpI7B+MBcVqB0dQn1M+JNfnOW2b15IHoUyAOX4ykWV0iUnL3VllC+XoGjEv9CMwtK4ccWz9XRTcR9GUfHoFbFlRLwthhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTSEoWMNQqJLSvvZE1CcRfuouTskUytQF9NVrZlNRco=;
 b=HhEAS339j+a/dEtavkZ46pzgkxyf3dowmmQ77z0G7dZZZHFhvycVEBFPyTm58DjDI72OypuwDev0w+t4CuCM2ExmmPvrs+YBkiXN2ooSfy0YaileC2ns9OS9eprQTk+aCCera3pz+kN51bLdtDz0+QOIhdj5cU//xff2QxQOXCC+Ysms118jeejd5ist8LiPIqBtQ8zjXPlxd9z1sFnWt6aYu9VsbP19Fit2rsBjzkUmcsAZznDsYSyYykd3zplKYIa9vMpDtWPbCjiqNJpplgNRJ8ycbIkNS9/xrFCfvyuSukXB3V2G6CjKuqdCDvcFKZGvqq9DJ9PGNRGzG4mlWg==
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
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgAAP1ICAAAu1gIABh4gAgABhyYCAAABooIAF7m6AgACLkzCAAPN2gIAA1fCggAAe9ICAAASUYIAAAmSAgAAAkBA=
Date: Tue, 16 May 2023 21:30:01 +0000
Message-ID:
 <PH0PR12MB54818B399F5950FA2FF81387DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <20230511085205-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812F2EFEC7B6A235953A82DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0f75a142-71e9-676a-11ae-a54e6dbb472d@redhat.com>
 <PH0PR12MB548136C3582B9DE232AEFDE5DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516021401-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816BF1E277820C594A6344DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516165509-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EE9429669D53FA8E77AADC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516171940-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230516171940-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB8245:EE_
x-ms-office365-filtering-correlation-id: 63abde63-e2c4-4391-8171-08db5654b515
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LYpkLLm2OPawlZ+1OIFEZiB28NGA25nImqyS4k0Tk6zKBIGCDAlVfCyBEtHErZI5XP2Amq2l579xhPB1EP5ZUCPh2x0JWjlRZlkbCErDJyqOznS4o1cp3+7bfdmsYExa7QEkuX2/tgLH5jI5a4pFWbrvMQre1ch/sBtugdvp5WGekZeMUlZdHOQX0oPJdyDRu2eyDlUfQMuHBOTv1LT/dpJlnhq/uHxBKwDmhBusGzLqjKMBc9WITh/DZuiI8mfAyeSkAkeOgBmjrjCokTYO42NlM2XFxv5JtsirusS4s7NV4b19XMyoo1QHGemTW5rzLw6o/sajTfQW6vRBESPx04xIq2jh/kSmqjkMAXH/78KqODKDzsb690OH0e+xHxKfTQJW4WMUKMEydqBg3u06uTX59Wql4gzjVmR3W6WaQUwdCXF2Qc50vIw8FCk9aPjpCvUoPBEExFkZOcSNJxbpaWaXUp4+w77EEezGKZLYWJ0dYUSHxRIASvCC3pCLlZ3JyJIH9/7v8f2geDby76Iyg3dFKxHQq+4cLpiV9ebjW4bdkgr1l1p++b8sm4GpqUd2V5sZ6uPJIIXRuwogw6uc7UmXBqLwbDTD/52S66VqP0bsjctdvJ0SexJLjRjm2FlA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(71200400001)(26005)(41300700001)(55016003)(122000001)(38100700002)(186003)(107886003)(6506007)(9686003)(83380400001)(8676002)(33656002)(2906002)(8936002)(5660300002)(52536014)(66946007)(64756008)(66556008)(7696005)(76116006)(38070700005)(66446008)(66476007)(86362001)(4326008)(316002)(54906003)(6916009)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+lgSmEvISU3mNh5KK1AN1jd3E3dcUfe/mZ+ZEGS5zoBTbUA5FxyeS7gMvUXV?=
 =?us-ascii?Q?E0CdqyfPJ/bAVwhdnUPbbm31m5RuCKZRVn4nu4sIvJhsQX7tBrnZY8EDSsvk?=
 =?us-ascii?Q?uSvqD76CTvymQTZxZrKse0P4pCixRWbhDcgATwzp/2Umg4e633GTKkYAH3wD?=
 =?us-ascii?Q?J4cKXpGD9vhX5CjcD8A7FnBxPZhLYuWUTHVZb071zRkUiBg+c0bWiesEaiX4?=
 =?us-ascii?Q?PzO71FSSdXEx3wjNTDdOVeEZ9+LBE0jJW5mvGXo1egl59XP2bljPF181dQUl?=
 =?us-ascii?Q?eEdmpl/m+nV1OwjzTs+3xaDvS8SgeK8bEIP/8yFB+xrV6dF9j1KowfIYynuK?=
 =?us-ascii?Q?+gN0vEyx86NaIL4jMpJYcDQOtmXvaTZYCZp9zpS1CyYTyR7GBNOHKNffZvpT?=
 =?us-ascii?Q?7PyGoSMgXpRmw1kVqNPLMXwjKf6tYTUM36hQmg4vtkSn8SO3BlVkFkEfURwT?=
 =?us-ascii?Q?ndWsckwvknc2uwqIWMOSCCrzBihyPQK6KN/7WA79xPGZP4DldpYvD2ZJhBGn?=
 =?us-ascii?Q?o8Bg8LuvybidKNa4ocUkAeF3tIZwM8rWw6RiLHwr4B036l5DVp5/D+P8SxhL?=
 =?us-ascii?Q?IE/JLX8LgORDlrzCZm7A1ZV/9VXY+oCt0EHjnfzb8BCkF9W8x/xkRBhMk0IZ?=
 =?us-ascii?Q?aua0V7NmHWozzvcsjg8eZaOVtYHnc5yFXAtrucDtDR1aitvOaJgAoqFGEO44?=
 =?us-ascii?Q?7w9wdS6v79sotdcQ7vW7JnwoqZxhj58RRabmLGnutx/X5upATaah2Aj8TFvP?=
 =?us-ascii?Q?1Ra7+ghGpGDrwh2Qc3smU82MEd67UJeNO8IJBTwn3AA29/U0zCW50HwGoqg3?=
 =?us-ascii?Q?FxpXjZc55hDv2lRQcPrIio2gESo0tTo1o5h0ltCkUz5QbHjiCYJo4rBnhk5E?=
 =?us-ascii?Q?bruNM79YXsC23hmD++Y8YPyp0XAFr0paz9HebdeqGqi2OXmTQkZIRUQ+sG51?=
 =?us-ascii?Q?H05jbcS9nzNIU0/GD6jk8H9qaoS4MMljDSKV7AyihAD23b8Fj//R+b2fTL0x?=
 =?us-ascii?Q?HqSQvmxls8q0GxzPKyEWCh27EKFpxt/LT/I9w/twQ7gc+4FZlr7HO2njg4hP?=
 =?us-ascii?Q?qiIVV7PhBLkG/ALalcE2N6SoXerg4UG9j0Ou7K6/yjzvPcH2Qm7b27cGeyAX?=
 =?us-ascii?Q?Okp26NrmCfkB5DAlU27OpO0l1DCLFjSPTjWk9Ety1C4BCjx/6dGzveC1skr9?=
 =?us-ascii?Q?McTGvNK0J8FqwEdGvbS+fFZ0DEPuEgSbaaVPDtqhNU39VMa+hL7TxyONSvPi?=
 =?us-ascii?Q?eXw3WoILu6V3nTtDCuveTq0m857WGJTq/zwCiuC6x2WIEVlQUUMbj4DDo1An?=
 =?us-ascii?Q?0fJuwhxjaFqO4CYtu2wmDSZ8eYh/tXeRL2gvx4eQQxqyL0QRKcfEjd2Jo8k/?=
 =?us-ascii?Q?bSfPGfqHM8gUUqLNWRq/obLZTfGml3J6LV+HclNNxuTzcjZDqzkF9BJAqprr?=
 =?us-ascii?Q?6waiX9XZ3r1SLk1WybFKw4druBO+mm6cXY3wrIf9drorTte9BIm810yXkU3F?=
 =?us-ascii?Q?n669MBHnzDnD0g0UUY00LtPvNjr6wS3Ov4fFNbLVN/9CPxfgkX0yXnjx50y4?=
 =?us-ascii?Q?yDIQ1JvrUGlfP6xWdss=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63abde63-e2c4-4391-8171-08db5654b515
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 21:30:01.8293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bMjKtB3gdm8LxrRmK8G3tiElaon67Pp8f77mwxtdOzZIvV0JW8uZYwqWNMiXnYrjpDR8LRo6OlUCXcWCUj4HeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, May 16, 2023 5:23 PM
>=20
> On Tue, May 16, 2023 at 09:19:02PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, May 16, 2023 4:58 PM
> >
> > > > > Let me give you an example. I feel that device specific config
> > > > > should allow arbitrary length accesses so that e.g.
> > > > > mac can be read and written atomically.
> > > > >
> > > > > On the other hand, this is not the case for common config.
> > > > >
> > > > Why is this not the case with common config?
> > > > Spec snippet: "When using the legacy interface the driver MAY
> > > > access the device-specific configuration region using any width acc=
esses"
> > >
> > > I mean, what you said above exactly?
> > > device-specific configuration excludes common config.
> > >
> > >
> > So, what prevents the device to fail AQ command with the error code whe=
n
> alignment/width/size is not right?
>=20
> Nothing but you then need to specify what is and what isn't right.
>=20
It follows the existing legacy interface section, you asked to not duplicat=
e it.

>=20
> > > > > I feel we do not need to allow e.g. access to both common config
> > > > > and device specific one in a single operation, that is just messy=
.
> > > > It is just an offset and value.
> > > > What part bothers you?
> > >
> > > E.g. that it can cross the coundary between common and device config.
> > >
> > This is the legacy transport.
> >
> > > Look we didn't build modern because we wanted to make work, we did
> > > because legacy is broken.  So either let legacy die already or let's
> > > build a sane interface to emulate it please.
> > Almost everyone building virtio device would prefer for legacy to die.
> > I am still trying to understand that why bisecting register definition =
of legacy
> makes it sane.
>=20
> Because legacy common config is very evil, do not copy it.
> Legacy device config is only bad in minor tolerable ways.
>=20
It is not used outside of the legacy interface.

The point is guest driver will follow certain config write/read pattern.
Hypervisor has no way to fail it.
So what do you expect hypervisor to do on undesired sequence?
Do you propose to correct it and send it to device?
And if so, the intention is building sane device for legacy interface? If t=
hat is the intention, sound fine.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

