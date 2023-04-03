Return-Path: <virtio-dev-return-11928-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9E5C77B62
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 19:50:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CEB852AC5B
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 19:50:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 56A54986640
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 19:50:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CC6CE9863E6; Mon,  3 Apr 2023 19:50:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 979469863E5;
	Mon,  3 Apr 2023 19:48:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nahsofFFwH3TEk/5Z6PgivSe13Cl7o+IAOr/NS3WVt/86hSs6hKMZ/Cn2u2RVZstgShQFLaTrJoB5zCDPn/FWEUQr6WLZdDmsIpvwurV3Y4Z0uGudOELdJwOttL89ItjyAwfHgeUmuU84ILLDjbHGC+/2zg/PJAT4poKKedM1G6LaXXx0/2perzVCEC945jDcW2DSTJmu3PQRMlTP9X5MjzT4FpjI1DoKQCE9r+rA9P2BLNrJXsLOU8f+6Ze/fCBl71T88xxuyX82fPYDelU1PBjJt4FEF6J2IgSvzg8Jk7onja4H0uWKMq0ZAoNyqPgKPy0brpztGF8hWpsTxt7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJ/5JAl4iHbyfBzhPi+6P0mG28NI6aeZ0mbTCupubII=;
 b=BWUN613lZgPn2tkNPl3D0yI9y0AEGiJqnXGdX7+hOx3HJfXPYzVyv9SpPdwpAuiVWuVIi/Qggl6spkvhgsK90hABW587np5n/AhKgSqEZrO92XaWmBygf5OpGqi4TEhIxUh3IvAGinQJHb6jWcZEsbW1w4eg1TqP5i/iBYmy3owXH1FAopTuY7Yr8HmQUDhd0I2/ZdzaN1IrgPDVd0bZrhd0WCjaC90Xc+Sgy8BACo1F7j/VSEf+zxF0gpYs0vF+gvsLAk0uKQVEScm/Dy4IN0w6qqChPFL0YTt+gCUiKLeI5p72D4qx5CVTqFrgiu2wYtamBBH/wU3UIGVHCZgSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH 00/11] Introduce transitional mmr pci
 device
Thread-Index: AQHZY1tF5ObSeHDFk0eWHj0gIzL7fK8ZryCAgABed4D//9TGAIAAINwQ
Date: Mon, 3 Apr 2023 19:48:56 +0000
Message-ID:
 <PH0PR12MB54811F46C61C499621DB5563DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230403144523.GC302168@fedora>
 <46a0db06-f922-2a8a-acf0-cf7e453a2945@nvidia.com>
 <20230403134407-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230403134407-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7884:EE_
x-ms-office365-filtering-correlation-id: b8d83b23-5126-4f80-3cfa-08db347c766a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 guS/CW3+6QxNySWFQcyGoU5xOuaqL76DM70zVrS/+xDXieR8Bv4MVepxbTLgJVvR1VcpvuAXmEmq4Em0RzJPGTFTgj9znYgJPCYXbc5T3at5Lb+c7Q0gAjw9nWR5q5bgmwv916iWcYUFYBzu/Wd6cVqwocTUKdt1HzYbgq/KlTWOKG05j3l5WGXjyzJJe0I38eAoN+Lr4ibGRSCjsXcYrpX6cH7QWFOGj9K41TiZL88dswa4WxNdmSQD6e0/IezCC5Wnc03pdi5Dum+k0DsMQ1LG4I3qxrYCpyCYyG8IOzSTaBI0Sf5uUlzbq5xl4n7khwmL90oF4wPD2yF7XsgcjZQ4p98j9wMOYxkrz5q51QlFo/DutadhN9MT203fixHbi4zuiCzqHam2qN1fWnwZa2C/6PLLQgGXEt9JW9XhlP9Z6QeBGqgQJ/3MmaRPVcWiU4u9RIbc2v+Zxww3XW/9vXob8ssCfUrEv7q5ugT+FxWbrp4SCGExi4jfGwLFFwbvKvEal1hiwR7cnL/H+DLisalG/+JOgD3McZ09Nml1n7pBXzPEBBnPd5Vf9O8wbwmH6+lT1/d63W98DBhxNNQ/fGhrqAh/Fx0YJCIeCO3sJzY5TIdBmBxbdDife7+jgT2e
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199021)(5660300002)(86362001)(186003)(83380400001)(107886003)(122000001)(9686003)(26005)(6506007)(38100700002)(38070700005)(8936002)(52536014)(64756008)(66556008)(8676002)(66446008)(6916009)(71200400001)(33656002)(478600001)(54906003)(66946007)(7696005)(66476007)(55016003)(4326008)(76116006)(316002)(41300700001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LT6csLQmT9qNIgGZFF7cp6J0wSGskHGRE74qowbp+b4mcdb6yjf6oDQ5FjZJ?=
 =?us-ascii?Q?QbCFjpg3SXhkJfHRC/OnKqpdp8I4eoaP8l9hr6iSfqO4D2YTGvLieHZIxkWo?=
 =?us-ascii?Q?Lry2IaVcBS1Y3HEwTutyyEbT/J5XBYS3Wqrsx6lDAS50qQC6lgEN3D+ShHHU?=
 =?us-ascii?Q?xeIj+7ZoSUVxXh7TU3IzDjT9howlldZ6XM7aGKUMUhCKMi97fzGU2jhCh8s9?=
 =?us-ascii?Q?fXPVeSBwmFsfYH8P/4TQGJKyWyqQx6gOlzU695k+BHtgH9jozbDAS3dXzVjk?=
 =?us-ascii?Q?tJq37LUaDSdLhu91l8s+dlj0FWMwFjhR5wEG0DMAQaDu8coWxBO3W4wTgHT/?=
 =?us-ascii?Q?l2w7C9NUAiADb7gHOIaVxs9acgIy3Enz6Y0H/sOzS+tHBZnyYDso/R0PZttY?=
 =?us-ascii?Q?Fc3/XgsToTKr78NT9btdy0AJRF/5UEfTgw12hHjlrtotEyscUbP3KL2qKVmU?=
 =?us-ascii?Q?N+zAeTTd2GjYYSHb6fNz6L+tKADfgthEzkQbstlyXyGQRyOGv+PgkEo/ydTI?=
 =?us-ascii?Q?+0z0bYISI4P6vxcqgYqK6STNF6F0GReVii0NVrPnYOrTdY4CUJGPNDvrbJ+X?=
 =?us-ascii?Q?rJbzJ/Iulz1QLAe61PZxQGIdOdVqZXjKrft/QDM38EGWNq2kabZYbQ219G3l?=
 =?us-ascii?Q?3LYJSGIgCa1jeNfQmKaMUIDHfR5oGEC0wTpINyMZyIa8BCRGpGExKc2ViV97?=
 =?us-ascii?Q?peugqcNviqpGYGVlayf+J4aB/utqK/PiG1jcprRYROu/nTK5dpY1xGGImRm5?=
 =?us-ascii?Q?Z9UdNm1laIm0Bb8MydtyTxegwGFpr8MYEPrVN1yESXtN/JoFjtJw5q9Z8iGL?=
 =?us-ascii?Q?IV17wFUWSoROmZFLle7l2yKd/+JN1Kh90Q13VMxZIEIMrJh3Soj9wuTQttoL?=
 =?us-ascii?Q?p8iQ+5uNyOwXIHcsN5kZxCUXutBcyhYQ8Ev8pnfx8KioN8BaLRSk2qIIgSXu?=
 =?us-ascii?Q?NF5+ZxeUOCePWIt6QFYybhvQddWO8OPgR0H9pcnrP0qOUKAy5J/PwCDvyS7t?=
 =?us-ascii?Q?o6+UepbyS3NxLmk7Ew84Hd2rdz1K6h4mSE7d4gjnBXcwNL44RNe74tA49BNz?=
 =?us-ascii?Q?9169RUgoq/eqR+6OWHw79kjYwo1e5wbME+VJ/BrwMnw/DNwxw7OlRUN/I+n2?=
 =?us-ascii?Q?9xfgcPkPLb6YAA0O9ubcP7q7D1HM/CWRVl6DUEVv03SdhGmdvVq6yP807plD?=
 =?us-ascii?Q?rEQsHfFxnfGNxRKom9IieEiMdYYwEn6D4RBsOUDMlvXLbR8aaim5VIHoDx3O?=
 =?us-ascii?Q?s48OjuEdcTWdtSjkD7b1TjOtTDBUKsfZROpf2rdbdJaYFr3qsvAftVlCozew?=
 =?us-ascii?Q?PNe3YvgvX+aUJdXoKo/QPJu5N5UxQYuahdLjWSylC/ispnrJEudLiQbM2dLh?=
 =?us-ascii?Q?g2MnEpfh1eaJV4qs5cp/tTA7iRdNFu5oquLqAelGgH15Mgty1MAMMmzZ96XR?=
 =?us-ascii?Q?K5dbSIcePTKsHvjRt2o7TNJ/GLZbfcDqR7OfAhLKELChX/HzfLX2ldczpVPh?=
 =?us-ascii?Q?c7M2CdX/+T1IE0RiXWE58tdyJ44vWclsfUXIuWdsrH9/IFNEO33WLJ7fuXtd?=
 =?us-ascii?Q?G2KLdF4nzo+Q2mqFXtU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d83b23-5126-4f80-3cfa-08db347c766a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 19:48:57.0065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+k1JkIh3ed2w6iAO2EB9lydnXlJ4fY9KNakReWMlx0rOnXmgLDTPL/Kzp/WQbiknjEjYBZ5k6VWrXTXFWGnXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 00/11] Introduce transitional mmr pci
 device



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 3, 2023 1:49 PM

> > Yes, but hypervisor is not involved in any configuration parsing or
> > anything of that nature.
> > It is only a passthrough fowarder from emulated IOBAR to memory mapped
> > legacy registers.
> > In other words, hypervisor do not care for the registers content at all=
.
>=20
> This part I do not see as important. legacy is frozen in time. Implement =
it once
> and you are done. Datapath differences are more important.
>
=20
> > > In other words, the guest doesn't know about Transitional MMR and
> > > does not need any code changes.
> > >
> > > > 3. A hypervisor system prefers to have single stack regardless of
> > > >     virtio device type (net/blk) and be future compatible with a
> > > >     single vfio stack using SR-IOV or other scalable device
> > > >     virtualization technology to map PCI devices to the guest VM.
> > > >     (as transitional or otherwise)
> > >
> > > What does this paragraph mean?
> > >
> > It means regardless of a VF being transitional MMR VF or 1.x VF
> > without any MMR extensions, there is single vfio virtio driver
> > handling both type of devices to map to the guest VM.
>=20
> I don't think this can be vfio. You need a host layer translating things =
such as
> device ID etc.
>
vfio layer does it.

=20
> > >
> > > Modern devices were added to Linux in 2014 and support SR-IOV.
> >
> > > Why is it
> > > important to support Transitional (which really means Legacy
> > > devices, otherwise Modern devices would be sufficient)?
> > >
> > To support guest VMs which only understand legacy devices and
> > unfortunately they are still in much wider use by the users.
>=20
> OK but supporting them with a passthrough driver such as vfio does not se=
em
> that important.
Not sure on what basis you assert it.
I clarified in the cover letter that these are the user level requirements =
to support transitional and non-transitional devices both via single vfio s=
ubsystem.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

