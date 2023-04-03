Return-Path: <virtio-dev-return-11933-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F89DC76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 20:42:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7D3A96040C
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 20:42:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7640D9865A3
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 20:42:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 68A6098641D; Mon,  3 Apr 2023 20:42:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5525F9863E4;
	Mon,  3 Apr 2023 20:42:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+s3JMGBxg/SX6K2yVMhbGj80UNfv/I4c0bTHLsTsPJ6nql1RlgUNSNgBVUCxrIwGYpQ2X9ZaEGeLfOGg1jIkEwSnFXeZcDwMOI6R6b7MznOH8eHK/NkhfxEIhNsa7EmdYKCN7rek0wog7DGDsLze+W9FGNTLTwRdgLpivrtiKLOwR94ZxW2ucBo4YiQCeCN1IeO4sgS6UbEUet/08h8fk5KGFa6sxAzUSsCCV+QvutNcSoQkEobBL6MIta9rMxJCujMS9HtZ284xiqKW/9sdKWugaNlHniD6Yb+U/dZdwgfJb8YIxEVY/yJke9X48tQh/sYkrj+jXDfj6TvEqY3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCXMn/UDUH/X/mTyvwX9UezfLL8QcuzgJO5F2jInSoE=;
 b=X96xM1/w3gSUG5tVeh0rLuW7BdwS+h0AvNIFSmW4InQn/TeffG9gf2KTk8nDw794rZ0MvDULZpMJZq2UbDO2e9mijeOjaqPUDYCftcQTrd1oDyNeZXMrVD+mVtc63kEIOvzkaU5SzhFmNxKC/eLgX5leJWz+09IfkChu7y22YvMYbATwfVoyQWxs8DUlEhU2Tgj75v/TKn43rZIIClZiR/74MbkySlSd0mjvZ4zQqvjDMjOYvlzU7NU0d5O4WhHRv7jbD3IGDfazfIQvpIGbJTJRcg0O4WPI8xVksPUDlYZ+4ZE0ynSdCmFFfmas7ljFw7yCeNWr8zsKOLap7OEe3w==
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
Thread-Index:
 AQHZY1tF5ObSeHDFk0eWHj0gIzL7fK8ZryCAgABed4D//9TGAIAAINwQgAAEjICAAAc8YA==
Date: Mon, 3 Apr 2023 20:42:52 +0000
Message-ID:
 <PH0PR12MB5481FCD5F8C57821B14FF360DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230403144523.GC302168@fedora>
 <46a0db06-f922-2a8a-acf0-cf7e453a2945@nvidia.com>
 <20230403134407-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811F46C61C499621DB5563DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403155310-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230403155310-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4928:EE_
x-ms-office365-filtering-correlation-id: 827a99e6-0d9d-497b-75ce-08db3483febe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 034imGLO1AF76AkXzSU0PiYh3xEaleVjdVpd/VOX6JlFxEgDFzAC9RGwivaX1vRlJtEXZ8hX9ducms1UZVUx7GJ4yw+/J+ZeCbUnToAT58MexkB9WbQ6MdCwoYZkqwRC8n7lNM/OFJzvxSnT7pkjkRuNTCmTKqkuxu4apBLX1z4EDW2WEDBPhdcJ7lvwKqp7hIcRhpmazWaFHRGcLe7mV0joMKt2el3vp4gabEHZII38UqlrZCbAE7re7P9CbOgTgv2LQVaprB2U8oNLS/uoI9/hZ5IYMeVLsB9xs+KzYwkkpw7XfM5+55gfz1nfDiQBi4SUA5nksArQ4AC5D/D3POkzNWBCwvCj3HCePfnnvYA4wEAwMkQLueNCMgrEkdBb+W0P9vNpkSqPdSEFmwyB15Bk5hsbEGDnoqYmX64mvvgALeRky/YilNXlFusMIav1l3i/B4mAQowNbFeKJ2kjMQPOMPbk2D5TxNkefiDHA7CcC1KCPnhgWClFbunxX0S8o+1ameWkWqXarP9TsPhh6xdnaGwn1GxxU7RqzblaqCj7Y6re0yGkTaPfCkxk0vdqUUMACo6XFeuqDvzLqlc/XHItXYST7zosFiT1O/dfdBGRSjzgxg0RIWW8Y4Oco6V8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(33656002)(64756008)(8676002)(66946007)(4326008)(66476007)(6916009)(76116006)(316002)(66446008)(54906003)(66556008)(71200400001)(7696005)(9686003)(8936002)(5660300002)(2906002)(478600001)(52536014)(38100700002)(55016003)(86362001)(38070700005)(41300700001)(122000001)(186003)(6506007)(83380400001)(107886003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Hf2z0gV5o8cZlAivaaUBsUQT+jw+K5UmrpsQ6IrGjxpRJKKWCmnU/Q8UkuAD?=
 =?us-ascii?Q?QrHCXv5pqpGAIWvxOocAIJZKbyj2ax6DCRRMUteGTT5d86HKn5e9G/ASPqMN?=
 =?us-ascii?Q?QShiQtwd05uoJY+sQGgJNMU4q/jTmk6Kd5AV2+TiR/44w4kvARVLeL6mR9uB?=
 =?us-ascii?Q?OMFohsauO01lxODa9g4Z12YdOGXC5mRHN2NFCSgCURAADthSyZRzZV7W0WMm?=
 =?us-ascii?Q?/e3ie/awpkzWfhY9OorhsKV1S+MrVJhysNDWXLY43PHlz3fo5KU9iyEiTVvy?=
 =?us-ascii?Q?HzZVHLIuBiBSPD6AEwKsUBplmpkM8pFZOjjP8bXTgjPYjJODB9shf64BMZUC?=
 =?us-ascii?Q?m+pNTO0B3iYeLyXDAiyqKtovRhsXc6IKkk0m/26ZXorMc8694UzvOouYDVHo?=
 =?us-ascii?Q?udSeF1whRBNmf49stgWoaDSngvSk5MBY3JavI6YDgIGqiCNwS16DwYARr4rU?=
 =?us-ascii?Q?kIT1X8W1H5ukfdQfk3oDirXShfvMAfLXYAlQG6SMYfw62YmEuzaVIZQ9E52/?=
 =?us-ascii?Q?+fqOYbsjRQL5S0WwyzAtcgZs84jiy+N6czLv9Tyk3Rk9pSlI3+FBnx7fr33l?=
 =?us-ascii?Q?ne/3/511MgBd6ZAnm6l8yy0l5sTKgw1zyw8JFlX/WZgCf5el/KyqKyrL47P6?=
 =?us-ascii?Q?AlgoP0VQO3XEHm4Uko8u1vlQnnVpHoBNp39RCJtH4nLvgKJ8Rvk4L/GYVnwG?=
 =?us-ascii?Q?27+jcgF1G/Z0Gt2m/IxiS3eO/D1ZMlZEcoURfCoMtzmPMgq5Cx87JBzIpHO7?=
 =?us-ascii?Q?jSPrLpcETvUfrPUtn7dNlQi8Hr4CvYvHn9uzHdrp1fO5fGvqfVDpNU1Dm47f?=
 =?us-ascii?Q?cml+EkpCAam3Mv4bwPQcJ6MNUFPB5hQa1R0qTWACvYaRt5i0xm6S2d/318Lr?=
 =?us-ascii?Q?3omfeOaL5koQvaF97T15c+Tdp2/yrfCiDwCWVQMYJgVdW9Wo65a4o/KvluEB?=
 =?us-ascii?Q?IJoEkPXWbdu3Fe8m6zCbZqAvWhtMYw8k0TnNCkHPnOSXifv3saM0sMg5rskv?=
 =?us-ascii?Q?IDTk4dddUkiN/mm5KEvU+Djz94imCAqwLMExtRQ2732+JEl6jBriDmu176Uv?=
 =?us-ascii?Q?fcD+CJgC2tHp2eIVfn+4QC7L/v83uSbBECMTL23vnh+qqIf52XNSfUHEMdEB?=
 =?us-ascii?Q?m6433MQddaszqNo++tg0Gx3MjiMqx7PD1X2ItwtbE8jQrqdHWRLmVZ8aDaKd?=
 =?us-ascii?Q?14Svg0xlqbkplF8hngrb2u8OmA3Lo19+wN6cM99ffauUo8qNWO/jIV0E47L5?=
 =?us-ascii?Q?pBqi9OrtFGR5rnvkYVSxEaPhixX6PezcsgbYX4FJxIfoWR1hKm/4tleZKvWY?=
 =?us-ascii?Q?PmATeILm+tuOQ3eFdJNOtJzM4T5I6HRIeV5TiLMb2YJvIj7uHckhjrwntJAr?=
 =?us-ascii?Q?ZZnnuYGPDtGG2D3XzO8TeoNE04Z0ZL+buhp43HhjnqqpUXz2WXKwSDSQ2aww?=
 =?us-ascii?Q?QHFTLN+isk0W/54TzJcm3lYgNAEb9itWmHdGWIFJeH/2Y/D7nrz1fWtcfdtl?=
 =?us-ascii?Q?h+Q5W6QPBiy33ZX2puvaGGTXXUeyHk1kKOLMlxPXNHXhVwciLn0CQ4ll3A0S?=
 =?us-ascii?Q?ABHd0Rx6llFJ7KkKNUo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827a99e6-0d9d-497b-75ce-08db3483febe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 20:42:52.2208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: STLFrmV/I+utO/35o3dsQClVyhlMMMBrT0GJpZYyy7gP/2zdd5r1t7IXpUGifEiiFf6ceosYwEkxnuCV7v3QWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4928
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 00/11] Introduce transitional mmr pci
 device


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 3, 2023 4:03 PM
>=20
> On Mon, Apr 03, 2023 at 07:48:56PM +0000, Parav Pandit wrote:
> > > OK but supporting them with a passthrough driver such as vfio does
> > > not seem that important.
> > Not sure on what basis you assert it.
> > I clarified in the cover letter that these are the user level requireme=
nts to
> support transitional and non-transitional devices both via single vfio su=
bsystem.
>=20
> And what is so wrong with vdpa?  Really I don't see how the virtio spec n=
eeds to
> accomodate specific partitioning between linux modules, be it vdpa or vfi=
o.
> Way beyond the scope of the driver.
>
vdpa has its own value.

Here requirements are different as listed so let's focus on it.
=20
> But anyway, my main
> point is about DMA. On the one hand you are asking for a VQ based
> management interface because it saves money. On the other you are saying
> DMA operations take extremely long to the point where they are unusable i=
n
> the boot sequence.

I think you missed the point I described few emails back.
The legacy registers are subset of the 1.x registers, so a device that impl=
ements existing 1.x registers, they get legacy registers for free.
Hence, there is no _real_ saving.

> So what is it? Was admin vq a mistake and we should do memory mapped?
No. Certainly not.
AQ is needed for LM, SR-IOV (SR-PCIM management), SIOV device life cycle.

> Or is
> legacy emulation doable over a vq and latency is not a concern, and the r=
eal
> reason is because it makes you push out a host driver with a bit less eff=
ort?
>=20
Legacy registers emulation is doable over VQ and has its merits (I listed i=
n previous email).
I forgot to mention in previous email that device reset is also better via =
tvq.
It is just that legacy_registers_transport_vq (LRT_VQ) requires more comple=
x hypervisor driver and only works for the VFs.

At spec level, MMR has value on the PF as well, hence I previously proposed=
 last week on your first email that spec should allow both.

Efforts of hypervisor not really a big concern.
Once we converge that LRT_VQ is good, it is viable option too.
I will shortly send out little more verbose command on lrt_vq so that its o=
ptimal enough.

> I just do not see how these claims do not contradict each other.

An AQ for queuing, parallelism, memory saving.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

