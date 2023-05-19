Return-Path: <virtio-dev-return-12764-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F68C77B7A
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 21:03:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DC1821CA249
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 21:03:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2F5A98673E
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 21:03:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C8B4998672F; Fri, 19 May 2023 21:03:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B0E4C986731;
	Fri, 19 May 2023 21:03:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwXFuJKV5XqTLfw1xqsRr/DcD5i55NwPohpHL2rAFsMxdvPf5jAKUww880u4gHm96SvCkOD1gB6qGYU4tcgGgNimJCz0V+QkCbsTVF9ljDSIQX0xYBHLf7ky0KA3xtZzry1KeDhVyLEJG5oyfhMoUM8v012sOS+ijzCuKnyblS3vzj6oUkFbgPzu9gbcEBbuS8W+TqU4vAGZkUEhxVjKMYoc5wPBBBNGn2XQS7pYhhSD+sG58GA5uTDJySKxJ+srD9Z2t9VkpKR99Kg/bdeOFIYIHeywRitrA4QS0p4/K25EHH9d0JbichLoPKZq1z88OAz20ZUAL6KehUb1xikt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V992BwPAGfvVmsPa1E72xVIVytQDJ8Y+695j43YlQCM=;
 b=YbfRK4vUntRzCWVivjodp39FvuTO3tPueZ36EehHDDuvW1yax2EamUqQtgXIhX6gzjV668fzdXysOTkRsQpe2A6BJpqzKK5qpx4DyzaNesOvBFOxXKB8L2j0dTp9WTjsx2GxC7H52ixMLSvJz/Hm8nA45uUTDIS3+WyIPlrRE2JvF7buNsCEE6MD3MRjLP+EYKJXh43fez1SI0NcB5GA5LJI2VmoWIYKW/tZg1Ku1Qgjx8NKo0h71b20nMG9Lf/0ga5dNQqHXvyj1LKTaK4Ru30XjhA/9C5uvQmoDPy7L1TSWnrZqt9FMBZSShvqymCIZhOfXKe1P0JsWx9h+PRjIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [PATCH 08/11] transport-pci: Introduce virtio extended
 capability
Thread-Index: AQHZY1tK9bYi+VUlRk+f1PKXMn2Qra9hanaAgADvnFA=
Date: Fri, 19 May 2023 21:02:58 +0000
Message-ID:
 <PH0PR12MB5481E912A8CDE621DF4344DEDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <20230519020737-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230519020737-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6650:EE_
x-ms-office365-filtering-correlation-id: 1288a9ac-6632-4b0c-5d45-08db58ac6ca1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BacEslM/oVdh0Kl8II0NPLQ7lEQ9enYEW++shiAHrDnTIBGnD6MR6iaCDwbJo3tdZNnu1+4QYdEloyyFIypIH9f/ilNrTi2TWXnK6cPoZ4BDap9mfc/oYw5B43ofT/Oz6HumRkt3+lJkr49kgDALQRpuVA56ihpuCYVqpf5No/nt+/41EonztKgkl9FJFnZspBjaqGxGNmyO6ubVs1P8eh3pv8VxuesHkgPmv1xs0TYOk2mQ1Hck5KO1MyxW9gAVe250RwXYpmXkkRUMeicLDkIoIRdOXzDfQ14/L11y3e8VbjF0obCGlJ9+gdfORDC50soiX8EbuEUjAb7Dca8qMfklIm4ihsKm27ThmPAsqRpJQG8kY6WQScPo4zSsviRoiG0h1IXSieGJwXnBzAbeCDaRPV4/bX5f2QMwcoW24oghwaV3BoUDSKUZuNlWBTNWYRU2jIGdwlehI0ZBrySJ/W7kUfXuVJE9a9n7cS0llROU6VwJ8/6tFjt/4xk0OYAGeE+nXw1Q9JMagrgo/Xi4J6vBd98IkswQ6RaXOVA2ynu8W9SmtbQTNPM650hs0xFaLi5COg57gRD65A6+mZsTJU3XL91xg01acXHQen29srMgMwu5JtGDNIlJ/sxndNMa
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(76116006)(33656002)(38070700005)(7696005)(66446008)(64756008)(6916009)(316002)(4326008)(478600001)(66556008)(66946007)(66476007)(54906003)(8676002)(4744005)(8936002)(5660300002)(2906002)(55016003)(52536014)(122000001)(41300700001)(38100700002)(6506007)(186003)(71200400001)(9686003)(26005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c0X7Gzla8kDMX6WbEzjVJjSAj9K0xC8HUiGegwoceoFWiCVfejv2jwUr4KK+?=
 =?us-ascii?Q?zPibhTbZnEHJLvpoBhH5JZpnXsqH66ZeifUEvZApwZqAGcCj76oBOKOJO4Mv?=
 =?us-ascii?Q?2vpx4lOffU1RC7qL1zCSpZ83AvUdW6kDEhkD6i8lHCRxPHGoBSTXpSBWXd59?=
 =?us-ascii?Q?3N/2caz3Cl5U1KY9+QcYMM73Gab3x8qd+2wbH2oQygHqrB/lJbzya51sJAI5?=
 =?us-ascii?Q?JWJZfv9SuoDqTYd6P+5ZajsSldKnAsiiQGJNHx4QniPBMBpMFnxQJHlZ6fdu?=
 =?us-ascii?Q?Tt4fhw61HxUORTo6vNtuwzZpFnSIldXc/nAknNmo6eiOM9VV68bZjWA88spJ?=
 =?us-ascii?Q?uT2gXZ1EvCaMuTDSpPNxGu/dYuCzHsEhUJUvFPX9UcT3VdbN8RDwXRi2qj4R?=
 =?us-ascii?Q?ICs6iQa0Xhrq5SawXJZ2wrXfuK/K2xIvEWXZ2XgJNKdzJMklzbI9Bbg4vQZ8?=
 =?us-ascii?Q?9TBGc+VcdqyC0/0/KXknOleNtpg4mYFE+WjRhSZJwMU/+9XsjS6ArUNl7Kdt?=
 =?us-ascii?Q?iHAjJP+LQrg3dzk9hXKISjphQsMsQ/FCk0cEh1OWqvl1OWnpP5CmyuPIpx1M?=
 =?us-ascii?Q?kv3dtBd6eme1ddbZ5wpkPU2mfGdVkV8/3yEJobqDcn4muYbJQu625fX2A9WF?=
 =?us-ascii?Q?IwiCpEPW2sIbfH6ijZDIVLZTBug4CQM5sbqpLGV1xvKPoF3EY2NY6vfdGjqk?=
 =?us-ascii?Q?5NzKo1nSuIMahPcvBNlNuUFNdIX63xUt51skUV1ahCGXa3/Qe/7UIMIsjV4A?=
 =?us-ascii?Q?F3QcdqQJdwSz45Yt52B9fyK+PL7UpXnqhxW7DfK9PMAPHKhtNZbggehp9oiz?=
 =?us-ascii?Q?Lkv302cEN+5MCcg2CtGDv536PXVDz8T7aBSbU8fgI9cEPZUndrKKsMhvNftn?=
 =?us-ascii?Q?sH9kDJkqcA0rkd9s9XtD5zQFzE7+wEJggcxJX7EUKuiUEaowlAnRjjaAUTLU?=
 =?us-ascii?Q?+Px6bPS/fLQuBRoGSze5VuI0cbaBuwFCPR6yCmtACuavoINvbdxETFgaxCOR?=
 =?us-ascii?Q?l+UsE1p/73iXRe75bAE+U4uRILtqyAjJZUlMfUzSI2o6uQIXQcN0v9Kw8nfy?=
 =?us-ascii?Q?qh+8Pc5IFsKy2my7FIeOTk6CBXqi4ibUR+etY2SerIwJsLESXgBY8kPNTZ0y?=
 =?us-ascii?Q?mWKeokJwkCpN9MOqtn4Vf/GRwUMJ2PzsrssrD5hmi8ebzieT17pLJZ2a5L/k?=
 =?us-ascii?Q?VmG9Pz4iOqGq1qwsCnDwvmUVQxllzMHfzGdUaW8GkDXRdlZ0ErL0rq8zU9o+?=
 =?us-ascii?Q?iBIuds3Y6qX37GSRUgveQwKt4YFYCAxcUu4VoOUK/iavi6NmZxeOQe3olDmh?=
 =?us-ascii?Q?PeqQvdnvysEr/c3SBILSeyPizMW7J664LS9pZGuODqmrTaqTAsUqX/xHF2Ql?=
 =?us-ascii?Q?XXdIXdsBxytFETVbFOsYXnBnntkjMcUCA/cmPIcyzQ18DAT24W4x4qNoD7WA?=
 =?us-ascii?Q?h8THLoY9o4xkq780Ze4sw+LYBmUvOCkj0+RGPhcL78A6zMu5HrhfMsuf2RzR?=
 =?us-ascii?Q?LtzSUpimQH9QqNFbbp4vXfWwAK7GLefEfpBGWbF4jP4C5wKEbhkf45pw7Iw1?=
 =?us-ascii?Q?8B5nE1nMY/N9H56zqzM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1288a9ac-6632-4b0c-5d45-08db58ac6ca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 21:02:58.2820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: foAOfHell/XPWfmefKFo2aQlOQvlr185Lz4O2OSg2ds3DRK8vawvNJMUVnhF6WcSEn/hFl8mb8kVBfjKQ0enxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
Subject: [virtio-dev] RE: [PATCH 08/11] transport-pci: Introduce virtio extended capability

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, May 19, 2023 2:10 AM
>=20
> So looking at this in isolation, it probably warrants an extra github iss=
ue. So I
> would like to find out whether we should introduce this capability and sw=
itch to
> it for new devices.
>=20
> My main question is whether e.g. seabios will be able to use it.
> Could you take a look at the source and let us all know?
>=20
Existing unmodified seabios cannot use it because it is not looking at the =
new offset and cap_id.
But that is the case with any existing software, not just seabios.

New capability is in addition to the existing one.
And code already exists to refer to the old one, so I am not seeing any gai=
n to create them now.
Any new capability that one creates in the future can be in the extended ar=
ea.

You mentioned a perf angle that it takes half the time, but I don't see how=
 as the only change between legacy and ext is: offset.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

