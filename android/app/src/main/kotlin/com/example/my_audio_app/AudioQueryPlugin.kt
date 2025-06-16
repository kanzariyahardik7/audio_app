package com.example.my_audio_app

import android.content.ContentResolver
import android.content.Context
import android.provider.MediaStore

object AudioQueryHelper {
    fun getAudioFiles(context: Context): List<Map<String, String>> {
        val resolver: ContentResolver = context.contentResolver
        val uri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI

        val projection = arrayOf(
            MediaStore.Audio.Media.TITLE,
            MediaStore.Audio.Media.ARTIST,
            MediaStore.Audio.Media.DATA,     // File path
            MediaStore.Audio.Media.DURATION  // Duration in ms
        )

        // ✅ Only include real music files
        val selection = "${MediaStore.Audio.Media.IS_MUSIC} != 0"

        val cursor = resolver.query(uri, projection, selection, null, null)
        val songs = mutableListOf<Map<String, String>>()

        cursor?.use {
            while (it.moveToNext()) {
                val title = it.getString(0) ?: "Unknown"
                val artist = it.getString(1) ?: "Unknown"
                val path = it.getString(2) ?: ""
                val duration = it.getString(3) ?: "0"

                songs.add(
                    mapOf(
                        "title" to title,
                        "artist" to artist,
                        "path" to path,
                        "duration" to duration
                    )
                )
            }
        }
        return songs
    }
}
