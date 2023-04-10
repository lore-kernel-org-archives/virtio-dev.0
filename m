Return-Path: <virtio-dev-return-12091-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCDDC76196
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 14:22:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 18F35419AB
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 14:22:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 111A59863D1
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 14:22:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 04DC1986321; Mon, 10 Apr 2023 14:22:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E03E7986319;
	Mon, 10 Apr 2023 14:22:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRLdjWF4hrdPUNP7YTa17WYxbneCMhDBpv9H2T+7jh1fJ8PoIyE3AG/RwsL0iOCn8vykHnxJ1rehpxFOYsbnfQkFzCvunB3KIATFTdPGTSEf7eOPJfyH7DQlIP3QoMNSd6mIerBsZjSwsuCqid0uSOQEbGc5r48m20SYx2H8ET3DYZ8ZBQ201WhRJv2I7+cL9WDRxttt/YdvCSlgcrsD/mlRhwAUirHRDFDIX3FN8eMmhiHWytNQsHZ2TX0/BN+Bb40EG3nzud0GA0yRESNYh+KJbQmE0OJITxi/g7ZSVnYGanGrSXdR+sJ2cwGiMpcNE3Vo2wwBlwoTVjEFhScatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TjVmp3k+eEzjWz0u2rW9WMLKIEp8gjRexx8MflzkMo=;
 b=gYA8c2fAvG8RzQ+rh475aimGeBVH6iPC7YOOnn4jWCwuEQWDhZUP5PNEnsGf1kcp1cbtUlZ1NLI9u/gPKzrnwwOVqtJvqVro8Wn8T9BpHYhoVnp2in8SAS1coXo8Oz1JXEWl6ma46p5NZOhtSG7e+jfomLikMgpx6SRRxOtZ+R1azZ5FnTV95TTLLWj6u5qAVs4tJ70jI5r/OhLthYen8E1u9606MyWLKJkaSroUgabAnIeJ6oBbwFlQ28g/1a8ZRinZakmVOq7X2Guc8LUtHXDMXnZtV0LpdVw5CZcZSnhvB3FGuqh7ynfwU7u7R6mHcGaDNDsvMEWJDUuPNKP8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH v11 04/10] admin: introduce virtio admin virtqueues
Thread-Index: AQHZZj13Sh975GzMPkylhblJLNg33q8eCnyAgAaIG4CAAA69IA==
Date: Mon, 10 Apr 2023 14:22:20 +0000
Message-ID:
 <PH0PR12MB5481CBA1F5A746DA89CD6BF3DC959@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1680533760.git.mst@redhat.com>
 <9cbecf20548a7adf4d97d07b17e40eb3c1c50209.1680533760.git.mst@redhat.com>
 <2ebedc33-1fa8-1fe5-67eb-8d657cf932db@nvidia.com>
 <20230410092104-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230410092104-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB7302:EE_
x-ms-office365-filtering-correlation-id: 2d9cb120-ce4f-458b-3e71-08db39cefee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GrbyEV2tI8SnyEj13vwi9whLL/Tn8KQhmgh6XeBeLApFiIrd1vv+jjNL/CZ8tGVoMtGecSTMAYeE1Nn7d9S5dAPafFiT0gY33SAWbqZuwcvUb27Lb6Vo2bYoBOugMUZh/VotdBTMDQVwvMmsViwHtoqABqpDiU4AGgegb/LP5xGyxdPlAIhbKNokkGIxU4l9U73SGNe7US3fTyNu43IF8A5wy3z4ydbSg7JpbH17UhiN6JU/Vnyv1lGvV/iW0HFjF0KDCYenT7OtzrZrMklgOYo2tuGbZprn7a2XksLpApvy2BhAtfVzGt6q5tQHUHRlxJ2g8MHkBU5QJXQps+weMvoPro/UnpHQca5Z4dbAgthilNLOmUk1Ih0CCC+jdaQT3QqimfxKm1vPvQE7QZjV6WNwuzmCSmUaKJ5X7WBHDiUhLL8kJgY8OOS+73qfTGfmiq6XYg4Abw2pHwh3A/BIIPvY2DFGWa1W/TMCQ6unO023lW3KTGOC1vxehV+dE+eJxAZIt+QaF+p5TLOSNDd7gCDLeV3FP/VznldOZXXrKX/bVjt98XUe+Hkq3f0I3ycabBUqmxNKEjJF/H5Zb74F2RcuA6tJda+zFcXcnaMdbaYZp5sPEMCYfO/zKwFLTrsY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(54906003)(122000001)(478600001)(33656002)(9686003)(6506007)(107886003)(71200400001)(7696005)(41300700001)(316002)(66446008)(66556008)(66476007)(64756008)(6916009)(4326008)(186003)(83380400001)(76116006)(66946007)(52536014)(38100700002)(4744005)(2906002)(5660300002)(7416002)(38070700005)(86362001)(55016003)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2m/MpCvxT+6vP4z7g+ygae/pav3K03dxXmge1OtnF5XtbQ+QBA7ucjw4lSTE?=
 =?us-ascii?Q?BCq5+h59TI8Xq4SsKTt0gCnYwlpI0cVI9rdpCcWxA4J4bYUXsoM5fOyc6/5g?=
 =?us-ascii?Q?4bBQOBKTjJfT/dYCFjM9KqVj8wFaLs6vti9pr5iTpelkjwwv7DvMiW32pGcN?=
 =?us-ascii?Q?sbCA6d3HeuXmD2fGriSBuzEWcvJOuMlAZRMQLXikPoJC2WCMbI1AJLMXBusK?=
 =?us-ascii?Q?82k5yk5sqDGF3sH4DhHyE18oSgUv9L+oI/i2C3HCLvZAIIBLCZf5bCGZI5bS?=
 =?us-ascii?Q?+L7HKEKc3EmPKSvS++x4IjpGaCjmG6n4BzEqgV2TJ5LPe7ryaO7kpnfOg9j6?=
 =?us-ascii?Q?X5inXa48gcijA2hNlSTOCGuo6TUcwCVLVGskaNTPqJwJ6kM+djmCXAD9CT+y?=
 =?us-ascii?Q?0RDc0/fbCGhRhfK6ZT0jvz2vxHw5IjCgYxSOT8rMq7U/AhE9v9P7hGoggtZg?=
 =?us-ascii?Q?Bq8FpkgBn3npKdgB81ivx4OVXFLuD21+XKuOWV0gAjhU0ttPM9xjw6nVYAtn?=
 =?us-ascii?Q?QWfPlR3Wp+ea2/rin04krMutbxvhQEZ2fwDaeH/QZEbtjbF47xOe0ZIyq5/i?=
 =?us-ascii?Q?TkBPcD3ARLkV2ba3nf2BN+hRtFJE47hMWgsiU6YkY8D8WrLN8hBtuIFHQB3u?=
 =?us-ascii?Q?afD82wrHGZ2mwatFYl9eIYNNWsxp8Vm4R8olGkQsohoFsfTIS8bPaVjQxt4I?=
 =?us-ascii?Q?cLaHRH/H+CNjnRrAGTi8Au9HdMO4aKxNV/M9PdNW/vYehCtN+XvprCHXp9KK?=
 =?us-ascii?Q?pbDQCFPLMX0o2H6smWMh2wUU9zJ1MhMnTr45zZWglvDkfLOvUul1t/PG9n26?=
 =?us-ascii?Q?VjIyZbVlBNQ/RkVYrgXpTowMbrEOqSzl+enZdSgP43lre0gc7lR+umTfaZMO?=
 =?us-ascii?Q?HgTl7T4GkSMSogZcej2DnUaLTN7lLvFgfIsptRg+i16AS2+u0xuLyvtX6Iva?=
 =?us-ascii?Q?5EpOG12VALK5kcabMcgrDlJ6YxYI9YiZmvMZbHrPHjkPFvGiqEDa2uJgKAjZ?=
 =?us-ascii?Q?rnonl+VBr53l5gRxLMPAB8cbBOhybjJf7wTrL6f+q26HGRlaLz0hIxmebfiw?=
 =?us-ascii?Q?hKq/6rk8MM3EZzFctpDFa01Q8jxVM6LzYZr2x0uuzorJil1UAj3bmOsKXlvn?=
 =?us-ascii?Q?F35I1h9NNKddKd3EL/lS7YMWAAw0btehiuugc2r1c4bagXLbjk0IVDGaBIiI?=
 =?us-ascii?Q?lE5fCa2iGxXnI8aQfUV+MAKk+F2tAbwFX2vipA9a5yPU5iQbJ2nDoyGCO7FD?=
 =?us-ascii?Q?YludVnQk6PeLh1nTkDY8tmOscoH52fOjb4bFRzNnAkEM6na4J0l7kc8Iz4tg?=
 =?us-ascii?Q?zoCXCEThWVZ4JGUpEWI5m0sRHZpo6d0mtW5QxSxRwrcf+g9JhzS9bEF+/Bte?=
 =?us-ascii?Q?ekQKQ10tKPyeIfshSgTamMSDgc4dBSko6R0NWS8P0hgN+b/btde0sbrjwKMs?=
 =?us-ascii?Q?hruy0p3YEq6SU8e9cQ7OiEWCkPMKk6tc4bzetvOwHy6YB4D/UjjEHbTZxV3V?=
 =?us-ascii?Q?8NywvbZ4ZZhS/Nr7xb9fFxrSWVJzdHqjBqRuXsa/L0O1hTNtEjN1mdjEZcxk?=
 =?us-ascii?Q?+1FW+AakKSFK1kOjUcGERCN79do2K58L5+lOSYu8NfGukaJnjkGJ63vYMlqK?=
 =?us-ascii?Q?f0pfi8mCEivUevCKnYWxn/k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9cb120-ce4f-458b-3e71-08db39cefee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 14:22:20.5164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mq6bX4BjSUPXVsiaMQmtvbl72JCWGvdE7pjq/Wi4CA9w0Mw1BrBL+3V5HTdZ7ednJboCQgS+KV2aMkWZEJu14Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7302
Subject: [virtio-dev] RE: [PATCH v11 04/10] admin: introduce virtio admin virtqueues



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 10, 2023 9:23 AM

> Not sure why - these are synonims - and this variant is more popular:
>=20
With my limited knowledge, when written for third person doing the adding e=
ntries to the queue, "enqueue" is suitable.

No strong opinion though.

> [mst@tuck virtio]$ git grep 'The driver queues'
> admin.tex:The driver queues requests to an arbitrary administration
> content.tex:The driver queues requests to the virtqueues, and they are us=
ed by
> content.tex:The driver queues requests to an arbitrary request queue, and
> virtio-gpio.tex:\item The driver queues \field{struct virtio_gpio_request=
} and
> virtio-i2c.tex:The driver queues requests to the virtqueue, and they are =
used by
> the virtio-vsock.tex:The driver queues outgoing packets on the tx virtque=
ue and
> incoming packet [mst@tuck virtio]$ git grep 'The driver enqueues'
> virtio-fs.tex:The driver enqueues normal requests on an arbitrary request
> queue. High


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

