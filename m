Return-Path: <virtio-dev-return-12555-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C056C77B78
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 19:01:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F2A8E127CAE
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 19:01:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EAF139866C2
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 19:01:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DB2209866B6; Thu,  4 May 2023 19:01:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B03459866B4;
	Thu,  4 May 2023 19:01:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfqM5DfDS3hl0CkbrxPd3c8gvcKsCzVzGjB/Hb37GeUxdJ7NNSRJGECnORxPPx2SkjAfLsD9GbAKbvW/tlLfLuk4vAgWKAefS3w97x5MyIte12ylxPUPvbdtiLT2UwPHaUKJOQk8don4UKVtU/wO9MfRfF/pIh3m2YkRrHS3gx6yVwz2bKb1CuibbYtyd4YoWi1ku8+7FduF76DHiHgW7ocq+wZ31xBMtKyDXE1A6e39YkP2JND38kd9qb3HbnifXgXOjNCfVWA4VRDkl6r0zpYrZphL4HchOhc3Ii9EqC/T8VJKUWNvs6M41k34xGKtcYsiM4GdYXIRQLYavZ8J0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLsUzPtQyaVub6t617l0QZ7QFkh21+4AVFCqA28nQKQ=;
 b=eUTDnrpSjs2D9bmzRU7hgrtSnqxQsMiRhO4M6d0/NUDXHt7sFYkZafFqIgI0KoGmNUQiIY0tS4M9L6s88rTkAH0pj+/Ponpe3Uw/jQgJyU1AZrorcpxtHfSJFk9IbFndfv+BX4TfLbmO5bWVLwn95KegU2PuDRs7XQe/Ff5J5vGCf7e0l7T442MUOdpLaHpiF5FMUyg5viTcJ79BdY/nNm+Sp6mbg7pR47C0K5TRFRz1BNKBVw/S4+9orXsOKf/l+olNJZFvJp8lTEAvSe9zdiFA4JS3fZ5ENLQiEBmLIIcM9Fzgq/fQfeZTwb8VAi3yfpvIKAGjXh/TllCV0/j5BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: David Edmondson <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v16 03/11] content: Rename confusing queue_notify_data
 and vqn names
Thread-Index: AQHZfjBm/WBwopgBd02gfjAA00VqW69KLOcAgABDVWCAAAXHAIAAAr9Q
Date: Thu, 4 May 2023 19:00:57 +0000
Message-ID:
 <PH0PR12MB548181231B04788B3E8964C6DC6D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230504022959.547025-1-parav@nvidia.com>
 <20230504022959.547025-4-parav@nvidia.com> <m21qjw5fyh.fsf@oracle.com>
 <PH0PR12MB548100E1C4AD64EA35E22772DC6D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230504144914-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230504144914-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN6PR12MB8489:EE_
x-ms-office365-filtering-correlation-id: 7337008a-0f98-44f1-a6da-08db4cd1e527
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wjwKvX2YhYyrRH8XwutEsiN5jdpMRcaXxyddnPDR+CDZtzlXdR+VVHWqiJjM0B/Es5pxj03JlTaL+o5nrVaFJh4y1wH/cCEoXb9zROBaZ82ZwKlBKaEWYA0F1PgnbIfJLCI0dStpGkS2c/OjaMM5A6Doi6gxAQJWmP4ygvX7PPSJkEPme6YKK8svWgQcJF3MYog7fr1FCFkwn925TAKz+GRo6Nib8130dVlhHFc4ixNEoD5WkhkJN3ZJ+NaGP9GARXt52tjLs0hdkgSiJ08i7jaP9g+YIVWVN4KM8uTgnG4dEtsLCATLtPifPTq1C/zrN4QmEYA+q3d4nEbZjS8WCAc7PmlmYavrRhJl8/D5+T/dXgLDRJ4yjsy9K4tq4sPoUs4EImrojnJW8mFlef4Y6Yi3SnyNS7TdjD2DhdlJxXmH04N1iWJKfr9HSDFhLIc/8QCWPTaJU63K6dhB/7WDK/3+fz6IT8FYHKpf90nvyqttU0+DI92PQ60MKd8hA7Nt2X/CNTOjpdKLPRLfZ81spYAXMPRyVV1ruUC9DOH3sR/2H/5GxAa0njaqeFFxcQ+S/3gCLi5nLqfC0onWCZwWHc7aXznqCFXIDVP4tQqmDkzXpp3yNDvNID1PRdtoYZsp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(83380400001)(8936002)(54906003)(38100700002)(122000001)(41300700001)(26005)(86362001)(9686003)(6506007)(5660300002)(52536014)(8676002)(186003)(107886003)(478600001)(4744005)(2906002)(38070700005)(55016003)(66556008)(66446008)(316002)(66946007)(6916009)(71200400001)(7696005)(66476007)(4326008)(33656002)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UmqigxVFSsMP7qj0qnOMYGMxJVldFje9aQ5xrf013w+RqGmzfmaSX0p/Wg7J?=
 =?us-ascii?Q?uKH1QE9Fe74ltf/95OD4NUooppmFSKVFgIeiCKROi7xMKkYX3/dG2Il66ABC?=
 =?us-ascii?Q?GOIuYE1FEbzk+DlAEkhuzkMxbQTwBrSBU0nnn1N1FY1VUE0sbvJrjELYGYQA?=
 =?us-ascii?Q?OB0hxW5tpt4Zb+cWfC5xebkxqsDu0Bgd1GhrSY8FS58narnMU5aQHt5TnkjM?=
 =?us-ascii?Q?1/h90fmNyxe/08PdJeyt7F/faPnCKvS0n6ze5SIxgr9oYB8UoqkadLwgo0l+?=
 =?us-ascii?Q?JgOWT+adENSQO1bsBo0ArT85coPXuy3rYtLxbVvrfdL49WL8ONWm+jj99C/Y?=
 =?us-ascii?Q?wFWUN9wHtrVhtqCCl1log2CuRHk9qArvvZQ72hc1gQFK8cLcF3R3fEAHnVEW?=
 =?us-ascii?Q?/esqaYZ1mDzSrFG0uQZrsBM9aK/rEio34QF5CIq2Dp+uWKqRtnULr9NKPDhn?=
 =?us-ascii?Q?NlVPtpn/z+jeZDbwxaE2nNJ6GT2ImsGEOeJy5uwugXCmEWMQwjC57pucUWKp?=
 =?us-ascii?Q?+WdkEhOAgxolsZnK06ESVFASOUAZdcnHuXU8jJAsqJmkBvFEjlFShBsci/Fx?=
 =?us-ascii?Q?VlCw7dCCuQRytQcjlI9LIRhSvX2WewxtkzMfALDGTYt5zsMEu14BJZENTvvw?=
 =?us-ascii?Q?8QiMzb0H+EiovBHU5atnHrGmUY3jYrjm+oZW1Gs8LUBfRkHJLn05w/mFP8c6?=
 =?us-ascii?Q?3hl6uihkdRLvpRYzTLQWvQffQvU//3vQFNmdwCxHGYR9C4bs6/bTxkDOBLUM?=
 =?us-ascii?Q?gnZpvwW5SGzZLyeNednzSeLlOOzCuM3p6RuXgCj2JZmpGvI5QMfFAXCKXeNi?=
 =?us-ascii?Q?u4+oYM8Yqee8JYcskRsZ99OdwHtLnzm5z2sFIa7xaCC8/WYJJtQU8htZVZs4?=
 =?us-ascii?Q?8QiWrv19vDdH9B/gzNqSSZQTB+SYi6si+Ek4CJrwPUxQZOxc6vgr4NjC63L4?=
 =?us-ascii?Q?k8gmzTHfCJs78hJaE5Vn9JQ/Wiz6X3O+JMR1yifr8pvgKS+jcEe+UBmAahH4?=
 =?us-ascii?Q?A+xjaVJHQtFCPq/KFXHCB/TJhFCoVzBNAqC1qBmkzy2hwBhtwcMeqKfW3J6g?=
 =?us-ascii?Q?DmIJPnOnd+TiLl6VOMgrdugHLgEeAFBCQZFgW/60IUCX3YATy497h9lwhn40?=
 =?us-ascii?Q?nl5TbukWoMCnIY/oMJl8gPT/IvTnqbrwOgqm2e3R0nTrYzhd+2BOcyJGDQsz?=
 =?us-ascii?Q?tECm7dCNiZG4/8YqLfhfYlLGkryBMBiFdiWOyS3ASXaqej5jx9DmhLl3dtYo?=
 =?us-ascii?Q?MCuFpuyoUuerPHCeFD9Bc3DP20s46unW8jyhf2XiMT9kkWAhk79BMpWIJ9EM?=
 =?us-ascii?Q?2v8eDyZqIptTsSU1Dfi3ACbdHBu5ivv5IglVjFMuog9ffmEJdSoL8rNB5Nrr?=
 =?us-ascii?Q?rlv4P6MBvStgWQTGqvMSd4UblmDsvd/hQXBUsWphQ+8c5FeRSvn8zQd9JHLX?=
 =?us-ascii?Q?uRq9qdFHiBrvk00QJfYU2T3DzHWfppgrzg8ocUIPL+SqrXvm8T0CnHLw10qL?=
 =?us-ascii?Q?b+xU+ZOjXkSwPPouaiaNVyAt6tzNHkhPzEgeCD/BA46id8kxv4IRyvOJZd1d?=
 =?us-ascii?Q?bhC8jnWVp6ysE7EqYCE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7337008a-0f98-44f1-a6da-08db4cd1e527
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 19:00:57.9210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1UWM/pznd2/4+4XN9CRAMTogU78MmV6IGcHlhU4QDfo3kL4oseqsHqqRH7rKCC2WEGqp6brg7yxyJorjKEQgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489
Subject: [virtio-dev] RE: [PATCH v16 03/11] content: Rename confusing queue_notify_data and
 vqn names


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, May 4, 2023 2:50 PM
> > Both suggestions look good to me.
> > Given rest of the patches are reviewed and it is already v16, I think I=
 can
> cover them right after this in editorial changes after merging this.
> > This way the majority of the work of this series and subsequent patches
> doesn't need to wait another week.
>=20
> Did voting start already? If not you can post a new version just before v=
oting if
> you already know what you want to do.

No voting didn't start.
I am ok to post now as the changes are ready; will wait for a day or two be=
fore requesting voting.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

