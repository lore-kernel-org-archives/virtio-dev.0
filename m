Return-Path: <virtio-dev-return-13145-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6697BEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 11:39:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A42812A881
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 11:39:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9A5D59866EB
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 11:39:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8D733986590; Thu, 29 Jun 2023 11:39:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D7D29865A8;
	Thu, 29 Jun 2023 11:38:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYXnrlvJDxrnXuyxr+N0RYqfrCzEkP3l9aVqiGLrKkdbGivKWhwKsu7Tp9qJptfwKYbeQBnejJS8PZiGNsRrVyGI/UESVxTHl4m6oJUKfND9YrGSZSNv6/gfAyDf1/kmn7wUz4qqnf6qnvUtj3EM/X33rB4DT3VSdSrCK/7tld9lkNliriUlHPF4O/j46rElXXtshVWQvhN/nI/PimJSBew9gzG+nasVXBpBRpBfuZ9zHAWOM1VykBJDDRq06G/jLSK5wnfZfBTWD3F6aSeVudE6PP8HJ8+b970jJ3bej5lP7vGrlnkPt2MNzK2Gm7ZZsPfsaD/iuXTacpXxmD0FWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DgLxmVjjn+L8j9hNE4AtrxRZvdpXe3eO5CNcMALjUE=;
 b=GY7QiIpHkYE2ALIbf+qhYDYeLsD9vr/bAUlHcfcLY/J1f5qk4hwFVx419aMJFk//nz6Pd0MTqBN7eee9f0pvNgkhjh/xvopQoFxQJbx4eyGWVZi/4uD6fg0UNT186UcoaR5LKbevyoSIYACwhrFOQt0K9UiHyiWDbI2NNbi4OK1W6bB67sIEGG85w4Ieqq1Lrxij5DGL9EPyKlYHPgnOqo5owdKhKAIx211tmAseVm+bfozoVUKIQQtoMNy6ZsLJNEd+5IzVRMt6c8zbpMLNbGM1SYi5QCPYxRG3KbKtm8FmnyHZ1yMy5IVLn/JHWprQrSW+LbNmNr0jQA9i+af7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Yuri Benditovich
	<yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] RE: [PATCH v19] virtio-net: support inner
 header hash
Thread-Index:
 AQHZqRVyfixvgxNlsUC5ASNdYCAGYa+flAoAgAAIhiCAAGduAIAAXkuggAALg4CAAAFYEIAACUwAgAACI2CAACUrgIAAZinggABRLQCAAFMlcA==
Date: Thu, 29 Jun 2023 11:38:53 +0000
Message-ID:
 <PH0PR12MB54811080B8232F945EEED7B8DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
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
In-Reply-To: <20230629064042.GB77232@h68b04307.sqa.eu95>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW6PR12MB8734:EE_
x-ms-office365-filtering-correlation-id: abbbd2df-0692-4092-7d82-08db78956a90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LnAjTKjyV/31NH9tuO637n5roUfnizPMYa1QZKmXIbgPxlBJKMUgwsMCqXEcyryEBBOtqQXZxOsgpmlbKYcqboYUSfO+AwBWAKpwKP/P8+l8KmURxo6fdKiRg/QAi7B994T+yGFKWlK9k/VFwYbrjlzH+uKjigts05QZxDHxe0lVfp0eoYVJYopHFk5IZldJyc9enPwSTtOJ16mP/7nKHim9mWaIR6UTN6rMFFkBsMBZzKmoeYtJ2xwHzzcdaVlbGMj5cnZVwUOBGSJKWnAcCLUHD2GXq9P3UVmhTBk8wcJTpPqxggZkqIpUjvDn5JMVzlnH+zPW3r2s/m0bXmYdlbDY7Wtly31nGKLH6DpXDnQE4RdPdP24ordmlGrP6rRE+Ir/2YTqbqwje/TR/sR28fBtXzPz6p9lU6gTaEf3g+e1/rQlcTYT4KSnRqPQqH+4VWwtbDfm4Vj+fyZlm9Jwzm7IQtXuPT/kW7J/wmqzxRN7MedLH5gRewBSvBM3H2NAkkTtR/hz5dsIzS+Z0WMDV92+FnkZejsoNU+lxMMqPdQVPH63HO+S+k4DtAsNQiczb0xZmsxIHvagKHwRN6OTPol9FLhqJDMZ+/91E8Vy8V7YH3qEvr3g4q4eM/UZQnis
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(26005)(9686003)(4326008)(66476007)(66556008)(38070700005)(8936002)(6506007)(110136005)(7696005)(478600001)(54906003)(186003)(2906002)(71200400001)(4744005)(122000001)(66946007)(55016003)(5660300002)(52536014)(38100700002)(76116006)(64756008)(33656002)(86362001)(8676002)(316002)(41300700001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?u7GZJPzOiVKZnhMiKHRVRLCbASADBeQv9x98b6UglGcSCpbA9jZmbpGNk5+q?=
 =?us-ascii?Q?00Ki6pzpcG23AzFXRMgxgSZgA+qnDPsjTHtljwsB4HypnvRXiwvWIKzVR1on?=
 =?us-ascii?Q?FHKTYGAVzN/a9cTEu6H/p3Vo996GCdwR1dAHXki8nw0gQEVzc7zzlAot2BWu?=
 =?us-ascii?Q?/AnVziId82N9PdmGEvlZO5Vr4Y5YWM1IWaTEwFoRQdbxDK8zK980R2l0CKT2?=
 =?us-ascii?Q?ETapyyB4E9XmC2kgbU3u1RVUhAHALJ2HQMmJhoGHA5BYEww5vNO0FtQN6DHx?=
 =?us-ascii?Q?C2JzXCtEvwNHpUyeR4Y4gRYxvwzoP0gJw6aXYklyo6lN+MqHZUi+0CVFeSQu?=
 =?us-ascii?Q?dKZQC/ebG/Cti6G4EslsC0lgvmkaWtrp4AfRsBH9v22Fi3DM2JIs/0IQKVQD?=
 =?us-ascii?Q?xWX1XV7cttOkqDQ6FB6AbIIIxYPKqky0bgeLuKBcZxkAYqG+pPCkXXhTdAQW?=
 =?us-ascii?Q?8FVzeAhIIn5eORXCz5ZgRtap472cZZZrrPsarcF3jblo7thkcwXfdWc0v/Vi?=
 =?us-ascii?Q?LDLFfqttqV3ucH1lcjs0XOlBq0LPGIl/v2FnKNU5NPGoMDD1CI5Dg8jdWC7o?=
 =?us-ascii?Q?8RSPlYOWdeE6w7Bby71nLzbttXUy/5qxM0KjuTTGxilkqaqNE0UCyFdlLZmh?=
 =?us-ascii?Q?U1qTHC4V5hxJeI1wdkCdKMnfN2KFeWgKf0AD+m5+qaJJOpJSitnkkudENcDm?=
 =?us-ascii?Q?xJ3MVse1M7+5vxivVwSBVQzseAGx+mHylp+rzR2gfeGy3iAFdypGc6j4df02?=
 =?us-ascii?Q?XJDYkHv34S+BSbastpNtvz0e/AsuUlzkb2fIbzM39SyXgiFONOWT/EcVvI2o?=
 =?us-ascii?Q?iDBRCplwTbYz3P92W19R4fayFcbSsheR/VGaEM7cnszplBsJVRpQbuh3MMAv?=
 =?us-ascii?Q?m18QSpI+AvvsAFqcLScWWzvnzxVKz4IzNsxydaYiaah4btZ5Aw4RH+KQ16CB?=
 =?us-ascii?Q?Q+T3+z6Dr8fIvMgU+dwDQ8kcU82EGoyd5eFOKZZAPMC739zJWILswjK3tCPx?=
 =?us-ascii?Q?p6bOQgaWyCZkaNCGUgpnzpFbBb96ShE7Z3O592rdobjxDVcuw9B5p4VPT7Is?=
 =?us-ascii?Q?NZg4cznHTs6b9+fmiqQtN7W9rVH2zRpk3iiHwiCozdFDPpma+veXfjCJpurX?=
 =?us-ascii?Q?aAlh/GCPt4QcqfGHTDPDl6rp8XSmoL1LswO76ILBshvPbXEXjeYASQhqRhdB?=
 =?us-ascii?Q?nsXuV6E1YezuXudj/c+At2N9QWSJBZOuufVPIENoZ5JAU2M3xfXS9++9D354?=
 =?us-ascii?Q?b6BASRuFLMGd22hhzxlBdLUoklhm9IHCOTGLYfJQYbqUf5vCWfG6wmpu8x0d?=
 =?us-ascii?Q?xzquBUMvPfnqJy2L2tqtFrlTGOLDupJ/rGf+HmYrNicvM/31F7CDs/pAjQsv?=
 =?us-ascii?Q?I9lYtoxtUUVkeJA6QBFCVo5NECXTJtACv7U1Uv1B1/ytH4ZzDVOcO50NQrUe?=
 =?us-ascii?Q?i2dPXGa9XqieiariYJ+hx166klabOjEqhYocqCkxED8lM/2T6SGxhCBYJR6z?=
 =?us-ascii?Q?V8+4k/OzaP2Gc0JjIX94zp3AI3OR0XdYWX5TD79DpecSJdS+1AkL4tey8UQ8?=
 =?us-ascii?Q?VDHEVylSrpJEDNT7SH8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbbd2df-0692-4092-7d82-08db78956a90
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 11:38:53.5901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fWj5iZfnh/sgz+5x7eKUHn2SnJkF7mVtidhkbv0PJebx91sWRdT5rKRxKbqL6tmcMblk2zejBWqzCdQjFYIZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v19] virtio-net: support inner header
 hash



> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Thursday, June 29, 2023 2:41 AM

> I would like to make sure if we're aligned. The new version should contai=
n the
> following:
> 1. The supported_tunnel_types are placed in the device config space; 2.
> Reserve the following structure:
>=20
>      struct virtnet_hash_tunnel {
> 		le32 enabled_tunnel_types;
>      };
>=20
> 3. Reserve the SET command for enabled_tunnel_types and remove the GET
> command for enabled_tunnel_types.
>=20
> If there is no problem, I will modify it accordingly.

Ack.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

