Return-Path: <virtio-dev-return-13290-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB51DEB64DC
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 20:44:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 282D0C6231
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 20:44:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F794986815
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 20:44:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1269B983B4A; Thu,  6 Jul 2023 20:44:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFFC59867B6;
	Thu,  6 Jul 2023 20:43:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZLEOlarLeyeOs4dXp4w+U7sqSX0rRlqBnB0fmnzA5r6XPos7CAJwu5kvMb4OG28bm6q8yTBwElwbu446ozl9opHTXT9NL/vvMlJoGBCpgqcplRg+vyh1L+0dC18RFkOWZ3BnLPLBx6jH6if+SDaTnXqomrzA+pBS45BLLGqN1B2gL8k5bPv/p3sNXNwNloDfsBP+OKiIG9fnUrFEYYxoAnRHZj3ttqxocX9nq7BxvMz/ZS0adVU7oUa007nEu1W07CUQe9DYcYuM5rvYoFkHE544CNIaVe+PrX8qdH/V7mmTe9IEnUnwhKQAUZVlKI2UiG1f2FQVbYUysrDOhD4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akOsUv0KCxv6b7Wpuycp4qxWkTrJMRgMuCS3rr6orHw=;
 b=Rnlcc+y991F7mqYyy6/n/y/2Uk5hgIkQU8pwucHUaiCW98ZrndMWqIMX3im5F1pgwbFih4oxJveMMG78nkdifY6xYsvZT5OODUku1AiMWWWzW1tl1vUZu6i6qNP+0vdq9SzKAFBQF1qpSnkq+yPyeTr9rnpiHzkj2GXl+WFTrHEjhiFgwKq8CJuN/F2AAVJtZ91uvLkMTF1gyiZcWM64tCGYRBEGKq56rtBbNFhrf9pQaTLWqc3cqTbpMK6JaG4opK3rO3h+ZWN+ipZjABPy8OFXapp9GZo/bZXTKxz6MJ0quDClqm8zVLSftos+0LAcuN78AzUSBip5p/OlTknjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index:
 AQHZr8EFxUk4agfAiUezeNF66UoB2q+s7j+AgAAAMsCAAAOkgIAAA7AwgAAKzQCAAACqYIAACE2AgAAAimCAAAs8AIAAAGiwgAAB8QCAAABNUIAADKSAgAAJwvCAAAL+gIAAAHnggAADKYCAAABagA==
Date: Thu, 6 Jul 2023 20:43:51 +0000
Message-ID:
 <PH0PR12MB54814132C3C74F00CD6F399BDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230706135858-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B845ED0FDA919B822941DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706144427-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817A61E0062B9BF3401836DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706145538-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481074A79C630384382CB20DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706154002-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AF3000FFDBA2CBA5D7ADDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706162505-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B7E0DE415B1489818DE9DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706164028-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230706164028-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6202:EE_
x-ms-office365-filtering-correlation-id: e114e34d-69da-4b36-9615-08db7e61b4ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +H2Fo24I4LgpUbyJhB+xs0qkUEbFE7gvjoi53UOIVtCG5BZ78UVYXOonKsP7SYgT+DcNgX9kY5l3Q+Qb2IWylHlnV8v4TuCZJ8TuDiabTAQYCOISQkRKLL/Rw4/vi7VrF0xd4EuRPRpCOnT3lCwAlMfy9xsewwypwktdRMHIzq1iYyl0I8QvOgw3D9/4ttI3lw0500JNIXUtJxp5L+jSwPOU0guJ3YF7UMzfxU37Q8GFSdg/TAK46Ml5H7PfhvpyUoyT3fkhv/SY4fRck68y/eYC2OPH9ORkbQTEoJ1LAWytBT73B/Qed25jC6vHSz9khkCevllIon6JFNGdUGpVl7thUiYV8gDwX0DvHQGzzocLeEZmjLmFpllI7iiMT/pDCTpOVIEbx8XzmfHMED3M/7swKfIPTsUI05CiMUk4FhZtXpYSjv0A46mC4mmDPtEH7eowmoNaNvVz3ft7PqItkM5QNI+OZ2uXrtghOm2lD0n0MmZS0xZt56WDHUcIL6PEj9eLuurKaRJF6vs8zSHaQyT2WQBLC7+uquZraDU85BYOBNj2Izm2zHtSxRwFcFrtCIy2baOsViqiy+Zy6JgcRf8wkizvVyRJ1bEHJHzkoIXg2oqUMz4r/y9bYTEII2tp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(66476007)(66446008)(64756008)(66556008)(6916009)(76116006)(4326008)(107886003)(122000001)(66946007)(186003)(86362001)(38070700005)(9686003)(6506007)(38100700002)(83380400001)(478600001)(33656002)(7696005)(54906003)(55016003)(71200400001)(4744005)(8936002)(41300700001)(8676002)(52536014)(5660300002)(2906002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VeFJ7O9UHyG+VPguCois2zmzB7gj2/HCrzFmRsTkMMxP1eJ+o7s5COND8blK?=
 =?us-ascii?Q?ev1ZhFm8ySqpQ6mYjYL9fFQANpwXVw9EuoyxlmCke1Xp7Jleg5by9ng3JHQG?=
 =?us-ascii?Q?YXgk/MrPgcVjvH98QmXFySc4bvUcEn0fIBc6lk2vHLWOepAOFBRED8TFgavz?=
 =?us-ascii?Q?7D/KD47VPE18zN1HGv9Uu0zQ1gHhH9Nr6CV1FSLYwz7OLJeLX5WVPPa/go5l?=
 =?us-ascii?Q?OEbKvey0bspKfWQuKKiJSN0l68pyVz/lo14ShWRxwjXQDM0gp3XBLJXHbUPB?=
 =?us-ascii?Q?Hm0QnPDBBorCEj9KUSbInUQ+z9f6zwq/dMYwtRXl2MEadTdurshoT6ySm2c2?=
 =?us-ascii?Q?P2bTNRFYw/wA3JUt3jV8UoKUuy3f+yoNkZh3EgKOuImUjSOrV+mOC11eeo+o?=
 =?us-ascii?Q?s66RwLFygERjGqEjf0NsaoGGxGpEpVEXLXEb1JgF17IoNhs5ryUh3LzVjNr5?=
 =?us-ascii?Q?wpCFHfau6fYK7tflEBbECWfFs7oByD5VMki/pG/BWr9jgK53+/LkULS3G9aQ?=
 =?us-ascii?Q?wlsDJ7mtXLm4FPmlxUrjif51aheuXtmH+yfvzr7xU2ZGbJIkeTFAcefmuFnW?=
 =?us-ascii?Q?Epzxv7OVJbadVRqmzbp/PhRRQ2RYjAKb5GkzxcwZ+YTzJiivPlyICt1pbFjS?=
 =?us-ascii?Q?Iz5HDWt8ej5p7GaxH+cj+MzMGFKEp0sVJF4zyfXpb1IdahJz2g2CZz/DfBc/?=
 =?us-ascii?Q?Y4bBKJY5b1MjrzUnOsSNA2AYpd9HdtVREFAjV1IHyUnD2CiDNMb8atoUlopd?=
 =?us-ascii?Q?+K7525cLbeX58clf+9bN+PaiOWcj5wAT9VTWYtbulBBO5yO17+cWMAvEAoqV?=
 =?us-ascii?Q?69segBzxQw13co5HhWSiqNgfFVlilDVpbnejHfTuB6Y9dcpRQ7NKOMj+MEhJ?=
 =?us-ascii?Q?SOF9jNNO4qVemxFAdn0pLR4dfzTDdNLaCCMlWznhnga0Z8L9zPAy+2/LKPUT?=
 =?us-ascii?Q?zeveb9+utWoypOv5nqm/zPQYNryHBOtIABv1kbF+FS0E6Z9hLy0ZgtdqtJNb?=
 =?us-ascii?Q?yz1WGklc9e8tbPi4iHykloPteqfo7hVW+THxtX+JV/5jPfyilgK3quUzhFGH?=
 =?us-ascii?Q?JCcRWT3iJ4En4iaf2G8vMaiDrgIS2q6cp1ltZPPWBxe95uWcD3/gg6Rp5x/v?=
 =?us-ascii?Q?/ZH0xqKaS4whSJ+NRMCxMmgML6q4xMNZRAiofZNderzi/CJslIQAEyoTDvNK?=
 =?us-ascii?Q?HGrhOd0lGQpRu1lne0s39K4nxj4/XrO+P89y8sdwBhiHCNMC6+ft27ik17Ju?=
 =?us-ascii?Q?zsGte/JndAeBfkLVSD8ym2itb0FjfQ2uE6TZ71QfPkeNEFXYeCNN5abtipmA?=
 =?us-ascii?Q?u96RTp+Y4DyvWW/JVesc5FMW4xAyVSFl7vnVhqJD/7kaCCxFKpGk+SxDSfnM?=
 =?us-ascii?Q?07AEZ6tv4Dk1gbbP6QkyB7YwyNNAKj0Nv7OYJoXVon9Ty2s4YxfO0D+Jng4j?=
 =?us-ascii?Q?6qJie8psWnA643f7g/M9Q6f0azbMq6ah0qdJUuaqyLWLqKH7XFdUgfwxIAwZ?=
 =?us-ascii?Q?vO4HiittGkDS1I98w7WVbeqDP4E3GmacbH1F70OpCFQtgjD0mFpyTYHSm3gN?=
 =?us-ascii?Q?khhGDkkTHdzW5GC4F9iZIMgLE+mIFj4LAWWI4Szu4V5ejhwITJquVUBZLPwY?=
 =?us-ascii?Q?L18pAf0W4UjdkPThRX7kvyc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e114e34d-69da-4b36-9615-08db7e61b4ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 20:43:51.1040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKJx4kgSQGTqZI2YU5m+mJ/Jxdrm/4jSOgV7U8hAiljAjCar95TZQrFHsjytHbIWVUYkA8+2Fqgc0w6opHFHzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202
Subject: [virtio-dev] RE: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, July 6, 2023 4:42 PM

[..]
> > Can we please avoid this over engineering?
> > Interface has the doors open for driver to make wise decision depending=
 on
> its environment.
>=20
> what if driver can access both with the same ease? this is the case that =
bothers
> me and I think it's practical since it will be common on linux.

Then Linux can say my preference is order, so it picks member.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

