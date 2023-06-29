Return-Path: <virtio-dev-return-13150-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA24EB64DC
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 12:01:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 16CE21318C3
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 12:01:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0FAD0986703
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 12:01:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 039A09866EB; Thu, 29 Jun 2023 12:01:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E27529865AA;
	Thu, 29 Jun 2023 12:01:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVltJNgFo3wdJozGGJnrfpPPAsjWUcsZBCkv+sLv5AenmEk1Q++FC4ypmxPvcHtM35CUWAqHWkxwmAbS/3eBL5uDDIObCSJvnSdMNYTDaOKgXuprq/CrY+mS2GOckVrWD4fFiYu2r2Z8Fcje6iREL7Q8MjTztkljnlQD7bLNVJIDCeb9Ciz+f3fgQoQigAnTt0bwczpjnB5yc58Us07zOA6UrWoPWMM95w93N+G/7CpTN000iQG8dcIWrAWwiq+34S+S5i2dn4w38SBKNrURJq9bCK1YyxiJvVOvyoYSk305pada03VQFNhXSVQyGnB33D8C0S/OfdNMdv+uQqwFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZocatdNj0sIbc51sFd+dWfYXaUT7ypk4prkno23Mrh4=;
 b=Uy2P2KEDTchy3G4NV9VGZDvOBBdBntrwzBjN96ge832EbNuFdB4pWdZiCx1Q0UR2qnKl3K7Z0tlkDCYoS1nR53nBl8Zt+etufX4dJNWmOLQJCYyusfzRilD89Ru8vNJ+fjW0k9eA50G0liR4UbFMa3aklOA1gCuWwOlBHVTgMi7NX1EdRw+P5Y7Ov2ewh810q7g3UBIWDDXPDW3DQKZzL49UTrw627bhNZSbPmlgKdRnDxNR+1xzHO3E8+wkedNkg6vxvKwIURMkNUxrgVBr6q0C9rLnkhrOOEQJJxawGREZ3bNWTGlYHYgjYrPqfdPY7m6OAdkSou1LF3Ji5hIMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Yuri Benditovich
	<yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] RE: [PATCH v19] virtio-net: support inner
 header hash
Thread-Index:
 AQHZqRVyfixvgxNlsUC5ASNdYCAGYa+flAoAgAAIhiCAAGduAIAAXkuggAALg4CAAAFYEIAACUwAgAACI2CAACUrgIAAZinggABRLQCAAFVVgIAABCYQ
Date: Thu, 29 Jun 2023 12:01:28 +0000
Message-ID:
 <PH0PR12MB5481C50A3C7CBB98C178579ADC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628061257-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481ED6C94DE8CC414C3369BDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628123131-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BA1CDA0942170186CB59DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628132122-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814D42786A6981467D3FADDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628152125-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EAD97F6163C52DF4FF53DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230629064042.GB77232@h68b04307.sqa.eu95>
 <20230629074358-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230629074358-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6529:EE_
x-ms-office365-filtering-correlation-id: e0337f95-deb2-4146-2da5-08db78989240
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8kIw7G4Byf4mZBYMQs9nLzWae9fQF/Q0w2sdWkAVMjsFJ4Hjq7zFpk33Ddsf+O98pby3bgs23d/YnhWzcPP1v8jyQgaahho8GxnKDlMx5ZqKhxhAzjPxmdBQVlK3k2nSNMdgFyr3+NY54700/uNCn3z0jx2Lq1vL9Vk1iMFGYcd2/QCtHSaTE/N4vSA/x0G4+P/qAY5CnVFgrwMx7Fz9DY/Qy6oayY3eiQ+XdotRP4fDxvfXaBNXgwJkx2fXjTbvFs6HMg2t2RaoksxS3xFob59Zkm7FB/ihyAMk2ZJoK+3/nF5ftDIhPWGzKpxQJP63ZEDP74Yz+wPeRjyswcbkFF+G82Kvv09sEf9kQvvqZK9QwFzpU+AOf3UvryS6lz8GiDvYJRgkGjdCaaj7OtLWI7cEjufidKW3CE0dEI8S0cBR74/zH5XYvsxkvW1kGAEBKE4ZnLinNIHP8VmYFsscL+W12Tghj+wzhPS4sjYVc9O3u9AMFoh8VZA9s+hWSZ1GII0O6HsvyXHtnRWqWw/0VVeHJmAkQENALPCrvCDphUzdBhHIqlBx5KeBlsnRoTzAQfcTncXDPbdNmPgBr5OD2CPMGmQhjhkawM7GN//B9H+2avAqu4iHAxlBQ5atXhhm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(2906002)(186003)(7696005)(55016003)(71200400001)(122000001)(9686003)(38100700002)(6506007)(26005)(86362001)(4744005)(110136005)(41300700001)(54906003)(38070700005)(478600001)(316002)(76116006)(66556008)(66446008)(4326008)(66946007)(33656002)(64756008)(66476007)(52536014)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4CK1zTJ7ZKdNVggnbwTeGsaP8/ThDswwkDFVuIKDZB5CAiCi21WA8oT37dIc?=
 =?us-ascii?Q?7AzQ06HNeh4jO23H4qj0cV7/HSs/6MPtCYXKGl6UqBv7KdZhmD26xyiKF04t?=
 =?us-ascii?Q?9tRf5LsLH3YfVodylmZ3u7apsfkABlwaykDBKiZy/4Pc4g0Fvq88MmRBNaQh?=
 =?us-ascii?Q?BW3V8h/OjmIiitRZcqoUnA/pCoafquxwfkQr6OVpLZ5oRd5fs1Bj4BttEJ/8?=
 =?us-ascii?Q?bRFYoI2159foxaiQVta+7womCFKj/Z90un6UwFKrsEcUeDV1B5aoYcGsjLXZ?=
 =?us-ascii?Q?3djahOU2QJlCMi84cWDgVpSk6odXXFU/wHi7feY69cALUBOlv9Q5X8eG66J2?=
 =?us-ascii?Q?9D47JiVOyMdBYaQAIOEL2DZU8f2UcHYSOaW8bvP22B/eRHxUeiccNVtFIlCu?=
 =?us-ascii?Q?d09Pv+wTbQJEREpqVO9kVI/dOjo8+GtB9xk+7Nv+A9ziswFBkyFg+etsydGt?=
 =?us-ascii?Q?Vlyjso+WgNbvWZwe38LUMNbt3Px5A+Sc7WqQ2yjD5JQRfXay67R387W7eG+8?=
 =?us-ascii?Q?5Lj+AneMKXPYuaeqH/JEQl6UbS+qdNhplsNOm6Zs8D1/MbMbP9m/6Jjp7yYX?=
 =?us-ascii?Q?olklBKtR/VEiE//j+qbRiILN9j9FO9I7TExtrLKxMMNuPx5zUvf5Ti4SgwQo?=
 =?us-ascii?Q?JhFSQNxUV/MeQXgA9wy2T4Lg2o3eewDY4Cfwk6Iuiabzk7wSLhF2XK6OktfL?=
 =?us-ascii?Q?H6xFKwivYzd/zDP1D18cQqSdmydMEtv3Mq7BMI0cEJewaCpLjQv8YhjP1+Mz?=
 =?us-ascii?Q?WuLhs1D1rfjGudKs9SnhHBHJvRiAaz2vQFowvZ8X+U94PIpAIijEZ6EN4ojf?=
 =?us-ascii?Q?moquTZyGAackkd+Y2NDNMNL9zZgTttrZikQagMCvDz6i5Di6O50C7LYXQJE9?=
 =?us-ascii?Q?gVHAmJBALhHY8UrjpCi9Y2tLlUgxqy7jLvnxhxFptEEgMW3Kv7sMqqdH1f6o?=
 =?us-ascii?Q?Fy/bau9v+Bn3CGPB+UCifnT8v/FzLIflKFLFBH0IGsgpLfSUZu03hlk22hSi?=
 =?us-ascii?Q?2z/7WkF6NWgNBkuwvBNDramrqvn+uX8QEaUkRHqNyyY1RQufZZkLRILCBE6b?=
 =?us-ascii?Q?Qz8/Sg6ib9PhC8ZtR+IPKi7vyWo4+oPEsT2lpCnUQPO3NJFli8FbJhenJOvb?=
 =?us-ascii?Q?riXxF9bi/NfnNrlyUPuJqQOiG+VYMgqav6kJOef9l08L1P85f05/5AJln2S6?=
 =?us-ascii?Q?TOh3L1QMWq3P5RBJ/zrBscJEf5/B09j1F5C77Beh52GSlfguafuPt0CHJgza?=
 =?us-ascii?Q?KXsWHhPuUYAbx19oqd/a4DCoDCA3ffEQ4eR+hx4TR977/4Hbqs4beofrmKyF?=
 =?us-ascii?Q?smGMMXVzwxMZ64SEMwWr+Ttw/k/kRVldbdhB5B7CIkIBXhF8p91jQo7uIP+K?=
 =?us-ascii?Q?CePsCjXyPOWaw7mwO0DxeerDHA2nxWd6xr9zZTciLOCxTELZfSA7igQl4c9p?=
 =?us-ascii?Q?HkwlVnmsCTS0rbC3EhOyX1OtiwHejYQZM647UlZm1vjIavZxJeKzuSeVL0bE?=
 =?us-ascii?Q?ASnt1nyda4GVeX/slGuSbGzbpn0Cau5J3OCM904qy+JyRDmIFfgFDnKR1LjX?=
 =?us-ascii?Q?qDh8GhlsBvLeRZjGmik=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0337f95-deb2-4146-2da5-08db78989240
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 12:01:28.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/UrQiHWCwNh/y8GkIPVl5oCQvQkhGpyJRE3TG+pVMJylv8OI+YWYZ0jvKsZfzSbDJ9cbnfOD9sKVv/UXFoE6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v19] virtio-net: support inner header
 hash



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 29, 2023 7:46 AM


> Just a second, when I talked about virtio_net_hash_config I meant this:
>=20
>=20
> struct virtio_net_hash_config {
>     le32 hash_types;
> -   le16 reserved[4];
> +   le32 enabled_tunnel_types;
> +   le16 reserved[2];
>     u8 hash_key_length;
>     u8 hash_key_data[hash_key_length];
> };
>=20
> and then we do not add a new command we modify the hash config command.
>=20
> Parav still ok with you?

yes, looks good.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

