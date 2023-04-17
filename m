Return-Path: <virtio-dev-return-12263-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34380C77B72
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 20:28:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8C4A0157EE8
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 20:28:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7F04B9863EE
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 20:28:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 716CF9863C7; Mon, 17 Apr 2023 20:28:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 609F79863D0;
	Mon, 17 Apr 2023 20:28:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2208bXAlLVrWdHSb4OD6BE0ZeD/hCNTQ6puMpxjfxgD4hWEjH50u/N3r4G8AXXBcX5FSuD6r+GSGwgb6MW0WfSq4X2tKBGXO95jr8xaA3W5ZKBaGYPCISnBHf1zK+bPYMOX0A7Qprqm1gj3fB4QOwzXQs0vLHtkplbMSbuQ3OCkzlRluvRvyRsy1Js3PR77ztC74uAHlTr1hFJyQClVMreVl95+Brp6hCsRPna5bVyksYlvLlcQkgpDFEx4yTOoE9dZqA28YmzCYyazNzaSyK8WOyLdNPMYJ4pGR1qPxIuAPv7lVsAIp7qC7rn2O9J96K2dGvBGkRcKxihfkue3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCykZvA3sGXvJkrdP/s2PeQ93JCKh9sUW7nQTMMdopE=;
 b=ayNJHp5vcDsVKrSG6L/deCFKCAAQ83Q8BiyCZZ8dNi5Gx7dtqxas95cF5MytHcbR4eeVft4RyYPfIf+UKfUuoQjQZ5OWSaAW83H0fiW5HFKCiAazWipzs79YFliv9gIhUOzZ2XUJ+rX+K0apUOMLXwc4MLhoLc+wPokW8T8tcVhGEUw1u8uOTbUG9eFph1GieLCUSRxnfIIv1Gkz/r+27Sdtd8k40UCnwdmmzczOTbqJz/yaVhZXTyRqCPEAhXPa+V4Itrmf+m7dLjn3w+8hlfuEqtlpW0lBFCbrAw/CNe29zOTMhM1T96qODpXnpsJud15rQOGdxLBBX3Iy2NuXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>, Yan Vugenfirer <yan@daynix.com>
Thread-Topic: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers
Thread-Index:
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcIAAxPiAgAAc1wCAABy4gIAAyrIAgAAhEfCAAIO9gIAAAWdQgAAGhACAAACJcIAEsiqAgADky5CAADloAIAAAFbg
Date: Mon, 17 Apr 2023 20:28:47 +0000
Message-ID:
 <PH0PR12MB5481710854882449008F28BDDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <20230413130326-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819A5D8FCEC6375D80897DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvSSXyXQnRs=OiaSJnSEYHP83chL6-B5ZPCGx6TeW9W5Q@mail.gmail.com>
 <PH0PR12MB548135CF5268D979A6D8EDE8DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsHtC99kTTa0TrfeJuhV+F7e-WF7XRgbLJkCBQeAxW8pA@mail.gmail.com>
 <PH0PR12MB5481C29561D5E48BA5D8AEEEDC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEseO=4xDA+pH2x=CaJ6XyzHEx1ZFO-+uevJH50kLeSWhA@mail.gmail.com>
 <PH0PR12MB5481FFC95F54AD048927FF12DC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230417162618-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230417162618-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5190:EE_
x-ms-office365-filtering-correlation-id: b12243b2-7d43-42a2-cf11-08db3f82593f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6iBvweo3ElCG4mhTjfKqOgH9X1Kd6YOum5bqsdhDPOso8oCtK3bKRMUeGx12kd3aimkA5S1fIhT9zpWtkxEFju76JB3Gzmri9sFlmAMUvl/cDzaKWMys7XFBjT1lu+7TQzzNeQF2CrBgH/XfraiuJ3iL6c17yXcGcJEYihxjRFqvNE/I/UAtcA68cTYUeu07o8EIWdLsAMkkRbJwBzJ7/9i3UwsyHc8Vz+dVy0AqHVK0rvaWbazTdx+Ef8pS1TZ7CHVaVCaaGiO52dEdh0/mxZpO7C/k/FMjHQ4Foq/aasViCknwl7JkoTUcbtBc/r6B6SWgod+N/73vVfOcQcT6RhWoloOsCAnNWapry+fujFdwJz+liHK7pBE2GaP5pGmHc6B4Jh2e/css1JsYrANsGKuhXjIhl1eLK0bY07ypbeZFIE5Ls/WgecB/5nXoqGBfqgk0zH5DNzFwwNhlrxLKESQL5qhH1Wz9jEOUBdjHoCUKZBN6FsI+FU+5LFXytVz+Louwoeoz6piwr8IsQGRaLoGRh7FA4IiiktCVnSmJxOZ6N4w80yxJJiUgBs8a7FRWlQpRwQnfnFBwi021CUsy9B5UhkpoFoftQ8q8MZgk5ZoPiiY6dH6YYnUPKqq1lkWH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(66446008)(54906003)(6916009)(4326008)(316002)(76116006)(66946007)(66476007)(64756008)(66556008)(7696005)(41300700001)(71200400001)(55016003)(8936002)(478600001)(8676002)(5660300002)(2906002)(4744005)(52536014)(122000001)(33656002)(38070700005)(86362001)(38100700002)(26005)(9686003)(186003)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7w3sk6g0HoVsLK0BDwitYCY47e8pJkmThmevLw77TxX7JAG4dwKw21fr6Pex?=
 =?us-ascii?Q?33dXEa56q2iTuUBFJQIwoAV572LuSFd+fJR0wMeHfbrDBTZUiHeFvKEwiKw+?=
 =?us-ascii?Q?zR4DlcL47Dub4Scmox7yFKuAWLcwFRj9DOtBDiKojyWwmwifANQA2qW/SLSA?=
 =?us-ascii?Q?pfMDOmw+pEX30hJnN1xiG+FXPXWDk3YFKKF1x5YNm48QWaRsE2VAzz1NRkid?=
 =?us-ascii?Q?xcSubfliLk4BIuGlQ6C9Lkn100YRMHUlv6ElQPM38O3U4nJe+E6NVj/HIV8p?=
 =?us-ascii?Q?WCQY92qDtXjb7z+GupPNDDucPkCdITqDzsp76gO892Zzwjrf1oAZPW1y+SvS?=
 =?us-ascii?Q?Tc/X6Ox2o1/BWTEX7yLRy8VU54nIwz6ItVjaAQIHPihHUILdGTJ+K8Q6kLnf?=
 =?us-ascii?Q?IPWfaMORMM24tmw69hYm1uVV9kUH+FeXyz2iDh2j0nES8EABF8CWjtb4sjRG?=
 =?us-ascii?Q?X98giXQXF3NlXTMdn97F4KNnZy6nqNJmJarCkjJsRPda1e26nZBxBpQX7QJr?=
 =?us-ascii?Q?YBVFO1MGqh0yEUMLJqf0n/6v/zHK0p4uGHOL+EEJH/BPlIZAHNUIrjseupBn?=
 =?us-ascii?Q?ju2PLLgrz5IAU8jWRH0gURFwntC90OEkHlGmZOY310zwV+bzefxf+puw/FCL?=
 =?us-ascii?Q?IkTYxDHvcpDRy+u2vqC+28inMFCZkxEZgKRTzBHpGWCTzbZeVQaUQxW7hhi0?=
 =?us-ascii?Q?tNjvRTD/2HZ8JajjKD5EXPZsYErscETnRvKM2hYG81x9lSCC4qgwyEMr5jBb?=
 =?us-ascii?Q?rtb8Dva1lnjfIkH+gK/WkAqjcOofKVzuEmQBnHsfa34Q9oes9CSiJMr2Fnxq?=
 =?us-ascii?Q?a2FZt/FTNtnz1ruTAWrHhdHtsF9WaFATumMpg3z5/qZpXCmAjgAeEs1og4yE?=
 =?us-ascii?Q?jaWzkQ+Em52n7h87SVRU0kU4sdkqANaV4B/Ci2ZwFUdMXfRDo8jU6X1tJ4Pq?=
 =?us-ascii?Q?W0bMUfmxIK5j71Baa+LBv/GvgZBPcGviJh5Xx4h/4kBulhkhUgRNMc2lIx30?=
 =?us-ascii?Q?+7glL7rsjqBUS9T9owrLhn3ZHURN2N9kJUc6BJey8fxffMJnXFxxRJACLFVT?=
 =?us-ascii?Q?80Lu23icIYoLmJw1uX5TN7+J15AxQE+yXkGwLYsl2wBoiv4G7obZ9BomE26R?=
 =?us-ascii?Q?D9xfKjNkIohOF4xuxGAwQRHx9klrF11tveI/guHaf5BbwIN1xaHrn/nPDLxa?=
 =?us-ascii?Q?FdGA9UdxtTTswe5stuKdMRzFEA8HQ9L1FsfqzrrmEHjiThC0NssldlhsFoBB?=
 =?us-ascii?Q?BfG1RPBtVhjNZhJVTPUaR7vQG7E9I82tskFIfB7uqARj8p3zslrfZfO4+HG+?=
 =?us-ascii?Q?P89wquR91+hwAPASv3+eqrjXHgci2bEbLEDOwCf2JOtyEYrdPykWZ1jE0bor?=
 =?us-ascii?Q?xErq7i/CeR+OrvE1AXWmYvxOVpem/fRZ24kNR2Wnu+Oj6HCStKGorDiNT/CE?=
 =?us-ascii?Q?2zOoLJ92oGJSeJn50nFSdjBRgjBSUTJmi4PU9ZUe4JROtY/CjHoPx3dpBqle?=
 =?us-ascii?Q?jd3u5v6h7EYbWRztFCvH4BLy+6WKLXqQhelVPdik7W9QSKAUuTVcoM8ijcoY?=
 =?us-ascii?Q?WQkp0ToVwlo6nmWm6aI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12243b2-7d43-42a2-cf11-08db3f82593f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 20:28:47.8306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AIJtbHFuewEvbFJFGZlrKrYun6m5gGqaH67162fEZ9B3ugUg0l4aQRJfzxNg16iz60AG4JPIC/LiOQhyUAuFCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 17, 2023 4:27 PM
> On Mon, Apr 17, 2023 at 05:23:30PM +0000, Parav Pandit wrote:
> > > Things might be simplified if we use separate queues for admin,
> > > transport and legacy.
> > >
> > Do you mean say we have three AQs, AQ_1, AQ_2, and AQ_3;
> > AQ_1 of the PF used by admin work as SIOV device create, SRIOV MSIX
> configuration.
> > AQ_2 of the PF used for transporting legacy config access of the PCI
> > VF
> > AQ_3 of the PF for some transport work.
> >
> > If yes, sounds find to me.
>=20
> Latest proposal simply leaves the split between AQs up to the driver.
> Seems the most flexible.
Yes. It is. Different opcode range and multiple AQs enable to do so.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

