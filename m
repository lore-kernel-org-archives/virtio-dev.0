Return-Path: <virtio-dev-return-12495-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049B4C7EE21
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 11:35:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4BB0DC6238
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 11:35:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BCFF298670C
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 11:35:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 47A96986486; Tue,  2 May 2023 11:35:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 665BA986485;
	Tue,  2 May 2023 11:34:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kx3k+1+LU9R/MPIT1uirSBl02vC4McIfdkbnGPgbR1ekQCQ2BuWoWErb0q9P5mziFQMPPzaqmuF8cblkaerSN28UdA61bz6yuhgS14ctW5UNuabxGzCV4Z8KcG4I3rYpYzWBLOTiP9gtVf8VKBi0QP6+uve7rS3kvoW4pDBXLY25gzkIhe0mktel/AjJapADnxgx3fjx1/zCxMobvkDCIEqqMDXNsgwtJnyky9ut1+1BkDwJisBQ6au/lzp4SLNfpmTqFDHZ81w/e7leyCXYnrQtV43sPbNHRnVJMIVW2ijV/KOwyaB3na84eNR1XEE/rSr2XojLo6XuBgox8SbvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRLgvbr5tE7kV4At1oLcgXLQ6j2sOfSG21EpIwvduQk=;
 b=KwipOSTBUj8Hw8SiglavNkVfTTDfINUwqbocVuMS0SqSAOZZ5/6LdIuVxp7rVwgRptLz8qHeFTSlSUkgLNe/vxPpJlIL6Za1Hha9KpbpJIDCYD9k90epVL68LDRL0RUMhOge6Eb5/sEujUxm3yMthNS6gWLywvjo/AdTrh1juagXJMMFAximhMRGUQ7O8L0rUehy8HeIWrxpemg6vhbxvxOSLMeWSrQ9ixtx6phfpoAD6dnnFvZK3QAwdG+/K+/PLfzTb4RCE8VzvArgp5fCw7B0GLveIP/0g14rsJsSETkWH7XVHRoicRs4o3S33xPQ//9W74PzRewbYo3Ay7X8MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH 0/2] admin virtqueue fixes
Thread-Index: AQHZfH6IBrBdi0TM80ipNfcwwF3Nca9Gmg4AgAA/uBA=
Date: Tue, 2 May 2023 11:34:10 +0000
Message-ID:
 <PH0PR12MB5481C415A8E662A9F3E9A3F8DC6F9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230501224430.485139-1-parav@nvidia.com>
 <20230502033954-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230502033954-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB7791:EE_
x-ms-office365-filtering-correlation-id: 6e6f346d-1d70-4aaf-fc00-08db4b012614
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9Vm43YeYxYSyRrYoaqhHpSTzdd1rhTu15/6J/v2AJkwJEOJJlxccDiNWbptuD4Qkr9xiy4BndrrgmTWOu7zzFduC1B876arERfllNgO6jV+IHZpiiTf7nyMZjRX6RAS0FnjRZoTSBizlQuT1x9GFa42o5cR++nU4qcWDiKbGmocGUsAjp1dUaRSGs7U6G8Rs7hQ6Mcsk99xowVBcTbhzV/kKJ9x4lAOqqMIXds2bSmV6aK+NCCgTna7Z1uYFq0OzhjH33uzM61hyef5l0kw9gY9+PTejgUKJAMi6YtTlFQ9PuWD6U25V6zruQxYiOekbUABf0QmqwPjvkhf7iKSVfyYQRqZsOW3NeqdYisr0wjPU1fYtlyQVpl5zpOkD0iqKpG4bVJgLMAkNo3gGbaz8SfuJzMe9EWMOW/AfxWrsQ71lBiAsNYwk0/804C7JqXG3RiVn5TD+lcWEDdbYmpmHaPE52SsoMmkaGkZu8Yk3crpUp8yYYi6SgAIFwUKLjZH3BXdN5ZAHzILEVrCBgP/IeO/y+E2Q7GXxYoFUeE/dOWPBrBDnmnf7yq1dDyNXaiQYDmIBRQ+7lfB3BUHQOFsYx+1vLpxn+72iEkmMMhks4QxN077HnGP/cFrc8X+9UEPsWIciuqErubLDAduoz7bYRV/5+VDOPoj4Q2yCInrjX/Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(52536014)(86362001)(38100700002)(8676002)(8936002)(4326008)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(122000001)(41300700001)(316002)(5660300002)(55016003)(38070700005)(2906002)(6916009)(966005)(186003)(9686003)(107886003)(6506007)(26005)(7696005)(71200400001)(83380400001)(33656002)(54906003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MGt1av1Ewk75a1tbl+3FRJrEdynjyB26Hus8lrYrMrdSoavjR0SaEVeanCBa?=
 =?us-ascii?Q?6nQ3eJZptlQIawls3AsLPuRqvsAShROZM4WPRLy4zYQ2S8DatSQTk8UcIo+B?=
 =?us-ascii?Q?uznXx6SU0dHSAEe252zpOGaqny8HLUoKQ3XD4dZ5z2kYw9an4X5vuYVYM72t?=
 =?us-ascii?Q?ubjDBGQjIhjFWpusxahmIn4SdU2pvzeA6ANasiSDM7SvBybQfDv3W6ocABxt?=
 =?us-ascii?Q?IWSUWKTzef+LPk9QTe2J9AbAuj1/LVwOQRQfHjs+UTbXaLrFL7u4kolYFTIr?=
 =?us-ascii?Q?hX6eujLSC9/0IjjyN+FBzD4ThFgLBQte7aeoirumxhimrZkltIzcDqFftG+c?=
 =?us-ascii?Q?K0pKda5UPWBoZTzLNNLDwh34C+GZZrH6e5JL/sjdkxC63Ayk0Gr/8upAG5Nl?=
 =?us-ascii?Q?8XKDLYXCKzSYYBEy31JOl3AvNVq/9OW04rF3Zy5xdTQkeaISBaACNB5nIV6q?=
 =?us-ascii?Q?99SCbKFZs5acuTtQdXMt0QGqwQhfLQWiGGq+u8nyfUbm/ouwrvvp32xoYa0R?=
 =?us-ascii?Q?7eoT70MKhWQDh+Vi//vJUrWXnBU9/vAt48zXeuWDrKsGuW565kiooKOb0xHo?=
 =?us-ascii?Q?xsO+z2Ar6lHkI6N+rwoeG5R3KD+M0QQhL3nMlS4u4V0ZxX+Ie4BqPBnCVakH?=
 =?us-ascii?Q?fGM0Ia2P3olzwBeyjQbWzE9DuePoz6vvxIJCrCfCsjsb+QD2Esw+/0xqyzbt?=
 =?us-ascii?Q?pTWrE49qZJdIfaQ15EgyF27dJ1vQKwEamFCaTHDr+bKQIs7pyLXgaSbBk7TN?=
 =?us-ascii?Q?8qMRONmOp5CZcNoILrvBgUb9VprvSch2y6e5PoE4IGO0NIE2QKkyckBpTFrN?=
 =?us-ascii?Q?W2TBQ33ntJklyeInJBfLnaLZJyuzxeTbGmKi3pHqlLGvQiS4qa2ss8t2hElF?=
 =?us-ascii?Q?mlYdOpw9k+E2/LahPDjF+GY9ewWN2yrw5f02srpWia2PVsb1rQ/vCk/Ywztw?=
 =?us-ascii?Q?LO+LYR4YoQMeQSkOFGLvfUOQ6NfZj1gLeaAy6Q9kju2JXljdiEoMkYiW5wYW?=
 =?us-ascii?Q?mr0F0qIoVvAe3PN9LxNnNANq8Vzj1ZVeVfZ2dqMvVyIuVzxsJiCGTbrrZ4cG?=
 =?us-ascii?Q?ZgG0AA/diwNw2tfUTnH977wot+dJHS1Hp49jJPRfT/um/t+hF61GIy9wHrJz?=
 =?us-ascii?Q?9xSRU/7Ojzwy8ljHjb1W1MNCBtUL2WcWX+U4sssppheguBm4qq8oZedlvkZD?=
 =?us-ascii?Q?9ttLCTOp16vnoAacCMN+8+d1jywAJfskEhO5K6OPayGcNWdCXnNbVQzLlMf7?=
 =?us-ascii?Q?pQBDWIHuoN3Y14dxL4StpPaqR0ue86jPYTjoE1qpBUvJ/rdhNl/jjtQf3E8G?=
 =?us-ascii?Q?KsW8CKcIvwzQbS7yJvIJd0d0HW2qgWZs2y0aQp4V9c2N6RX10b3D1r5nSEjC?=
 =?us-ascii?Q?vVFSTDfi1AJ0quJ2mKk7wYqdNz1PgJaerEC0x4+CrMWGTLGu+opjXB4EgIHz?=
 =?us-ascii?Q?mqz8j2u2G8GN4OrDiVDx8BZtof+x8he6wjT85gtPuWZw9DJHiztJXlQCIcRM?=
 =?us-ascii?Q?q6nKfw6BvETO1oQ216LHPHt12+ZPO13PcHvxRhrMibjI8XX5EPcJLaCLGJRP?=
 =?us-ascii?Q?M+Ci6SDRDDSWXtNvP3xawDE7XUmoP4aaaUYHywTk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6f346d-1d70-4aaf-fc00-08db4b012614
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 11:34:10.8713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6wSYfaaqYjnHTivkiltYuR+ZX9al40vpjpIWcdhg0m0nefR4sKt1dVaL1NSjvia2h31o/SWTFdoICC3EuBggg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7791
Subject: [virtio-dev] RE: [PATCH 0/2] admin virtqueue fixes



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, May 2, 2023 3:42 AM
>=20
> On Tue, May 02, 2023 at 01:44:28AM +0300, Parav Pandit wrote:
> >
> > Hi Michael,
> >
> > Please review these two small fixes for the admin virtqueue patches.
> > They are on top of your work of v12 at [1].
> >
> > Patch summary:
> > patch-1 removes PCI transport dependency on deprecated migration bit
> > patch-2 fixes admin command command data type to be u8 similar to
> > result
> >
> > [1]
> > https://lore.kernel.org/virtio-comment/cover.1682354275.git.mst@redhat
> > .com/T/#t
>=20
> I can take 1/2 since that's just removing text. Taking 2/2 will mean more=
 review
> time before vote - besides me not really liking that change, are you sure=
 it's
> worth it?
> Was going to start voting today but if we are still tweaking command form=
at
> then I can't ...
>
There were 4 editorial fixes without which PDF is not readable for v12 and =
commit message needs update the AQ usage.
It needs rebase also.
And these two changes also.

Given we have 6+ changes, better to make them and ask for vote after that.

Vote includes spec and commit message content.
So please roll v13 addressing above to make things easier to vote.

You said posting too fast is not good. Now one week has passed, so its fine=
 to repost v13 and ask for the vote.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

