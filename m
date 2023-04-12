Return-Path: <virtio-dev-return-12194-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EB9C77B73
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 06:02:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AB2092A881
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 06:02:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8E780986549
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 06:02:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7FCCB986509; Wed, 12 Apr 2023 06:02:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6C79398650E;
	Wed, 12 Apr 2023 06:02:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKkzEUFR6804jOKjdgYuRSA11VZgwMpCCCpSgX2gy0W4aZ/vfsHrziGWDM6AzkY3fI7qclVR6lnnPcTqXeT+05r8JlweVkczmnoB7LVCdnw9/n+mcqsZSyr2QqHQdBgAz+CvyMYThc2EQ3lZy0vDX0Iv4sY9472+D5Tcu/4imFwohvPtpbtkwtgKhoxP/s1rYZxw+KqncdtreUYwxPbk0RE+imNGsuhPWyXoWx35BUx9moZ12CgmwzNuHhG4gikvqnomKn5dc1ozhUh0y4kzCmigRcLJi4z+pyLYJ3WRsIsdEle/9URe24YFtPltIq393MoZDKjumAMkRIyuvOqxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEM2m8LxOCgzlfF5m8/lCaFMWzqX2ZOZaRkamtaisL0=;
 b=Hx8B1WCb60kfX7ZBk2/KcIOQPNZvwavGb6+HRHbpP0Gw2/ZWomZaOiMw2YMmLBN/qvHGlK5A+jSBE3P9/Q8Rvw/7mypCI6PC6ZHugqr1tz0szrdGGLEAFltkztsy4vMW11qqfopVwwjV9NvJ5fIDog4ImUOg0a/xvZncSyWikiVZ5+u3txcsrS1V7UGRnfrJPeYhb1EvzwCRrcvUs8pEGIVqMfK+UgEkw4kKbucNLWxrwpiEr8CuAY8n8Htj6mwxKoMyw2nlbFrwNoo8EQSfg8eQWHbG2bIZRY6629MxkjULGCjYRr7hrUu+ReLKgEWB3Gpqbe3te9Q55sV08ZN7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr
 pci device
Thread-Index: AQHZY1tF5ObSeHDFk0eWHj0gIzL7fK8nLToAgAAAdXCAAAY+AIAADdRg
Date: Wed, 12 Apr 2023 06:02:39 +0000
Message-ID:
 <PH0PR12MB54819CBDDF3D127978B3F638DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230412004331-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC4B82A0A57F08ABF3F7DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230412010437-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230412010437-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB7498:EE_
x-ms-office365-filtering-correlation-id: 8f58e5a3-dc56-4921-ab04-08db3b1b85db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sxJMkBbHHsbW57AF+np7scnMZB5+xlUSz48wpjt4YZ/gV90sywHQwmcWNVHzr0eTarwadimYW2D48eL3xD4e/WShVFll/astBR7dgA9t0rA15Mn1MVrit168HpdjTwVy1nXzKDB1gMYt2Pjn/70Dkvz/7qvjFPpvuutksbz39UJZ2cGazTVAkBl4XNdBtdNvucArDVGYSe4qek7RlzCQvYMojldCO7UifLd9AIumPznSASoNxppY07ZJ4CCt5qTeupgS1Ave+XrABabHymLCz472zTB3npLdC6Dy7JQcIbXaIhXvFdobLFeL32Fymt3+6dk0fwGVG1srRx7Ojyw7/9kM7tO8kJVeP6dcKry7trPSiPLUSnmF9y2RrBDfWEyhSYA3kha8pgi1vE4S2339V6H/A2hJYjIznlKXL7IZSOm4fWhKyLek/k3LjdoJkM8bcHvc5tUtNWr0SjGBVpZ0DqfK1b2aAJjzd/eD2SUKj/bd0GI2SR1q27N01uyBSbKYUiMFO45Oa513DchbgBQLeNzJlZ1YtROsdqTWlWK8a0yPXaTwqKuBCDyKBrdyetEzk+EgWkBWS4o6oP00ZQIUPAe8wKPvngkdkQCsn2IiCkeJdolxyZfVcAz+0JwpfOFz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(76116006)(107886003)(478600001)(71200400001)(7696005)(186003)(54906003)(6506007)(9686003)(2906002)(52536014)(4744005)(33656002)(5660300002)(38100700002)(122000001)(66556008)(6916009)(4326008)(41300700001)(66476007)(66446008)(64756008)(66946007)(316002)(8936002)(38070700005)(55016003)(86362001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TcxkyLLlE+5COkOUiL85dNSQpL7eWzLB68fd0H/w0Old5miWSqcL8fZh+Iep?=
 =?us-ascii?Q?+GTJUzSy0a7m771QipXJFU2e5kBJcMkDXFio2j+E+HD2WrTBigFZ3sM0ixBI?=
 =?us-ascii?Q?sAeDTYcB2m0U2wZTLavM+YdUHZaqFd7O2vwpBimLPRydL0/LbRiBpjJEjBMu?=
 =?us-ascii?Q?CRUkw6zR8xLZipo4aBdI3N1AruF0qB+cNVeBGLRWqX6UnjyXGx+AcrWiw+qm?=
 =?us-ascii?Q?TOraQ95Y1gsLquVScz/iM/BBFFCrFKejWhSSsE9N+8i89vvkUkBY/nQ/ExOq?=
 =?us-ascii?Q?IfqCSEPN95iq51YpRRBTCbj8Q2BS3PieKg/kwNCX8YBVgWqg1hHgEtjarJtN?=
 =?us-ascii?Q?aGchsNe7J+ou137CeB3i62PJQPg5SMS43HuOBqwr1uFH3p4tyoGjrUXQn/U8?=
 =?us-ascii?Q?0/tj/pUzMH+DO519kYkRcARM+jzzSW4k6gw0TAR4eJThWaH931mAceKRnfma?=
 =?us-ascii?Q?lCgWVXuKsjrXv2h2OLVzu4V5vbYbTM6t5stytGs2BUBDAix965STIzgdKEUl?=
 =?us-ascii?Q?xcWu3BJvlqF4awP5rPoriEDIlmHoQyHlhF7xfRBMKY7Bnqoe9G9FD2FSCll/?=
 =?us-ascii?Q?JRhYuN1kPphhW6srm8uItYlJKyN+LqQJGacplf5fco6suJdOiFuWyliphTtL?=
 =?us-ascii?Q?iwzL2Jyy/Aph3+twQMdvVoZf2Q+VUuUa7Qku0KYgNY8isCVaChpaqPM4E//q?=
 =?us-ascii?Q?ajlpMnwT2v0N/dfWFCujKAlO7OyHtJM71vPrNs8KQPz8IA+9y7u9Se9wrEgQ?=
 =?us-ascii?Q?d4iOge1Mnlr8jdj05cTn3CMHX9VErqG5sy7nqwNAmQfpZaIrPakVX7Hd/f79?=
 =?us-ascii?Q?6pmCRh4tZz/MqNxhvrF5NnXvXclIESdOUEDyojjPGXvu8emvW24QDe6IPGA7?=
 =?us-ascii?Q?EW0qFNdgOxTdMgvkws5buAMGXZvpAtHqn7+L85skgJ+tkPFHzud2dKt+pCWa?=
 =?us-ascii?Q?me95FEK3xRdOnH8JP3wE+yrWBZJDZwSNBW3irPWujfem9oZtqDR7KZkZkD3m?=
 =?us-ascii?Q?+YDX6Ebh74gokXs6+LlBoFfXtMWCYevnWdRsl0HkNZUECOYnp8wL+uzjgcbL?=
 =?us-ascii?Q?iR3J3kGn4mDSCVBjvs/gKIcKbbfy3tJHaouwXxJ9W6wXRQpjR5aKecC1T/UL?=
 =?us-ascii?Q?AEAcW8p6bLiVDL8kzMTgejee2xEq/Zia6Vo/8rGBKCfIkLjFm8/QdQL0kHhA?=
 =?us-ascii?Q?yUihatufFveSY17T+ymEFxmhRBtLBEAOIR1WuXNAFMgTAkgbCAxfb4JnKHAn?=
 =?us-ascii?Q?tyLMN5GPCGtT3CklFnnrsCvedE0VvKCYjnIw6Yt9p2UAg4A7C3QfDu0muNRZ?=
 =?us-ascii?Q?uBYOycSd4liJVRdnfB1P/t8ZNZ/h04p4ksgs58t82w+cxcWjgJr9fa6PJ6IW?=
 =?us-ascii?Q?0f0W7WA3QE2FFy3+f37fOPWEXhpBjfBuObWJzHTvQI6l61AqyHnSip6OM8g0?=
 =?us-ascii?Q?X/0SpiBNowNEwv58ouU9ksRVC9RlNBi64CoySoBC3NfOcW5uArMHNdalljKl?=
 =?us-ascii?Q?C1eVPaGiJtOyWl0AnhI+jSg7gm5JeZdPu7WWZyh4psjwCW7hK8qpaIlL2KX6?=
 =?us-ascii?Q?qHyeHsWEuoVeyF3FIrpOD5S+LYuTp5ErZaPH3nttZg0sZashxEMNo9aeYuxC?=
 =?us-ascii?Q?/vo0cu950N57+XxMpFq1Bdw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f58e5a3-dc56-4921-ab04-08db3b1b85db
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 06:02:39.8559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WxfJuu2/JrPiEXAxvclsyiu9UOsQatcfkHrkemvAB4JcGXaLXWpkuQBtaJg5FA5FytDdr0WwvsLk4YrJ5OWylQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr pci
 device



> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Michael S. Tsirkin
> Sent: Wednesday, April 12, 2023 1:12 AM

> New issue I found today:
> - if guest disables MSI-X host can not disable MSI-X.
>   need some other channel to notify device about this.
Not sure why you say so.
MSI-X is not coming from virtio side.
So host will be able to disable.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

