Return-Path: <virtio-dev-return-13189-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4128EB64D7
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 11:38:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1483F2AC4D
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 11:38:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 075599866FD
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 11:38:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ECE889865E9; Fri, 30 Jun 2023 11:38:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7F2C9866EC;
	Fri, 30 Jun 2023 11:38:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZn5s53lmc6h5C+PY6iWurk0mq07EtSZtIAqIZljElSOXk6LRp39mPdozVFsfkAlM5oeFtabrxEqayT8wRk4DnSsdkceLpcy/pmFkq2GP+A33OzYlf+UKM9SiTPmGx99KGv7r0pG292ptVvu4TzxIMz3fr9sPzJMrw4DLo2mE21ZpCwmbygJQwSGg/Kv3mp5AXhrwLwQj/4m7FCX/ZjNMFn7692Nbj/Y+n9u24ErgOh/nS4nB36fQhQZHnMyb6IEeyRWtNPD+rNlxof/qGbGngVho2J7Lo/IVtDelR1E4+kE5KAjyaXLPeaIKWXpBXSuLGfcdjoi8RQkV0qSNhH7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAKYwF5ZlLsSvTRJTqXMPhqrOqRZ/8PQpdHgEBh3KQ0=;
 b=k6+IY86J/0fDFjtIE9n+N9osw+O7HPbguIXxOAQ8Kb+HLIvrdN7CyFaI/IHYbZ3lHbp1wAOZrAE2IJC9tUFiEalnpuEliQQyKHNKj0cxOviKBU+XhjSg+LEfDHT1ezcz/1n+sas7+ywZqnr67SGFwccfOyc6cvmrt8TmQWl1fda9KyE4DbeXOfxpiETrDM8VV4oN7CojHHpMn9zgNm9k55INFyQz/BYYaaYfadmF3EpxNqFScJR5E/MljL5TIzyk136MORwHghmY10o5lMeOvAQn2iQfzuaVwRneGZqQPJ8lOib40/jM8R1/8TUAariRVQbTomsYHidzJdDOhZ2Diw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-dev] Re: [virtio-comment] RE: [PATCH v19] virtio-net:
 support inner header hash
Thread-Index:
 AQHZqRVyfixvgxNlsUC5ASNdYCAGYa+flAoAgAAIhiCAAGduAIAAXkuggAALg4CAAAFYEIAACUwAgAACI2CAACUrgIAAZinggABYjgCAAd11QA==
Date: Fri, 30 Jun 2023 11:38:49 +0000
Message-ID:
 <PH0PR12MB548107B410662A97A3BD1BEFDC2AA@PH0PR12MB5481.namprd12.prod.outlook.com>
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
 <20230629030345-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230629030345-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB7974:EE_
x-ms-office365-filtering-correlation-id: a280fb4b-b62b-4e30-9f9f-08db795e923d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tih4ITxMnp1QEkaa9y9cwl0PaHGXQyPk17fxcPGbZJv9tpQ5nZNs9+Av1gIPIRB+PWJ0/Mu4tElhseSnzNPA49W5r6HYqy0RnfiTSo9L4tU1QD6F0zbS8YhJkvRX5gkLqSJMI4UZmTUC+rNuJGcaoxUT8/iv5PifsFEeT8exA6FNu2XHXAZUUwNLB5D/B/YvDYILSApcHa2qrUAeJyFhyMGk96JfYdv4FVXXWpfmEF+fSAZhw5t21pYDlzr+fXP34DD70PimW4VVFG8sa0V7MxfjzkGqkphjdBH41Gy98b4t1aktI725XEMw+S4ddettpOejESaED3NI2JH3InEu3Cg7hk6z/gq/6xHYiC/Sx7d2bqfZIR4RIRGSDQgrDD6Arc1JW9a8ngvoXNTxy3DXuQUoVuX7LEzPGpqrlsicXIHvXoubbRHN/cLgyDieP+P4jBoMt+Y59nj07bkALv2xJ0CiV9cV7bovg3TbclbFWlXcNxjMgLQ0AbSwePqFjbOiDnU+S9Fj4fAvDORe9VTm7Rz1t+gMFbo2hoZ+xOmxQLqY8sTqeOTP12z+nWFMrSvorOqEYB0sGvmo9d+/odV5Os5pczImct5ZOgcFXczi2pvD4a+lDDt4UXtnXO6LC9t8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199021)(76116006)(4326008)(316002)(66946007)(71200400001)(478600001)(38070700005)(6916009)(66476007)(66556008)(64756008)(66446008)(54906003)(86362001)(33656002)(83380400001)(186003)(9686003)(26005)(52536014)(2906002)(5660300002)(8676002)(8936002)(41300700001)(7696005)(55016003)(122000001)(38100700002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kIkm1WU0v41txrMUnhlnlW3MtK+ExzqVpvXCPTlerTe+QlsONBOxOf8BoJ1H?=
 =?us-ascii?Q?wLpz9pu8RGivU9voCig/L3e+g5uhYOuCcOXyhvTEsCIayb6EQgVc3J0tQva6?=
 =?us-ascii?Q?qljDmhVa0Z/vkCLeYfPJ1vQ+9+O7tjsY9nfpswZ4XRxcgZcmtPXHHdypdBRl?=
 =?us-ascii?Q?8DHnq6uPYMMjWeNZrF4HYxp/npMXZEdoqZ+sKK3JetM5BF63soEI0PglHGws?=
 =?us-ascii?Q?gV8yU7olZZUxtlOftZuwaHi5gG/R5v6gd73rd0lD2uzDgdWMQbrZjIlKqdGC?=
 =?us-ascii?Q?W2bG24GhaUNVIeSrSGmTg2mkwe7nprHJaS+rwTfN7Xfi8B8xroUHAwYSR7dR?=
 =?us-ascii?Q?YeAkl9YbGt8gen9b3Ew7dzGMv2feABmr4rkw/MmqATjHKqCSphFDUNT66skF?=
 =?us-ascii?Q?VJaD6L4fVvyWrPd3meIqHbgdZF/wb8vsPfxwjOjtKgTj5HLWDpzQ+TYYoyVo?=
 =?us-ascii?Q?gRmw6/A+eOoG4HB4CgFkA+AuJgI7Kk5dP4PUApMrpo1xLeaa3Pvv00dQMTyZ?=
 =?us-ascii?Q?b4Ew84MdnU6J/eKAUyLTVGrDxvjVcooUOy2Gml63ZQjoQYl4CYx43rAW/r7C?=
 =?us-ascii?Q?8M53DVDjCVYANPMd77399yKBRfxwWpjzb4A1xYXq/usKnVDR9dy0JBW8GZ/O?=
 =?us-ascii?Q?YdoYtFl6AypR1eO0VAnAtkW89GcaqGC8e7Y3Y/oacttrNW37i7usrXtioLCP?=
 =?us-ascii?Q?EtTEzMWbDvdnLoh9jIHNa9AavMTvNcEqgQ3vfexy1Zby3sZinY0UtNJWy6+l?=
 =?us-ascii?Q?/L0ILhQwz/KiulP9aI1p0tBM7b5E0Mkfpr6s0qJK1N87JYeXSCiaSEsfEwE1?=
 =?us-ascii?Q?g5668eMw3gPUUGR3bwdhjNtTK2JSIPy8SBahehLSM/yErDDeKE/AUeZj83T9?=
 =?us-ascii?Q?a7zNEOWXN/Ib2jMNp+cZ4j42YOu4ye2H764eAYkMfGuPoF1a0Dg6vHwGhzpE?=
 =?us-ascii?Q?ckuvlKQn5wIk9Nx+xlZKxaDlQFLVfGTAjIk7iTBJUZIlip0IqFlgT+UtKg6W?=
 =?us-ascii?Q?xe5Z6joM2a8MNxSxJ8l/BuuSjJeMvF73TvCYPVtjtzBkYeKZUj9Bg1PxpyjV?=
 =?us-ascii?Q?wEIMrQvsT2+k2Q6/swUe7Po+T3uTIRBa/K3kasPA8Go0N1pSbryaybEws6xL?=
 =?us-ascii?Q?FO4BMdL0T2lJ1GhM632OuUha1C/NJ5ddOaXELxVMUKd09QfDn58s9pZzZLq6?=
 =?us-ascii?Q?ayQNpakeVrloNkq37+JHf6skdynAhZ1YmoPj7sNqwJSSQTzKc/1eBADRzkHW?=
 =?us-ascii?Q?fQv+8v44bJFblc2AiCu3Thv3frqOKBTNWH6pj57z3tsu74Wr3+hArrucmP3X?=
 =?us-ascii?Q?Y/6YXpi2elkYP+UNIKKPK8XMXTgGW1KlID07tAzj3P7q4+6bLtmKq/IQ3yPr?=
 =?us-ascii?Q?48lRQ7Bxp+qxSaWZrON/VctD4S/yyWgPasKuRbHbAQuPoEhVcTLCSY7lxRJV?=
 =?us-ascii?Q?fRRbdOIO7XvXzmX8JzNsa4f9FQQ4zWKbi1outG+A7ohpwyBy6BiHtZbBYBio?=
 =?us-ascii?Q?q50u3rjnrHRMETt0wF54CpWCSM0+gzsScBRyTUaaVifoLeP6KsQkiCoPBjob?=
 =?us-ascii?Q?xMPFelGM70YTQBfDutE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a280fb4b-b62b-4e30-9f9f-08db795e923d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 11:38:49.0198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iaXgBF5FwsDKrB9uwzbcMj9Xmg8GVtHJX+5NLKS+fTnFzeHljcbO/Hh9J2T40QwRYV8bJBNSd/ASr5i+7Q4HDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974
Subject: RE: [virtio-dev] Re: [virtio-comment] RE: [PATCH v19] virtio-net:
 support inner header hash



> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> O=
n
> Behalf Of Michael S. Tsirkin
> Sent: Thursday, June 29, 2023 3:07 AM

> > > Well SHOULD also does not mean "ok to just ignore".
> > >
> > > 	This word, or the adjective "RECOMMENDED", mean that there
> > > 	   may exist valid reasons in particular circumstances to ignore a
> > > 	   particular item, but the full implications must be understood and
> > > 	   carefully weighed before choosing a different course.
> > >
> > RECOMMENDED and SHOULD forces the device to support MMIO, which is
> not good.
>=20
> You said this already. Let's not repeat ourselves please.
>=20
> It's a single word. We need to work on a patch, we can argue about small =
detail
> once it's posted. It's not in your list of plans so I am guessing we need=
 someone
> on Red Hat side to work on this?

Yes, I prefer to work together and before writing the patch.
As just DMA for config space is only point fix problem.
So lets discuss in new thread and improve this for config space and also ot=
her limitations (like support multi-address VQ).



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

