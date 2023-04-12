Return-Path: <virtio-dev-return-12179-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD42C77B6E
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:06:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 864D82B362
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:06:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8066F9865B3
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:06:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 73AB9986509; Wed, 12 Apr 2023 05:06:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6279698650E;
	Wed, 12 Apr 2023 05:06:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnaxLqZ4Til/FwwIyIkfAf3XT2lDV/3iFNXdjBgdlQtIZglpgOTPPAI75CggDmgQ/6I6Cvnz90DHFOxOHCzabcxL4WVIkHe80Lg0DtDBmNANBKYNAbRPGCYSbkyuaCfXycZEKfzcc79lTsBaQ7dZCuvNeYbnqdUxBWv1YC2IlGH8juHMFjqrZmvGKPy5DHPFxIIjyyR3ScbleOePZQuJXebIUYneG4xm8nLmxd8Azuc/EX/Y4MeEtpLqm+D7caXC2XIGdeoAPdOKsHQ8xV5F5a9OhLOer9vKKBb/pRI2otv7ONpfahBJkWjNKweEL4XvKeU8Z+DKwZ3n93xbyuWcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhGNPU5lQBrX0twQUtL11rh5bEHucAcZvKTyXzoTwIg=;
 b=auBW9yjzoBX3C+gIOswhqs3JkOJehwxom0XObi7IL/x5g+SOsCKzHmF7th25W8TVNmOIk18W/lR2G3QqZejgDHXXO277LR6tUBo2fN8ajiTtxKlI6fjWN0QpVSVAiQc+W/PtIxvRBG4hOOJhBJZiTUJZK3Qf8uTm0aqdJ+KTGobSlQKx1TmBFecXi62tB+zAHxOfZyJ6mZ5n7RUSNLMfutN1EP4oKVaTr4shFDynKZ5/TKuYdET0SG2vk9mQ1S9zL72xKvWMV2+ekdyrKj6WDZllE2LTR8rxrjhqBnAMveUkZR9/ybdZXF+gpxsvhmC5OPKvQmCtgH8cC+NE1HwQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [virtio-comment] Re: [PATCH 10/11] transport-pci: Use driver
 notification PCI capability
Thread-Index:
 AQHZY1tLBn6tX00VoEql9uT0hRsw3K8nKIQAgAAAVNCAAAL9AIAAAFBggAAFNICAAAAt8A==
Date: Wed, 12 Apr 2023 05:06:09 +0000
Message-ID:
 <PH0PR12MB5481843F73EA11341608A1B6DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-11-parav@nvidia.com>
 <20230412003006-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481394D07C5CFBB2347B5F0DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230412004152-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548170E8002F19709C6D55ADDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230412010224-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230412010224-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM8PR12MB5398:EE_
x-ms-office365-filtering-correlation-id: 6276c3df-a002-4947-dfa0-08db3b13a0c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jXgvyhQVL9WrAe88WAdD+4TEGtmdkQhEBmmfRXdbGUV9h0fQMUPBq0G8JhvJSfdynm38qUq/8jRq3B4V7uGPNcDgLyuNYQwj8dKb5uuEyOzQMxvVZTaj487hAAvpHcq14y7C9EbAumZGFL8UOj0vDbFFDjC6OoRZUgYt3nltRmqJ1rNbd4ArhuniFuiEpvgRTUT89OX4Q2UbO8kmy9DBpEgDWFniIpGNoL78ZjXJeqNXWJIazfFn6zQj1hMqlfwcs3hXtLo6FiSdh5fYLGQmlM0UrpGQ+jskqGJtwJCFObLgYPMce+i49c3JpMou/+T4xHmGQE59b6mRAjf1gPpTBWW6t5GzN0zM7neWcPShEC+5a+49r5471L5fH2DOG3yS+IeC2k9XogO0sQ6lmSYswZ43YHbvvuFx6/tac9DtlBJSghq8Eeg9A1+5IDLq3bldiovkS6wsTjb4xr7tjLlKFj4Wc4hQmcG6hzZ/OKmWQ0SHey64uX30xpLeQjkJ2HIMF4afm20VMc4izcOSd8v42n7R68YM5QBWuDhQ24txnTPy4jHjan4YrqIgx9w67yB67BW8KRNXvynzUsnfChCLzmImsWhbIkbj0+waG6Q5do3M0sGHzxrVgOC0Vn0D8RT5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(6916009)(4326008)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(8676002)(15650500001)(4744005)(2906002)(41300700001)(52536014)(8936002)(316002)(5660300002)(478600001)(54906003)(83380400001)(71200400001)(7696005)(9686003)(55016003)(6506007)(33656002)(186003)(38100700002)(38070700005)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Bgq6L5OkOnlV9bHEsFOktmMm+fkWTgoNpjoHwZpq45TliVf5UcjfqudPPOKC?=
 =?us-ascii?Q?gy9RlNV8R6rgUlmo3U/IVLDKSCd1bMROwmJkwdfTOmcH3USee1FyGRnjm/eP?=
 =?us-ascii?Q?kjUdk1GMQ+cAPl7IlhYdJURsF+vVgUVWJKn9fj9qRlOZ8d2AUHWaG+EhMjf5?=
 =?us-ascii?Q?dN0OlsCkO1NoiTNvrDayWYYyUCrDtOnKq9ztBoN0t9BxleYYZdLVpKVzUq6Q?=
 =?us-ascii?Q?IEkV2YM8qRkPDXmpZd6EUUHuSz//iYzgRPoNIkM3ieg/3WF+3j56ZwnBdDfU?=
 =?us-ascii?Q?EEyZCeMa1eQPlk2Nkpe+c6PVE10STnRE+/1FSyiD8qclbiKKqr0jrZEjy/8P?=
 =?us-ascii?Q?IyZ831YJIDvRX4JM8xeZ+/LIOwBqn44zrh7uCRVZjum34+ap43n1Gb4mmVNp?=
 =?us-ascii?Q?R++MMiSVHGP5ligcc++aUZuzc2A5s3dY0gyqRMaktmXLLeKIKE7OFBYM+UHY?=
 =?us-ascii?Q?htaXFUr/zqlQ13+gdlphXLuYIZNKCpUoLWfMD1AaQxox3dJ/QGfhGAlNkLP+?=
 =?us-ascii?Q?MeaXVUXGtoy05BHXEgWK2R6oVT9q81Zjnvr6VwFAe1iqC3jxGftIZJFRLZEh?=
 =?us-ascii?Q?URvet/dmyKUWq2mAZDCbp23YM1/b2A9aKDoqab/MAlXigkccYc9xJqXmmu9o?=
 =?us-ascii?Q?/Clv8hMcASgimgh74J7XfEt2Rn8cDKMjk4GJ4Zek+JCHgwUht95l4APrMeTh?=
 =?us-ascii?Q?+TSVo2mn4QBguHEnSaMEUx8qhh5fT1ymOb9WmA3176VZXt5eQ3fX1z8d9bz9?=
 =?us-ascii?Q?QnRMl1lAdEJyRE//EaZLmZUDRt0/ktyYGxTCZMgdR7ZEbdllRcN5mpND3oZ4?=
 =?us-ascii?Q?fEGvp+a04CQwmIBhe3e9GrUc33dsXLk0I+DYd9sawv0T+03WRHWpFwf583m4?=
 =?us-ascii?Q?4QmjPpcSWBFPm24QSrJB1qU+op9rPSgVZpG0F+JxkfMhyqtZHBS/LXcsphrq?=
 =?us-ascii?Q?KiZpIuqi+6N5jLj74JOqpMuZB7YIGrd8lOKsTBndexdHkph/Llx92cACASYi?=
 =?us-ascii?Q?Q+yVI5XuF/gFhXXuKaX8Ue8LIU6poWLuavqIhkbwUJiXJ/taBuyaBVmbJL7T?=
 =?us-ascii?Q?jqUGOvhke/HFvAJUBA5HO/fVGj4UTakFBrRjkTyBkXpZfbn4x8uLkmN150gP?=
 =?us-ascii?Q?y0nsDlC0AJD41pcHsx5hbyXTrdBMzIjertnNfM+O9TTcfeGFc6eJqaQqWTLX?=
 =?us-ascii?Q?wKvh2Tgl/O9trYb6+yvHZ6OLqLWuBqbnHSLjqw4Zva2VWybb3lljN3fYSt8v?=
 =?us-ascii?Q?hiXC86jDTK13Zs4dqec1SBp1BJ7apBTonrcBtYm0AGTc9BvUercbMPr0vCOb?=
 =?us-ascii?Q?tlAXQRAWFekvmTmzn7LkwNffw7YDv524HVJnGGQI6yGyb0W6LbD8r2ynFm2v?=
 =?us-ascii?Q?hNsea7+AJL7zY9mKUOtx/qisTkWo7w32E3ryMflCtQL4FAdKM0gRARMPPbo8?=
 =?us-ascii?Q?FTpGx3liOWMeyVjxdg6Qg2Zih8pTUI1jnD/WdhguVLqwVt/1Of2LPaS0ZwBz?=
 =?us-ascii?Q?ywx57ZhWnqVShZjF+o+V1ZzyKiaPhEr+tKuBS6T5BSfvCrxNH8ngWazg9OYX?=
 =?us-ascii?Q?x8bs3w2wzaTekAgyjZfxMD6sU7fHuejer9dXtDRbQYJvuYu3TJ4KL5wXaLN9?=
 =?us-ascii?Q?l/B1KHN2u5ZKhWk71ZI7BdE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6276c3df-a002-4947-dfa0-08db3b13a0c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 05:06:09.0499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJTcJjIGuolSuaFabr+aMrET7d5F2qZrFupGtb5PazE95Nb6EDMk1xdjUvHRho1l8J3nLugovcFF16YPwUjBQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5398
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 10/11] transport-pci: Use driver
 notification PCI capability



> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Michael S. Tsirkin

> > On that occurrence, hypervisor driver forwards the q notification using=
 the q
> notification region which is defined by struct virtio_pci_notify_cap.
>=20
> What is wrong with forwarding it on the legacy window?
Legacy window is configuration registers.
One has sandwitched q notification register in middle of all the config reg=
isters.
Such registers do not start the VQ data path engines.
1.x spec has done the right thing to have dedicated notification region whi=
ch something an actual pci hw can implement.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

