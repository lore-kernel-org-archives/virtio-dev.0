Return-Path: <virtio-dev-return-11709-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984B5C6FD1C
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:40:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 46B27157F1D
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:40:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 335FE986463
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 16:40:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 271DC98644E; Wed, 22 Mar 2023 16:40:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 13DE5986450;
	Wed, 22 Mar 2023 16:40:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvfuVjkyux8xNMlcpUpDvYMcsc7ClSmlCuwVKmjjQRRmwu+xSCN6NJrZSagsWaL/TVSASXy50lPfrIkYAyP//LAs1tbhKyieR0HYsMoceHPL1l0C5If3j9zBdwbttIgi4+UTxu9u3Tt6BdI4tWNu+ZzrkX2id7zcxWyCrNGD5UnLJH4mzTuOXB1TTyC+NR8/+x61s7xYCUV5fWiAlRjyzgz/kAm3CHO8pf3ZgKrkdyp7MvRbZ/SAr41ZBLR1Z0y+fcsK+cAPUPEpiZWeks9CtnUVVLeVe/CvE0qLA0OETygkL1do6vV+OGPbcXZC+kfpbzS49gImdZZ8osifTG8QeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWukvEUKlzwjO5ADCBgdKvIuGHJZdLgKb6xUlKN33hs=;
 b=PYB+kW4dHl4L2HcTsvbK0B58rxTlbtQLH7J5/GbQB2q6Osr2badqdG0Abv3QvmZACmFMCHEt0x7t+7qHdNYSOS0jOdrXErlpiGCiCGWwQdEL+6bwbZ5X1b319/P9WSrr4U5fShRHbrWkoMrL9bkLRoXj6yLwp0DJnbOeRvumKWx4wsyJ+5qkBHKI4YWGMpI5U8N4ZCV/c+Q2Itm6eogXlAfvw0JhnuUoTXG73zkl+hKTo0cwizDZRwie3GOVVvmuet4DKpTDdJOcqGrm2F4fA53FrSr/jiqG1MpBxpltDhu50BOXgzsYoN26VG+FAD+Jy2ttsB4ZKCDK0ECPtpDohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>, David Edmondson
	<david.edmondson@oracle.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [PATCH v13] virtio-net: support the virtqueue coalescing
 moderation
Thread-Index: AQHZXL0YQHWs+6YDyUK7u3Kjjs+HRK8G6jaAgAAQ9sCAAARNgIAAACrQ
Date: Wed, 22 Mar 2023 16:40:44 +0000
Message-ID:
 <PH0PR12MB5481C1E2C473B2F13D1B8D84DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230322125153.128385-1-hengqi@linux.alibaba.com>
 <87sfdwhkxq.fsf@redhat.com>
 <PH0PR12MB5481FCF22C47F2D23E6638E2DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87pm90hhew.fsf@redhat.com>
In-Reply-To: <87pm90hhew.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB6398:EE_
x-ms-office365-filtering-correlation-id: 486337fc-3439-4fb6-c985-08db2af42ecf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BhK75d0NdX3rcQV9gh67NYjmo1u5DF/HhDkSF0IUDgKwCdOcx3tOvqZlQqlc7vzHbzfRqiAimIMRIwNAnB7eo5+S2mdxKNn1aDVBvKvTsKx2Jr4UZX3+SPb7uv6M5IsWKdd1Y753oPsX5lLjx7dO48+zjEGR0rjAlUytYz2UveNXcpINaPiFWMi4RJKubeTEUQX+iz+kFTH1mw5dtu+inPFVre+DEZvmvfwXmsD2iZ8l/Clt0QnfVpuMGnZtLqmYuCBEa3smB9kABt1s5Aw+M77BV6+9RIS39exJeWdUQvtFdvZefLan/rVISNq2TpkjsimRavoZfyfV4+3c1t2gqqqkWZC7vkc8o7rd5f2Ry7sWwSy550zQh7X0yGKQM4sS34VRszi8JJwt5A/zWaxiwWszXZ+s8YxTAyueYH4mJJJ26BuIF4YEU94YEVudd+VJk2S9v+sz9uwFJyjn7N6Qq2HVjA5+Q2p69v5xpS91DKK4wPDBVx84WQRouBgslUtU5IKowEDqTNJUNNwcGF823ckSyGCW+tPRHSJzRmIIIpvOQcvkQ9I49FukWj7ed341gsdXecJMyOsWrM8n9hVk/v7v9WOy9B0q83/g+jlegh4vGfRKmdSBs9nFUSHy/vNMC8hVRmCooZKa9j3Aj2pNsZkkDSNsnQTaOXL4VyE8qmsyWBCEAR37BrXQlY5MG62lKyqWVQmxURWeLe3d0MwUDw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199018)(6506007)(9686003)(186003)(38070700005)(26005)(7696005)(86362001)(38100700002)(54906003)(71200400001)(478600001)(2906002)(122000001)(316002)(76116006)(33656002)(55016003)(110136005)(66556008)(41300700001)(8936002)(52536014)(8676002)(66476007)(66446008)(64756008)(66946007)(4326008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4W5yLtxsjGs+Nj3YLCF8ecRvUzvVahHEvb/WuirKqnEEA81pW91OFFE46hMP?=
 =?us-ascii?Q?OtJ86ou1B/jmzE8I26VWqBEo7JgRUoOyujItjH0B348f1iDaFbZKJM6Gtswp?=
 =?us-ascii?Q?xhuYfop/FNJPYdI/00yvpsPuJgJn33ddSiTMoIaIUZWZzVsm4thoVIck74Zz?=
 =?us-ascii?Q?ZRZLgIzdrp3j/zcxe/Yhy5S86JIpKNdY9wTk/AxUJl2bjMkJ6svu7kaLKg3P?=
 =?us-ascii?Q?Fkbvj0YThYhdVEX45x5515TmOkPBm2ZU9LlIFTkFd2bN36je2V4R4U1kduHL?=
 =?us-ascii?Q?ZuedmO5t4HZSU5d5h6s9kZIMoWlT/XUMCcwu7hLnM4LindqLvJs75D6bOLd/?=
 =?us-ascii?Q?/FYZja1S0GV2BGX/jTwlVFNfbF9WCsOCNMVtFlsG9XTwWFta44ZYBG6xnzYQ?=
 =?us-ascii?Q?rTuqm/5sbhgtWbyOHFc3hdryFjWOP0dx5Oels5ipYfaWtOkvPBQ+FXbIWgPZ?=
 =?us-ascii?Q?3J64MxiFYYeg5HThnH+1L9OLfWVhFEKn/Qy2G+V6s6p9/hqJnqnXraN28jPf?=
 =?us-ascii?Q?ggULm/fO1MoKwD3HVVfPhyTMXUfjLf6O/rrPWNXK+GNw1KRDNzOd6I8D/gAH?=
 =?us-ascii?Q?ZtYhkLv8qIYtBmryrx3AdlzuRwMoQiIQd0RhSTiabJDRLbzfwow9/5LeAOcq?=
 =?us-ascii?Q?e1oGlDvTllHShZgt/RPT+P6pWzLBkDeZdzBVUiMmcwJnmIAl+IKbd/nFyIVl?=
 =?us-ascii?Q?pgroR9pouQDjlaROfeHa5upxQWmWeUrsKqB6NGaqsUxoI1k/QP2uw7uGIQjp?=
 =?us-ascii?Q?vjBJ2ew0KDj+ejCZqVSCpCDspgkwVTN3W7UtWMO5r79nssp8K17Bl32seKyn?=
 =?us-ascii?Q?9OI3Y1JuPRA8/8YUwA0GeOoxh03fQSGpQ5COZeb/F/purQ+uZg8AcXEQ/TtF?=
 =?us-ascii?Q?VvBaNf19Ivijo6YOTTbBm6AkwAoobvJFk3Sc1STrp3frACdki8LVVI0x3I96?=
 =?us-ascii?Q?7RlP2es5QB5SOfcc7c5K7WOYUmmyrxFRgoW90ubwYOdPWSrdGgccJCvWxBeH?=
 =?us-ascii?Q?ZtgYHynkDmDNVIQJ12V6AUXO5mgpMrVEJzKuP5LwmgQuyc0eIdwdHX+koHnn?=
 =?us-ascii?Q?YoRAGLpPWx726zCtB9q24oaX19G/5Bh/NgkD7P6/bUPrhKgJwB6uSJoX4Ovu?=
 =?us-ascii?Q?uPRCi61ouk+abEi9DnWWNRTHBjnuGjkOlVWtSK7uSfP/4f6WYtNVKrJDtORl?=
 =?us-ascii?Q?ijiGNJhSJBwvw4bW1CFM+rp4eOQBxNYv+13HtlerqEze9UeBqbgY3HaEtv02?=
 =?us-ascii?Q?d0kvZuDt6HqE7dqMpFt8W1ql4+k8Wom6JnLo/tmZJ/WxuyX9FVcD6Hv/Pz7E?=
 =?us-ascii?Q?Aj36j2MDOezHfusTkMrShOMh33vBskjpTcccBw8EZ4gDVxU//iyPP+PfdtF1?=
 =?us-ascii?Q?CcOnH8PBn6tkh5pTjmMmKSEz43EgowGw070dqEHtmqz4o3s12gQeZ11cFEve?=
 =?us-ascii?Q?JmOP1XPD0sQ3rWRy4MWjC1oLvRbUdEcXDCVya3rlbmnt4ujRxF/Z2l9eCdfJ?=
 =?us-ascii?Q?TEZiaZ7y2nLsTepAd7byIvtrm2g4nWi6EyIQQIqQPIPVCF0Smoh9Gid4MECU?=
 =?us-ascii?Q?tSI1g5hNsjDFSpVooW8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486337fc-3439-4fb6-c985-08db2af42ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 16:40:44.8657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uVVzJpP/ofwp4IiE0icMbSAo6F+IGprb0EMpspffOPFm+2AcU7blEbu+GSuAvS6vTUqoTINOTw+3562mJ4GPGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
Subject: [virtio-dev] RE: [PATCH v13] virtio-net: support the virtqueue coalescing
 moderation



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Wednesday, March 22, 2023 12:37 PM
>=20
> On Wed, Mar 22 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> >> From: Cornelia Huck <cohuck@redhat.com>
> >> Sent: Wednesday, March 22, 2023 11:21 AM
> >>
> >> On Wed, Mar 22 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:
> >>
> >> > +The driver MUST NOT set \field{vqn} to any value other than an
> >> > +enabled
> >> transmit or receive virtqueue number.
> >>
> > Why do you suggest a negative statement here?
> > How is it better than,
> > The driver MUST set ...
>=20
> So make it
>=20
> "The driver MUST set \field{vqn} to the virtqueue number of an enabled
> transmit or receive virtqueue." ?
>=20
Looks good.

> > The device will anyway have to check and apply the parameter to the rig=
ht
> virtqueue.
> > And if the vq is not enabled or vq is not tx or rx vq, it needs to fail=
 the
> command.
>=20
> Well, I think we want to avoid having to add a normative statement for th=
e
> device, so we need to be strict with what the driver is allowed to do.
Drivers are untrusted entities.
device normative statement is needed, it will do the checks anyway where it=
 is applying the config.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

