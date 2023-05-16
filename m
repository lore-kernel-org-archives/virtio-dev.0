Return-Path: <virtio-dev-return-12731-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD40EC77B7A
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 20:59:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3BBFF2B04D
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 20:59:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2BC029865B0
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 20:59:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2020A9862F6; Tue, 16 May 2023 20:59:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E6559862F7;
	Tue, 16 May 2023 20:59:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXZiKLc2rnxv/nOfpsgnPlG1DqfhIOvc8hSgEfWIn/puPRS92H3rtBESO592/RIC41zUbsh5AFQX6AWKaT9JAXgEy2mPXB75B7CfTZ1P8sZEt2eWlROmmPmgdc266m+1FaT0eNTtAg6rQGCjeWvOLofeOoL/7NSFZtcxSowq/EiHWzBs7O/gWNVoTfIkLR7WLhSSbj1fUMamphQRsuwQQ88DcYYEfUh5SE3Ysu4MSgivcycLGs3Laxf3WlAsMvUvW3e69i393olZqcZg859SotpgYB/ejt743HWKkdsg+s1zkClrHY17jxlEamKzsldGvkLA1R6BkAa0YjP1KJzvUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qpEsiEYOlux3YKJADd4dqow6u5VMJAc12mX7iWIvTA=;
 b=FHD6ibX0tdJHltep2hgb6jY6/jE12DOtyhSKwWke4jBpzQ4Rl7YiQ6rVrhtcS+e9pB5RZ5fAGSQvxkZdfmbobey1flcadyErAjZqUO5pKkKTRhbzA7oBtwUlSKJzfaqWM9Hf3FAjYuCaCtjGaktf1PqG3yqqg48KowEDqVPnKbeAFkYymawU/wm8TszFyovDcmX5UCztlqPYAYrNKt0FjDzAE23SWQGUXQEf8ulS8Do0Nl1a3PvfKCAbX9sjua/UnA9sZ+YPdGoZzQqm2edSpqaaPzQyOO5YCObpanH5gVJ3B0ZVboD0QUeqYRwZquelyI94ohIF8eZxkuu7DWtzsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH] content: Replace guest OS with driver
Thread-Index:
 AQHZh6LOHXgJrNfl6USbWvfsD1oXE69cZmGAgAAp7wCAABxFgIAAoImwgAAS9QCAAAK9gA==
Date: Tue, 16 May 2023 20:59:32 +0000
Message-ID:
 <PH0PR12MB548155D503296E253EEA0395DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230516030139.767838-1-parav@nvidia.com>
 <20230516013842-mutt-send-email-mst@kernel.org> <87lehohefn.fsf@redhat.com>
 <20230516054313-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481451FE5B75AEA9864C0E1DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516164254-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230516164254-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7098:EE_
x-ms-office365-filtering-correlation-id: f46bb2f4-50ee-4791-5d31-08db565072b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qY4LMW4YimUFs3cgFd/WsycQ8Xny0V5yStlBO8nk323bktisUHKh82CDviLXXg8dhNcT8vmG//Lgq9XiOvJxRnxtY/mmfEcYRrILrSSlGg2AArjjATghe5mPzVMS6f/T2OFUk/4lvhIlXKOPTiOtm0zEekhmpSeglvQqEVHGenJNqMyTdlCJ1qpabuxHcelcidBWE+QTrH3qU11tvWaaAdekY5gHomu2mpWonQUE2KOanUWrcbYCLMVo5IkXvAXO3W9KcfLQ9UoKUcZ4hRxvk9JXtWt+xSAbyHzzP+D6jRpTDzNuofsbhT7uWY+ciztr8XnDh0xmm0GfVxYGCwZFuw4XwtnOV+WohWJPTWweT+oBaudgzZRdlx1HXHhbBoSoqibHw7vvIi4V0eJ+LwF6C2Q6NaCt1JIEx7AvhEB9HoPjEIIn+nRDM0+yUO+AMOzfWAvlkRF84ofUe2e3bP/4MEwMpqJjApRso9kehGHg0+9z+CKk7aZXXkPHYDmwtAiuBOfVxscxdwzvrXZA66ANK+MfZ1ulurVap5H33PevuWjP05j4tmhbOKsvQ5YwP6rObnGPZ72w/8Y+sfm3ee7Ax0m9mZdcVbS09YDsxoe5GI6PagDmS+iDDF8Pedxy2IYD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199021)(86362001)(52536014)(2906002)(66476007)(66446008)(8936002)(8676002)(316002)(122000001)(4326008)(6916009)(64756008)(66556008)(76116006)(66946007)(54906003)(5660300002)(41300700001)(38070700005)(26005)(33656002)(186003)(9686003)(478600001)(55016003)(38100700002)(71200400001)(7696005)(6506007)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pXiSMEoZ9cftPzHrQcTorV5P/oO2eyfNaZ/DsaUKaarCMSIvLSxz9rtcIoYy?=
 =?us-ascii?Q?xBYUmfsem/ySaALcd72Oncfi7WKiXNUJZwDD2pkqYSNCEU1ebYVz+JINJbEx?=
 =?us-ascii?Q?+jOAOgpcD9T7PI/NzQ752Zzwe+FtAihDF52z1ivJXvTd4XQcb6cJt/dOnfE/?=
 =?us-ascii?Q?llrkCO1eILlRyhrcfzSIbeBbNingXVmactCrjVh4S/RoJyhlSJMALmeY6SaJ?=
 =?us-ascii?Q?pyulVDBMpvfdAPI+fGKGuDUN3hsGvWEGGfTiEMLnetUHAuD1ove4NDGX70RB?=
 =?us-ascii?Q?/CaHljK+fbXlrcuvqdu8q8+nYd2j0j+CsweNfY//wx47xneTw3flAxKKG/N1?=
 =?us-ascii?Q?NSL+UrE0Wx86xuy+0lRcX/Rlpy0wsy49uBf8tXqr2WSM3nEkZgByRixy7gXt?=
 =?us-ascii?Q?k2bDEiFWt5VzQGrFFTqJV5Kk98F6h/K5q6uQYNfrSoGi50NlKngshqv5Bc2l?=
 =?us-ascii?Q?FLwLVjB6KRoFtkeFzuGGSg/H7VHwA4fpxpjJAAvOlTF/WdhKa0i5GbD2z0x8?=
 =?us-ascii?Q?BUsxTP0u6Hau0R8xM1Ihp/xg8QV9que6HH77oaAOeu/1qQJtxg9ts+w3KIgX?=
 =?us-ascii?Q?WsICAZjJKXHKWBQlW8B7HZAhuRwl5CZgjzi0h5QiPKUdSUQRU/rmPW6RU4S+?=
 =?us-ascii?Q?XsMtMiRYGKcayjLE6a88F81v5cwWKLne+3DgraPFedJCbXy7luTmxOf2xDnM?=
 =?us-ascii?Q?i35StSOb4KwGdb1tOKTyK1ndEHjWyN+K0kPHLq2M3aPCoPuJC49W4z3L+ppg?=
 =?us-ascii?Q?Te2xi2KbSnj+XRLDXAhBIRiojIPWV/fao5RSUM4b9MgYd4Mo8pLU4sV+yKl8?=
 =?us-ascii?Q?uId4Nqxd/fzalxvVAtuha5S+j0O+877j/+2h/MSbSeVR6WObCaMhYSiFN+Q3?=
 =?us-ascii?Q?PjIKd5ofhHjTS6RnGeXOSLfDIHsnCkSLnDV0WKhT7FL6mk23kWsF7o7naSYv?=
 =?us-ascii?Q?TV/utTsIuc8otWw6cN2QgcfcUMD+ZF/aCCO56LRLWaJ1B95ycq0UzefE1ZZT?=
 =?us-ascii?Q?QeuA9xX5AW7vYrx9yqQTDUWGR5DUWLYXdq/fIRvC5eDJ7Yc/D9W443OUElgZ?=
 =?us-ascii?Q?4yi94ZqUeiESCn6NUJ3wHA+h9aL/Hy6t4tqIWhmF1zZ+h0d2E90iefVTTYEH?=
 =?us-ascii?Q?ubqcYVpIL5ajPfHhF2gh4oU6pJj2qtnxeYfBE7pXXqXBDlCM00q8FHIlVUQZ?=
 =?us-ascii?Q?p7wyDOVqxZM9MRYnhUTBB0eVFRR1EAVNNWpA0hlLTSix8cipkIG7K1kuhYW1?=
 =?us-ascii?Q?3uNOqCSdrOBrL0KARgHK+8dasopL5as5A0gDFQqz5bfpn0oL/Mzs2iW/3OdG?=
 =?us-ascii?Q?oVaV9PSWZ6KLDZnytIYucCL7jX7IUjFuS1Hp2QtllJA/xCDRZbBZjt1kJ/Us?=
 =?us-ascii?Q?P2hnKriR6jJHpFz3IDLX9IQPS4oEIoYDUPZHq7lCB9WEi3R593mdMQNjvNuf?=
 =?us-ascii?Q?SbTfUK1DIGGx9OMyVXDkDokH9bhY0lfnOCmYTh1hXZrAOaIm8leiUa5E6+f+?=
 =?us-ascii?Q?meUu21qdTMEyhE3V6Hi7g/F3L3kxUNBnydAZ4cw0bZL+pI2cdnShr78RskUz?=
 =?us-ascii?Q?GINlRWXJj5k72XFr5oM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46bb2f4-50ee-4791-5d31-08db565072b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 20:59:32.4363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJi+YPQUbA0ffN9f19ENJYcEce88sxYbAUQJC+IpqAAyQ6jHvH6OrpKMWvNR6yuAA72PmeHLrWO+vxi7zu3USg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7098
Subject: [virtio-dev] RE: [PATCH] content: Replace guest OS with driver


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, May 16, 2023 4:48 PM
>=20
> On Tue, May 16, 2023 at 07:50:48PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, May 16, 2023 6:05 AM
> >
> > >
> > > SO I propose:
> > >
> > > \item[ACKNOWLEDGE (1)] Indicates that a transport driver has found th=
e
> > >     device and recognized it as a valid virtio device transport.
> > >
> > > \item[DRIVER (2)] Indicates that a device type specific driver was fo=
und
> > >     and will attempt to attach to the device.
> > >
> > Above bisection is a implementation specific example of Linux (though v=
alid
> and widely used one).
> >
> > The UEFI virtio driver doesn't even have such two drivers.
> > In some OS variant drivers are merged to single kernel binary.
>=20
> which one?
>=20
Flavor of a RHEL has inbuilt.

> > Does driver only matter with device_driver structure or module binary?.=
..
>=20
> Can't parse your question.
>=20
> > Driver is largely the software entity that drives the device.
> > I think we can keep the spec simple enough to not mix these details and=
 just
> call it a "driver".
>=20
> Not just linux there are lots of drivers like this.  the two bits pass us=
eful
> information the way you changed it this distinction is lots.
> I agree it is worth thinking what exactly does it mean.
> Since you researched it - what exactly do drivers such as uefi and the un=
named
> "some OS variant" do exactly?
There is just one "driver" virtio_net_pci that has sets the required bits.

> when do they set ACKNOWLEDGE and when DRIVER?
>=20
Not any different flow.
Entity is one.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

